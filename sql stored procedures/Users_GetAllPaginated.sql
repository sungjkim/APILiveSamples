ALTER PROC [dbo].[Users_GetAllPaginated]    
    @PageIndex INT,
    @PageSize INT
AS
/*
    DECLARE
	   @_pageIndex INT = 0,
	   @_pageSize INT = 5

    EXEC dbo.Users_GetAllPaginated
	   @_pageIndex,
	   @_pageSize
*/
BEGIN
    DECLARE @Offset INT = @PageSize * @PageIndex;

    SELECT
	   U.Id,
	   UP.FirstName,
	   UP.LastName,
	   U.Email,
	   U.IsConfirmed,
	   U.[Status],
	   U.DateCreated,
	   U.DateModified,
	   TotalCount = COUNT(0)Over()
    FROM dbo.Users AS U
	   INNER JOIN dbo.UserProfiles AS UP
		  ON U.Id = UP.UserId
    ORDER by U.DateCreated DESC

    OFFSET @Offset ROWS
    FETCH NEXT @PageSize ROWS ONLY
END