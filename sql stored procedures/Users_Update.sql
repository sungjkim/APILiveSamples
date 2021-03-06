ALTER PROC [dbo].[Users_Update]
    @Id INT,
    @Email NVARCHAR(255),
    @PasswordHash NVARCHAR(128),
    @IsConfirmed BIT,
    @Status INT
AS
/*
    DECLARE
	   @_id INT = 3,
	   @_email NVARCHAR(255) = 'sampleEmail@mailinator.com',
	   @_passwordHash NVARCHAR(128) = '7dsf78saf7sag78aga',
	   @_isConfirmed BIT = 0,
	   @_status INT = 0

    SELECT *
    FROM dbo.Users
    WHERE Id = @_id

    EXEC dbo.Users_Update
	   @_id,
	   @_email,
	   @_passwordHash,
	   @_isConfirmed,
	   @_status

    SELECT *
    FROM dbo.Users
    WHERE Id = @_id
*/
BEGIN
    UPDATE 
	   dbo.Users
    SET
	   Email = @Email,
	   PasswordHash = @PasswordHash,
	   IsConfirmed = @IsConfirmed,
	   [Status] = @Status,
	   DateModified = GETUTCDATE()   	   
    WHERE
	   Id = @Id
END