SELECT g.id, g.name, a.name AS native, g.feature_code, g.population
FROM geo_geoname AS g
LEFT JOIN geo_alternate_name AS a ON a.geoname_id = g.id
WHERE g.country = 'ua' 
	AND g.feature_class = 'p'
	AND a.language_code = 'uk'
	AND g.population > 15000
GROUP BY g.id
ORDER BY g.population DESC
LIMIT 500;


SELECT * FROM (
	SELECT g.id, g.name, a.name AS native, g.feature_code, g.population
	FROM geo_geoname AS g
	INNER JOIN geo_alternate_name AS a ON a.geoname_id = g.id
	WHERE g.country = 'ua'
    	AND g.feature_class = 'a'
	    AND a.language_code = 'uk'
	ORDER BY g.id, a.is_preferred DESC
) AS tmp
GROUP BY id
ORDER BY population DESC
LIMIT 500;