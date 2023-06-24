import subprocess as sp
import pymysql
import pymysql.cursors
from prettytable import PrettyTable

def insertMatch():
    try:
        row = {}
        print("Enter match's details: ")

        row["Match_no"] = int(input("Match No.: "))
        row["Date"] = input("Date (YYYY-MM-DD): ")
        row["TeamA"] = input("Team A: ")
        row["TeamB"] = input("Team B: ")

        row["Time"] = input("Time (Afternoon/Evening): ")
        if (row["Time"] != "Afternoon" and row["Time"] != "Evening"):
            print("Wrong Time")
            return
        
        row["Stadium_name"] = input("Stadium Name: ")
        row["Team_won"] = input("Team Won: ")

        # Error handling of players
        
        row["Man_match_fname"] = input("First Name of man of the match: ")
        row["Man_match_lname"] = input("Last Name of man of the match: ")
        query = "SELECT Fname, Lname, Team_name FROM PLAYERS where Fname='%s' and Lname='%s'"%(
            row["Man_match_fname"], row["Man_match_lname"])
            
        cur.execute(query)
        rows = cur.fetchall()

        if (len(rows) == 0):
            print("Player", row["Man_match_fname"], row["Man_match_lname"], "does not exist")
            return

        # Error handling ends

        row["Umpire_fname"] = input("First Name of Umpire: ")
        row["Umpire_lname"] = input("Last Name of Umpire: ")

        query = "INSERT INTO MATCHES VALUES(%d, '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s','%s','%s')" % (
            row["Match_no"], row["Date"], row["TeamA"], row["TeamB"], row["Time"], row["Stadium_name"], row["Team_won"], row["Man_match_fname"], row["Man_match_lname"], row["Umpire_fname"], row["Umpire_lname"])

        cur.execute(query)
        con.commit()

        print("Inserted Into Database")

    except Exception as e:
        con.rollback()
        print("Failed to Insert into database")
        print(">>>", e)

    return


def deleteMatch():
    try:
        match_no = int(input("Enter match no. which is to be deleted: "))
        query = "DELETE FROM MATCHES WHERE Match_no = %d" % match_no
        cur.execute(query)
        con.commit()

        print("Deleted from Database")

    except Exception as e:
        con.rollback()
        print("Failed to Delete from database")
        print(">>>", e)

    return


def update_Totalruns():
    try:

        Jersey_no = int(input("Enter Jersey_no of the Player: "))
        Team_name = input("Enter the Team name of Player: ")
        Runs = int(input("Enter runs scored by the Player in Match: "))
        query = "UPDATE STATISTICS SET Total_runs = (Total_runs + %d) where Jersey_no = %d AND Team_name = '%s'" % (
            Runs, Jersey_no, Team_name)
        cur.execute(query)
        con.commit()

        print("Runs updated in Database")

    except Exception as e:
        con.rollback()
        print("Failed to update in database")
        print(">>>", e)

    return


def update_Maxruns():
    try:

        Jersey_no = int(input("Enter Jersey_no of the Player: "))
        Team_name = input("Enter the Team name of Player: ")
        Runs = int(input("Enter runs scored by the Player in Match: "))

        query = "SELECT Max_runs from STATISTICS where Jersey_no = %d AND Team_name = '%s'" % (
            Jersey_no, Team_name)

        cur.execute(query)
        Max_runs = cur.fetchone()["Max_runs"] # returns a dict with key-value pair

        if (Runs < Max_runs):
            print("Error: Max runs scored Already is", Max_runs)

        else:
            query = "UPDATE STATISTICS SET Max_runs = %d where Jersey_no = %d AND Team_name = '%s'" % (
                Runs, Jersey_no, Team_name)
            cur.execute(query)
            con.commit()

        print("Runs updated in Database")

    except Exception as e:
        con.rollback()
        print("Failed to update in database")
        print(">>>", e)

    return


def update_Wickets_taken():
    try:

        Jersey_no = int(input("Enter Jersey_no of the Player: "))
        Team_name = input("Enter the Team name of Player: ")
        Wickets = int(input("Enter wickets taken by player in Match: "))
        
        query = "UPDATE STATISTICS SET Wickets_taken = Wickets_taken + %d where Jersey_no = %d AND Team_name = '%s'" % (
            Wickets, Jersey_no, Team_name)
        cur.execute(query)
        con.commit()

        print("Wickets updated in Database")

    except Exception as e:
        con.rollback()
        print("Failed to update in database")
        print(">>>", e)

    return

def printData(rows):    
    i = 0
    if(len(rows)==0):
        print("No tuple exists")
        return

    for row in rows:
        if (i == 0):
            headings=[]
            for col in row:
                headings.append(col)
            x=PrettyTable(headings) 
            i = 1

        l=[]    
        for col in row.values():
            l.append(col)

        x.add_row(l)    
    print(x)


