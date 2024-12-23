CREATE PROCEDURE InsertBookingFacts @ApplicationDatabase NVARCHAR(MAX), @AnalyticsDatabase NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON; -- Suppress row count messages to improve performance

    -- Declare the dynamic SQL query variable
    DECLARE @Query NVARCHAR(MAX);

    -- Construct the dynamic SQL query to insert data into FactApplicationUsage
    SET @Query = '
    INSERT INTO ' + @AnalyticsDatabase + '.dbo.FactApplicationUsage (Encounter_key, User_key, Date_Key, Test_Key, Task_Key, Procedure_Key, Booking_key)
    SELECT
        de.id AS Encounter_Key, -- Encounter key from DimEncounter
        du.id AS User_Key, -- User key from DimUsers
        FORMAT(neb.Added_Date, ''yyyyMMdd'') AS Date_Key, -- Date key in YYYYMMDD format
        NULL AS Test_Key, -- Placeholder for Test Key
        NULL AS Task_Key, -- Placeholder for Task Key
        NULL AS Procedure_Key, -- Placeholder for Procedure Key
        db.id AS Booking_Key -- Booking key from DimBooking
    FROM ' + @AnalyticsDatabase + '.dbo.DimBooking db -- DimBooking as the source
    LEFT JOIN ' + @ApplicationDatabase + '.dbo.NewEncounterBookings neb ON db.id = neb.id -- Join to fetch booking details
    LEFT JOIN ' + @ApplicationDatabase + '.dbo.EncounterForms ef ON neb.Form_id = ef.id -- Join to fetch form details
    LEFT JOIN ' + @ApplicationDatabase + '.dbo.Encounters e ON ef.Encounter_id = e.id -- Join to fetch encounter details
    LEFT JOIN ' + @AnalyticsDatabase + '.dbo.DimEncounter de ON e.id = de.EncounterId -- Join to fetch DimEncounter details
    LEFT JOIN ' + @AnalyticsDatabase + '.dbo.DimUsers du ON ef.Consultant_id = du.id -- Join to fetch DimUsers details
    WHERE NOT EXISTS (
        SELECT 1
        FROM ' + @AnalyticsDatabase + '.dbo.FactApplicationUsage fau -- Target table to check existing records
        WHERE fau.Encounter_key = de.id -- Check if the encounter key exists
          AND fau.User_key = du.id -- Check if the user key exists
          AND fau.Date_Key = FORMAT(neb.Added_Date, ''yyyyMMdd'') -- Check if the date key exists
          AND fau.Booking_key = db.id -- Check if the booking key exists
    );
    ';

    -- Execute the dynamically constructed SQL query
    EXEC sp_executesql @Query;
END