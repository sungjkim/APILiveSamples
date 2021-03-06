ALTER PROC [dbo].[Users_UpdateStatus]
    @Id INT,
    @Status INT
AS
/*
    DECLARE
	   @_id INT = 7,
	   @_status INT = 0

    SELECT Id, Status 
    FROM dbo.Users 
    WHERE Id = @_id

    EXEC dbo.Users_UpdateStatus
	   @_id,
	   @_status
	       
    SELECT Id, Status 
    FROM dbo.Users 
    WHERE Id = @_id
*/
BEGIN
    UPDATE 
	   dbo.Users
    SET
	   [Status] = @Status,
	   DateModified = GETUTCDATE()   	   
    WHERE
	   Id = @Id
END