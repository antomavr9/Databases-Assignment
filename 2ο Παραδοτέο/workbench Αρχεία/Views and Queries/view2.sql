#view that contains all the serial number of the spaceships
#that have fully passed checking
#(meaning that all their parts have a certificate)

#assisting view that contains the spaceship serials and if they are certified
CREATE VIEW `temp_checked_spaceships` AS
SELECT spaceship_serial, MIN(certification) AS passed_checking
FROM spaceship_part
GROUP BY spaceship_serial;

CREATE VIEW `checked_spaceships` AS
SELECT spaceship_serial
FROM temp_checked_spaceships 
WHERE passed_checking = TRUE;