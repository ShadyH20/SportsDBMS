-- CREATE DATABASE SportsDraft;
GO

CREATE PROCEDURE createAllTables
AS
   CREATE TABLE SystemUser(
       username VARCHAR(20) PRIMARY KEY,
       password VARCHAR(20)
   )
   CREATE TABLE SystemAdmin(
       username VARCHAR(20) FOREIGN KEY REFERENCES SystemUser ON DELETE CASCADE ON UPDATE CASCADE,
       id INT IDENTITY PRIMARY KEY,
       name VARCHAR(20)
   )
   CREATE TABLE Fan(
       username VARCHAR(20) FOREIGN KEY REFERENCES SystemUser ON DELETE CASCADE ON UPDATE CASCADE,
       national_id VARCHAR(20) PRIMARY KEY, -----CHANGED TO VARCHAR
       birth_date DATE,
       phone_num INT,
       fan_name VARCHAR(20),
       address VARCHAR(20),
       unblocked BIT DEFAULT 1
   )
   CREATE TABLE SportsAssociationManager(
       username VARCHAR(20) FOREIGN KEY REFERENCES SystemUser ON DELETE CASCADE ON UPDATE CASCADE,
       id INT IDENTITY PRIMARY KEY,
       manager_name VARCHAR(20)
   )
   CREATE TABLE Club(
       id INT IDENTITY PRIMARY KEY,
       club_name VARCHAR(20),
       location VARCHAR(20)
   )
   CREATE TABLE Stadium(
       id INT IDENTITY PRIMARY KEY,
       stadium_name VARCHAR(20),
       available BIT DEFAULT 1,
       capacity INT,
       location VARCHAR(20)
   )
   CREATE TABLE Match(
       id INT IDENTITY PRIMARY KEY,
       start_time DATETIME,
       end_time DATETIME,
       stadium_id INT FOREIGN KEY REFERENCES Stadium(id) ON DELETE CASCADE ON UPDATE CASCADE,
       host_club_id INT FOREIGN KEY REFERENCES Club(id) ON DELETE CASCADE ON UPDATE CASCADE,
       guest_club_id INT FOREIGN KEY REFERENCEs Club(id) ON DELETE NO ACTION ON UPDATE NO ACTION, ----- delete or set null when delete club
       UNIQUE(host_club_id, guest_club_id, start_time)
   )
   CREATE TABLE Ticket(
       id INT IDENTITY PRIMARY KEY,
       match_id INT FOREIGN KEY REFERENCES Match(id) ON DELETE CASCADE ON UPDATE CASCADE,
       fan VARCHAR(20) FOREIGN KEY REFERENCES Fan(national_id) ON DELETE CASCADE ON UPDATE CASCADE,
       stadium_id INT FOREIGN KEY REFERENCES Stadium(id) ON DELETE NO ACTION ON UPDATE NO ACTION, -- delete tickets before deleting stadium
       available BIT DEFAULT 1
   )
   CREATE TABLE StadiumManager(
       username VARCHAR(20) FOREIGN KEY REFERENCES SystemUser ON DELETE CASCADE ON UPDATE CASCADE,
       id INT IDENTITY PRIMARY KEY ,
       manager_name VARCHAR(20),
       stadium_id INT FOREIGN KEY REFERENCES Stadium(id) ON DELETE CASCADE ON UPDATE CASCADE
   )
   CREATE TABLE ClubRepresentative(
       username VARCHAR(20) FOREIGN KEY REFERENCES SystemUser ON DELETE CASCADE ON UPDATE CASCADE,
       id INT IDENTITY PRIMARY KEY,
       representative_name VARCHAR(20),
       club_id INT FOREIGN KEY REFERENCES Club(id) ON DELETE CASCADE ON UPDATE CASCADE
   )
   CREATE TABLE RequestHosting(
       representative_id INT FOREIGN KEY REFERENCES ClubRepresentative(id) ON DELETE CASCADE ON UPDATE CASCADE,
       stadium_manager INT FOREIGN KEY REFERENCES StadiumManager(id) ON DELETE NO ACTION ON UPDATE NO ACTION, --delete RequestHosting when deleting SM
       match_id INT FOREIGN KEY REFERENCES Match(id) ON DELETE NO ACTION ON UPDATE NO ACTION, --delete RequestHosting when deleting Match
       approved BIT,
       PRIMARY KEY (representative_id,stadium_manager,match_id)
);
-- DROP PROCEDURE createAllTables
 
GO
CREATE PROCEDURE dropAllTables
AS
DROP TABLE RequestHosting;
DROP TABLE ClubRepresentative
DROP TABLE StadiumManager
DROP TABLE Ticket
DROP TABLE Match
DROP TABLE Stadium
DROP TABLE Club
DROP TABLE SportsAssociationManager
DROP TABLE Fan
DROP TABLE SystemAdmin
DROP TABLE SystemUser

