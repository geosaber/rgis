﻿DROP TABLE IF EXISTS start."StreamCenterlines";

CREATE TABLE start."StreamCenterlines"
(
  "ReachID" serial primary key,
  "RiverCode" text,
  "ReachCode" text,
  "FromNode" integer,
  "ToNode" integer,
  "ReachLen" double precision,
  "FromSta" double precision,
  "ToSta" double precision,
  "Notes" text,
  geom geometry(LineString,2180)
);

CREATE INDEX "sidx_RiverCenterlines_geom"
  ON start."StreamCenterlines"
  USING gist
  (geom);

-- utworz przykładowe obiekty StreamCenterlines

INSERT INTO
  start."StreamCenterlines" ("RiverCode", "ReachCode", geom)
VALUES
    ('Odra', 'testowy', ST_GeomFromText('LINESTRING(324411 392195.305535,324239 392416,324058 392628,324006 392795,323997 392993,323992 393221)',2180)),
    ('Doplyw A', 'dolna część', ST_GeomFromText('LINESTRING(324539 392790,324022 392743)',2180)),
    ('Doplyw A', 'górna część', ST_GeomFromText('LINESTRING(325014 392216,324887 392383,324772 392378,324711 392493,324673 392635,324577 392731,324539 392790)',2180)),
    ('Doplyw B', 'testowy', ST_GeomFromText('LINESTRING(325337 393195,325222 393136,325022 393082,324831 393049,324709 393021,324645 392964,324589 392858,324539 392790)',2180));


-- XsCutline Table

DROP TABLE IF EXISTS start."XSCutLines";

CREATE TABLE start."XSCutLines"
(
  "XsecID" serial primary key,
  "ReachID" integer,
  "Station" double precision,
  "Nr" integer,
  "LeftBank" double precision,
  "RightBank" double precision,
  "LeftLen" double precision,
  "ChanLen" double precision,
  "RightLen" double precision,
  "Name" text,
  "Description" text,
  geom geometry(LineString,2180)
);

CREATE INDEX "sidx_XSCutLines_geom"
  ON start."XSCutLines"
  USING gist
  (geom);

-- utwórz kilka przykładowych obiektów XsCutline

INSERT INTO
  start."XSCutLines" (geom)
VALUES
  (ST_GeomFromText('LINESTRING(323889 393184,324455 393217)', 2180)),
  (ST_GeomFromText('LINESTRING(323325 392863,324468 392966)', 2180)),
  (ST_GeomFromText('LINESTRING(323305 392364,324486 392721)', 2180)),
  (ST_GeomFromText('LINESTRING(324424 392734,324419 392832)', 2180)),
  (ST_GeomFromText('LINESTRING(324499 392736,324497 392835)', 2180)),
  (ST_GeomFromText('LINESTRING(324540 392695,324628 392760)', 2180)),
  (ST_GeomFromText('LINESTRING(324502 392496,325037 392677)', 2180)),
  (ST_GeomFromText('LINESTRING(324561 392214,325130 392393)', 2180)),
  (ST_GeomFromText('LINESTRING(324637 392813,324516 392892)', 2180)),
  (ST_GeomFromText('LINESTRING(324759 392945,324690 393101)', 2180)),
  (ST_GeomFromText('LINESTRING(323338 392165,324207 392230,324416 392390,324571 392434)', 2180));


-- Linie brzegów (BankLines)
DROP TABLE IF EXISTS start."BankLines";

CREATE TABLE start."BankLines"
(
  "BankID" SERIAL PRIMARY KEY,
  geom     GEOMETRY(LINESTRING, 2180)
);

INSERT INTO
  start."BankLines" (geom)
