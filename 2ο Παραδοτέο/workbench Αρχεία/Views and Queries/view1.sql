#view that contains all the serial number and the name of the spaceships
#that have been already used at least once
CREATE VIEW `used_spaceships` AS
SELECT name, serial_number
FROM spaceship
WHERE state_of_use = TRUE;