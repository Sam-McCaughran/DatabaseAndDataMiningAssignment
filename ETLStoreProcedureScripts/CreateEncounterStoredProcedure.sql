CREATE PROCEDURE InsertEncounterDimensions @ApplicationDatabase NVARCHAR(MAX), @AnalyticsDatabase NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON; -- Suppress row count messages to improve performance

    -- Declare the dynamic SQL query variable
    DECLARE @Query NVARCHAR(MAX);

    -- Construct the dynamic SQL query to insert data into DimEncounter
    SET @Query = '
    INSERT INTO ' + @AnalyticsDatabase + '.dbo.DimEncounter (EncounterId, EncounterLocation, EncounterPurpose, EncounterOutcome, EncounterDate, EncounterDepartment)
    SELECT
        ef.Encounter_id AS EncounterId, -- Encounter ID from EncounterForms
        lc.Building AS EncounterLocation, -- Location building details
        ps.Purpose_Description AS EncounterPurpose, -- Purpose of the encounter
        eo.Encounter_Outcome_Type, -- Outcome of the encounter
        FORMAT(ec.Encounter_Date, ''yyyyMMdd'') AS EncounterDate, -- Date of the encounter in YYYYMMDD format
        ms.Medical_Services AS EncounterDepartment -- Department handling the encounter
    FROM ' + @ApplicationDatabase + '.dbo.EncounterForms ef -- EncounterForms as the source
    LEFT JOIN ' + @ApplicationDatabase + '.dbo.Encounters ec ON ec.id = ef.Encounter_id -- Join to fetch encounter details
    LEFT JOIN ' + @ApplicationDatabase + '.dbo.Locations lc ON ec.Encounter_Location_id = lc.id -- Join to fetch location details
    LEFT JOIN ' + @ApplicationDatabase + '.dbo.EncounterPurposes ps ON ec.Encounter_Purpose_id = ps.id -- Join to fetch purpose details
    LEFT JOIN ' + @ApplicationDatabase + '.dbo.TreatmentFunctions tf ON ps.Purpose_Treatment_Function_id = tf.id -- Join to fetch treatment function details
    LEFT JOIN ' + @ApplicationDatabase + '.dbo.MedicalServices ms ON tf.Medical_Service_id = ms.id -- Join to fetch medical service details
    LEFT JOIN ' + @ApplicationDatabase + '.dbo.EncounterOutcomes eo ON ef.Encounter_Outcome_id = eo.id -- Join to fetch encounter outcome details
    WHERE NOT EXISTS (
        SELECT 1
        FROM ' + @AnalyticsDatabase + '.dbo.DimEncounter de -- Target table to check existing records
        WHERE de.EncounterId = ef.Encounter_id -- Check if the encounter ID already exists
    );
    ';

    -- Execute the dynamically constructed SQL query
    EXEC sp_executesql @Query;
END
