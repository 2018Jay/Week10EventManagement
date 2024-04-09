
--Created By JayPatel Date:=06-04-2024
--Create Sp For User
EXEC SP_User 'INSERT',0,'Jay','Limla','jay@gmail.com','123456','101010101',NULL,NULL,1
EXEC SP_User 'LOGIN',0,'Jay','Limla','jay@gmail.com','123456','101010101','4/8/2024',NULL,1
ALTER PROCEDURE SP_User(
@Flag VARCHAR(30),
@UserId BIGINT ,
@UserName VARCHAR(70),
@UserAddress VARCHAR(100),
@UserEmail VARCHAR(100),
@UserPassword VARCHAR(30),
@UserMobile VARCHAR(10),
@CreateDateTime DATETIME,
@UpdatedDateTime DATETIME,
@IsActive BIT
)
AS
BEGIN
	

	IF(@Flag ='INSERT')
	BEGIN
	BEGIN TRY
		IF(EXISTS(Select * from [USER] where  UserEmail=@UserEmail))
		BEGIN
			SELECT '200' as StatusCode,'User Already Exists' As ResponseMessage
		END
		ELSE
		BEGIN
			INSERT INTO [USER](UserName,UserAddress,UserEmail,UserPassword,UserMobile,CreateDateTime,UpdatedDateTime,IsActive) VALUES(@UserName,@UserAddress,@UserEmail,@UserPassword,@UserMobile,GETDATE(),NULL,@IsActive)
			SELECT '200' as StatusCode,'User Inserted Successfully' As ResponseMessage 
		END
	END TRY
	BEGIN CATCH
		SELECT '200' as StatusCode,ERROR_MESSAGE() As ResponseMessage
	END CATCH
	END
	ELSE IF(@Flag='LOGIN')
	BEGIN
	BEGIN TRY
		IF(EXISTS(Select * from [USER] where  UserEmail=@UserEmail))
		BEGIN
			DECLARE @DBPassword VARCHAR(30);
			SELECT @DBPassword=UserPassword FROM [USER] WHERE UserEmail=@UserEmail
			IF(@UserPassword=@DBPassword)
			BEGIN
				SELECT UserId,UserName,UserAddress,UserEmail,UserPassword,UserMobile,CreateDateTime,UpdatedDateTime,IsActive FROM [USER] 
			END
			ELSE
			BEGIN
				SELECT '200' as StatusCode,'Password Not Match' As ResponseMessage
			END
		END
		ELSE
		BEGIN
			SELECT '200' as StatusCode,'User Not Exists' As ResponseMessage 
		END
	END TRY
	BEGIN CATCH
		SELECT '200' as StatusCode,ERROR_MESSAGE() As ResponseMessage 
	END CATCH
	END

	ELSE
	BEGIN
	BEGIN TRY
		SELECT '200' as StatusCode,'Enter Valid Flag' As ResponseMessage 
	END TRY
	BEGIN CATCH
		SELECT '200' as StatusCode,ERROR_MESSAGE() As ResponseMessage 
	END CATCH
	END
END

--Created By JayPatel Date:=06-04-2024
--Create Sp For Admin
EXEC SP_Admin'INSERT',0,'admin1','Limla','admin@gmail.com','123456@admin','101010101',NULL,NULL,1
EXEC SP_Admin'LOGIN',0,'Jay','Limla','admin@gmail.com','123456@admin','101010101',NULL,NULL,1
AlTER PROCEDURE SP_Admin(
@Flag VARCHAR(30),
@AdminId BIGINT ,
@AdminName VARCHAR(70),
@AdminAddress VARCHAR(100),
@AdminEmail VARCHAR(100),
@AdminPassword VARCHAR(30),
@AdminMobile VARCHAR(10),
@CreateDateTime DATETIME,
@UpdatedDateTime DATETIME,
@IsActive BIT
)
AS
BEGIN
	IF(@FLAG ='INSERT')
	BEGIN
		IF(EXISTS(Select * from [ADMIN] where  AdminEmail=@AdminEmail))
		BEGIN
			BEGIN TRY
				SELECT '200' as StatusCode,'Admin Already Register' As ResponseMessage
			END TRY
			BEGIN CATCH
				SELECT '200' as StatusCode,ERROR_MESSAGE() As ResponseMessage
			END CATCH
		END
		ELSE
		BEGIN
			INSERT INTO [ADMIN](AdminName,AdminAddress,AdminEmail,AdminPassword,AdminMobile,CreateDateTime,UpdatedDateTime,IsActive) VALUES(@AdminName,@AdminAddress,@AdminEmail,@AdminPassword,@AdminMobile,GETDATE(),NULL,@IsActive)
			SELECT '200' as StatusCode,'Admin Register Successfully' As ResponseMessage 
		END
	END
	ELSE IF(@FLAG='LOGIN')
	BEGIN
		IF(EXISTS(Select * from [ADMIN] where  AdminEmail=@AdminEmail))
		BEGIN
		BEGIN TRY
			DECLARE @DBPassword VARCHAR(30);
			SELECT @DBPassword=AdminPassword FROM [ADMIN] WHERE AdminEmail=@AdminEmail
			IF(@AdminPassword=@DBPassword)
			BEGIN
				SELECT AdminId,AdminName,AdminAddress,AdminEmail,AdminPassword,AdminMobile,CreateDateTime,UpdatedDateTime,IsActive FROM [ADMIN] 
			END
			ELSE
			BEGIN
				SELECT '200' as StatusCode,'Password Not Match' As ResponseMessage
			END
		END TRY
		BEGIN CATCH
			SELECT '200' as StatusCode,ERROR_MESSAGE() As ResponseMessage
		END CATCH
		END
		ELSE
		BEGIN
		BEGIN TRY
			SELECT '200' as StatusCode,'Admin Not Register' As ResponseMessage 
		END TRY
		BEGIN CATCH
			SELECT '200' as StatusCode,ERROR_MESSAGE() As ResponseMessage 
		END CATCH
		END	
	END
