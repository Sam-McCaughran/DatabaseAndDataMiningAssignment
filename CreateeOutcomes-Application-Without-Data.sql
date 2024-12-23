USE [eOutcomes-Application]
GO
/****** Object:  Table [dbo].[AttendanceStatus]    Script Date: 23/12/2024 19:05:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttendanceStatus](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Attendance_Status] [varchar](50) NOT NULL,
 CONSTRAINT [PK_AttendanceStatus] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Form_id] [int] NOT NULL,
	[Comment_Added_By_id] [int] NOT NULL,
	[Comment_Text] [varchar](200) NOT NULL,
	[Comment_Active] [bit] NOT NULL,
	[Comment_Added_Date] [datetime] NOT NULL,
	[Last_Modified_Date] [datetime] NOT NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EncounterForms]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EncounterForms](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Encounter_id] [varchar](14) NOT NULL,
	[Form_Definition_Type] [varchar](4) NOT NULL,
	[Attendance_Status_id] [int] NOT NULL,
	[Actual_Encounter_Medium] [varchar](4) NOT NULL,
	[New_RTT_Status_id] [int] NOT NULL,
	[Encounter_Outcome_id] [int] NOT NULL,
	[Consultant_id] [int] NULL,
	[Completed_By_id] [int] NULL,
	[Completed_Date] [datetime] NULL,
	[Creation_Date] [datetime] NOT NULL,
	[Last_Modified_By_id] [int] NOT NULL,
	[Last_Modified_Date] [datetime] NOT NULL,
 CONSTRAINT [PK_Encounter_Forms] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EncounterOutcomes]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EncounterOutcomes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Encounter_Outcome_Type] [varchar](50) NOT NULL,
 CONSTRAINT [PK_EncounterOutcomes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EncounterPurposes]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EncounterPurposes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Purpose_Treatment_Function_id] [int] NOT NULL,
	[Purpose_Description] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_Encounter_Purposes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Encounters]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Encounters](
	[id] [varchar](14) NOT NULL,
	[Encounter_Date] [datetime] NOT NULL,
	[Encounter_Type] [varchar](2) NOT NULL,
	[Patient_id] [varchar](6) NOT NULL,
	[Encounter_Location_id] [int] NOT NULL,
	[Encounter_Purpose_id] [int] NOT NULL,
	[Expected_Encounter_Clinician] [varchar](50) NULL,
	[Encounter_State_id] [int] NOT NULL,
	[Current_RTT_Status_id] [int] NOT NULL,
	[Expected_Encounter_Medium] [varchar](4) NOT NULL,
	[Import_Date] [datetime] NOT NULL,
	[Last_Modified_Date] [datetime] NOT NULL,
 CONSTRAINT [PK_Encounters] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EncounterState]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EncounterState](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Encounter_State_Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_EncounterState] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Locations]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Locations](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Clinic_Name] [varchar](100) NOT NULL,
	[Building] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Locations] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MedicalServices]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedicalServices](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Medical_Services] [varchar](100) NOT NULL,
 CONSTRAINT [PK_MedicalServices] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NewEncounterBookings]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NewEncounterBookings](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Form_id] [int] NOT NULL,
	[New_Encounter_Purpose_id] [int] NOT NULL,
	[Booked_In_Connect] [bit] NOT NULL,
	[New_Encounter_Comments] [varchar](200) NULL,
	[Added_Date] [datetime] NOT NULL,
	[Last_Modified_Date] [datetime] NOT NULL,
 CONSTRAINT [PK_FormBookings] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Patients]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patients](
	[id] [varchar](6) NOT NULL,
	[NHS_Number] [varchar](10) NOT NULL,
	[Patient_Forenames] [nvarchar](100) NOT NULL,
	[Patient_Surnames] [nvarchar](100) NOT NULL,
	[Patient_Date_Of_Birth] [date] NOT NULL,
	[Patient_Date_Of_Death] [date] NULL,
	[Initial_Import_Date] [date] NOT NULL,
	[Last_Modified_Date] [datetime] NOT NULL,
 CONSTRAINT [PK_Patients] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PerformedProcedures]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PerformedProcedures](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Form_id] [int] NOT NULL,
	[Procedure_id] [int] NOT NULL,
	[Procedure_Site_id] [int] NOT NULL,
	[Procedure_Comment] [varchar](100) NULL,
 CONSTRAINT [PK_FormProcedures] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProcedureSiteGroups]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProcedureSiteGroups](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Procedure_Site_Group] [varchar](100) NOT NULL,
 CONSTRAINT [PK_ProcedureSiteGroups] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProcedureSites]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProcedureSites](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Site_Group_id] [int] NOT NULL,
	[Site_Description] [varchar](200) NOT NULL,
	[Site_Code] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Procedure_Sites] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProcedureTypes]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProcedureTypes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Procedure_Treatment_Function_id] [int] NOT NULL,
	[Procedure_Concept_Code] [nvarchar](256) NOT NULL,
	[Procedure_Description] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_Procedures] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestionOptions]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestionOptions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Form_Question_Type_id] [int] NOT NULL,
	[Applicable_Treatment_Function_id] [int] NOT NULL,
	[Form_Question_Option_Text] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_FormQuestionOptions] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestionTypes]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestionTypes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Form_Question_Text] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_FormQuestionTypes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReferralToTreatStatus]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReferralToTreatStatus](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[RTT_Status_Description] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Role_Description] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tasks]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tasks](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Form_id] [int] NOT NULL,
	[Task_Type_id] [int] NOT NULL,
	[Task_Role_id] [int] NOT NULL,
	[Task_Complete] [bit] NOT NULL,
	[Task_Complete_Date] [datetime] NULL,
	[Task_Create_Date] [datetime] NOT NULL,
	[Task_Comment] [varchar](200) NULL,
	[Last_Modified_Date] [datetime] NOT NULL,
 CONSTRAINT [PK_FormTasks] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaskTypes]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskTypes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Task_Type_Description] [varchar](100) NOT NULL,
 CONSTRAINT [PK_TaskTypes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TestRequests]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestRequests](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Form_id] [int] NOT NULL,
	[Test_Type_id] [int] NOT NULL,
	[Test_Urgent] [bit] NOT NULL,
	[Test_Comments] [varchar](200) NULL,
	[Test_Request_Date] [datetime] NOT NULL,
	[Last_Modified_Date] [datetime] NOT NULL,
 CONSTRAINT [PK__FormTest__3213E83F3EC90030] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TestTypes]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestTypes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Test_Name] [varchar](100) NOT NULL,
 CONSTRAINT [PK_TestTypes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TreatmentFunctions]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TreatmentFunctions](
	[id] [int] NOT NULL,
	[Medical_Service_id] [int] NULL,
	[Treatment_Function_Name] [varchar](100) NOT NULL,
	[Treatment_Function_Division] [varchar](50) NOT NULL,
	[Treatment_Function_Caregroup] [varchar](10) NOT NULL,
	[Treatment_Function_Allows_PIFU] [bit] NULL,
 CONSTRAINT [PK_TreatmentFunctions] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[First_Name] [varchar](100) NOT NULL,
	[Last_Name] [varchar](100) NOT NULL,
	[User_Login] [varchar](100) NOT NULL,
	[Role_id] [int] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Comments] ADD  CONSTRAINT [DF_FormComments_Comment_Added_Date]  DEFAULT (getdate()) FOR [Comment_Added_Date]
GO
ALTER TABLE [dbo].[Comments] ADD  CONSTRAINT [DF_FormComments_Modify_Date]  DEFAULT (getdate()) FOR [Last_Modified_Date]
GO
ALTER TABLE [dbo].[EncounterForms] ADD  CONSTRAINT [DF_Encounter_Forms_Creation_Date]  DEFAULT (getdate()) FOR [Creation_Date]
GO
ALTER TABLE [dbo].[EncounterForms] ADD  CONSTRAINT [DF_EncounterForms_Last_Modified_Date]  DEFAULT (getdate()) FOR [Last_Modified_Date]
GO
ALTER TABLE [dbo].[Encounters] ADD  CONSTRAINT [DF_Encounters_Import_Date]  DEFAULT (getdate()) FOR [Import_Date]
GO
ALTER TABLE [dbo].[Encounters] ADD  CONSTRAINT [DF_Encounters_Last_Modified_Date]  DEFAULT (getdate()) FOR [Last_Modified_Date]
GO
ALTER TABLE [dbo].[NewEncounterBookings] ADD  CONSTRAINT [DF_FormNewEncounterBookings_Import_Date]  DEFAULT (getdate()) FOR [Added_Date]
GO
ALTER TABLE [dbo].[NewEncounterBookings] ADD  CONSTRAINT [DF_FormNewEncounterBookings_Last_Modified_Date]  DEFAULT (getdate()) FOR [Last_Modified_Date]
GO
ALTER TABLE [dbo].[Patients] ADD  CONSTRAINT [DF_Patients_Initial_Import_Date]  DEFAULT (getdate()) FOR [Initial_Import_Date]
GO
ALTER TABLE [dbo].[Patients] ADD  CONSTRAINT [DF_Patients_Last_Modified_Date]  DEFAULT (getdate()) FOR [Last_Modified_Date]
GO
ALTER TABLE [dbo].[Tasks] ADD  CONSTRAINT [DF_FormTasks_Task_Create_Date]  DEFAULT (getdate()) FOR [Task_Create_Date]
GO
ALTER TABLE [dbo].[Tasks] ADD  CONSTRAINT [DF_FormTasks_Last_Modified_Date1]  DEFAULT (getdate()) FOR [Last_Modified_Date]
GO
ALTER TABLE [dbo].[TestRequests] ADD  CONSTRAINT [DF_FormTestRequests_Last_Modified_Date]  DEFAULT (getdate()) FOR [Last_Modified_Date]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Users] FOREIGN KEY([Comment_Added_By_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Users]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_FormComments_EncounterForms] FOREIGN KEY([Form_id])
REFERENCES [dbo].[EncounterForms] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_FormComments_EncounterForms]
GO
ALTER TABLE [dbo].[EncounterForms]  WITH CHECK ADD  CONSTRAINT [FK_EncounterForms_AttendanceStatus] FOREIGN KEY([Attendance_Status_id])
REFERENCES [dbo].[AttendanceStatus] ([id])
GO
ALTER TABLE [dbo].[EncounterForms] CHECK CONSTRAINT [FK_EncounterForms_AttendanceStatus]
GO
ALTER TABLE [dbo].[EncounterForms]  WITH CHECK ADD  CONSTRAINT [FK_EncounterForms_EncounterOutcomes] FOREIGN KEY([Encounter_Outcome_id])
REFERENCES [dbo].[EncounterOutcomes] ([id])
GO
ALTER TABLE [dbo].[EncounterForms] CHECK CONSTRAINT [FK_EncounterForms_EncounterOutcomes]
GO
ALTER TABLE [dbo].[EncounterForms]  WITH CHECK ADD  CONSTRAINT [FK_EncounterForms_Encounters] FOREIGN KEY([Encounter_id])
REFERENCES [dbo].[Encounters] ([id])
GO
ALTER TABLE [dbo].[EncounterForms] CHECK CONSTRAINT [FK_EncounterForms_Encounters]
GO
ALTER TABLE [dbo].[EncounterForms]  WITH CHECK ADD  CONSTRAINT [FK_EncounterForms_RTTStatus] FOREIGN KEY([New_RTT_Status_id])
REFERENCES [dbo].[ReferralToTreatStatus] ([id])
GO
ALTER TABLE [dbo].[EncounterForms] CHECK CONSTRAINT [FK_EncounterForms_RTTStatus]
GO
ALTER TABLE [dbo].[EncounterForms]  WITH CHECK ADD  CONSTRAINT [FK_EncounterForms_Users] FOREIGN KEY([Completed_By_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[EncounterForms] CHECK CONSTRAINT [FK_EncounterForms_Users]
GO
ALTER TABLE [dbo].[EncounterForms]  WITH CHECK ADD  CONSTRAINT [FK_EncounterForms_Users1] FOREIGN KEY([Consultant_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[EncounterForms] CHECK CONSTRAINT [FK_EncounterForms_Users1]
GO
ALTER TABLE [dbo].[EncounterForms]  WITH CHECK ADD  CONSTRAINT [FK_EncounterForms_Users2] FOREIGN KEY([Last_Modified_By_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[EncounterForms] CHECK CONSTRAINT [FK_EncounterForms_Users2]
GO
ALTER TABLE [dbo].[EncounterPurposes]  WITH CHECK ADD  CONSTRAINT [FK_EncounterPurposes_TreatmentFunctions] FOREIGN KEY([Purpose_Treatment_Function_id])
REFERENCES [dbo].[TreatmentFunctions] ([id])
GO
ALTER TABLE [dbo].[EncounterPurposes] CHECK CONSTRAINT [FK_EncounterPurposes_TreatmentFunctions]
GO
ALTER TABLE [dbo].[Encounters]  WITH CHECK ADD  CONSTRAINT [FK_Encounters_EncounterPurposes] FOREIGN KEY([Encounter_Purpose_id])
REFERENCES [dbo].[EncounterPurposes] ([id])
GO
ALTER TABLE [dbo].[Encounters] CHECK CONSTRAINT [FK_Encounters_EncounterPurposes]
GO
ALTER TABLE [dbo].[Encounters]  WITH CHECK ADD  CONSTRAINT [FK_Encounters_EncounterState] FOREIGN KEY([Encounter_State_id])
REFERENCES [dbo].[EncounterState] ([id])
GO
ALTER TABLE [dbo].[Encounters] CHECK CONSTRAINT [FK_Encounters_EncounterState]
GO
ALTER TABLE [dbo].[Encounters]  WITH CHECK ADD  CONSTRAINT [FK_Encounters_Locations] FOREIGN KEY([Encounter_Location_id])
REFERENCES [dbo].[Locations] ([id])
GO
ALTER TABLE [dbo].[Encounters] CHECK CONSTRAINT [FK_Encounters_Locations]
GO
ALTER TABLE [dbo].[Encounters]  WITH CHECK ADD  CONSTRAINT [FK_Encounters_Patients] FOREIGN KEY([Patient_id])
REFERENCES [dbo].[Patients] ([id])
GO
ALTER TABLE [dbo].[Encounters] CHECK CONSTRAINT [FK_Encounters_Patients]
GO
ALTER TABLE [dbo].[Encounters]  WITH CHECK ADD  CONSTRAINT [FK_Encounters_ReferralToTreatStatus] FOREIGN KEY([Current_RTT_Status_id])
REFERENCES [dbo].[ReferralToTreatStatus] ([id])
GO
ALTER TABLE [dbo].[Encounters] CHECK CONSTRAINT [FK_Encounters_ReferralToTreatStatus]
GO
ALTER TABLE [dbo].[NewEncounterBookings]  WITH CHECK ADD  CONSTRAINT [FK_FormBookings_EncounterForms] FOREIGN KEY([Form_id])
REFERENCES [dbo].[EncounterForms] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[NewEncounterBookings] CHECK CONSTRAINT [FK_FormBookings_EncounterForms]
GO
ALTER TABLE [dbo].[NewEncounterBookings]  WITH CHECK ADD  CONSTRAINT [FK_FormBookings_Procedures] FOREIGN KEY([New_Encounter_Purpose_id])
REFERENCES [dbo].[EncounterPurposes] ([id])
GO
ALTER TABLE [dbo].[NewEncounterBookings] CHECK CONSTRAINT [FK_FormBookings_Procedures]
GO
ALTER TABLE [dbo].[PerformedProcedures]  WITH CHECK ADD  CONSTRAINT [FK_FormProcedures_EncounterForms] FOREIGN KEY([Form_id])
REFERENCES [dbo].[EncounterForms] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PerformedProcedures] CHECK CONSTRAINT [FK_FormProcedures_EncounterForms]
GO
ALTER TABLE [dbo].[PerformedProcedures]  WITH CHECK ADD  CONSTRAINT [FK_FormProcedures_Procedures] FOREIGN KEY([Procedure_id])
REFERENCES [dbo].[ProcedureTypes] ([id])
GO
ALTER TABLE [dbo].[PerformedProcedures] CHECK CONSTRAINT [FK_FormProcedures_Procedures]
GO
ALTER TABLE [dbo].[PerformedProcedures]  WITH CHECK ADD  CONSTRAINT [FK_FormProcedures_ProcedureSites] FOREIGN KEY([Procedure_Site_id])
REFERENCES [dbo].[ProcedureSites] ([id])
GO
ALTER TABLE [dbo].[PerformedProcedures] CHECK CONSTRAINT [FK_FormProcedures_ProcedureSites]
GO
ALTER TABLE [dbo].[ProcedureSites]  WITH CHECK ADD  CONSTRAINT [FK_ProcedureSites_ProcedureSiteGroups] FOREIGN KEY([Site_Group_id])
REFERENCES [dbo].[ProcedureSiteGroups] ([id])
GO
ALTER TABLE [dbo].[ProcedureSites] CHECK CONSTRAINT [FK_ProcedureSites_ProcedureSiteGroups]
GO
ALTER TABLE [dbo].[ProcedureTypes]  WITH CHECK ADD  CONSTRAINT [FK_Procedures_TreatmentFunctions] FOREIGN KEY([Procedure_Treatment_Function_id])
REFERENCES [dbo].[TreatmentFunctions] ([id])
GO
ALTER TABLE [dbo].[ProcedureTypes] CHECK CONSTRAINT [FK_Procedures_TreatmentFunctions]
GO
ALTER TABLE [dbo].[QuestionOptions]  WITH CHECK ADD  CONSTRAINT [FK_FormQuestionOptions_FormQuestionTypes] FOREIGN KEY([Form_Question_Type_id])
REFERENCES [dbo].[QuestionTypes] ([id])
GO
ALTER TABLE [dbo].[QuestionOptions] CHECK CONSTRAINT [FK_FormQuestionOptions_FormQuestionTypes]
GO
ALTER TABLE [dbo].[QuestionOptions]  WITH CHECK ADD  CONSTRAINT [FK_FormQuestionOptions_TreatmentFunctions] FOREIGN KEY([Applicable_Treatment_Function_id])
REFERENCES [dbo].[TreatmentFunctions] ([id])
GO
ALTER TABLE [dbo].[QuestionOptions] CHECK CONSTRAINT [FK_FormQuestionOptions_TreatmentFunctions]
GO
ALTER TABLE [dbo].[Tasks]  WITH CHECK ADD  CONSTRAINT [FK_FormTasks_EncounterForms] FOREIGN KEY([Form_id])
REFERENCES [dbo].[EncounterForms] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tasks] CHECK CONSTRAINT [FK_FormTasks_EncounterForms]
GO
ALTER TABLE [dbo].[Tasks]  WITH CHECK ADD  CONSTRAINT [FK_FormTasks_FormTaskTypes] FOREIGN KEY([Task_Type_id])
REFERENCES [dbo].[TaskTypes] ([id])
GO
ALTER TABLE [dbo].[Tasks] CHECK CONSTRAINT [FK_FormTasks_FormTaskTypes]
GO
ALTER TABLE [dbo].[Tasks]  WITH CHECK ADD  CONSTRAINT [FK_FormTasks_Roles] FOREIGN KEY([Task_Role_id])
REFERENCES [dbo].[Roles] ([id])
GO
ALTER TABLE [dbo].[Tasks] CHECK CONSTRAINT [FK_FormTasks_Roles]
GO
ALTER TABLE [dbo].[TestRequests]  WITH CHECK ADD  CONSTRAINT [FK_FormTestRequests_EncounterForms] FOREIGN KEY([Form_id])
REFERENCES [dbo].[EncounterForms] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TestRequests] CHECK CONSTRAINT [FK_FormTestRequests_EncounterForms]
GO
ALTER TABLE [dbo].[TestRequests]  WITH CHECK ADD  CONSTRAINT [FK_FormTestRequests_TestTypes] FOREIGN KEY([Test_Type_id])
REFERENCES [dbo].[TestTypes] ([id])
GO
ALTER TABLE [dbo].[TestRequests] CHECK CONSTRAINT [FK_FormTestRequests_TestTypes]
GO
ALTER TABLE [dbo].[TreatmentFunctions]  WITH CHECK ADD  CONSTRAINT [FK_TreatmentFunctions_MedicalServices] FOREIGN KEY([Medical_Service_id])
REFERENCES [dbo].[MedicalServices] ([id])
GO
ALTER TABLE [dbo].[TreatmentFunctions] CHECK CONSTRAINT [FK_TreatmentFunctions_MedicalServices]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Roles] FOREIGN KEY([Role_id])
REFERENCES [dbo].[Roles] ([id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Roles]
GO
/****** Object:  Trigger [dbo].[TR_Comments_UpdateModifiedDate]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[TR_Comments_UpdateModifiedDate]
                ON [dbo].[Comments]
                AFTER UPDATE
                AS
                BEGIN
                    SET NOCOUNT ON;

                    UPDATE Comments
                    SET Last_Modified_Date = GETDATE()
                    FROM Comments t
                    INNER JOIN inserted i ON t.id = i.id;
                END;
GO
ALTER TABLE [dbo].[Comments] ENABLE TRIGGER [TR_Comments_UpdateModifiedDate]
GO
/****** Object:  Trigger [dbo].[TR_EncounterForms_UpdateModifiedDate]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[TR_EncounterForms_UpdateModifiedDate]
                ON [dbo].[EncounterForms]
                AFTER UPDATE
                AS
                BEGIN
                    SET NOCOUNT ON;

                    UPDATE EncounterForms
                    SET Last_Modified_Date = GETDATE()
                    FROM EncounterForms t
                    INNER JOIN inserted i ON t.id = i.id;
                END;
GO
ALTER TABLE [dbo].[EncounterForms] ENABLE TRIGGER [TR_EncounterForms_UpdateModifiedDate]
GO
/****** Object:  Trigger [dbo].[TR_Encounters_UpdateModifiedDate]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[TR_Encounters_UpdateModifiedDate]
                ON [dbo].[Encounters]
                AFTER UPDATE
                AS
                BEGIN
                    SET NOCOUNT ON;

                    UPDATE Encounters
                    SET Last_Modified_Date = GETDATE()
                    FROM Encounters t
                    INNER JOIN inserted i ON t.id = i.id;
                END;
GO
ALTER TABLE [dbo].[Encounters] ENABLE TRIGGER [TR_Encounters_UpdateModifiedDate]
GO
/****** Object:  Trigger [dbo].[TR_NewEncounterBookings_UpdateModifiedDate]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[TR_NewEncounterBookings_UpdateModifiedDate]
                ON [dbo].[NewEncounterBookings]
                AFTER UPDATE
                AS
                BEGIN
                    SET NOCOUNT ON;

                    UPDATE NewEncounterBookings
                    SET Last_Modified_Date = GETDATE()
                    FROM NewEncounterBookings t
                    INNER JOIN inserted i ON t.id = i.id;
                END;
GO
ALTER TABLE [dbo].[NewEncounterBookings] ENABLE TRIGGER [TR_NewEncounterBookings_UpdateModifiedDate]
GO
/****** Object:  Trigger [dbo].[TR_Patients_UpdateModifiedDate]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[TR_Patients_UpdateModifiedDate]
                ON [dbo].[Patients]
                AFTER UPDATE
                AS
                BEGIN
                    SET NOCOUNT ON;

                    UPDATE Patients
                    SET Last_Modified_Date = GETDATE()
                    FROM Patients t
                    INNER JOIN inserted i ON t.id = i.id;
                END;
GO
ALTER TABLE [dbo].[Patients] ENABLE TRIGGER [TR_Patients_UpdateModifiedDate]
GO
/****** Object:  Trigger [dbo].[TR_Tasks_UpdateModifiedDate]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[TR_Tasks_UpdateModifiedDate]
                ON [dbo].[Tasks]
                AFTER UPDATE
                AS
                BEGIN
                    SET NOCOUNT ON;

                    UPDATE Tasks
                    SET Last_Modified_Date = GETDATE()
                    FROM Tasks t
                    INNER JOIN inserted i ON t.id = i.id;
                END;
GO
ALTER TABLE [dbo].[Tasks] ENABLE TRIGGER [TR_Tasks_UpdateModifiedDate]
GO
/****** Object:  Trigger [dbo].[TR_TestRequests_UpdateModifiedDate]    Script Date: 23/12/2024 19:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[TR_TestRequests_UpdateModifiedDate]
                ON [dbo].[TestRequests]
                AFTER UPDATE
                AS
                BEGIN
                    SET NOCOUNT ON;

                    UPDATE TestRequests
                    SET Last_Modified_Date = GETDATE()
                    FROM TestRequests t
                    INNER JOIN inserted i ON t.id = i.id;
                END;
GO
ALTER TABLE [dbo].[TestRequests] ENABLE TRIGGER [TR_TestRequests_UpdateModifiedDate]
GO
