import mysql.connector


def create_db_connection(host_name, user_name, user_password, db_name):
    conn = None
    try:
        conn = mysql.connector.connect(
            host=host_name,
            user=user_name,
            passwd=user_password,
            database=db_name
        )
        print("MySQL Database connection successful")
    except Error as err:
        print(f"Error: '{err}'")
    return conn


host = "localhost"
user = "root"
password = "123456"
database = "worldcup2022"

connection = create_db_connection(host, user, password, database)

cursor = connection.cursor()


#Export data about football players
def showplayerinfo(player_name):
    query = """ SELECT * FROM players WHERE player_name=%s """
    cursor.execute(query, (player_name,))
    result = cursor.fetchall()
    return result


player_name = input("Which player's data would you like to see? ")

data = showplayerinfo(player_name)

print(f"Please see {player_name}'s data below:")
print(f" Player ID: {data[0][0]}")
print(f" Player name: {data[0][1]}")
print(f" Player position: {data[0][2]}")
print(f" Player matches played: {data[0][3]}")
print(f" Player goals scored: {data[0][4]}")
print(f" Team ID: {data[0][5]}")


def managerandteaminfo(manager_name):
    query = """ SELECT * FROM managers, teams
                WHERE managers.team_id=teams.team_id
                AND manager_name=%s"""
    cursor.execute(query, (manager_name,))
    result = cursor.fetchall()
    return result

manager_name = input("Which manager's data would you like to see? ")

data = managerandteaminfo(manager_name)

print(f"""Please see {manager_name}'s and their teams data below:\n
            Manager ID: {data[0][0]}
            Manger name: {data[0][1]}
            Age: {data[0][2]}
            Years Coaching Experience: {data[0][3]}
            Team managing: {data[0][6]}
            _Group Stage Record_
            Matches played: {data[0][7]}
            Matches won: {data[0][8]}
            Matches drawn: {data[0][9]}
            Matches lost: {data[0][10]}
            """)


def find_group(team_name):
    query = """SELECT teams.team_country, groups_.group_name
                FROM teams, groups_
                WHERE teams.group_id=groups_.group_id
                AND teams.team_country=%s"""
    cursor.execute(query, (team_name,))
    result = cursor.fetchall()
    return result

team_name = input("Which team's group would you like to find out? ")

data = find_group(team_name)

print(f"""Please see your results below:\n
            Team Name: {data[0][0]}
            Group: {data[0][1]}
            """)

def find_match_stadium(match_id):
    query = """SELECT m.match_id, s.stadium_name
    FROM matches AS m, stadiums AS s
    WHERE m.stadium_id=s.stadium_id AND m.match_id=%s"""
    cursor.execute(query, (match_id,))
    result = cursor.fetchall()
    return result

match_id = input("Enter the Match ID to find the stadium the match was played in? ")

data = find_match_stadium(match_id)

print(f"""Please see your results below:\n
            Match ID: {data[0][0]}
            Stadium Name: {data[0][1]}
            """)



def number_of_staff(team_name):
    query = """SELECT t.team_country, COUNT(s.staff_id) AS number_of_staff
    FROM staff AS s, teams AS t
    WHERE s.team_id = t.team_id AND t.team_country=%s
    GROUP BY s.staff_id;"""
    cursor.execute(query, (team_name,))
    result = cursor.fetchall()
    return result

team_name = input("Please enter the team name: ")

data = number_of_staff(team_name)

print(f"""Please see your results below:\n
            Team Name: {data[0][0]}
            Number of Staff: {data[0][1]}
            """)