END

--Created By JayPatel Date:=06-04-2024
--Craete Sp For Event
EXEC SP_EventInfo 'GETALL',0,'HOLI','About Holi CELEBRATION','2024-2-28','2024-2-28','Path1',NUll,NULL,1
EXEC SP_EventInfo 'UPDATE',4,'HOLI','About Holi Celebrationn','2024-2-28','2024-2-28','Path1',NUll,NULL,1

ALTER PROCEDURE SP_EventInfo(
@Flag VARCHAR(30),
@EventId BIGINT ,
@EventName VARCHAR(200),
@EventDESC VARCHAR(MAX),
@EventStartDate DATE,
@EventEndDate DATE,
@EventImgPath VARCHAR(300),
@CreatedDateTime DATETIME,
@UpdatedDateTime DATETIME,
@AdminId BIGINT
)
AS
BEGIN
	IF(@Flag='INSERT')
	BEGIN
		BEGIN TRY
			INSERT INTO EVENTINFO(EventName,EventDESC,EventStartDate,EventEndDate,EventImgPath,CreatedDateTime,UpdatedDateTime,AdminId) VALUES (@EventName,@EventDESC,@EventStartDate,@EventEndDate,@EventImgPath,CONVERT(DATE,GETDATE()),@UpdatedDateTime,@AdminId)
			SELECT '200' as StatusCode,'Event Inserted Successfully' As ResponseMessage
		END TRY
		BEGIN CATCH
			SELECT '200' as StatusCode,ERROR_MESSAGE() As ResponseMessage
		END CATCH
	END
	ELSE IF(@Flag='GETALL')
	BEGIN
		SELECT * FROM EVENTINFO
	END
	ELSE IF(@Flag='UPDATE')
	BEGIN
		BEGIN TRY
			IF(EXISTS(SELECT * from EVENTINFO WHERE EventId=@EventId))
			BEGIN
				UPDATE EVENTINFO SET EventName=@EventName,EventDESC=@EventDESC,EventStartDate=@EventStartDate,EventEndDate=@EventEndDate,EventImgPath=@EventImgPath,CreatedDateTime=@CreatedDateTime,UpdatedDateTime=@UpdatedDateTime,AdminId=@AdminId WHERE EventId=@EventId
				SELECT '200' as StatusCode,'Event Updated Successfully' As ResponseMessage
			END
			ELSE
			BEGIN
				SELECT '200' as StatusCode,'Event Is Not Exists' As ResponseMessage
			END
		END TRY
		BEGIN CATCH
			SELECT '200' as StatusCode,ERROR_MESSAGE() As ResponseMessage
		END CATCH
	END
	ELSE 
	BEGIN
		SELECT '200' as StatusCode,'Enter Valid Flag' As ResponseMessage 
	END

END

--CREATED BY JAYPATEL DATE:=06-04-2024
--CREATE FOR ACTIVITYINFO
CREATE PROCEDURE  SP_ActivityInfo(
@Flag VARCHAR(30),
@ActivityId BIGINT ,
@ActivityName VARCHAR(200),
@ActivityDESC VARCHAR(MAX),
@ActivityStartDateTime DATE,
@ActivityEndDateTime DATE,
@ActivityPrice Decimal(10,2),
@CreatedDateTime DATETIME,
@UpdatedDateTime DATETIME,
@EventId BIGINT
)
As
BEGIN
	IF(@Flag='INSERT')
	BEGIN
		BEGIN TRY
			INSERT INTO ACTIVITYINFO(ActivityName,ActivityDESC,ActivityStartDateTime,ActivityEndDateTime,ActivityPrice,CreatedDateTime,UpdatedDateTime,EventId) VALUES (@ActivityName,@ActivityDESC,@ActivityStartDateTime,@ActivityEndDateTime,@ActivityPrice,@CreatedDateTime,@UpdatedDateTime,@EventId)
			SELECT '200' as StatusCode,'Activity Inserted Successfully' As ResponseMessage
		END TRY
		BEGIN CATCH
			SELECT '200' as StatusCode,ERROR_MESSAGE() As ResponseMessage
		END CATCH
	END
	ELSE IF(@Flag='GETALL')
	BEGIN
		SELECT * FROM ACTIVITYINFO
	END
	ELSE IF(@Flag='UPDATE')
	BEGIN
		BEGIN TRY
		IF(EXISTS(SELECT * from ACTIVITYINFO WHERE ActivityId=@ActivityId))
		BEGIN
			UPDATE ACTIVITYINFO SET ActivityName=@ActivityName,ActivityDESC=@ActivityDESC,ActivityStartDateTime=@ActivityStartDateTime,ActivityEndDateTime=@ActivityEndDateTime,ActivityPrice=@ActivityPrice,CreatedDateTime=@CreatedDateTime,UpdatedDateTime=@UpdatedDateTime,EventId=@EventId WHERE ActivityId=@ActivityId
			SELECT '200' as StatusCode,'Event Updated Successfully' As ResponseMessage
		END
		ELSE
		BEGIN
			SELECT '200' as StatusCode,'This Activity Not Exists' As ResponseMessage
		END
		END TRY
		BEGIN CATCH
			SELECT '200' as StatusCode,ERROR_MESSAGE() As ResponseMessage
		END CATCH
	END
	ELSE 
	BEGIN
		SELECT '200' as StatusCode,'Enter Valid Flag' As ResponseMessage 
	END

END
