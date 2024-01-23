--- Create new database --- 
CREATE DATABASE Crime_db  

--- Creating Tables --- 
CREATE TABLE Crime 
(
 CrimeID INT PRIMARY KEY,
 IncidentType VARCHAR(255),
 IncidentDate DATE,
 Location VARCHAR(255),
 Description TEXT,
 Status VARCHAR(20)
); 

CREATE TABLE Victim (
 VictimID INT PRIMARY KEY,
 CrimeID INT,
 Name VARCHAR(255),
 ContactInfo VARCHAR(255),
 Injuries VARCHAR(255),
 FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
);

CREATE TABLE Suspect (
 SuspectID INT PRIMARY KEY,
 CrimeID INT,
 Name VARCHAR(255),
 Description TEXT,
 CriminalHistory TEXT,
 FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
);


select * from Crime
select * from Victim 
select * from Suspect 

--- Inserting data into tables --- 
INSERT INTO Crime (CrimeID, IncidentType, IncidentDate, Location, Description, Status)
VALUES
 (1, 'Robbery', '2023-09-15', '123 Main St, Cityville', 'Armed robbery at a convenience store', 'Open'),
 (2, 'Homicide', '2023-09-20', '456 Elm St, Townsville', 'Investigation into a murder case', 'Under Investigation'),
 (3, 'Theft', '2023-09-10', '789 Oak St, Villagetown', 'Shoplifting incident at a mall', 'Closed');

 INSERT INTO Victim (VictimID, CrimeID, Name, ContactInfo, Injuries)
 VALUES
 (1, 1, 'John Doe', 'johndoe@example.com', 'Minor injuries'),
 (2, 2, 'Jane Smith', 'janesmith@example.com', 'Deceased'),
 (3, 3, 'Alice Johnson', 'alicejohnson@example.com', 'None'); 

 INSERT INTO Suspect (SuspectID, CrimeID, Name, Description, CriminalHistory)
 VALUES
 (1, 1, 'Robber 1', 'Armed and masked robber', 'Previous robbery convictions'),
 (2, 2, 'Unknown', 'Investigation ongoing', NULL),
 (3, 3, 'Suspect 1', 'Shoplifting suspect', 'Prior shoplifting arrests'); 

 --- Adding 'Age' Column to Table Victim --- 
 ALTER TABLE Victim ADD Age INT

  --- Adding 'Age' Column to Table Suspect --- 
 ALTER TABLE Suspect ADD Age INT


 --- Solving Queries --- 
 --- 1. Select all open incidents. --- 
 SELECT * FROM Crime WHERE Status = 'Open'

 --- 2. Find the total number of incidents. --- 
 SELECT COUNT(CrimeID) AS Total_Incidents FROM Crime

 --- 3. List all unique incident types. --- 
 SELECT DISTINCT(IncidentType) FROM Crime

 --- 4. Retrieve incidents that occurred between '2023-09-01' and '2023-09-10'. --- 
 SELECT * FROM Crime WHERE IncidentDate BETWEEN '2023-09-01' AND '2023-09-10'

 --- 5. List persons involved in incidents in descending order of age. --- 
 SELECT V.Name , C.CrimeID FROM Crime C JOIN Victim V ON C.CrimeID = V.CrimeID 

 --- 6. Find the average age of persons involved in incidents. ---
 SELECT AVG(V.Age) AS Average_Age FROM Crime C JOIN Victim V ON C.CrimeID = V.CrimeID 
 
 --- 7. List incident types and their counts, only for open cases. --- 
 SELECT IncidentType, Status, COUNT(CrimeId) AS Total_Count FROM Crime GROUP BY IncidentType, Status HAVING Status = 'Open' 

 --- 8. Find persons with names containing 'Doe'. --- 
 SELECT Name FROM Victim WHERE NAME LIKE '%Doe%'

 --- 9. Retrieve the names of persons involved in open cases and closed cases --- 
 SELECT V.Name FROM Crime C JOIN Victim V ON C.CrimeID = V.CrimeID WHERE C.Status IN ('Open', 'Closed') 

 --- 10. List incident types where there are persons aged 30 or 35 involved. --- 
 SELECT C.IncidentType , V.Age FROM Crime C JOIN Victim V ON C.CrimeID = V.CrimeID WHERE V.Age IN(30, 35)  

 --- 11. Find persons involved in incidents of the same type as 'Robbery'. ---- 
 SELECT Name FROM Victim WHERE EXISTS (SELECT Name FROM Crime WHERE Crime.CrimeID = Victim.CrimeID AND IncidentType = 'Robbery')

 --- 12. List incident types with more than one open case. ---- 
SELECT IncidentType ,Status, COUNT(CrimeID) AS Total_Count FROM Crime GROUP BY IncidentType, Status HAVING Status = 'Open' AND COUNT(CrimeID) > 1

--- 13. List all incidents with suspects whose names also appear as victims in other incidents ---- 
SELECT C.* FROM Crime C JOIN Suspect S ON C.CrimeID = S.CrimeID 
WHERE S.Name IN (SELECT Name FROM Victim) 

--- 13. List all incidents with suspects whose names also appear as victims in other incidents ---- 
SELECT C.* FROM Crime C JOIN Suspect S ON C.CrimeID = S.CrimeID 
WHERE S.Name IN (SELECT Name FROM Victim) 

--- 14. Retrieve all incidents along with victim and suspect details. ---  
SELECT C.*, V.Name AS Victim_Name, S.Name AS Suspect_Name 
FROM Crime C JOIN Victim V ON C.CrimeID = V.CrimeID 
JOIN Suspect S ON C.CrimeID = S.CrimeID 

--- 15. Find incidents where the suspect is older than any victim. ---  
SELECT * FROM Crime JOIN Suspect ON Crime.CrimeID = Suspect.CrimeID 
WHERE Suspect.Age > ANY (SELECT Age FROM Victim) 

--- 16. Find suspects involved in multiple incidents ---  
SELECT Name, COUNT(CrimeID) AS Total_Involvement FROM Suspect GROUP BY Name HAVING COUNT(CrimeID) > 1 

--- 17. List incidents with no suspects involved. ---  
SELECT C.CrimeID, C.IncidentType,C.IncidentDate, S.SuspectID FROM Crime C LEFT JOIN Suspect S ON C.CrimeID = S.CrimeID WHERE S.SuspectID = NULL 

--- 18. List all cases where at least one incident is of type 'Homicide' and all other incidents are of type 'Robbery' ---  


--- 19.Retrieve a list of all incidents and the associated suspects, showing suspects for each incident, or 'No Suspect' if there are none.
SELECT C.CrimeID, C.IncidentType, C.IncidentDate, C.Location, C.Status, S.Name 
FROM Crime C JOIN Suspect S ON C.CrimeID = S.CrimeID  

