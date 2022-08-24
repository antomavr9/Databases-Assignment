#which static spaceports of ESA are available for arrival in 2020-12-26
DROP TABLE IF EXISTS t41, t42, t43;

CREATE TEMPORARY TABLE t41 AS
SELECT spaceport_code
FROM spaceport
WHERE owner = "ESA" AND type = "static";

CREATE TEMPORARY TABLE t42 AS
SELECT launch_sp_code AS spaceport_code
FROM mission
WHERE launch_date = '2022-9-23';

CREATE TEMPORARY TABLE t43 AS
SELECT return_sp_code AS spaceport_code
FROM mission
WHERE return_date = '2022-9-23';

#subtraction and union
SELECT * FROM t41
WHERE spaceport_code NOT IN (SELECT * FROM t42 UNION SELECT * FROM t43);