SELECT g.id, g.name, a.name AS native, g.feature_code, g.population
FROM geo_geoname AS g
LEFT JOIN geo_alternate_name AS a ON a.geoname_id = g.id
WHERE 
	g.feature_class = 'p'
	AND g.population > 1000
	AND g.country = 'ua' 
	AND a.language_code = 'uk'
GROUP BY g.id
ORDER BY g.population DESC
LIMIT 500;


SELECT * FROM (
	SELECT g.id, g.name, a.name AS native, g.feature_code, g.population
	FROM geo_geoname AS g
	INNER JOIN geo_alternate_name AS a ON a.geoname_id = g.id
	WHERE g.feature_class = 'a'
		AND g.country = 'ua'
	    AND a.language_code = 'uk'
	ORDER BY g.id, a.is_preferred DESC
) AS tmp
GROUP BY id
ORDER BY population DESC
LIMIT 500;


SELECT * FROM (
	SELECT c.code, a.name
	FROM `geo_country` AS c
	INNER JOIN geo_alternate_name AS a ON a.geoname_id = c.geoname_id
	WHERE a.language_code = 'uk'
	ORDER BY is_preferred DESC
) AS tmp
GROUP BY code
ORDER BY name collate utf8_unicode_ci ASC