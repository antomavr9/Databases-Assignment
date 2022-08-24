#view that contains the compartments every spaceship has, along with the name and the serial number of the spaceship
CREATE VIEW `parts_number` AS
SELECT name, spaceship.serial_number, COUNT(spaceship.serial_number) AS parts_number
FROM spaceship JOIN spaceship_part ON spaceship.serial_number = spaceship_part.spaceship_serial
GROUP BY spaceship_serial;