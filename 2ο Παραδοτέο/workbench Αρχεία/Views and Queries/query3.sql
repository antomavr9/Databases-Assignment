#which astronauts have flown with all spaceship types
DROP TABLE IF EXISTS t31, t32, t33;

CREATE TEMPORARY TABLE t31 AS
SELECT astronaut_id, type
FROM spaceship JOIN mission ON spaceship.serial_number = mission.spaceship_serial
			   JOIN astronaut_is_assigned_to_mission ON mission.mission_number = astronaut_is_assigned_to_mission.mission_number
               WHERE astronaut_id IN (SELECT astronaut_id FROM astronaut);

#copy of t31
CREATE TEMPORARY TABLE t33 AS 
SELECT astronaut_id, type
FROM spaceship JOIN mission ON spaceship.serial_number = mission.spaceship_serial
			   JOIN astronaut_is_assigned_to_mission ON mission.mission_number = astronaut_is_assigned_to_mission.mission_number
               WHERE astronaut_id IN (SELECT astronaut_id FROM astronaut);

CREATE TEMPORARY TABLE t32 AS
SELECT DISTINCT type
FROM spaceship;

#division
#implemented according to the pdf on http://www.cs.kent.edu/~xlian/old_courses/CSCI4333_2014fall/MySQL-set-operators.pdf
SELECT DISTINCT t31.astronaut_id AS astronaut_id
FROM t31
WHERE NOT EXISTS  
	(SELECT * FROM t32
     WHERE NOT EXISTS (SELECT * FROM t33 WHERE t33.astronaut_id = t31.astronaut_id AND t33.type = t32.type));