GO
CREATE PROCEDURE dropAllProceduresFunctionsViews
AS
DROP PROC createAllTables
DROP PROC dropAllTables
DROP PROC clearAllTables
DROP VIEW allAssocManagers
DROP VIEW allClubRepresentatives
DROP VIEW allStadiumManagers
DROP VIEW allFans
DROP VIEW allMatches
DROP VIEW allTickets
DROP VIEW allCLubs
DROP VIEW allStadiums
DROP VIEW allRequests
DROP PROC addAsscoiationManager
DROP PROC addNewMatch
DROP VIEW clubsWithNoMatches
DROP PROC deleteMatch
DROP PROC deleteMatchesOnStadium
DROP PROC addClub
DROP PROC addTicket
DROP PROC deleteClub
DROP PROC addStadium
DROP PROC deleteStadium
DROP PROC blockFan
DROP PROC unblockFan
DROP PROC addRepresentative
DROP FUNCTION viewAvailableStadiumsOn
DROP PROC addHostRequest
DROP FUNCTION allUnassignedMatches
DROP PROC addStadiumManager
DROP FUNCTION allPendingRequests
DROP PROC acceptRequest
DROP PROC rejectRequest
DROP PROC addFan
DROP FUNCTION upcomingMatchesOfClub
DROP FUNCTION availableMatchesToAttend
DROP PROC purchaseTicket
DROP PROC updateMatchHost
DROP VIEW matchesPerTeam
DROP VIEW clubsNeverMatched
DROP FUNCTION clubsNeverPlayed
DROP FUNCTION matchWithHighestAttendance
DROP FUNCTION matchesRankedByAttendance
DROP FUNCTION requestsFromClub 
DROP PROC dropAllProceduresFunctionsViews
DROP PROCEDURE checkUser
DROP PROCEDURE noRepClubs
DROP PROCEDURE noRepClubs
DROP PROCEDURE noManStadiums
DROP PROCEDURE clubInfo
DROP PROCEDURE userType
DROP PROCEDURE upcomingMatches
DROP PROCEDURE availableStadiums 
DROP FUNCTION viewAvailableMatchesOn
DROP FUNCTION viewAvailableMatchesOn
DROP PROC ViewStadManagerStadium
DROP PROC ViewUpcoming
DROP PROC ViewPlayed
DROP PROC ViewClashed
DROP PROC AllClubNames
DROP PROC AllClubNames
DROP PROC allManagerRequests
DROP FUNCTION checkExistsReq



 
GO
CREATE PROCEDURE clearAllTables
AS
EXEC sp_MSForEachTable 'DISABLE TRIGGER ALL ON ?'
EXEC sp_MSForEachTable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL'
EXEC sp_MSForEachTable 'SET QUOTED_IDENTIFIER ON; DELETE FROM ?'
EXEC sp_MSForEachTable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL'
EXEC sp_MSForEachTable 'ENABLE TRIGGER ALL ON ?'
-- DROP PROC clearAllTables
 
---- BEGINNING OF 2.2 ----

GO -- a)
CREATE VIEW allAssocManagers AS
SELECT U.username, U.password, SAM.manager_name
FROM SportsAssociationManager SAM, SystemUser U
WHERE U.username = SAM.username;
 

GO -- b)
CREATE VIEW  allClubRepresentatives AS
SELECT U.username, U.password, CR.representative_name, C.club_name
FROM SystemUser U, ClubRepresentative CR INNER JOIN Club C ON CR.id = C.id
WHERE U.username = CR.username;

 
GO -- c)
CREATE VIEW  allStadiumManagers AS
SELECT U.username, U.password, SM.manager_name, S.stadium_name
FROM SystemUser AS U, StadiumManager AS SM INNER JOIN Stadium AS S ON SM.id = S.id
WHERE U.username = SM.username;

 
GO -- d)
CREATE VIEW allFans AS
SELECT F.username,U.password, F.fan_name, F.national_id, F.birth_date, F.unblocked
FROM Fan F, SystemUser U
WHERE U.username = F.username;

 
GO -- e)
CREATE VIEW allMatches AS
SELECT C1.club_name Host, C2.club_name Guest, M.start_time
FROM Match M INNER JOIN Club C1 ON C1.id = M.host_club_id
INNER JOIN Club C2 ON C2.id = M.guest_club_id;
 
GO -- f) ✅
CREATE VIEW allTickets AS
SELECT C1.club_name Host, C2.club_name Guest, S.stadium_name, M.start_time
FROM Match M INNER JOIN Stadium S ON M.stadium_id = S.id
INNER JOIN Club C1 ON M.host_club_id = C1.id
INNER JOIN Club C2 ON M.guest_club_id = C2.id
INNER JOIN Ticket T ON T.match_id = M.id
-- DROP VIEW allTickets
 
 
GO -- g)
CREATE VIEW allClubs AS
SELECT C.club_name, C.location
FROM club AS C;
 