VALUES
  (ST_GeomFromText('LINESTRING(324453 392252,324342 392419,324238 392509,324130 392620,324057 392812,324039 393021,324057 393226)', 2180)),
  (ST_GeomFromText('LINESTRING(324307 392227,324165 392387,324092 392485,324008 392586,323918 392808,323900 393021,323911 393233)', 2180)),
  (ST_GeomFromText('LINESTRING(324972 392245,324888 392312,324821 392340,324744 392373,324707 392434,324671 392532,324605 392652,324551 392700,324527 392737,324480 392756,324422 392753)', 2180)),
  (ST_GeomFromText('LINESTRING(325005 392300,324908 392396,324788 392443,324728 392558,324688 392650,324622 392728,324579 392770,324546 392799,324500 392810,324415 392814)', 2180)),
  (ST_GeomFromText('LINESTRING(324584 392817,324754 392991,324841 393007)', 2180)),
  (ST_GeomFromText('LINESTRING(324817 393121,324690 393068,324549 392923,324530 392845)', 2180));


-- drogi przepływu (flow paths)
DROP TABLE IF EXISTS start."Flowpaths";

CREATE TABLE start."Flowpaths"
(
  "PathID" SERIAL PRIMARY KEY,
  "LineType"   TEXT,
  geom     GEOMETRY(LINESTRING, 2180)
);

-- dodanie przykładowych dróg przepływu
INSERT INTO
  start."Flowpaths" ("LineType", geom)
VALUES
  ('Channel', ST_GeomFromText('LINESTRING(324411 392195.305535,324239 392416,324058 392628,324006 392795,323997 392993,323992 393221)', 2180)),
('Channel', ST_GeomFromText('LINESTRING(325337 393195,325222 393136,325022 393082,324831 393049,324709 393021,324645 392964,324589 392858,324539 392790)', 2180)),
('Right', ST_GeomFromText('LINESTRING(324487 392297,324288 392787,324238 393068,324219 393243)', 2180)),
('Right', ST_GeomFromText('LINESTRING(324798 393101,324662 393052,324589 392965,324558 392885,324535 392841)', 2180)),
('Channel', ST_GeomFromText('LINESTRING(325014 392216,324887 392383,324772 392378,324711 392493,324673 392635,324577 392731,324539 392790,324022 392743)', 2180)),
('Left', ST_GeomFromText('LINESTRING(323812 392179,323709 392398,323700 392626,323763 392913,323932 393210)', 2180)),
('Left', ST_GeomFromText('LINESTRING(324770 392180,324654 392410,324562 392650,324525 392734,324507 392758,324481 392763,324415 392761)', 2180)),
('Right', ST_GeomFromText('LINESTRING(325075 392267,324876 392594,324734 392703,324617 392757,324525 392807,324408 392810)', 2180)),
('Left', ST_GeomFromText('LINESTRING(324815 393013,324600 392817)', 2180));

-- NodesTable
-- Tabela wypełniana za pomocą funkcji from_to_node

-- Linie rzek rysujemy zgodnie z kierunkiem przeplywu. To samo dotyczy drog przepływu Flowpaths.
-- Dzieki temu FromNode zawsze jest na gorze odcinka, a ToNode przy ujsciu.

-- NodesTable jest tworzona przez funkcję from_to_node() Lukasza

-- DROP TABLE IF EXISTS start."NodesTable";
--
-- CREATE TABLE start."NodesTable"
-- (
--   "NodeId" serial primary key,
--   "X" double precision,
--   "Y" double precision
--   );

CREATE OR REPLACE FUNCTION "start".from_to_node ()
    RETURNS VOID AS
$BODY$
DECLARE
    c cursor FOR SELECT * FROM "start"."StreamCenterlines";
    r "start"."StreamCenterlines"%ROWTYPE;
    start_geom geometry;
    end_geom geometry;
    start_node integer := 0;
    end_node integer := 0;
    nr integer := 0;
BEGIN
DROP TABLE IF EXISTS "start"."NodesTable";
CREATE TABLE "start"."NodesTable"(
    geom geometry(POINT, 2180),
    "NodeID" serial primary key,
    "X" double precision,
    "Y" double precision);
