CREATE PROCEDURE InsertUsersDimensions @ApplicationDatabase NVARCHAR(MAX), @AnalyticsDatabase NVARCHAR(MAX)
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
