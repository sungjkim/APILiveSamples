ALTER PROC [dbo].[Events_Insert]
    @Id INT OUT,
    @OrganizationId INT,
    @UserId INT,
    @EventTypeId INT,
    @Name NVARCHAR(255),
    @Summary NVARCHAR(255),
    @Headline NVARCHAR(50),
    @Description NVARCHAR(4000),
    @DateStart DATETIME2(7),
    @DateEnd DATETIME2(7),
    @SetupTime DATETIME2(7),
    @EventStatusId INT,
	
    @LocationId INT,
    @VenueId INT,
    @VenueName NVARCHAR(255),
    @VenueHeadline NVARCHAR(200),
    @VenueDescription NVARCHAR(4000),
    @VenueUrl NVARCHAR(255),
    @VenueIsApproved BIT,

    @AdvertisementDocuments AS dbo.AdDocList READONLY,
    @Images AS dbo.ImageList READONLY,

    @AllowContributions BIT,
    @ContributionTypes AS dbo.ContributionTypeList READONLY,

    @Urls AS dbo.UrlList READONLY
AS
/*  
    DECLARE
	   @_id INT,
	   @_organizationId INT = 104,
	   @_userId INT = 124,
	   @_eventTypeId INT = 1,
	   @_name NVARCHAR(255) = 'Long Beach Hackathan',
	   @_summary NVARCHAR(255) = 'Come to this hackathon event. Test your skills against southern California's best web developers',
	   @_headline NVARCHAR(50) = 'Hackathon' ,
	   @_description NVARCHAR(4000) = 'Come meet over 40 software engineers and user experience designers and watch as they pitch their solutions to some of the most pressing social impact issues in Los Angeles. Thursday evening will be the culmination of the GA graduation hackathon, offering an intimate look at what can be accomplished by passionate thinkers and builders.',
	   @_dateStart DATETIME2(7) = '2019-06-02 09:00:00',
	   @_dateEnd DATETIME2(7) = '2019-06-04 17:00:00',
	   @_setupTime DATETIME2(7) = '2019-06-01 06:00:00' ,
	   @_eventStatusId INT = 1,

	   @_locationId INT = 2,
	   @_venueId INT = 9999,
	   @_venueName NVARCHAR(255) = 'General Assembly Los Angeles',
	   @_venueHeadline NVARCHAR(200) = 'In aliquet mattis libero vel volutpat',
	   @_venueDescription NVARCHAR(4000) = 'In odio diam, tristique nec laoreet quis, consequat vitae neque. Nam ut odio sit amet augue pharetra feugiat ac nec ante. Vivamus aliquet, diam sed volutpat imperdiet, nunc dolor dictum arcu, nec mattis sem diam ut dui.',
	   @_venueUrl NVARCHAR(255) = 'http://boulder.thespringsevents.com/wp-content/uploads/sites/14/2013/09/L-succulent-cake.jpg',
	   @_venueIsApproved BIT = 1,
	   
	   @_advertisementDocuments AS dbo.AdDocList,
	   @_images AS dbo.ImageList,

	   @_allowContributions BIT = 1,
	   @_contributionTypes AS dbo.ContributionTypeList,

	   @_urls AS dbo.UrlList

    INSERT INTO @_advertisementDocuments ([Name], DocumentUrl) VALUES ('Advert1', 'https://www.wiki-how.in/wp-content/uploads/2015/08/sgtsr.png')
    INSERT INTO @_advertisementDocuments ([Name], DocumentUrl) VALUES ('Advert2', 'https://www.wiki-how.in/wp-content/uploads/2015/08/sgtsr.png')
    --INSERT INTO @_advertisementDocuments ([Name], DocumentUrl) VALUES ('Advert3', 'https://www.wiki-how.in/wp-content/uploads/2015/08/sgtsr.png')
    
    INSERT INTO @_images (EntityTypeId, [Url], Title, [Description]) VALUES (12, 'http://planetside.co.uk/wp-content/uploads/2016/08/gannaing_St-Mary-Lake-1920x960.png', 'St. Mary Lake', 'Proin sit amet facilisis lectu')
    INSERT INTO @_images (EntityTypeId, [Url], Title, [Description]) VALUES (7, 'http://planetside.co.uk/wp-content/uploads/2016/08/gannaing_St-Mary-Lake-1920x960.png', 'someImageeee', 'Proin sit amet facilisis lectu')
    --INSERT INTO @_images (EntityTypeId, [Url], Title, [Description]) VALUES (7, 'http://planetside.co.uk/wp-content/uploads/2016/08/gannaing_St-Mary-Lake-1920x960.png', 'someImageeee2', 'Proin sit amet facilisis lectu')
    
    INSERT INTO @_contributionTypes (ContributionTypeId) VALUES (1)
    INSERT INTO @_contributionTypes (ContributionTypeId) VALUES (4)
    INSERT INTO @_contributionTypes (ContributionTypeId) VALUES (14)

    INSERT INTO @_urls (Url, UrlTypeId, EntityTypeId) VALUES ('https://www.facebook.com', 1, 7)
    --INSERT INTO @_urls (Url, UrlTypeId, EntityTypeId) VALUES ('https://www.instagram.com', 3, 7)

    EXEC dbo.Events_Insert
	   @_id OUT,
	   @_organizationId,
	   @_userId,
	   @_eventTypeId,
	   @_name, 
	   @_summary,
	   @_headline,
	   @_description,
	   @_dateStart, 
	   @_dateEnd, 
	   @_setupTime, 
	   @_eventStatusId,
	   
	   @_locationId,
	   @_venueId, 
	   @_venueName,
	   @_venueHeadline,
	   @_venueDescription,
	   @_venueUrl,
	   @_venueIsApproved,

	   @_advertisementDocuments,
	   @_images,

	   @_allowContributions,
	   @_contributionTypes,

	   @_urls

    EXEC dbo.Events_GetById
	   @_id
*/
BEGIN
    SET XACT_ABORT ON
    DECLARE @Tran NVARCHAR(50) = '_eventRegistration'
    
    BEGIN TRY
	   BEGIN TRAN @Tran
		  ---------- Venue ----------
		  IF (@VenueId = 9999)
		  BEGIN
			 INSERT INTO
				dbo.Venues (
				    [Name],
				    Headline,
				    [Description],
				    LocationId,
				    [Url],
				    IsApproved,
				    CreatedBy,
				    ModifiedBy
				) VALUES (
				    @VenueName,
				    @VenueHeadline,
				    @VenueDescription,
				    @LocationId,
				    @VenueUrl,
				    @VenueIsApproved,
				    @UserId,
				    @UserId
				);
			 SET @VenueId = SCOPE_IDENTITY();
		  END		  

		  ---------- Event ----------
		  INSERT INTO
			 dbo.[Events] (	
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
				AllowContributions			
			 ) VALUES (
				@OrganizationId,
				@UserId,
				@EventTypeId, 
				@Name, 
				@Summary, 
				@Headline, 
				@Description, 
				@VenueId, 
				@DateStart,
				@DateEnd,
				@SetupTime,
				@EventStatusId,
				@AllowContributions				
			 );
		  SET @Id = SCOPE_IDENTITY();

		  ---------- Advertisement Documents ----------
		  INSERT INTO
			 dbo.AdvertisementDocuments (
				EventId,
				[Name],
				DocumentUrl,
				CreatedBy
			 ) 
			 SELECT
				@Id,
				[Name],
				DocumentUrl,
				@UserId
			 FROM @AdvertisementDocuments

		  ---------- Images ----------
		  INSERT INTO
			 dbo.Images (
				UserId,
				EntityId,
				EntityTypeId,
				[Url],
				Title,
				[Description],
				CreatedBy
			 ) 
			 SELECT
				@UserId,
				@Id,
				EntityTypeId,
				[Url],
				Title,
				[Description],
				@UserId
			 FROM @Images

		  ---------- Contributions ----------
		  IF (@AllowContributions = 1)
		  BEGIN
			 INSERT INTO
				dbo.EventsContributions (
				    EventId,
				    ContributionTypeId
				)
				SELECT
				    @Id,
				    ContributionTypeId
				FROM @ContributionTypes
		  END

		  ---------- Urls ----------
		  INSERT INTO
			 dbo.Urls(
				UserId,
				[Url],
				UrlTypeId,
				EntityId,
				EntityTypeId
			 )
			 SELECT
				@UserId,
				[Url],
				UrlTypeId,
				@Id,
				EntityTypeId
			 FROM @Urls

	   COMMIT TRAN @Tran
    END TRY

    BEGIN CATCH
	   IF (XACT_STATE()) = -1
	   BEGIN  
		  PRINT 'The transaction is in an uncommittable state.' +  
			   ' Rolling back transaction.'  
		  ROLLBACK TRANSACTION @Tran;;  
	   END;  
   
	   IF (XACT_STATE()) = 1  
	   BEGIN  
		  PRINT 'The transaction is committable.' +   
			   ' Committing transaction.'  
		  COMMIT TRANSACTION @Tran;;     
	   END; 

	   THROW
    END CATCH    

    SET XACT_ABORT OFF
END