GO -- h)
CREATE VIEW allStadiums AS
SELECT S.stadium_name, S.location, S.capacity, S.available
FROM Stadium AS S;
 
GO -- i)
CREATE VIEW allRequests AS  -- change to usernames not names
SELECT CR.representative_name, SM.manager_name, R.approved
FROM RequestHosting R INNER JOIN ClubRepresentative CR ON R.representative_id = CR.id
    INNER JOIN StadiumManager SM ON R.stadium_manager = SM.id;
 
---- BEGINNING OF 2.3 ----

GO -- i ✅
CREATE PROC addAssociationManager
@name VARCHAR(20),
@UserName VARCHAR(20),
@password VARCHAR(20)
AS
INSERT INTO SystemUser(username, password) VALUES (@UserName, @password)
INSERT INTO SportsAssociationManager(manager_name, username) VALUES(@name,@UserName)

GO -- ii ✅
CREATE PROC addNewMatch
@hostClubName VARCHAR(20),
@guestClubName VARCHAR(20),
@startTime DATETIME,
@endTime DATETIME
AS
DECLARE @id1 INT
DECLARE @id2 INT
SET @id1 = (SELECT id FROM Club WHERE club_name = @hostClubName)
SET @id2 = (SELECT id FROM Club WHERE club_name = @guestClubName)
INSERT INTO Match VALUES(@startTime,@endTime,NULL,@id1,@id2)
 
GO -- iii ✅
CREATE VIEW clubsWithNoMatches 
AS
SELECT club_name FROM Club C 
WHERE NOT EXISTS (SELECT M.id FROM Match M, Club H, Club G
                    WHERE M.host_club_id = H.id AND M.guest_club_id = G.id
                    AND (H.id = C.id OR G.id = C.id))

GO -- iv ✅
CREATE PROC deleteMatch
@hostclub VARCHAR(20),
@guestclub VARCHAR(20)
AS
DELETE FROM RequestHosting
WHERE match_id IN (SELECT M.id FROM Match M, Club H, Club G
                    WHERE M.host_club_id = H.id AND M.guest_club_id = G.id
                    AND H.club_name = @hostclub AND G.club_name = @guestclub)
DELETE FROM Match                   
WHERE host_club_id = (SELECT C.id FROM Club C WHERE C.club_name = @hostclub)
AND guest_club_id = (SELECT C.id FROM Club C WHERE C.club_name = @guestclub)
 
GO -- v ✅
CREATE PROC deleteMatchesOnStadium
@stadiumName VARCHAR(20)
AS
DELETE FROM RequestHosting
    WHERE match_id IN (SELECT M.id FROM Stadium S INNER JOIN Match M ON M.stadium_id = S.id AND S.stadium_name = @stadiumName
                    WHERE M.start_time > CURRENT_TIMESTAMP)
DELETE FROM Match 
    WHERE id IN (SELECT M.id FROM Stadium S INNER JOIN Match M ON M.stadium_id = S.id AND S.stadium_name = @stadiumName
                    WHERE M.start_time > CURRENT_TIMESTAMP)
-- DROP PROC deleteMatchesOnStadium
 
GO -- vi ✅
CREATE PROC addClub
@clubname VARCHAR(20),
@clubLocation VARCHAR(20)
AS
INSERT INTO Club(club_name, location) VALUES(@clubname, @clubLocation)
 
GO -- vii ✅
CREATE PROC addTicket
@hostclub VARCHAR(20),
@awayclub VARCHAR(20),
@starttime DATETIME
AS
DECLARE @id1 INT
DECLARE @id2 INT
SET @id1 = (SELECT id FROM Club WHERE club_name = @hostclub)
SET @id2 = (SELECT id FROM Club WHERE club_name = @awayclub)
INSERT INTO Ticket SELECT M.id, NULL, M.stadium_id, 1 FROM Match M
                    WHERE host_club_id = @id1 AND guest_club_id = @id2
                    AND start_time = @starttime
-- DROP PROC addTicket
 
GO -- viii
CREATE PROC deleteClub -- ✅ 
@clubName VARCHAR(20)
AS
DECLARE @id1 INT
DECLARE @userrepname VARCHAR(20)
DECLARE @guestclub VARCHAR(20)
SET @id1  = (SELECT CR.id FROM ClubRepresentative CR INNER JOIN Club C ON CR.club_id = C.id
                WHERE C.club_name = @clubName)
SET @userrepname = (SELECT SU.username FROM ClubRepresentative CR INNER JOIN SystemUser SU ON CR.username = SU.username
                      WHERE CR.id = @id1)
DELETE FROM SystemUser WHERE username = @userrepname

DELETE FROM RequestHosting WHERE match_id IN (SELECT M.id FROM Match M INNER JOIN Club C ON M.guest_club_id = C.id
                                WHERE C.club_name = @clubName)
