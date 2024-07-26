/* Creating the database*/

CREATE DATABASE worldcup2022;

USE worldcup2022;


/*Creating the tables*/


/*Create groups table*/
CREATE TABLE groups (
group_id VARCHAR(6),
group_name VARCHAR(30) NOT NULL,
group_start VARCHAR(11) NOT NULL, /*Length of date format*/
group_end VARCHAR(11) NOT NULL, /*Length of date format*/
PRIMARY KEY (group_id)
);

/*Create teams table*/
CREATE TABLE teams (
team_id VARCHAR(6),
team_country VARCHAR(32) NOT NULL,
played INT(3) NOT NULL,
matches_won INT(3) NOT NULL,
matches_drawn INT(3) NOT NULL,
matches_lost INT(3) NOT NULL,
group_id INT(6),
PRIMARY KEY (team_id),
FOREIGN KEY (group_id) REFERENCES groups(group_id)
);

/*Create players table*/
CREATE TABLE players (
player_id VARCHAR(6),
player_name VARCHAR(32) NOT NULL,
position VARCHAR(2) NOT NULL, /*this will be a position code such as GK or AM*/
player_age INT(2) NOT NULL,
matches_played INT(3) NOT NULL,
goals_scored INT(3) NOT NULL,
team_id INT(6),
PRIMARY KEY (player_id),
FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

/*Create managers table*/
CREATE TABLE managers (
manager_id VARCHAR(6),
manager_name VARCHAR(30) NOT NULL,
manager_age INT(3) NOT NULL,
years_coaching_experience INT(3),
team_id INT(6),
PRIMARY KEY (manager_id),
FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

/*Create staff table*/
CREATE TABLE staff (
staff_id VARCHAR(6),
staff_name VARCHAR(30) NOT NULL,
staff_age INT(8) NOT NULL,
staff_role VARCHAR(30) NOT NULL,
team_id INT(6),
PRIMARY KEY (staff_id),
FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

/*Create stadiums table*/
CREATE TABLE stadiums (
stadium_id VARCHAR(6),
stadium_name VARCHAR(30) NOT NULL,
stadium_capacity INT(8) NOT NULL,
no_matches_hosted INT(3),
opening_date VARCHAR(30) NOT NULL,
PRIMARY KEY (stadium_id)
);

/*Create matches table*/
CREATE TABLE matches (
match_id VARCHAR(6),
referee VARCHAR(30) NOT NULL,
match_date VARCHAR(30) NOT NULL,
match_time VARCHAR(30),
attendance INT(8)
stadium_id INT(6),
PRIMARY KEY (match_id),
FOREIGN KEY (stadium_id) REFERENCES stadiums(stadium_id)
);


/*Establishing the Composite table*/


/*Create groups table*/
CREATE TABLE teams_participate_in_matches (
match_id VARCHAR(6),
team_id VARCHAR(6),
team_goals INT(3),
opposition_goals INT(3) NOT NULL,
percent_posession INT(3) NOT NULL,
total_added_time INT(3) NOT NULL,
PRIMARY KEY (match_id, team_id),
CONSTRAINT FK1 FOREIGN KEY (match_id) REFERENCES matches(match_id),
CONSTRAINT FK2 FOREIGN KEY (team_id) REFERENCES teams(team_id)
);



/*Inserting Data into the tables*/


/*Insert groups table data*/
INSERT INTO groups VALUES
("GR0001", "Group A", "20-NOV-2022", "29-NOV-2022", 6),
("GR0002", "Group B", "21-NOV-2022", "29-NOV-2022", 6),
("GR0003", "Group C", "22-NOV-2022", "30-NOV-2022", 6),
("GR0004", "Group D", "22-NOV-2022", "30-NOV-2022", 6),
("GR0005", "Group E", "23-NOV-2022", "01-DEC-2022", 6);

/*Insert groups table data*/
INSERT INTO teams VALUES
("TE0001", "Argentina", 3, "GR0003", 2, 0, 1),
("TE0002", "Poland", 3, "GR0003", 1, 1, 1),
("TE0003", "Mexico", 3, "GR0003", 1, 1, 1),
("TE0004", "Saudi Arabia", 3, "GR0003", 1, 0, 2),
("TE0005", "France", 3, "GR0004", 2, 0, 1);

/*Insert players table data*/
INSERT INTO players VALUES
("PL000001", "Lionel Messi", "F", 35, 3, 2, "TE000001"),
("PL000002", "Robert Lewandowski", "ST", 34, 3, 1, "TE000002"),
("PL000003", "Kylian Mbappe", "F", 24, 3, 3, "TE000005"),
("PL000004", "Mohammed Al-Owais", "GK", 31, 3, 0, "TE000004"),
("PL000005", "Enzo Fernandez", "DM", 22, 3, 1, "TE000001");

/*Insert managers table data*/
INSERT INTO managers VALUES
("MA000001", "Lionel Scaloni", 44, 8,"TE000001"),
("MA000002", "Czeslaw Michniewicz", 53, 20, "TE000002"),
("MA000003", "Gerardo Martino", 60, 25,"TE000003"),
("MA000004", "Hervé Renard", 54, 24, "TE000004"),
("MA000005", "Didier Deschamps", 54, 23, "TE000005");

/*Insert staff table data*/
INSERT INTO staff VALUES
("ST000001", "Guy Stéphan", 66, "Assistant Coach", "TE000005"),
("ST000002", "Pablo Aimar", 43, "Assistant Coach", "TE000001"),
("ST000003", "Óscar Dautt", 46, "Goalkeeping Coach", "TE000003"),
("ST000004", "Mohammed Ameen", 42, "Assistant Coach", "TE000004"),
("ST000005", "Tomasz Muchiński", 57, "Goalkeeping Coach", "TE000002");

/*Insert stadiums table data*/
INSERT INTO stadiums VALUES
("SD000001", "Lusail Stadium", 88966, 6, "2021-11-21"),
("SD000002", "Education City Stadium", 44667, 6, "2020-06-15"),
("SD000003", "Stadium 974", 44089, 6, "2021-11-30"),
("SD000004", "Al-Janoub Stadium", 44325, 6, "2019-05-16"),
("SD000005", "Al-Bayt Stadium", 68895, 6, "2021-11-30");

/*Insert matches table data*/
INSERT INTO matches VALUES
("MT000001", "Slavko Vinčić", "2022-11-22", "13:00:00", 88012, "SD000001"),
("MT000002", "Chris Beath", "2022-11-22", "19:00:00", 39369, "SD000003"),
("MT000003", "Wilton Sampaio", "2022-11-26", "16:00:00", 44259, "SD000002"),
("MT000004", "Daniele Orsato", "2022-11-26", "22:00:00", 88966, "SD000001"),
("MT000005", "Michael Oliver", "2022-11-30", "22:00:00", 84985, "SD000001");

/*Insert teams_participate_in_matches table data*/
INSERT INTO teams_participate_in_matches VALUES
("MT000001", "TE000001", 1, 2,"1-2", 64, 21),
("MT000001", "TE000004", 2, 1,"1-2", 36, 21),
("MT000002", "TE000003", 0, 0,"0-0", 61, 11),
("MT000002", "TE000002", 0, 0,"0-0", 39, 11),
("MT000003", "TE000002", 2, 0,"2-0", 36, 18),
("MT000003", "TE000004", 0, 2,"2-0", 64, 18);


/*View created tables*/
SELECT * FROM groups_;
SELECT * FROM teams;
SELECT * FROM players;
SELECT * FROM managers;
SELECT * FROM staff;
SELECT * FROM stadiums;
SELECT * FROM matches;
SELECT * FROM teams_participate_in_matches;