FOR r in c LOOP
    start_geom := ST_StartPoint(r.geom);
    end_geom := ST_EndPoint(r.geom);
    IF (SELECT exists (SELECT 1 FROM "start"."NodesTable" WHERE geom = start_geom LIMIT 1)) THEN
        start_node := (SELECT "NodeID" FROM "start"."NodesTable" WHERE geom = start_geom LIMIT 1);
    ELSE
        nr := nr + 1;
        start_node := nr;
        INSERT INTO "start"."NodesTable" VALUES (start_geom, nr, ST_X(start_geom), ST_Y(start_geom));
    END IF;
    IF (SELECT exists (SELECT 1 FROM "start"."NodesTable" WHERE geom = end_geom LIMIT 1)) THEN
        end_node := (SELECT "NodeID" FROM "start"."NodesTable" WHERE geom = end_geom LIMIT 1);
    ELSE
        nr := nr + 1;
        end_node := nr;
        INSERT INTO "start"."NodesTable" VALUES (end_geom, nr, ST_X(end_geom), ST_Y(end_geom));
    END IF;
    UPDATE "start"."StreamCenterlines" SET
    "FromNode" = start_node,
    "ToNode" = end_node
    WHERE CURRENT OF c;
END LOOP;
END;
$BODY$
    LANGUAGE plpgsql;

SELECT "start".from_to_node ();
DROP FUNCTION IF EXISTS "start".from_to_node ();


-- Nadanie ReachID przekrojom

UPDATE start."XSCutLines" as xs
SET 
  "ReachID" = riv."ReachID"
FROM
  start."StreamCenterlines" as riv
WHERE
  xs.geom && riv.geom AND
  ST_Intersects(xs.geom, riv.geom);


-- utworzenie tabeli Endpoints

CREATE OR REPLACE VIEW "start".pnts1 AS
SELECT "RiverCode", "ReachCode", ST_StartPoint(geom) AS geom, 'start' AS typ_punktu
FROM "start"."StreamCenterlines"
UNION ALL
SELECT "RiverCode", "ReachCode", ST_EndPoint(geom) AS geom, 'end' AS typ_punktu
FROM "start"."StreamCenterlines";

CREATE OR REPLACE VIEW "start".pnts2 AS
SELECT "RiverCode", geom
FROM "start".pnts1
GROUP BY "RiverCode", geom
HAVING COUNT(geom) = 1;

DROP TABLE IF EXISTS "start"."Endpoints";
SELECT pnts1."RiverCode", pnts1."ReachCode", pnts1.geom::geometry(POINT, 2180) INTO "start"."Endpoints"
FROM "start".pnts1, "start".pnts2
WHERE pnts1."RiverCode" = pnts2."RiverCode" AND pnts1.geom = pnts2.geom AND pnts1.typ_punktu = 'end';

drop view start.pnts2;
drop view start.pnts1;

-- SELECT * FROM "start"."StreamCenterlines"
-- WHERE "StreamCenterlines"."ReachCode" = ANY((SELECT "Endpoints"."ReachCode" FROM "start"."Endpoints"));


-- nadanie stacji końcom odcinków

CREATE TABLE start.tmp1 AS
SELECT "RiverCode", "ReachCode", ST_StartPoint(geom) AS geom, 'start' AS typ_punktu
FROM start."StreamCenterlines"
UNION ALL
SELECT "RiverCode", "ReachCode", ST_EndPoint(geom) AS geom, 'end' AS typ_punktu
FROM start."StreamCenterlines";

CREATE TABLE start.tmp2 AS
SELECT "RiverCode", geom
FROM start.tmp1
GROUP BY "RiverCode", geom
HAVING COUNT(geom) = 1;

DROP TABLE IF EXISTS start."Endpoints";
SELECT tmp1.geom::geometry(POINT, 2180), tmp1."RiverCode", tmp1."ReachCode", "NodesTable"."NodeID" INTO start."Endpoints"
FROM start.tmp1, start.tmp2, start."NodesTable"
WHERE tmp1."RiverCode" = tmp2."RiverCode" AND tmp1.geom = tmp2.geom AND tmp1.typ_punktu = 'end' AND tmp1.geom = "NodesTable".geom;

DROP TABLE IF EXISTS start.tmp1;
DROP TABLE IF EXISTS start.tmp2;
------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION start.from_to_stations ()
    RETURNS VOID AS
$BODY$
DECLARE
    c cursor FOR SELECT * FROM start."Endpoints";
    r start."Endpoints"%ROWTYPE;
    river text;
    tonode_id integer;
    fromnode_id integer;
    fromsta double precision;
    tosta double precision;
    len double precision;
