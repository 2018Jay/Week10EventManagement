--Create a DataBase
CREATE DATABASE EVENTMANAGEMENT
--Use DataBase
Use EVENTMANAGEMENT
--Create User Table 
CREATE TABLE [USER](
UserId BIGINT IDENTITY PRIMARY KEY,
UserName VARCHAR(70) NOT NULL,
UserAddress VARCHAR(100) NOT NULL,
UserEmail VARCHAR(100) NOT NULL,
UserPassword VARCHAR(30) NOT NULL,
UserMobile VARCHAR(10) NOT NULL,
CreateDateTime DATETIME,
UpdatedDateTime DATETIME,
IsActive BIT
)

--Drop 
Drop Table [USER]
truncate Table [User]


--Create Admin Table
CREATE TABLE [ADMIN](
AdminId BIGINT IDENTITY PRIMARY KEY,
AdminName VARCHAR(70),
AdminAddress VARCHAR(100),
AdminEmail VARCHAR(100),
AdminPassword VARCHAR(30),
AdminMobile VARCHAR(10),
CreateDateTime DATETIME,
UpdatedDateTime DATETIME,
IsActive BIT
)
drop table [Admin]

--Create Event Table
CREATE TABLE EVENTINFO(
EventId BIGINT IDENTITY PRIMARY KEY,
EventName VARCHAR(200),
EventDESC VARCHAR(MAX),
EventStartDate DATE,
EventEndDate DATE,
EventImgPath VARCHAR(300),
CreatedDateTime DATETIME,
UpdatedDateTime DATETIME,
AdminId BIGINT FOREIGN KEY REFERENCES [ADMIN](AdminId)
)
drop  table EVENTINFO


--Create Activity Table 
CREATE TABLE ACTIVITYINFO(
ActivityId BIGINT IDENTITY PRIMARY KEY,
ActivityName VARCHAR(200),
ActivityDESC VARCHAR(MAX),
ActivityStartDateTime DATE,
ActivityEndDateTime DATE,
ActivityPrice Decimal(10,2),
CreatedDateTime DATETIME,
UpdatedDateTime DATETIME,
EventId BIGINT
)
DROP TABLE ACTIVITYINFO