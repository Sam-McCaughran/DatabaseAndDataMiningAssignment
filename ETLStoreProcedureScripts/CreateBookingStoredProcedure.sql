CREATE PROCEDURE InsertBookingDimensions @ApplicationDatabase NVARCHAR(MAX), @AnalyticsDatabase NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    -- Construct the query dynamically
    DECLARE @Query NVARCHAR(MAX);
    SET @Query = '
    INSERT INTO ' + @AnalyticsDatabase + '.dbo.DimBooking (id, BookingPurpose, BookedInConnect, BookingHasComment, BookingForSameDepartment)
    SELECT
        neb.id,
        ep.Purpose_Description,
        neb.Booked_In_Connect,
        CASE
            WHEN neb.New_Encounter_Comments IS NULL THEN 0
            ELSE 1
        END AS BookingHadComments,
        CASE
            WHEN ep.Purpose_Treatment_Function_id = 
                (SELECT Purpose_Treatment_Function_id 
                 FROM ' + @ApplicationDatabase + '.dbo.EncounterPurposes ep_sub 
                 WHERE e.Encounter_Purpose_id = ep_sub.id) THEN 1
            ELSE 0
        END AS TestIsSameDept
    FROM ' + @ApplicationDatabase + '.dbo.NewEncounterBookings neb 
    LEFT JOIN ' + @ApplicationDatabase + '.dbo.EncounterPurposes ep ON neb.New_Encounter_Purpose_id = ep.id
    LEFT JOIN ' + @ApplicationDatabase + '.dbo.EncounterForms ef ON neb.Form_id = ef.id
    LEFT JOIN ' + @ApplicationDatabase + '.dbo.Encounters e ON ef.Encounter_id = e.id
    WHERE NOT EXISTS (
        SELECT 1
        FROM ' + @AnalyticsDatabase + '.dbo.DimBooking db
        WHERE db.id = neb.id
    );
    ';

    -- Execute the dynamically constructed query
    EXEC sp_executesql @Query;
END