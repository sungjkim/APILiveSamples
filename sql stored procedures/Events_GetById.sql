ALTER PROC [dbo].[Events_GetById]
    @Id INT
AS
/*
    DECLARE
	   @_id INT = 1;
    EXEC dbo.Events_Events_GetById
	   @_id
*/
BEGIN
    ----- Event -----
    SELECT
	   Id,
	   OrganizationId,
	   UserId,
	   EventTypeId ,
	   [Name],
	   Summary, 
	   Headline,
	   [Description], 
	   VenueId,
	   DateStart,
	   DateEnd,
	   SetupTime,
	   EventStatusId,
	   AllowContributions,
	   DateCreated,
	   DateModified,
	   ModifiedBy				
    FROM dbo.[Events]
    WHERE Id = @Id;

    DECLARE @VenueId INT
    SELECT @VenueId = V.Id
    FROM dbo.[Events] AS E
	   INNER JOIN dbo.Venues AS V
		  ON E.VenueId = V.Id
    WHERE E.Id = @Id

    ----- Venue -----
    SELECT
	   Id,
	   [Name],
	   Headline,
	   [Description],
	   LocationId,
	   [Url],
	   IsApproved,
	   CreatedBy,
	   ModifiedBy,
	   DateCreated,
	   DateModified
    FROM dbo.Venues
    WHERE Id = @VenueId

    ----- AdvertisementDocuments -----
    SELECT
	   Id,
	   EventId,
	   [Name],
	   DocumentUrl,
	   DateCreated,
	   CreatedBy
    FROM dbo.AdvertisementDocuments
    WHERE EventId = @Id

    ----- Images -----
    SELECT
	   Id,
	   UserId,
	   EntityId,
	   EntityTypeId,
	   [Url],
	   Title,
	   FileId,
	   DateCreated,
	   DateModified,
	   [Description],
	   CreatedBy,
	   ModifiedBy
    FROM dbo.Images
    WHERE
	   EntityTypeId IN (12, 7) AND 
	   EntityId = @Id

    ----- EventsContributions -----
    SELECT
	   EventId,
	   ContributionTypeId,
	   DateCreated
    FROM dbo.EventsContributions
    WHERE EventId = @Id

    ----- Urls -----
    SELECT
	   Id,
	   UserId,
	   [Url],UrlTypeId,
	   EntityId,
	   EntityTypeId,
	   DateCreated,
	   DateModified
    FROM dbo.Urls
    WHERE
	   EntityTypeId = 7 AND 
	   EntityId = @Id
END