def retrieveStatsOfPlayersOfTeam():
    try:
        Team_name = input(
            "Enter Team name whose player statistics you want to see: ")
        query = "SELECT * FROM STATISTICS WHERE Team_name = '%s'" % Team_name
        cur.execute(query)
        rows = cur.fetchall()

        printData(rows)

    except Exception as e:
        con.rollback()
        print("Failed to Retrieve data from database")
        print(">>>", e)

    return


def retrieveDataMatchesWonByTeam():
    try:
        Team_name = input(
            "Enter Team name whose data of all matches won you want to see: ")
        query = "SELECT * FROM MATCHES WHERE Team_won = '%s'" % Team_name
        cur.execute(query)
        rows = cur.fetchall()

        printData(rows)

    except Exception as e:
        con.rollback()
        print("Failed to Retrieve data from database")
        print(">>>", e)

    return


def retrieveDataMatchesPlayedAtStadium():
    try:
        Stadium_name = input(
            "Enter Stadium name whose data of all matches played you want to see: ")
        query = "SELECT * FROM MATCHES WHERE Stadium_name = '%s'" % Stadium_name
        cur.execute(query)
        rows = cur.fetchall()

        printData(rows)

    except Exception as e:
        con.rollback()
        print("Failed to Retrieve data from database")
        print(">>>", e)

    return


def projectTeamsWonAfterDate():
    try:
        Date = input(
            "Enter Date after which you want to see name of all teams that won: ")
        query = "SELECT Team_won FROM MATCHES WHERE Date > '%s'" % Date
        cur.execute(query)
        rows = cur.fetchall()

        printData(rows)

    except Exception as e:
        con.rollback()
        print("Failed to Retrieve data from database")
        print(">>>", e)

    return


def projectPlayersAverageMoreThanx():
    try:
        
        Avg = int(input("Enter min batting Average of Player: "))
        query = "select distinct fname, lname from PLAYERS P, STATISTICS S, MATCHES M where S.Jersey_no=P.Jersey_no and S.Team_name=P.Team_name and (Total_runs/(select count(*) from MATCHES where M.TeamA=P.Team_name OR M.TeamB=P.Team_name)) > %d" %(
            Avg)
        cur.execute(query)
        rows = cur.fetchall()
        printData(rows)

    except Exception as e:
        con.rollback()
        print("Failed to Retrieve data from database")
        print(">>>", e)

    return


def projectNationalityOfCoachesOfTeam():
    try:
        Team_name = input(
            "Enter Team name whose nationality of coaches you want to see: ")
        query = "SELECT NATIONALITY FROM COACH WHERE Team_name = '%s'" % Team_name
        cur.execute(query)
        rows = cur.fetchall()

        printData(rows)

    except Exception as e:
        con.rollback()
        print("Failed to Retrieve data from database")
        print(">>>", e)

    return


def aggregateAverageRunsByPlayersOfTeam():
    
    try:
        Team_name = input("Enter Team name: ")
        query = "with A AS (select count(*) AS num from MATCHES M where M.teama='%s' or M.teamb='%s') select fname, lname, S.total_runs/A.num AS Avg_runs from STATISTICS S , PLAYERS P, A where S.jersey_no=P.jersey_no and S.team_name=P.team_name and  P.team_name='%s'"%(
            Team_name, Team_name, Team_name)
        cur.execute(query)
        rows = cur.fetchall()

        printData(rows)

    except Exception as e:
        con.rollback()
        print("Failed to Retrieve data from database")
        print(">>>", e)

    return


def aggregateTotalWicketsByTeam():
    try:
        Team_name = input(
            "Enter Team name whose total number of wickets you want to see: ")
        query = "SELECT SUM(Wickets_taken) FROM STATISTICS WHERE Team_name = '%s'" % Team_name
        cur.execute(query)
        rows = cur.fetchall()

        printData(rows)

    except Exception as e:
        con.rollback()
        print("Failed to Retrieve data from database")
        print(">>>", e)

    return


def aggregateMaxTotalRuns():
    try:
        query = "SELECT MAX(Total_runs) FROM STATISTICS"
        cur.execute(query)
        rows = cur.fetchall()

        printData(rows)

    except Exception as e:
        con.rollback()
        print("Failed to Retrieve data from database")
        print(">>>", e)

    return


def searchNamePlayersWithPrefix():
    try:
        pre = input("Enter the prefix of Player Name: ")
        query = "select fname, lname from PLAYERS where fname like '%s%%'" % pre
        cur.execute(query)
        rows = cur.fetchall()

        printData(rows)

    except Exception as e:
        con.rollback()
        print("Failed to Retrieve data from database")
        print(">>>", e)

    return

def searchNameTeamsWithSuffix():
    try:
        suf = input("Enter the suffix of Team name: ")
        query = "select Team_name from TEAMS where Team_name like '%%%s'"% suf
        cur.execute(query)
        rows = cur.fetchall()

        printData(rows)

    except Exception as e:
        con.rollback()
        print("Failed to Retrieve data from database")
        print(">>>", e)

    return

