#in which future missions a specific astronaut(www www) will participate, what's the role he will have and when will they happen
SELECT astr_name.name, astronaut_role, launch_date, return_date
FROM mission JOIN astronaut_is_assigned_to_mission ON mission.mission_number = astronaut_is_assigned_to_mission.mission_number
			 JOIN ((SELECT id, name FROM astronaut WHERE name = "Kostas Dimitriou") AS astr_name) ON astronaut_is_assigned_to_mission.astronaut_id = astr_name.id;