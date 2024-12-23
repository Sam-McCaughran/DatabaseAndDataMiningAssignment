CREATE PROCEDURE EnsureDateKeysUpToDate @ApplicationDatabase NVARCHAR(MAX), @AnalyticsDatabase NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON; -- Suppress row count messages to improve performance

    -- Declare variables for the current date, end date, oldest encounter date, and maximum DateKey
    DECLARE @Today DATE = GETDATE(); -- Current date
    DECLARE @EndDate DATE = DATEADD(YEAR, 1, @Today); -- Target end date (one year from today)
    DECLARE @OldestEncounterDate DATE; -- Oldest encounter date from the Encounter table
    DECLARE @MaxDateKey INT; -- Maximum DateKey from the DimTime table

    -- Get the oldest encounter date from the Encounter table
    DECLARE @OldestEncounterQuery NVARCHAR(MAX);
    SET @OldestEncounterQuery = '
        SELECT @OldestEncounterDate = MIN(Encounter_Date) 
        FROM ' + @ApplicationDatabase + '.dbo.Encounters';

    EXEC sp_executesql 
        @OldestEncounterQuery, 
        N'@OldestEncounterDate DATE OUTPUT', 
        @OldestEncounterDate OUTPUT;

    -- If no encounter exists, set the oldest date to today
    IF @OldestEncounterDate IS NULL
        SET @OldestEncounterDate = @Today;

    -- Get the maximum DateKey from the DimTime table
    DECLARE @MaxDateKeyQuery NVARCHAR(MAX);
    SET @MaxDateKeyQuery = '
        SELECT @MaxDateKey = MAX(DateKey) 
        FROM ' + @AnalyticsDatabase + '.dbo.DimTime';

    EXEC sp_executesql 
        @MaxDateKeyQuery, 
        N'@MaxDateKey INT OUTPUT', 
        @MaxDateKey OUTPUT;

    -- Determine the starting date for generating missing dates
    DECLARE @StartDate DATE = CASE
        WHEN @MaxDateKey IS NOT NULL THEN CONVERT(DATE, CONVERT(VARCHAR(8), @MaxDateKey, 112))
        ELSE @OldestEncounterDate
    END;

    -- If the dimension is not up-to-date, insert missing dates
    IF @StartDate IS NULL OR @StartDate < @EndDate
    BEGIN
        DECLARE @InsertQuery NVARCHAR(MAX);

        SET @InsertQuery = '
        ;WITH DateSequence AS (
            SELECT CAST(''' + FORMAT(@StartDate, 'yyyy-MM-dd') + ''' AS DATE) AS DateValue
            UNION ALL
            SELECT DATEADD(DAY, 1, DateValue)
            FROM DateSequence
            WHERE DateValue < ''' + FORMAT(@EndDate, 'yyyy-MM-dd') + '''
        )
        INSERT INTO ' + @AnalyticsDatabase + '.dbo.DimTime (DateKey, FullDate, Day, Month, Year, Week, Quarter, WeekDayName, IsWeekend)
        SELECT
            CAST(FORMAT(DateValue, ''yyyyMMdd'') AS INT) AS DateKey,
            DateValue AS FullDate,
            DAY(DateValue) AS Day,
            MONTH(DateValue) AS Month,
            YEAR(DateValue) AS Year,
            DATEPART(WEEK, DateValue) AS Week,
            DATEPART(QUARTER, DateValue) AS Quarter,
            DATENAME(WEEKDAY, DateValue) AS WeekDayName,
            CASE WHEN DATENAME(WEEKDAY, DateValue) IN (''Saturday'', ''Sunday'') THEN 1 ELSE 0 END AS IsWeekend
        FROM DateSequence
        OPTION (MAXRECURSION 0);';

        -- Execute the insert query to populate missing dates
        EXEC sp_executesql @InsertQuery;
    END
END;
