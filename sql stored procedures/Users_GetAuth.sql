ALTER PROC [dbo].[Users_GetAuth]
    @Email NVARCHAR(255)
AS
/*
    DECLARE
	   @_email NVARCHAR(255) = 'sampleEmail@mailinator.com'

    EXEC dbo.Users_GetAuth
	   @_email
*/
BEGIN
    SELECT
	   U.Id,
	   URT.Id AS RoleId,
	   URT.[Name] AS RoleName
    FROM dbo.Users AS U
	   INNER JOIN dbo.UsersRoles AS UR
		  ON U.Id = UR.UserId
	   INNER JOIN dbo.UserRoleTypes AS URT
		  ON UR.UserRoleType = URT.Id
    WHERE
	   U.Email = @Email

    SELECT
	   U.Id,
	   UP.FirstName,
	   UP.LastName,
	   U.Email,
	   U.PasswordHash
    FROM dbo.Users AS U
	   LEFT OUTER JOIN dbo.UserProfiles AS UP
		  ON U.Id = UP.UserId
    WHERE
	   Email = @Email
END