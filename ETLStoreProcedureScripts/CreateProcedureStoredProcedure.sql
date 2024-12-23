CREATE PROCEDURE InsertProcedureDimensions @ApplicationDatabase NVARCHAR(MAX), @AnalyticsDatabase NVARCHAR(MAX)
AS
BEGIN
    -- Suppress row count messages to improve performance
    SET NOCOUNT ON;

    -- Declare the dynamic SQL query variable
    DECLARE @Query NVARCHAR(MAX);

    -- Construct the dynamic SQL query to insert data into DimProcedures
    SET @Query = '
    INSERT INTO ' + @AnalyticsDatabase + '.dbo.DimProcedures (id, ProcedureType, ProcedureCode, ProcedureSite, ProcedureHadComments)
    SELECT
        pp.id, -- Procedure ID from the source table
        pt.Procedure_Description AS ProcedureType, -- Description of the procedure type
        pt.Procedure_Concept_Code AS ProcedureCode, -- Procedure code from the source
        ps.Site_Description AS ProcedureSite, -- Description of the procedure site
        CASE
            WHEN pp.Procedure_Comment IS NULL THEN 0 -- Check if comments exist
            ELSE 1
        END AS ProcedureHadComment
    FROM ' + @ApplicationDatabase + '.dbo.PerformedProcedures pp -- Source table for performed procedures
    LEFT JOIN ' + @ApplicationDatabase + '.dbo.ProcedureTypes pt ON pp.Procedure_id = pt.id -- Join to fetch procedure type details
    LEFT JOIN ' + @ApplicationDatabase + '.dbo.ProcedureSites ps ON pp.Procedure_Site_id = ps.id -- Join to fetch procedure site details
    WHERE NOT EXISTS (
        SELECT 1
        FROM ' + @AnalyticsDatabase + '.dbo.DimProcedures dp -- Target table to check existing records
        WHERE pp.id = dp.id -- Exclude records that already exist in DimProcedures
    );
    ';

    -- Execute the dynamically constructed SQL query
    EXEC sp_executesql @Query;
END
