ALTER PROC [dbo].[AdvertisementDocuments_GetById]
    @Id INT   
AS
/*
    DECLARE
	   @_id INT = 5

    EXEC dbo.AdvertisementDocuments_GetById
	   @_id
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
	   Id = @Id
END