BEGIN
FOR r IN c LOOP
    river := r."RiverCode";
    tonode_id := r."NodeID";
    fromsta := 0;
    tosta := 0;
    FOR i in 1..(SELECT COUNT(*) FROM start."StreamCenterlines" WHERE "StreamCenterlines"."RiverCode" = river) LOOP
        SELECT "FromNode", ST_Length(geom) INTO fromnode_id, len FROM start."StreamCenterlines" WHERE "RiverCode" = river AND "ToNode" = tonode_id;
        tosta := fromsta + len;
        UPDATE start."StreamCenterlines" SET
        "FromSta" = fromsta,
        "ToSta" = tosta
        WHERE "RiverCode" = river AND "ToNode" = tonode_id;
        tonode_id = fromnode_id;
        fromsta := tosta;
    END LOOP;
END LOOP;
END;
$BODY$
    LANGUAGE plpgsql;
------------------------------------------------------------------------------------------------------------------------
SELECT start.from_to_stations ();
DROP FUNCTION IF EXISTS start.from_to_stations ();

-- Nadanie stacji (kilometraza) przekrojom

WITH xspts as (
  SELECT 
    xs."XsecID" as "XsecID",
    riv."ReachID" as "ReachID",
    ST_LineLocatePoint(riv.geom, ST_Intersection(xs.geom, riv.geom)) as "Fraction"
  FROM
    start."StreamCenterlines" as riv,
    start."XSCutLines" as xs
  WHERE
    xs.geom && riv.geom AND
    ST_Intersects(xs.geom, riv.geom)
)
UPDATE start."XSCutLines" as xs
SET
  "Station" = riv."FromSta" + xspts."Fraction" * (riv."ToSta" - riv."FromSta")
FROM
  xspts,
  start."StreamCenterlines" as riv
WHERE
  xspts."ReachID" = riv."ReachID" AND
  xspts."XsecID" = xs."XsecID";

-- nadaj przekrojom kolejny numer na odcinku idac od gory
-- numery będą potrzebne do określenia kolejności przekrojów
-- przy ustalaniu odległości między przekrojami wzdłuż dróg przepływu

WITH orderedXsecs as (
SELECT
    "XsecID",
    xs."ReachID",
    rank() OVER (PARTITION BY "RiverCode" ORDER BY "Station" ASC) as rank
  FROM
    start."XSCutLines" as xs
  LEFT JOIN
    start."StreamCenterlines" sc ON  sc."ReachID" = xs."ReachID"
)
UPDATE start."XSCutLines" xs
  SET
    "Nr" = rank
  FROM
    orderedXsecs ox
  WHERE
    xs."XsecID" = ox."XsecID";



-- brzegi rzeki (banks) - w Mike'u 11 markery 4 i 5

WITH bankpts as (
  SELECT
    xs."XsecID" as "XsecID",
    ST_LineLocatePoint(xs.geom, ST_Intersection(xs.geom, bl.geom)) as "Fraction"
  FROM
    start."BankLines" as bl,
    start."XSCutLines" as xs
  WHERE
    xs.geom && bl.geom AND
    ST_Intersects(xs.geom, bl.geom)
)
UPDATE start."XSCutLines" as xs
SET
  "LeftBank" = minmax."minFrac",
  "RightBank" = minmax."maxFrac"
FROM
  (
  SELECT
    "XsecID",
    min("Fraction") as "minFrac",
    max("Fraction") as "maxFrac"
  FROM
    bankpts as bp
  GROUP BY "XsecID"
  ) minmax
WHERE
  xs."XsecID" = minmax."XsecID";



-- odleglosci wzdluż dróg przepływu

-- tworze tabele kilometrazu wzdluz 3 drog przeplywu
DROP TABLE IF EXISTS start."FlowpathStations";

CREATE TABLE start."FlowpathStations" (
  "XsecID" integer primary key,
  "RiverCode" text,
  "Nr" integer,
  "LeftSta" double precision,
  "ChanSta" double precision,
  "RightSta" double precision
);

