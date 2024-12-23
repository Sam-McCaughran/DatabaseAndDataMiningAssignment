CREATE PROCEDURE ExecuteETLPipeline @ApplicationDatabase NVARCHAR(MAX), @AnalyticsDatabase NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON; -- Suppress row count messages to improve performance

    -- Execute stored procedures in the correct order
    EXEC EnsureDateKeysUpToDate @ApplicationDatabase, @AnalyticsDatabase;
    EXEC InsertEncounterDimensions @ApplicationDatabase, @AnalyticsDatabase;
    EXEC InsertUsersDimensions @ApplicationDatabase, @AnalyticsDatabase;
    EXEC InsertBookingDimensions @ApplicationDatabase, @AnalyticsDatabase;
    EXEC InsertProcedureDimensions @ApplicationDatabase, @AnalyticsDatabase;
    EXEC InsertTaskDimensions @ApplicationDatabase, @AnalyticsDatabase;
    EXEC InsertTestDimensions @ApplicationDatabase, @AnalyticsDatabase;
    EXEC InsertEncounterDimensions @ApplicationDatabase, @AnalyticsDatabase;

    EXEC InsertBookingFacts @ApplicationDatabase, @AnalyticsDatabase;
    EXEC InsertTestFacts @ApplicationDatabase, @AnalyticsDatabase;
    EXEC InsertTaskFacts @ApplicationDatabase, @AnalyticsDatabase;
    EXEC InsertProcedureFacts @ApplicationDatabase, @AnalyticsDatabase;
END;