DELETE FROM Match WHERE id IN (SELECT M.id FROM Match M INNER JOIN Club C ON M.guest_club_id = C.id
                                WHERE C.club_name = @clubName)
DELETE FROM Club WHERE club_name = @clubName
-- DROP PROC deleteClub
 
GO -- ix ✅
CREATE PROC addStadium
@stadiumname VARCHAR(20),
@stadiumlocation VARCHAR(20),
@stadiumcapacity INT
AS
INSERT INTO Stadium(stadium_name,location, capacity) VALUES(@stadiumname, @stadiumlocation, @stadiumcapacity)

GO --x ✅
CREATE PROC deleteStadium
@stadiumname VARCHAR(20)
AS
DELETE FROM RequestHosting WHERE stadium_manager = (SELECT SM.id FROM StadiumManager SM, Stadium S
                                                    WHERE SM.stadium_id = S.id AND S.stadium_name = @stadiumname)

DELETE FROM SystemUser WHERE username = (SELECT SM.username FROM StadiumManager SM, Stadium S
                                        WHERE SM.stadium_id = S.id AND S.stadium_name = @stadiumname)
DELETE FROM Ticket WHERE id IN (SELECT T.id FROM Ticket T, Stadium S
                                WHERE T.stadium_id = S.id AND S.stadium_name = @stadiumname)
DELETE FROM Stadium WHERE stadium_name = @stadiumname
-- DROP PrOC deleteStadium

--- from xi to xx ---

GO --xi ✅
CREATE PROC blockFan
@national_id VARCHAR(20)
AS
UPDATE Fan
SET unblocked = 0
WHERE national_id = @national_id

GO --xii ✅
CREATE PROC unblockFan
@national_id VARCHAR(20)
AS
UPDATE Fan
SET unblocked = 1
WHERE national_id = @national_id

GO --xiii ✅
CREATE PROC addRepresentative
@name VARCHAR(20), 
@club_name VARCHAR(20),
@username VARCHAR(20),
@password VARCHAR(20)
AS
INSERT INTO SystemUser values (@username, @password)
INSERT INTO ClubRepresentative
SELECT @username, @name ,id FROM Club WHERE club_name = @club_name

GO --xiv ✅
CREATE FUNCTION viewAvailableStadiumsOn
(@date datetime)
RETURNS TABLE
RETURN(
    SELECT stadium_name, location, capacity
    FROM Stadium S
    WHERE available = 1
    AND NOT EXISTS (SELECT start_time FROM Match WHERE stadium_id = S.id AND start_time <= @date AND @date < end_time )
)
-- DROP FUNCTION viewAvailableStadiumsOn

GO --xv
CREATE PROC addHostRequest -- ✅
@club_name VARCHAR(20),
@stadium_name VARCHAR(20),
@start_time DATETIME
AS
IF (SELECT available FROM Stadium S WHERE S.stadium_name = @stadium_name) = 1 BEGIN
    INSERT INTO RequestHosting
    SELECT CR.id, SM.id, M.id, NULL FROM Club C INNER JOIN ClubRepresentative CR ON C.id = CR.club_id 
    INNER JOIN Match M ON M.host_club_id = C.id , Stadium S  
    INNER JOIN StadiumManager SM ON SM.stadium_id = S.id 
    WHERE C.club_name = @club_name AND M.start_time = @start_time AND S.stadium_name = @stadium_name
END
-- DROP PROC addHostRequest

GO --xvi ✅
CREATE FUNCTION allUnassignedMatches
(@club_name VARCHAR(20))
RETURNS TABLE 
RETURN(
    SELECT C2.club_name AS Guest , M.start_time AS startTime 
    FROM Match M INNER JOIN Club C1 ON M.host_club_id = C1.id 
    INNER JOIN Club C2 ON M.guest_club_id = C2.id 
    WHERE C1.club_name = @club_name AND M.stadium_id IS NULL
)
--DROP FUNCTION allUnassignedMatches

GO --xvii ✅
CREATE PROC addStadiumManager
@name VARCHAR(20),
@stadium_name VARCHAR(20),
@username VARCHAR(20),
@password VARCHAR(20)
AS
IF NOT EXISTS (SELECT username FROM SystemUser WHERE username = @username)
BEGIN
    INSERT INTO SystemUser values (@username, @password)
END
                       
INSERT INTO StadiumManager
SELECT @username, @name, S.id 
FROM Stadium S
WHERE S.stadium_name = @stadium_name
-- DROP PROC addStadiumManager

