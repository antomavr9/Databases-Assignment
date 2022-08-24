#show the launch and return date and spaceport of a specific mission(Mars9)
SELECT mission.name, launch_date, return_date, launch_sp.name AS launch_sp_name, return_sp.name AS return_sp_name
FROM mission JOIN spaceport AS launch_sp ON mission.launch_sp_code = launch_sp.spaceport_code
			 JOIN spaceport AS return_sp ON mission.return_sp_code = return_sp.spaceport_code
WHERE mission.name = "Mars9";