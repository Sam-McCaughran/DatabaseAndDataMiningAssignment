create procedure ClearAnalyticsDatabase @AnalyticsDatabase NVARCHAR(MAX)
AS
BEGIN

DECLARE @DeleteQuery NVARCHAR(MAX);

Set @DeleteQuery = '
delete ' + @AnalyticsDatabase + '.dbo.DimBooking
delete ' + @AnalyticsDatabase + '.dbo.DimProcedures
delete ' + @AnalyticsDatabase + '.dbo.DimTasks
delete ' + @AnalyticsDatabase + '.dbo.DimTest
delete ' + @AnalyticsDatabase + '.dbo.DimUsers
delete ' + @AnalyticsDatabase + '.dbo.DimTime
delete ' + @AnalyticsDatabase + '.dbo.DimEncounter
delete ' + @AnalyticsDatabase + '.dbo.FactApplicationUsage
';
exec sp_executesql @DeleteQuery
END

