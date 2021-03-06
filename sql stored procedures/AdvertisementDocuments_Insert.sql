ALTER PROC [dbo].[AdvertisementDocuments_Insert]
    @Id INT OUT,
    @EventId INT,
    @Name NVARCHAR(50),
    @DocumentUrl NVARCHAR(255),
    @CreatedBy INT
AS
/*
    DECLARE
	   @_id INT,
	   @_eventId INT = 12,
	   @_name NVARCHAR(50) = 'Ad3',
	   @_documentUrl NVARCHAR(255) = 'https://sampleDocument.com',
	   @_createdBy INT = 95

    EXEC dbo.AdvertisementDocuments_Insert
	   @_id OUT,
	   @_eventId,
	   @_name,
	   @_documentUrl,
	   @_createdBy

    SELECT * 
    FROM dbo.AdvertisementDocuments 
    WHERE Id = @_id
*/
BEGIN
    INSERT INTO
	   dbo.AdvertisementDocuments (
		  EventId,
		  [Name],
		  DocumentUrl,
		  CreatedBy
	   ) VALUES (
		  @EventId,
		  @Name,
		  @DocumentUrl,
		  @CreatedBy
	   )

    SET @Id = SCOPE_IDENTITY();
END