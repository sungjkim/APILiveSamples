ALTER PROC [dbo].[Users_Delete]
    @Id INT
AS
/*
    DECLARE
	   @_id INT = 3

    SELECT *
    FROM dbo.Users
    WHERE Id = @_id

    EXEC dbo.Users_Delete
	   @_id

    SELECT *
    FROM dbo.Users
    WHERE Id = @_id
*/
BEGIN
    DELETE 
	   dbo.Users
    WHERE
	   Id = @Id
END