GO --xviii ✅
CREATE FUNCTION allPendingRequests 
(@username VARCHAR(20))
RETURNS TABLE
RETURN(
    SELECT CR.representative_name AS Representative , C2.club_name AS Guest , M.start_time
    FROM StadiumManager SM INNER JOIN RequestHosting RH ON SM.id = RH.stadium_manager
    INNER JOIN Match M ON RH.match_id = M.id 
    INNER JOIN Club C2 ON M.guest_club_id = C2.id
    INNER JOIN ClubRepresentative CR ON CR.id = RH.representative_id
    WHERE SM.username = @username AND RH.approved IS NULL
)

GO --xix  ✅
CREATE PROC acceptRequest 
@username VARCHAR(20),
@host_club VARCHAR(20),
@guest_club VARCHAR(20),
@start_time DATETIME
AS
DECLARE @capacitynum INT
DECLARE @stadID INT
SET @stadID = (SELECT TOP(1) S.id FROM Stadium S INNER JOIN StadiumManager SM ON SM.stadium_id = S.id WHERE SM.username = @username)
SET @capacitynum = (SELECT TOP(1) S.capacity FROM Stadium S WHERE S.id = @stadID) --/new

UPDATE RequestHosting
SET approved = 1 
WHERE representative_id = (SELECT TOP(1) RH.representative_id FROM RequestHosting RH
    INNER JOIN StadiumManager SM ON RH.stadium_manager = SM.id 
    INNER JOIN Match M ON RH.match_id = M.id INNER JOIN Club C1 ON M.host_club_id = C1.id 
    INNER JOIN Club C2 ON M.guest_club_id = C2.id
    WHERE SM.username = @username AND C1.club_name = @host_club 
    AND C2.club_name = @guest_club AND M.start_time = @start_time)

UPDATE Match SET stadium_id = @stadID WHERE id =
                (SELECT TOP(1) M.id FROM Match M, Club H, Club G
                 WHERE M.host_club_id = H.id AND M.guest_club_id = G.id
                    AND H.club_name = @host_club AND G.club_name = @guest_club
                    AND start_time = @start_time)

WHILE (@capacitynum >= 1) BEGIN -- start of while, decrements kol ma3 kol mara l7d ma t3ml 3add el tickets el kamel /new
    EXEC addTicket @host_club, @guest_club, @start_time
    SET @capacitynum = @capacitynum - 1
END

-- DROP PROC acceptRequest

GO --xx ✅
CREATE PROC rejectRequest
@username VARCHAR(20),
@host_club VARCHAR(20),
@guest_club VARCHAR(20),
@start_time DATETIME
AS
UPDATE RequestHosting
SET approved = 0
WHERE representative_id = (SELECT RH.representative_id FROM RequestHosting RH 
    INNER JOIN StadiumManager SM ON RH.stadium_manager = SM.id INNER JOIN
    Match M ON RH.match_id = M.id INNER JOIN Club C1 ON M.host_club_id = C1.id 
    INNER JOIN Club C2 ON M.guest_club_id = C2.id
    WHERE SM.username = @username AND C1.club_name = @host_club 
    AND C2.club_name = @guest_club AND M.start_time = @start_time)
-- DROP PROC rejectRequest

---- shady ----


GO --xxi ✅
CREATE PROC addFan
@name VARCHAR(20),
@username VARCHAR(20),
@password VARCHAR(20),
@nationalId VARCHAR(20),
@birthDate DATETIME,
@address VARCHAR(20),
@phone INT
AS
INSERT INTO SystemUser values (@username, @password)
INSERT INTO Fan(username,national_id,birth_date,phone_num,fan_name,address,unblocked)
         values(@username, @nationalId, @birthDate, @phone, @name, @address, 1);
-- DROP PROC addFan

GO -- xxii ✅
CREATE FUNCTION upcomingMatchesOfClub(@clubName VARCHAR(20))
RETURNS TABLE
AS
    RETURN
        SELECT @clubName AS club, C2.club_name AS competing_club, M.start_time, S.stadium_name
        FROM Club C1 INNER JOIN Match M
               ON C1.id = M.host_club_id
                     INNER JOIN Club C2 
               ON C2.id = M.guest_club_id
                     LEFT OUTER JOIN Stadium S ON S.id = M.stadium_id
        WHERE C1.club_name = @clubName AND start_time > CURRENT_TIMESTAMP
        UNION
        SELECT @clubName AS club, C1.club_name AS competing_club, M.start_time, S.stadium_name
        FROM Club C1 INNER JOIN Match M
               ON C1.id = M.host_club_id
                     INNER JOIN Club C2 
               ON C2.id = M.guest_club_id
                     LEFT OUTER JOIN Stadium S ON S.id = M.stadium_id
        WHERE C2.club_name = @clubName AND start_time > CURRENT_TIMESTAMP
-- DROP FUNCTION upcomingMatchesOfClub

