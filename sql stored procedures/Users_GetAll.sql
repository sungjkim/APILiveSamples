ALTER PROC [dbo].[Users_GetAll]    
AS
/*
    EXEC dbo.Users_GetAll
*/
BEGIN
    SELECT
	   UR.UserId,
	   URT.Id AS RoleId,
	   URT.[Name] AS RoleName
    FROM dbo.UsersRoles AS UR
	   INNER JOIN dbo.UserRoleTypes AS URT
		  ON UR.UserRoleType = URT.Id

    SELECT
	   U.Id,
	   UP.FirstName,
	   UP.LastName,
	   U.Email,
	   U.IsConfirmed,
	   U.[Status],
	   UP.AvatarUrl,
	   UP.PhoneNumber,
	   U.DateCreated,
	   U.DateModified
    FROM dbo.Users AS U
	   LEFT OUTER JOIN dbo.UserProfiles AS UP
		  ON U.Id = UP.UserId
END