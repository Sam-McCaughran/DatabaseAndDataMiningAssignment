CREATE PROCEDURE InsertTaskDimensions @ApplicationDatabase NVARCHAR(MAX), @AnalyticsDatabase NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON; -- Suppress row count messages to improve performance

    -- Declare the dynamic SQL query variable
    DECLARE @Query NVARCHAR(MAX);

    -- Construct the dynamic SQL query to update and insert data into DimTasks
    SET @Query = '
    -- Update existing tasks in DimTasks
    UPDATE dt
    SET
        dt.TaskType = taty.Task_Type_Description,
        dt.TaskRole = r.Role_Description,
        dt.TaskCompleted = ta.Task_Complete,
        dt.TaskLifetimeDays = DATEDIFF(day, ta.Task_Create_Date, ISNULL(ta.Task_Complete_Date, GETDATE()))
    FROM ' + @AnalyticsDatabase + '.dbo.DimTasks dt
    INNER JOIN ' + @ApplicationDatabase + '.dbo.Tasks ta ON dt.id = ta.id
    LEFT JOIN ' + @ApplicationDatabase + '.dbo.TaskTypes taty ON ta.Task_Type_id = taty.id
    LEFT JOIN ' + @ApplicationDatabase + '.dbo.Roles r ON ta.Task_Role_id = r.id;

    -- Insert new tasks into DimTasks
    INSERT INTO ' + @AnalyticsDatabase + '.dbo.DimTasks (id, TaskType, TaskRole, TaskCompleted, TaskLifetimeDays)
    SELECT
        ta.id, -- Task ID
        taty.Task_Type_Description, -- Description of the task type
        r.Role_Description, -- Description of the role associated with the task
        ta.Task_Complete, -- Indicator if the task is completed
        DATEDIFF(day, ta.Task_Create_Date, ISNULL(ta.Task_Complete_Date, GETDATE())) AS TimeToComplete -- Time taken to complete the task
    FROM ' + @ApplicationDatabase + '.dbo.Tasks ta -- Source table for tasks
    LEFT JOIN ' + @ApplicationDatabase + '.dbo.TaskTypes taty ON ta.Task_Type_id = taty.id -- Join to get task type details
    LEFT JOIN ' + @ApplicationDatabase + '.dbo.Roles r ON ta.Task_Role_id = r.id -- Join to get role details
    WHERE NOT EXISTS (
        SELECT 1
        FROM ' + @AnalyticsDatabase + '.dbo.DimTasks dt
        WHERE dt.id = ta.id -- Exclude records that already exist in DimTasks
    );
    ';

    -- Execute the dynamically constructed SQL query
    EXEC sp_executesql @Query;
END
