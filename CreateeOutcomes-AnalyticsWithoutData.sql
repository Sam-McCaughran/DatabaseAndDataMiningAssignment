USE [eOutcomes-Analytics]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimBooking](
	[id] [int] NOT NULL,
	[BookingPurpose] [varchar](100) NOT NULL,
	[BookedInConnect] [bit] NOT NULL,
	[BookingHasComment] [bit] NOT NULL,
	[BookingForSameDepartment] [bit] NOT NULL,
 CONSTRAINT [PK_DimBooking] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimEncounter](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[EncounterId] [varchar](14) NULL,
	[EncounterLocation] [varchar](100) NOT NULL,
	[EncounterPurpose] [varchar](100) NOT NULL,
	[EncounterOutcome] [varchar](100) NOT NULL,
	[EncounterDate] [varchar](100) NOT NULL,
	[EncounterDepartment] [varchar](100) NOT NULL,
 CONSTRAINT [PK_DimEncounter] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimProcedures](
	[id] [int] NOT NULL,
	[ProcedureType] [varchar](100) NOT NULL,
	[ProcedureCode] [varchar](50) NOT NULL,
	[ProcedureSite] [varchar](100) NOT NULL,
	[ProcedureHadComments] [bit] NOT NULL,
 CONSTRAINT [PK_DimProcedures] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimTasks](
	[id] [int] NOT NULL,
	[TaskType] [varchar](100) NOT NULL,
	[TaskRole] [varchar](100) NOT NULL,
	[TaskCompleted] [bit] NOT NULL,
	[TaskLifetimeDays] [int] NULL,
 CONSTRAINT [PK_DimTasks] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimTest](
	[id] [int] NOT NULL,
	[TestType] [varchar](100) NOT NULL,
	[TestUrgent] [bit] NOT NULL,
	[TestHadComment] [bit] NOT NULL,
 CONSTRAINT [PK_DimTest] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimTime](
	[DateKey] [int] NOT NULL,
	[FullDate] [date] NOT NULL,
	[Day] [int] NOT NULL,
	[Month] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[Week] [int] NOT NULL,
	[Quarter] [int] NOT NULL,
	[WeekDayName] [varchar](10) NOT NULL,
	[IsWeekend] [bit] NOT NULL,
 CONSTRAINT [PK_DimTime] PRIMARY KEY CLUSTERED 
(
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimUsers](
	[id] [int] NOT NULL,
	[UserName] [varchar](100) NOT NULL,
	[UserLogin] [varchar](100) NOT NULL,
	[UserRole] [varchar](100) NOT NULL,
 CONSTRAINT [PK_DimUsers] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactApplicationUsage](
	[Fact_id] [int] IDENTITY(1,1) NOT NULL,
	[Encounter_key] [int] NOT NULL,
	[User_key] [int] NOT NULL,
	[Date_Key] [int] NULL,
	[Test_Key] [int] NULL,
	[Task_key] [int] NULL,
	[Procedure_key] [int] NULL,
	[Booking_key] [int] NULL,
 CONSTRAINT [PK_FactApplicationUsage] PRIMARY KEY CLUSTERED 
(
	[Fact_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FactApplicationUsage]  WITH CHECK ADD  CONSTRAINT [FK_FactApplicationUsage_DimBooking] FOREIGN KEY([Booking_key])
REFERENCES [dbo].[DimBooking] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FactApplicationUsage] CHECK CONSTRAINT [FK_FactApplicationUsage_DimBooking]
GO
ALTER TABLE [dbo].[FactApplicationUsage]  WITH CHECK ADD  CONSTRAINT [FK_FactApplicationUsage_DimEncounter] FOREIGN KEY([Encounter_key])
REFERENCES [dbo].[DimEncounter] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FactApplicationUsage] CHECK CONSTRAINT [FK_FactApplicationUsage_DimEncounter]
GO
ALTER TABLE [dbo].[FactApplicationUsage]  WITH CHECK ADD  CONSTRAINT [FK_FactApplicationUsage_DimProcedures] FOREIGN KEY([Procedure_key])
REFERENCES [dbo].[DimProcedures] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FactApplicationUsage] CHECK CONSTRAINT [FK_FactApplicationUsage_DimProcedures]
GO
ALTER TABLE [dbo].[FactApplicationUsage]  WITH CHECK ADD  CONSTRAINT [FK_FactApplicationUsage_DimTasks] FOREIGN KEY([Task_key])
REFERENCES [dbo].[DimTasks] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FactApplicationUsage] CHECK CONSTRAINT [FK_FactApplicationUsage_DimTasks]
GO
ALTER TABLE [dbo].[FactApplicationUsage]  WITH CHECK ADD  CONSTRAINT [FK_FactApplicationUsage_DimTest] FOREIGN KEY([Test_Key])
REFERENCES [dbo].[DimTest] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FactApplicationUsage] CHECK CONSTRAINT [FK_FactApplicationUsage_DimTest]
GO
ALTER TABLE [dbo].[FactApplicationUsage]  WITH CHECK ADD  CONSTRAINT [FK_FactApplicationUsage_DimTime] FOREIGN KEY([Date_Key])
REFERENCES [dbo].[DimTime] ([DateKey])
GO
ALTER TABLE [dbo].[FactApplicationUsage] CHECK CONSTRAINT [FK_FactApplicationUsage_DimTime]
GO
ALTER TABLE [dbo].[FactApplicationUsage]  WITH CHECK ADD  CONSTRAINT [FK_FactApplicationUsage_DimUsers] FOREIGN KEY([User_key])
REFERENCES [dbo].[DimUsers] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FactApplicationUsage] CHECK CONSTRAINT [FK_FactApplicationUsage_DimUsers]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ClearAnalyticsDatabase] @AnalyticsDatabase NVARCHAR(MAX)
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

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EnsureDateKeysUpToDate] @ApplicationDatabase NVARCHAR(MAX), @AnalyticsDatabase NVARCHAR(MAX)
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

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ExecuteETLPipeline] @ApplicationDatabase NVARCHAR(MAX), @AnalyticsDatabase NVARCHAR(MAX)
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
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertBookingDimensions] @ApplicationDatabase NVARCHAR(MAX), @AnalyticsDatabase NVARCHAR(MAX)
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
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertBookingFacts] @ApplicationDatabase NVARCHAR(MAX), @AnalyticsDatabase NVARCHAR(MAX)
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
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertEncounterDimensions] @ApplicationDatabase NVARCHAR(MAX), @AnalyticsDatabase NVARCHAR(MAX)
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

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertProcedureDimensions] @ApplicationDatabase NVARCHAR(MAX), @AnalyticsDatabase NVARCHAR(MAX)
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

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertProcedureFacts] @ApplicationDatabase NVARCHAR(MAX), @AnalyticsDatabase NVARCHAR(MAX)
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
        FORMAT(ef.Creation_Date, ''yyyyMMdd'') AS Date_Key, -- Date key in YYYYMMDD format
        NULL AS Test_Key, -- Placeholder for Test Key
        NULL AS Task_Key, -- Placeholder for Task Key
        dp.id AS Procedure_Key, -- Procedure key from DimProcedures
        NULL AS Booking_Key -- Placeholder for Booking Key
    FROM ' + @AnalyticsDatabase + '.dbo.DimProcedures dp -- DimProcedures as the source
    LEFT JOIN ' + @ApplicationDatabase + '.dbo.PerformedProcedures pp ON dp.id = pp.id -- Join to fetch performed procedure details
    LEFT JOIN ' + @ApplicationDatabase + '.dbo.EncounterForms ef ON pp.Form_id = ef.id -- Join to fetch form details
    LEFT JOIN ' + @ApplicationDatabase + '.dbo.Encounters e ON ef.Encounter_id = e.id -- Join to fetch encounter details
    LEFT JOIN ' + @AnalyticsDatabase + '.dbo.DimEncounter de ON e.id = de.EncounterId -- Join to fetch DimEncounter details
    LEFT JOIN ' + @AnalyticsDatabase + '.dbo.DimUsers du ON ef.Consultant_id = du.id -- Join to fetch DimUsers details
    WHERE NOT EXISTS (
        SELECT 1
        FROM ' + @AnalyticsDatabase + '.dbo.FactApplicationUsage fau -- Target table to check existing records
        WHERE fau.Encounter_key = de.id -- Check if the encounter key exists
          AND fau.User_key = du.id -- Check if the user key exists
          AND fau.Date_Key = FORMAT(ef.Creation_Date, ''yyyyMMdd'') -- Check if the date key exists
          AND fau.Procedure_key = dp.id -- Check if the procedure key exists
    );
    ';

    -- Execute the dynamically constructed SQL query
    EXEC sp_executesql @Query;
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertTaskDimensions] @ApplicationDatabase NVARCHAR(MAX), @AnalyticsDatabase NVARCHAR(MAX)
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

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertTaskFacts] @ApplicationDatabase NVARCHAR(MAX), @AnalyticsDatabase NVARCHAR(MAX)
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
        FORMAT(tas.Task_Create_Date, ''yyyyMMdd'') AS Date_Key, -- Date key in YYYYMMDD format
        NULL AS Test_Key, -- Placeholder for Test Key
        dtas.id AS Task_Key, -- Task key from DimTasks
        NULL AS Procedure_Key, -- Placeholder for Procedure Key
        NULL AS Booking_Key -- Placeholder for Booking Key
    FROM ' + @AnalyticsDatabase + '.dbo.DimTasks dtas -- DimTasks as the source
    LEFT JOIN ' + @ApplicationDatabase + '.dbo.Tasks tas ON dtas.id = tas.id -- Join to fetch task details
    LEFT JOIN ' + @ApplicationDatabase + '.dbo.EncounterForms ef ON tas.Form_id = ef.id -- Join to fetch form details
    LEFT JOIN ' + @ApplicationDatabase + '.dbo.Encounters e ON ef.Encounter_id = e.id -- Join to fetch encounter details
    LEFT JOIN ' + @AnalyticsDatabase + '.dbo.DimEncounter de ON e.id = de.EncounterId -- Join to fetch DimEncounter details
    LEFT JOIN ' + @AnalyticsDatabase + '.dbo.DimUsers du ON ef.Consultant_id = du.id -- Join to fetch DimUsers details
    WHERE NOT EXISTS (
        SELECT 1
        FROM ' + @AnalyticsDatabase + '.dbo.FactApplicationUsage fau -- Target table to check existing records
        WHERE fau.Encounter_key = de.id -- Check if the encounter key exists
          AND fau.User_key = du.id -- Check if the user key exists
          AND fau.Date_Key = FORMAT(tas.Task_Create_Date, ''yyyyMMdd'') -- Check if the date key exists
          AND fau.Task_key = dtas.id -- Check if the task key exists
    );
    ';

    -- Execute the dynamically constructed SQL query
    EXEC sp_executesql @Query;
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertTestDimensions] @ApplicationDatabase NVARCHAR(MAX), @AnalyticsDatabase NVARCHAR(MAX)
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

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertTestFacts] @ApplicationDatabase NVARCHAR(MAX), @AnalyticsDatabase NVARCHAR(MAX)
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
        FORMAT(tr.Test_Request_Date, ''yyyyMMdd'') AS Date_Key, -- Date key in YYYYMMDD format
        dt.id AS Test_Key, -- Test key from DimTest
        NULL AS Task_Key, -- Placeholder for Task Key
        NULL AS Procedure_Key, -- Placeholder for Procedure Key
        NULL AS Booking_Key -- Placeholder for Booking Key
    FROM ' + @AnalyticsDatabase + '.dbo.DimTest dt -- DimTest as the source
    LEFT JOIN ' + @ApplicationDatabase + '.dbo.TestRequests tr ON dt.id = tr.id -- Join to fetch test request details
    LEFT JOIN ' + @ApplicationDatabase + '.dbo.EncounterForms ef ON tr.Form_id = ef.id -- Join to fetch form details
    LEFT JOIN ' + @ApplicationDatabase + '.dbo.Encounters e ON ef.Encounter_id = e.id -- Join to fetch encounter details
    LEFT JOIN ' + @AnalyticsDatabase + '.dbo.DimEncounter de ON e.id = de.EncounterId -- Join to fetch DimEncounter details
    LEFT JOIN ' + @AnalyticsDatabase + '.dbo.DimUsers du ON ef.Consultant_id = du.id -- Join to fetch DimUsers details
    WHERE NOT EXISTS (
        SELECT 1
        FROM ' + @AnalyticsDatabase + '.dbo.FactApplicationUsage fau -- Target table to check existing records
        WHERE fau.Encounter_key = de.id -- Check if the encounter key exists
          AND fau.User_key = du.id -- Check if the user key exists
          AND fau.Date_Key = FORMAT(tr.Test_Request_Date, ''yyyyMMdd'') -- Check if the date key exists
          AND fau.Test_key = dt.id -- Check if the test key exists
    );
    ';

    -- Execute the dynamically constructed SQL query
    EXEC sp_executesql @Query;
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertUsersDimensions] @ApplicationDatabase NVARCHAR(MAX), @AnalyticsDatabase NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON; -- Suppress row count messages to improve performance

    -- Declare the dynamic SQL query variable
    DECLARE @Query NVARCHAR(MAX);

    -- Construct the dynamic SQL query to insert data into DimUsers
    SET @Query = '
    INSERT INTO ' + @AnalyticsDatabase + '.dbo.DimUsers (id, UserName, UserLogin, UserRole)
    SELECT
        u.id, -- User ID from the source Users table
        u.First_Name + '' '' + u.Last_Name AS UserName, -- Combine First_Name and Last_Name with a space in between
        u.User_Login AS UserLogin, -- User login details
        r.Role_Description AS UserRole -- Role description from the Roles table
    FROM ' + @ApplicationDatabase + '.dbo.Users u -- Source Users table
    LEFT JOIN ' + @ApplicationDatabase + '.dbo.Roles r ON r.id = u.Role_id -- Join to fetch role details
    WHERE NOT EXISTS (
        SELECT 1
        FROM ' + @AnalyticsDatabase + '.dbo.DimUsers Du -- Target DimUsers table
        WHERE u.id = Du.id -- Exclude records that already exist in DimUsers
    );
    ';

    -- Execute the dynamically constructed SQL query
    EXEC sp_executesql @Query;
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[KibanaPipelineQuery]
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
GO