-- wkladam do tabeli wszystkie przekroje z ich identyfikatorami
INSERT INTO start."FlowpathStations"
  ("XsecID", "RiverCode", "Nr")
SELECT
  xs."XsecID",
  sc."RiverCode",
  xs."Nr"
FROM
  start."XSCutLines" as xs
  LEFT JOIN start."StreamCenterlines" as sc ON xs."ReachID" = sc."ReachID";


-- nadaje przekrojom kilometraz wzdluz linii typu Channel

WITH xspts as (
  SELECT
    xs."XsecID" as "XsecID",
    path."LineType" as "LineType",
    ST_LineLocatePoint(path.geom, ST_Intersection(xs.geom, path.geom))
      * ST_Length(path.geom) as "Station"
  FROM
    start."Flowpaths" as path,
    start."XSCutLines" as xs
  WHERE
    path."LineType" = 'Channel' AND
    xs.geom && path.geom AND
    ST_Intersects(xs.geom, path.geom)
)
UPDATE start."FlowpathStations" as flowSta
SET
  "ChanSta" = xspts."Station"
FROM
  xspts
WHERE
  xspts."XsecID" = flowSta."XsecID";


-- nadaje przekrojom kilometraz wzdluz linii typu Left

WITH xspts as (
  SELECT
    xs."XsecID" as "XsecID",
    path."LineType" as "LineType",
    ST_LineLocatePoint(path.geom, ST_Intersection(xs.geom, path.geom))
      * ST_Length(path.geom) as "Station"
  FROM
    start."Flowpaths" as path,
    start."XSCutLines" as xs
  WHERE
    path."LineType" = 'Left' AND
    xs.geom && path.geom AND
    ST_Intersects(xs.geom, path.geom)
)
UPDATE start."FlowpathStations" as flowSta
SET
  "LeftSta" = xspts."Station"
FROM
  xspts
WHERE
  xspts."XsecID" = flowSta."XsecID";


-- nadaje przekrojom kilometraz wzdluz linii typu Right

WITH xspts as (
  SELECT
    xs."XsecID" as "XsecID",
    path."LineType" as "LineType",
    ST_LineLocatePoint(path.geom, ST_Intersection(xs.geom, path.geom))
      * ST_Length(path.geom) as "Station"
  FROM
    start."Flowpaths" as path,
    start."XSCutLines" as xs
  WHERE
    path."LineType" = 'Right' AND
    xs.geom && path.geom AND
    ST_Intersects(xs.geom, path.geom)
)
UPDATE start."FlowpathStations" as flowSta
SET
  "RightSta" = xspts."Station"
FROM
  xspts
WHERE
  xspts."XsecID" = flowSta."XsecID";


-- teraz trzeba sprawdzić czy wszystkie drogi przepływu przecinaja przekroje
-- jesli nie, to w tablicy "FlowpathStations" są braki i trzeba zmienic przebieg "Flowpaths"
-- a nastepnie uruchomic ponownie nadawanie stacji wzdluz drog przeplywu

-- wlasciwe obliczenie odleglosci wzdluz drog przeplywu

WITH xsdata AS (
SELECT
  x."XsecID",
  s."RiverCode"
FROM
  start."XSCutLines" as x
  LEFT JOIN start."StreamCenterlines" as s ON x."ReachID" = s."ReachID"
)
UPDATE start."XSCutLines" as xs
SET
  "LeftLen" = abs(nfs."LeftSta" - fs."LeftSta"),
  "ChanLen" = abs(nfs."ChanSta" - fs."ChanSta"),
  "RightLen" = abs(nfs."RightSta" - fs."RightSta")
FROM
  xsdata,
  start."FlowpathStations" as fs,
  start."FlowpathStations" as nfs
WHERE
  xs."Nr" > 1 AND
  xs."XsecID" = xsdata."XsecID" AND
  xsdata."RiverCode" = fs."RiverCode" AND
  fs."RiverCode" = nfs."RiverCode" AND
  xs."XsecID" = fs."XsecID" AND
  xs."Nr" = fs."Nr" AND
  xs."Nr" = nfs."Nr" + 1;


