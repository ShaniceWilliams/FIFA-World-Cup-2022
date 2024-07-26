SELECT * FROM managers, teams
WHERE managers.team_id=teams.team_id;

/* Data to show the group of each team*/
SELECT teams.team_country, groups_.group_name FROM teams, groups_
WHERE teams.group_id=groups_.group_id;

/* Data to show the football stadium for each team game*/
SELECT s.stadium_name, m.match_id, t.team_country FROM matches AS m, stadiums AS s, teams_participate_in_matches AS tm, teams AS t
WHERE m.stadium_id=s.stadium_id AND tm.match_id=m.match_id AND t.team_id=tm.team_id ;

/* Data to count how many staff members are in the database per team*/
SELECT t.team_country, COUNT(s.staff_id) AS number_of_staff
FROM staff AS s, teams AS t
WHERE s.team_id = t.team_id
GROUP BY s.staff_id;

/* Data to find the teams that start with "Eng"*/
SELECT * FROM teams WHERE team_country LIKE 'Eng%';

/* Data to find the staff members per head coach*/
SELECT M.manager_name, S.staff_name
FROM teams AS T, staff AS S, managers AS M
WHERE S.team_id = T.team_id AND T.team_id = M.team_id;

/* Data to find the youngest manager*/
SELECT M.manager_id, M.manager_name, M.years_coaching_experience, M.manager_age FROM managers AS M
ORDER BY manager_age ASC LIMIT 1;

/* Data to find players between 22-30 years old (including 22 and 30)*/
SELECT p.player_name, p.player_age
FROM players AS p
WHERE p.player_age >= 22 AND p.player_age <= 30;

/* Data to find the average of age per football team*/
SELECT t.team_country, AVG(p.player_age) AS avg_age
FROM players AS P,teams AS t
WHERE p.team_id = t.team_id
GROUP BY t.team_country;
