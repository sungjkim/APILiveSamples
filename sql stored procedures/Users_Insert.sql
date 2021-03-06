ALTER PROC [dbo].[Users_Insert]
    @Id INT OUT,
    @Email NVARCHAR(255),
    @PasswordHash NVARCHAR(128),
    @IsConfirmed BIT,
    @Status INT,
    @RoleName NVARCHAR(100)
AS
/*
    DECLARE
	   @_id INT,
	   @_email NVARCHAR(255) = 'jd@email.com',
	   @_passwordHash NVARCHAR(128) = 'hhaaalloooo',
	   @_isConfirmed BIT = 0,
	   @_status INT = 1,
	   @_roleName NVARCHAR(100) = 'Volunteer' -- Organization Admin, Volunteer

    EXEC dbo.Users_Insert
	   @_id OUT,
	   @_email,
	   @_passwordHash,
	   @_isConfirmed,
	   @_status,
	   @_roleName

    SELECT * 
    FROM dbo.Users AS U
	   INNER JOIN dbo.UsersRoles AS UR
		  ON U.Id = UR.UserId
	   INNER JOIN dbo.UserRoleTypes AS URT
		  ON UR.UserRoleType = URT.Id
    WHERE U.Id = @_id
*/
BEGIN
    IF NOT EXISTS 
	   (
		  SELECT 1
		  FROM dbo.Users
		  WHERE Email = @Email
	   )
	   BEGIN
		  DECLARE @RoleId INT = -1;
		  SELECT @RoleId = Id
		  FROM dbo.UserRoleTypes
		  WHERE [Name] = @RoleName

		  IF (@RoleId > 0)
			 BEGIN
				INSERT INTO
				    dbo.Users (
					   Email,
					   PasswordHash,
					   IsConfirmed,
					   [Status]
				    ) VALUES (
					   @Email,
					   @PasswordHash,
					   @IsConfirmed,
					   @Status
				    )
				SET @Id = SCOPE_IDENTITY();


				INSERT INTO
				    dbo.UsersRoles (
					   UserId,
					   UserRoleType
				    ) VALUES (
					   @Id,
					   @RoleId
				    )    
			 END
		  ELSE
			 BEGIN
				RAISERROR('Role does not exist', 11, 1)
			 END		  
	   END
    ELSE
	   BEGIN
		  RAISERROR('Account with that email already exists', 11, 1)
	   END
END