ALTER PROC [dbo].[AdvertisementDocuments_GetByCreatedBy]
    @CreatedBy INT   
AS
/*
    DECLARE
	   @_createdBy INT = 1

    EXEC dbo.AdvertisementDocuments_GetByCreatedBy
	   @_createdBy
*/
BEGIN
    SELECT
	   Id,
	   EventId,
	   [Name],
	   DocumentUrl,
	   DateCreated,
	   CreatedBy
    FROM
	   dbo.AdvertisementDocuments
    WHERE
	   CreatedBy = @CreatedBy
END