GO -- xxiii ✅
CREATE FUNCTION availableMatchesToAttend(@startDate DATETIME)
RETURNS TABLE
AS
    RETURN
        SELECT C1.club_name AS host_club, C2.club_name AS guest_club, M.start_time, S.stadium_name
        FROM Club C1 INNER JOIN Match M
               ON C1.id = M.host_club_id
                     INNER JOIN Club C2 
               ON C2.id = M.guest_club_id
                     LEFT OUTER JOIN Stadium S ON S.id = M.stadium_id
        WHERE M.start_time >= @startDate AND EXISTS (SELECT * FROM Ticket
                                                        WHERE available = 1 AND match_id = M.id)


GO -- xxiv ✅
CREATE PROC purchaseTicket(@nationalId VARCHAR(20),@hostClub VARCHAR(20),@guestClub VARCHAR(20),@start_time DATETIME)
AS
IF ((SELECT unblocked FROM Fan WHERE Fan.national_id = @nationalId) = 1)
BEGIN
    DECLARE @matchID INT
    DECLARE @ticketID INT
    SET @matchID = (SELECT M.id FROM Match M, Club H, Club G
                    WHERE M.host_club_id = H.id AND M.guest_club_id = G.id
                    AND H.club_name = @hostClub AND G.club_name = @guestClub
                          AND start_time = @start_time)
    SET @ticketId = (SELECT TOP(1) id FROM Ticket
                     WHERE match_id = @matchID AND available = 1) -- gets 1 ticket available for this match
    UPDATE Ticket
    SET fan = @nationalID, available = 0
    WHERE id = @ticketID
END
-- DROP PROC purchaseTicket

GO -- xxv ✅
CREATE PROCEDURE updateMatchHost(@hostClub VARCHAR(20),@guestClub VARCHAR(20),@start_time DATETIME)
AS
DECLARE @matchID INT
SET @matchID = (SELECT M.id FROM Match M, Club H, Club G
                WHERE M.host_club_id = H.id AND M.guest_club_id = G.id
                AND H.club_name = @hostClub AND G.club_name = @guestClub
                      AND start_time = @start_time)
DECLARE @temp INT
SET @temp = (SELECT host_club_id FROM Match WHERE id = @matchID)
UPDATE Match
SET host_club_id = guest_club_id, guest_club_id = @temp
WHERE id = @matchID
-- DROP PROCEDURE updateMatchHost

GO -- xxvi ✅
CREATE VIEW matchesPerTeam
AS
SELECT C.club_name, COUNT(M.id) as matches_played
    FROM Club C LEFT OUTER JOIN (SELECT * FROM Match
                                 WHERE end_time <= CURRENT_TIMESTAMP) M
                                 ON C.id = M.host_club_id OR C.id = M.guest_club_id
    GROUP BY C.club_name
-- DROP VIEW matchesPerTeam

GO -- xxvii Fetches pair of club names which have never played against each other.
CREATE VIEW clubsNeverMatched
AS
SELECT C1.club_name AS club1, C2.club_name AS club2 FROM Club C1, Club C2
WHERE C1.club_name < C2.club_name AND NOT EXISTS (SELECT * FROM Match
                                    WHERE (host_club_id = C1.id AND guest_club_id = C2.id)
                                       OR (host_club_id = C2.id AND guest_club_id = C1.id))
-- DROP VIEW clubsNeverMatched

GO -- xxviii  all club names which the given club has never competed against.
CREATE FUNCTION clubsNeverPlayed(@clubName VARCHAR(20))
RETURNS TABLE
AS
    RETURN (
    SELECT club1 AS club_name FROM clubsNeverMatched WHERE club2 = @clubName
    UNION
    SELECT club2 FROM clubsNeverMatched WHERE club1 = @clubName)
-- DROP FUNCTION clubsNeverPlayed   

GO -- xxix
CREATE FUNCTION matchWithHighestAttendance()
RETURNS TABLE
AS
    RETURN
        SELECT H.club_name AS host_club, G.club_name AS guest_club
        FROM Club H, Club G, Match M,
            (SELECT COUNT(T.id) AS number, M.id
              FROM Match M LEFT OUTER JOIN Ticket T ON M.id = T.match_id
              INNER JOIN Club H ON M.host_club_id = H.id
              INNER JOIN Club G ON M.guest_club_id = G.id
              WHERE T.available = 0
              GROUP BY M.id
              HAVING COUNT(T.id) = (SELECT MAX(c) FROM (SELECT COUNT(T.id) AS c, M.id
                                      FROM Match M LEFT OUTER JOIN Ticket T ON M.id = T.match_id
                                      INNER JOIN Club H ON M.host_club_id = H.id
                                      INNER JOIN Club G ON M.guest_club_id = G.id
                                      WHERE T.available = 0
                                      GROUP BY M.id) AS A )) AS X
        WHERE M.id = X.id AND H.id = M.host_club_id AND G.id = M.guest_club_id
-- DROP FUNCTION matchWithHighestAttendance

