CREATE USER 'admin'@'localhost' IDENTIFIED BY 'superpassword';
CREATE USER 'admin'@'%' IDENTIFIED BY 'superpassword';
GRANT ALL PRIVILEGES ON SpaceXMissionDB.* TO 'admin'@'localhost';
GRANT ALL PRIVILEGES ON SpaceXMissionDB.* TO 'admin'@'%';

CREATE USER 'astronaut'@'localhost' IDENTIFIED BY 'astronaut';
CREATE USER 'astronaut'@'%' IDENTIFIED BY 'astronaut';
GRANT SELECT ON SpacexMissionDB.astronaut_is_assigned_to_mission TO 'astronaut'@'localhost';
GRANT SELECT ON SpacexMissionDB.astronaut_is_assigned_to_mission TO 'astronaut'@'%';
GRANT SELECT ON SpacexMissionDB.mission TO 'astronaut'@'localhost';
GRANT SELECT ON SpacexMissionDB.mission TO 'astronaut'@'%';
GRANT SELECT ON SpacexMissionDB.spaceship TO 'astronaut'@'localhost';
GRANT SELECT ON SpacexMissionDB.spaceship TO 'astronaut'@'%';
GRANT SELECT ON SpacexMissionDB.spaceport TO 'astronaut'@'localhost';
GRANT SELECT ON SpacexMissionDB.spaceport TO 'astronaut'@'%';
GRANT SELECT ON SpacexMissionDB.final_destination TO 'astronaut'@'localhost';
GRANT SELECT ON SpacexMissionDB.final_destination TO 'astronaut'@'%';


CREATE USER 'mechanic'@'localhost' IDENTIFIED BY 'mechanic';
CREATE USER 'mechanic'@'%' IDENTIFIED BY 'mechanic';
GRANT SELECT ON SpacexMissionDB.spaceship TO 'mechanic'@'loaclhost';
GRANT SELECT ON SpacexMissionDB.spaceship TO 'mechanic'@'%';
GRANT SELECT, INSERT, UPDATE ON SpacexMissionDB.spaceship_part TO 'mechanic'@'localhost';
GRANT SELECT, INSERT, UPDATE ON SpacexMissionDB.spaceship_part TO 'mechanic'@'%';

CREATE USER 'customer'@'%' IDENTIFIED BY 'customer';
GRANT SELECT ON SpacexMissionDB.astronaut TO 'customer'@'%';
GRANT SELECT ON SpacexMissionDB.payload TO 'customer'@'%';
GRANT SELECT ON SpacexMissionDB.final_destination TO 'customer'@'%';
GRANT SELECT ON SpacexMissionDB.spaceport TO 'customer'@'%';
GRANT SELECT ON SpacexMissionDB.mission TO 'customer'@'%';
