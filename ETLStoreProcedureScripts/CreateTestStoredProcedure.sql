CREATE PROCEDURE InsertTestDimensions @ApplicationDatabase NVARCHAR(MAX), @AnalyticsDatabase NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON; -- Suppress row count messages to improve performance

    -- Declare the dynamic SQL query variable
    DECLARE @Query NVARCHAR(MAX);

    -- Construct the dynamic SQL query
    SET @Query = '
    INSERT INTO ' + @AnalyticsDatabase + '.dbo.DimTest (id, TestType, TestUrgent, TestHadComment)
    SELECT
        tr.id, -- Test request ID
        tt.Test_Name AS TestType, -- Test type description
        tr.Test_Urgent AS TestUrgent, -- Indicator if the test is urgent
        CASE
            WHEN tr.Test_Comments IS NULL THEN 0 -- No comments present
            ELSE 1 -- Comments present
        END AS TestHadComment
    FROM ' + @ApplicationDatabase + '.dbo.TestRequests tr -- Source table for test requests
    LEFT JOIN ' + @ApplicationDatabase + '.dbo.TestTypes tt ON tr.Test_Type_id = tt.id -- Join to get test type details
    WHERE NOT EXISTS (
        SELECT 1
        FROM ' + @AnalyticsDatabase + '.dbo.DimTest dt
        WHERE dt.id = tr.id -- Exclude records that already exist in DimTest
    );
    ';

    -- Execute the dynamically constructed SQL query
    EXEC sp_executesql @Query;
END