GO -- xxx -- all PLAYED matches
CREATE FUNCTION matchesRankedByAttendance()
RETURNS TABLE
AS
    RETURN
        SELECT H.club_name AS host_club, G.club_name AS guest_club, X.number
        FROM Club H, Club G, Match M,
            (SELECT COUNT(T.id) AS number, M.id
              FROM Match M LEFT OUTER JOIN Ticket T ON M.id = T.match_id
              INNER JOIN Club H ON M.host_club_id = H.id
              INNER JOIN Club G ON M.guest_club_id = G.id
              WHERE T.available = 0
              GROUP BY M.id
              ) AS X
        WHERE M.id = X.id AND H.id = M.host_club_id AND G.id = M.guest_club_id 
        AND M.end_time <= CURRENT_TIMESTAMP -- played
        ORDER BY X.number DESC OFFSET 0 ROW
-- DROP FUNCTION matchesRankedByAttendance

GO -- xxxi ✅
CREATE FUNCTION requestsFromClub(@stadiumName VARCHAR(20), @clubName VARCHAR(20))
RETURNS TABLE
AS
    RETURN
        SELECT H.club_name AS host_club, G.club_name AS guest_club
        FROM RequestHosting RH, Stadium S, Club C,
        StadiumManager SM, ClubRepresentative CR, Match M, Club H, Club G
        WHERE RH.representative_id = CR.id AND RH.stadium_manager = SM.id
        AND CR.club_id = C.id AND SM.stadium_id = S.id
        AND S.stadium_name = @stadiumName AND C.club_name = @clubName
        AND M.host_club_id = H.id AND M.guest_club_id = G.id
        AND M.id = RH.match_id




-----------------------
        GO
INSERT INTO SystemUser values ('admin','admin');
INSERT INTO SystemAdmin values ('admin', 'Admin');

---CHECK USERNAME AND PASSWORD---
GO
CREATE PROCEDURE checkUser
@username VARCHAR(20),
@password VARCHAR(20),
@res BIT OUTPUT
AS
IF EXISTS (SELECT * FROM SystemUser WHERE username = @username AND password = @password)
    SET @res = 1
ELSE
    SET @res = 0

---CHECK CLUBS AVAILABLE FOR REPRESENTING
GO
CREATE PROCEDURE noRepClubs
AS
SELECT club_name FROM Club C1
WHERE NOT EXISTS (SELECT C.club_name FROM Club C, ClubRepresentative CR
                    WHERE C.id = CR.club_id AND C1.id = C.id)

---CHECK CLUBS AVAILABLE FOR REPRESENTING
GO
CREATE PROCEDURE noRepClubs
AS
SELECT club_name FROM Club C1
WHERE NOT EXISTS (SELECT C.club_name FROM Club C, ClubRepresentative CR
                    WHERE C.id = CR.club_id AND C1.id = C.id)


GO
CREATE PROCEDURE noManStadiums
AS
SELECT S.stadium_name FROM Stadium S
WHERE NOT EXISTS (SELECT S1.stadium_name FROM Stadium S1, StadiumManager SM
                    WHERE S1.id = SM.stadium_id AND S1.id = S.id)

GO 
CREATE PROCEDURE clubInfo
@username VARCHAR(20)
AS
SELECT C.* 
FROM Club C INNER JOIN ClubRepresentative CR ON CR.club_id = C.id
WHERE CR.username = @username

GO
CREATE PROCEDURE userType
@username VARCHAR(20),
@type VARCHAR(20) OUTPUT
AS
IF EXISTS(SELECT * FROM SystemAdmin WHERE username = @username)
    SET @type = 'ADMIN'
ELSE IF EXISTS(SELECT * FROM SportsAssociationManager WHERE username = @username)
    SET @type = 'SAM'
ELSE IF EXISTS(SELECT * FROM StadiumManager WHERE username = @username)
    SET @type = 'STM'
ELSE IF EXISTS(SELECT * FROM ClubRepresentative WHERE username = @username)
    SET @type = 'CR'
ELSE IF EXISTS(SELECT * FROM Fan WHERE username = @username)
    SET @type = 'FAN'

GO
CREATE PROCEDURE upcomingMatches
@clubname VARCHAR(20)
AS
SELECT C1.club_name AS host_club, C2.club_name AS guest_club, M.start_time, M.end_time, S.stadium_name
        FROM Club C1 INNER JOIN Match M
               ON C1.id = M.host_club_id
                     INNER JOIN Club C2 
               ON C2.id = M.guest_club_id
                     LEFT OUTER JOIN Stadium S ON S.id = M.stadium_id
        WHERE (C1.club_name = @clubName OR C2.club_name = @clubname) AND start_time > CURRENT_TIMESTAMP


GO
CREATE PROCEDURE availableStadiums 
@date datetime
AS
SELECT * FROM viewAvailableStadiumsOn(@date)

