-- tabela przekrojow
CREATE TABLE radek.xscutlines
(
  gid serial NOT NULL,
  hydroid integer,
  geom geometry(LineString,2180), -- UWAGA: geometria prosta a NIE multi
  CONSTRAINT xscutlines_pkey PRIMARY KEY (gid)
);

-- tabela uzytkowania
CREATE TABLE radek.uzytkowanie
(
  gid serial NOT NULL,
  lucode character varying(32),
  n_value double precision,
  geom geometry(Polygon,2180), -- UWAGA: geometria prosta a NIE multi
  CONSTRAINT uzytkowanie_pkey PRIMARY KEY (gid)
);

-- dodaj jakies obiekty do powyzszych tabel i uruchom zapytania ponizej

-- tabela punktow zmiany szorstkosci
create table radek.pkty_zmiany (
    gid bigserial primary key,
    xs_hid integer,
    m double precision, -- wzgledne polozenie na linii przekroju
    code text, -- kod pokrycia
    n double precision, -- wsp szorstkosci
	geom geometry(point, 2180) -- geometria
);

CREATE INDEX sidx_pkty_zmiany_geom ON 
    radek.pkty_zmiany
USING gist (geom);


-- znajdz punkty zmiany szorstkosci

with linie_z_poligonow as ( -- tymczasowe granice poligonow uzytkowania
SELECT 
    Distinct ST_MakeLine(sp,ep) as geom
FROM -- http://stackoverflow.com/questions/7595635/how-to-convert-polygon-data-into-line-segments-using-postgis
   -- extract the endpoints for every 2-point line segment for each linestring
   (SELECT
      ST_PointN(geom, generate_series(1, ST_NPoints(geom)-1)) as sp,
      ST_PointN(geom, generate_series(2, ST_NPoints(geom)  )) as ep
    FROM
       -- extract the individual linestrings
      (SELECT (ST_Dump(ST_Boundary(geom))).geom
       FROM radek.uzytkowanie
       ) AS linestrings
    ) AS segments )
insert into radek.pkty_zmiany
    (xs_hid, geom)
select
    xs.hydroid, -- zeby wiedziec na jakim przekroju lezy punkt
    (ST_Dump(ST_Intersection(l.geom, xs.geom))).geom as geom
from 
    linie_z_poligonow l,
    radek.xscutlines xs

-- dodaj do pktow zmiany poczatki przekrojow
insert into radek.pkty_zmiany
    (xs_hid, geom)
select
    xs.hydroid,
    ST_LineInterpolatePoint(xs.geom, 0.0)
from
    radek.xscutlines xs
    
    
-- ustal polozenie pktow zmiany wzdluz przekrojow

update 
    radek.pkty_zmiany as p
set
    m = ST_LineLocatePoint(xs.geom, p.geom)
from
    radek.xscutlines as xs
where
    xs.hydroid = p.xs_hid

    
-- probkuj kod uzytkowania z poligonow

update 
    radek.pkty_zmiany as p
set
    code = u.lucode
from
    radek.uzytkowanie as u
where
    p.geom && u.geom and
    ST_Intersects(p.geom, u.geom)
    