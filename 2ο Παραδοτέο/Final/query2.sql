#which missions(name) have left a payload in a specific celestial body(Mars, on various orbits) and when
DROP TABLE IF EXISTS t2;

CREATE TEMPORARY TABLE t2 AS
SELECT destination_code
FROM final_destination
WHERE celestial_body = 'Mars';

SELECT name AS mission_name, payload_release_date AS release_date, celestial_body, orbit
FROM mission JOIN payload ON mission.mission_number = payload.mission_number
			 JOIN final_destination ON payload.destination_code = final_destination.destination_code
             WHERE final_destination.destination_code IN (SELECT destination_code FROM t2);