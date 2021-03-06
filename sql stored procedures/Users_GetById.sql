ALTER PROC [dbo].[Users_GetById]
    @Id INT   
AS
/*
    DECLARE
	   @_id INT = 19

    EXEC dbo.Users_GetById
	   @_id
*/
BEGIN
    SELECT
	   Id,
	   Email,
	   IsConfirmed,
	   [Status],
	   DateCreated,
	   DateModified
    FROM
	   dbo.Users
    WHERE
	   Id = @Id
END