def analysisNumberPlayersTotalScoreAboveAverage():
    try:
        query = "select count(*) from STATISTICS S where total_runs > (select avg(total_runs) from STATISTICS);"
        cur.execute(query)
        rows = cur.fetchall()

        printData(rows)

    except Exception as e:
        con.rollback()
        print("Failed to Retrieve data from database")
        print(">>>", e)

    return

def analysisNumberTeamsWithTotalWicketsLessThanGiven():
    try:
        wickets=int(input("Enter number of wicket: "))
        query = "select count(*) as Number_ofTeams from (select P.Team_name from PLAYERS P, STATISTICS S where P.jersey_no=S.jersey_no and P.team_name=S.team_name group by S.team_name having sum(wickets_taken) < %d) as P"%(
            wickets)
        cur.execute(query)
        rows = cur.fetchall()

        printData(rows)

    except Exception as e:
        con.rollback()
        print("Failed to Retrieve data from database")
        print(">>>", e)

    return 


def runSQLquery():
    try:
        query=input("Enter the query: ")
        cur.execute(query)
        rows = cur.fetchall()

        printData(rows)

    except Exception as e:
        con.rollback()
        print("Failed to execute query")
        print(">>>", e)

    return 


def dispatch(ch):
    """
    Function that maps helper functions to option entered
    """

    if (ch == 1):
        insertMatch()
    elif (ch == 2):
        deleteMatch()
    elif (ch == 3):
        update_Totalruns()
    elif (ch == 4):
        update_Maxruns()
    elif (ch == 5):
        update_Wickets_taken()
    elif (ch == 6):
        retrieveStatsOfPlayersOfTeam()
    elif (ch == 7):
        retrieveDataMatchesWonByTeam()
    elif (ch == 8):
        retrieveDataMatchesPlayedAtStadium()
    elif (ch == 9):
        projectTeamsWonAfterDate()
    elif (ch == 10):
        projectPlayersAverageMoreThanx()
    elif (ch == 11):
        projectNationalityOfCoachesOfTeam()
    elif(ch==12):
        aggregateAverageRunsByPlayersOfTeam()    
    elif (ch == 13):
        aggregateTotalWicketsByTeam()
    elif (ch == 14):
        aggregateMaxTotalRuns()
    elif (ch == 15):
        searchNamePlayersWithPrefix()
    elif (ch == 16):
        searchNameTeamsWithSuffix()
    elif (ch == 17):
        analysisNumberPlayersTotalScoreAboveAverage()
    elif (ch == 18):
        analysisNumberTeamsWithTotalWicketsLessThanGiven()  
    elif (ch == 19):
        runSQLquery()


    else:
        print("Error: Invalid Option")


# Global
while (1):
    tmp = sp.call('clear', shell=True)
    try:
        con = pymysql.connect(host='localhost',
                              port=3306,
                              user="root",
                              password="Nikunj@6636",
                              db='WORLDCUP',
                              cursorclass=pymysql.cursors.DictCursor)

        tmp = sp.call('clear', shell=True)

        if (con.open):
            print("Connected")
        else:
            print("Failed to connect")

        tmp = input("Enter any key to CONTINUE>")

        with con.cursor() as cur:
            while (1):
                tmp = sp.call('clear', shell=True)
                print("1. Insert - Insert into Matches")
                print("2. Delete - Delete Match")
                print("3. Update - Update Total runs of Player")
                print("4. Update - Update Max runs of Player")
                print("5. Update - Update Wickets_taken of player")
                print("6. Retrieval - Retrieve Statistics of all players belonging to a Team")
                print("7. Retrieval - Retrieve data of all the matches won by a Team")
                print("8. Retrieval - Retrieve data of all matches played at a given stadium")
                print(
                    "9. Projection - Project Name of all teams that win the match on or after a given date")
                print(
                    "10. Projection - Project Name of all players having average run greater than 20")
                print("11. Projection - Project Nationality of all coaches of a given country")
                print("12. Aggregate - Calculate the average runs scored by each player of a given team")
                print("13. Aggregate - Calculate the total number of wickets taken by a team")
                print("14. Aggregate - Find Max total runs scored by a player in tournament")
                print("15. Search - Find Name of all the players with prefix of their name")
                print("16. Search - Find Name of all the teams with suffix of their names")
                print("17. Analysis - Find Number of players whose total score is above average in the tournment")
                print("18. Analysis - Find the number of teams whose total wickets taken is less than the given number")
                print("19. Write any SQL Query")
                print("20. Logout")
                ch = int(input("Enter choice> "))
                tmp = sp.call('clear', shell=True)
                if ch == 20:
                    exit()
                else:
                    dispatch(ch)
                    tmp = input("Enter any key to CONTINUE>")

    except Exception as e:
        tmp = sp.call('clear', shell=True)
        print(e)
        print("Connection Refused: Either username or password is incorrect or user doesn't have access to database")
        tmp = input("Enter any key to CONTINUE>")
