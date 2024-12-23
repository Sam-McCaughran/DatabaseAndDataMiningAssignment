CREATE PROCEDURE KibanaPipelineQuery
AS
BEGIN
    SELECT 
        * -- Selecting all fields; refine this to specific fields as needed
    FROM FactApplicationUsage AS FA
    LEFT JOIN DimEncounter AS DE ON FA.Encounter_key = DE.id -- Join with DimEncounter for encounter details
    LEFT JOIN DimUsers AS DU ON FA.User_key = DU.id -- Join with DimUsers for user details
    LEFT JOIN DimTime AS DT ON FA.Date_Key = DT.DateKey -- Join with DimTime for date-related details
    LEFT JOIN DimProcedures AS DP ON FA.Procedure_key = DP.id -- Join with DimProcedures for procedure details
    LEFT JOIN DimBooking AS DB ON FA.Booking_key = DB.id -- Join with DimBooking for booking details
    LEFT JOIN DimTest AS DTE ON FA.Test_Key = DTE.id -- Join with DimTest for test-related details
    LEFT JOIN DimTasks AS DTA ON FA.Task_Key = DTA.id -- Join with DimTasks for task-related details
    ORDER BY FA.Fact_id; -- Sorting the output by Fact_id
END;