GO  -- dont forget to not show the start time :)
CREATE FUNCTION viewAvailableMatchesOn
(@date DATETIME)
RETURNS TABLE
RETURN(
SELECT DISTINCT C1.club_name Host, C2.club_name Guest, S.stadium_name StadName, S.location Location, M.start_time, M.id match_id, COUNT(T.id) as number
FROM Match M INNER JOIN Stadium S ON M.stadium_id = S.id
INNER JOIN Club C1 ON M.host_club_id = C1.id
INNER JOIN Club C2 ON M.guest_club_id = C2.id
INNER JOIN Ticket T ON T.match_id = M.id
WHERE M.start_time = @date AND T.available = '1'
GROUP BY C1.club_name, C2.club_name, S.stadium_name, S.location, M.start_time, M.id
)
GO
DROP FUNCTION viewAvailableMatchesOn

GO
CREATE PROC getNationalID
@username VARCHAR(20)
AS
SELECT national_id FROM Fan
WHERE @username = username;


GO
CREATE PROC ViewStadManagerStadium
@username VARCHAR(20)
AS
SELECT S.stadium_name StadName, S.available Available, S.capacity Capacity, S.location Location
FROM Stadium S INNER JOIN StadiumManager SM ON S.id = SM.stadium_id AND SM.username = @username;


GO
CREATE PROC ViewUpcoming
AS
SELECT C1.club_name AS Hostclub, C2.club_name AS competing_club, M.start_time, M.end_time
        FROM Club C1 INNER JOIN Match M
               ON C1.id = M.host_club_id
                     INNER JOIN Club C2 
               ON C2.id = M.guest_club_id

        WHERE start_time > CURRENT_TIMESTAMP

GO
CREATE PROC ViewPlayed
AS
SELECT C1.club_name AS Hostclub, C2.club_name AS competing_club, M.start_time, M.end_time
        FROM Club C1 INNER JOIN Match M
               ON C1.id = M.host_club_id
                     INNER JOIN Club C2 
               ON C2.id = M.guest_club_id

        WHERE end_time < CURRENT_TIMESTAMP


GO
CREATE PROC ViewClashed
AS
SELECT C1.club_name AS club1, C2.club_name AS club2 FROM Club C1, Club C2
WHERE C1.club_name < C2.club_name AND NOT EXISTS (SELECT * FROM Match
                                    WHERE (host_club_id = C1.id AND guest_club_id = C2.id)
                                       OR (host_club_id = C2.id AND guest_club_id = C1.id))

GO
CREATE PROC AllClubNames
@clubname1 VARCHAR(20),
@clubname2 VARCHAR(20),
@bool BIT OUTPUT
AS
IF EXISTS(SELECT C1.club_name, C2.club_name FROM Club C1, Club C2 WHERE @clubname1 = C1.club_name AND @clubname2 = C2.club_name) 
BEGIN
SET @bool = 1
END
ELSE
SET @bool = 0


GO
CREATE PROC stadiumInfo
@username VARCHAR(20)
AS
SELECT S.* FROM Stadium S, StadiumManager SM
WHERE S.id = SM.stadium_id AND SM.username = @username

GO
CREATE PROC allManagerRequests
@username VARCHAR(20)
AS
SELECT CR.representative_name AS Representative , C1.club_name AS Host, C2.club_name AS Guest , M.start_time, M.end_time, RH.approved
    FROM StadiumManager SM INNER JOIN RequestHosting RH ON SM.id = RH.stadium_manager
    INNER JOIN Match M ON RH.match_id = M.id 
    INNER JOIN Club C1 ON M.host_club_id = C1.id
    INNER JOIN Club C2 ON M.guest_club_id = C2.id
    INNER JOIN ClubRepresentative CR ON CR.id = RH.representative_id
    WHERE SM.username = @username


GO
CREATE FUNCTION checkExistsReq(@club_name VARCHAR(20), @stadium_name VARCHAR(20), @start_time datetime)
RETURNS BIT
AS
BEGIN

IF EXISTS (SELECT * FROM (SELECT CR.id crID, SM.id smID, M.id mID FROM Club C INNER JOIN ClubRepresentative CR ON C.id = CR.club_id 
                            INNER JOIN Match M ON M.host_club_id = C.id , Stadium S  
                            INNER JOIN StadiumManager SM ON SM.stadium_id = S.id 
                            WHERE C.club_name = @club_name AND M.start_time = @start_time AND S.stadium_name = @stadium_name) AS Req, RequestHosting RH
            WHERE Req.crID = RH.representative_id AND Req.mID = RH.match_id AND RH.stadium_manager = Req.smID
           )
    BEGIN
    RETURN '1'
END
RETURN '0'
END

GO
CREATE FUNCTION checksExistsUser(@username VARCHAR(20))
RETURNS BIT
AS
BEGIN
IF EXISTS (SELECT * FROM SystemUser
            WHERE username = @username
           )
    BEGIN
    RETURN '1'
END
RETURN '0'
END
