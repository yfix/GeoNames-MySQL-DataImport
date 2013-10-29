
CREATE TABLE IF NOT EXISTS geo_city (
    geoname_id   int PRIMARY KEY,
    name        varchar(200),
    latitude    decimal(10,7),
    longitude   decimal(10,7),
    country     varchar(2),
    admin1      varchar(20),
    admin2      varchar(80),
    admin3      varchar(20),
    admin4      varchar(20),
    population  int,
    timezone    varchar(40)
) CHARACTER SET utf8;

INSERT INTO geo_city
SELECT
    g.geoname_id,
    g.name,
    g.latitude,
    g.longitude,
    g.country,
    g.admin1,
    g.admin2,
    g.admin3,
    g.admin4,
    g.population,
    g.timezone
FROM
    geo_geoname AS g
WHERE
    g.fclass =  'P'
    AND g.fcode = 'PPL';


# Get administration 1 LEVEL FROM Spain
/*
SELECT gan.name, gg.*
FROM geo_geoname AS gg
    JOIN `geo_hierarchy` AS gh
        ON gg.geoname_id = gh.child_id
    JOIN `geo_alternate_names` AS gan
        ON gg.geoname_id = gan.geoname_id
        AND gan.iso_language = 'es'
        AND gan.is_short = 1
WHERE gh.parent_id = 2510769
    AND gh.type = 'ADM'
ORDER BY gan.name ASC
*/