-- nadaj zerowe odleglosci ostatnim przekrojom na odcinkach rzek (przy ujsciu)

UPDATE start."XSCutLines" as xs
SET
  "LeftLen" = 0,
  "ChanLen" = 0,
  "RightLen" = 0
WHERE
  xs."Nr" = 1;



-- współczynniki szorstkości Manninga

DROP TABLE IF EXISTS start."LandUse";

CREATE TABLE start."LandUse"
(
  "LUseID" serial primary key,
  "LUCode" character varying(32),
  "N_Value" double precision,
  geom geometry(Polygon,2180) -- UWAGA: geometria prosta a NIE multi
);

CREATE INDEX sidx_landuse_geom ON
    start."LandUse"
USING gist (geom);

-- dodaj jakies obiekty do powyzszych tabel i uruchom zapytania ponizej

INSERT INTO
  start."LandUse" ("LUCode", "N_Value", geom)
VALUES
  ('a', 0.01, ST_GeomFromText('POLYGON((323284 393262,323271 392115,324238 392126,324090 393255,323284 393262))',2180)),
  ('b', 0.02, ST_GeomFromText('POLYGON((324090 393255,324275 393270,324403 392149,324238 392126,324090 393255))',2180)),
  ('c', 0.03, ST_GeomFromText('POLYGON((324275 393270,324433 393279,324462 392776,324530 392165,324403 392149,324275 393270))',2180)),
  ('d', 0.04, ST_GeomFromText('POLYGON((324433 393279,324786 393283,324787 393080,324532 392777,324462 392776,324433 393279))',2180)),
  ('e', 0.05, ST_GeomFromText('POLYGON((324815 392196,324530 392165,324462 392776,324532 392777,324687 392593,324815 392196))',2180)),
  ('f', 0.06, ST_GeomFromText('POLYGON((324532 392777,324787 393080,324786 393283,325222 392320,324815 392196,324687 392593,324532 392777))',2180));

-- tabela punktow zmiany szorstkosci

DROP TABLE IF EXISTS start."Manning";
create table start."Manning" (
    "MannID" bigserial primary key,
    "XsecID" integer,
    "Fraction" double precision, -- wzgledne polozenie na linii przekroju
    "LUCode" text, -- kod pokrycia
    "N_Value" double precision, -- wsp szorstkosci
	geom geometry(point, 2180) -- geometria
);

CREATE INDEX sidx_luchangelocations_geom ON
    start."Manning"
USING gist (geom);


-- znajdz punkty zmiany szorstkosci

with linie_z_poligonow as ( -- tymczasowe granice poligonow uzytkowania
SELECT
    (ST_Dump(ST_Boundary(geom))).geom
FROM start."LandUse"
)
insert into start."Manning"
    ("XsecID", geom)
select distinct
    xs."XsecID", -- zeby wiedziec na jakim przekroju lezy punkt
    (ST_Dump(ST_Intersection(l.geom, xs.geom))).geom as geom
from
    linie_z_poligonow l,
    start."XSCutLines" xs
where
    l.geom && xs.geom;


-- dodaj do pktow zmiany poczatki przekrojow
insert into start."Manning"
    ("XsecID", geom)
select
    xs."XsecID",
    ST_LineInterpolatePoint(xs.geom, 0.0)
from
    start."XSCutLines" xs;


-- ustal polozenie pktow zmiany wzdluz przekrojow

update
    start."Manning" as p
set
    "Fraction" = ST_LineLocatePoint(xs.geom, p.geom)
from
    start."XSCutLines" as xs
where
    xs."XsecID" = p."XsecID";


-- probkuj kod uzytkowania z poligonow

update
    start."Manning" as p
set
    "LUCode" = u."LUCode",
    "N_Value" = u."N_Value"
from
    start."LandUse" as u,
    start."XSCutLines" as xs
where
    xs."XsecID" = p."XsecID" AND
    ST_LineInterpolatePoint(xs.geom, p."Fraction"+0.001) && u.geom AND
    ST_Intersects(ST_LineInterpolatePoint(xs.geom, p."Fraction"+0.001), u.geom);




