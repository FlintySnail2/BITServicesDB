USE [BIT_JobManagement]
GO
/****** Object:  StoredProcedure [dbo].[usp_AbsentContractorSkill]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[usp_AbsentContractorSkill] 
	-- Add the parameters for the stored procedure here
	@ContractorId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT OFF;

    SELECT DISTINCT	
		S.SkillTitle
	FROM
		Skill AS S
	WHERE
		S.SkillTitle NOT IN(SELECT 
								CS.SkillTitle
							FROM
								ContractSkill AS CS
							WHERE
								CS.ContractorId = @ContractorId);
		
		
END
GO
/****** Object:  StoredProcedure [dbo].[usp_AcceptJob]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry
-- Create date: 13/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_AcceptJob]
	-- Add the parameters for the stored procedure here
	@JobId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE
		Job
	SET
		[Status] = 'Accepted'
	WHERE
		JobId = @JobId;
END
GO
/****** Object:  StoredProcedure [dbo].[usp_AssignContractor]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_AssignContractor]
	-- Add the parameters for the stored procedure here
	@ContractorId INT,
	@JobId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	UPDATE
		Job	
	SET
		[Status] = 'Assigned',
		ContractorId = @ContractorId
	WHERE
		JobId = @JobId
END
GO
/****** Object:  StoredProcedure [dbo].[usp_AssignJob]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry
-- Create date: 13/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_AssignJob]
	-- Add the parameters for the stored procedure here
	@JobId  INT,
	@ContractorId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE 
		Job
	SET
		[Status] = 'Assign'
	WHERE
		JobId = @JobId
	AND
		ContractorId = @ContractorId;
END
GO
/****** Object:  StoredProcedure [dbo].[usp_AvailableContractor]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_AvailableContractor]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
SELECT
	CON.ContractorId,
	CON.FirstName,
	CON.LastName,
	CS.SkillTitle,
	A.AvailabilityDate,
	CON.ContractorRating
FROM
	Contractor as CON
INNER JOIN [Availability] AS A ON CON.ContractorId = A.ContractorId
INNER JOIN ContractSkill AS CS ON CON.ContractorId = CS.ContractorId;
	
END
GO
/****** Object:  StoredProcedure [dbo].[usp_CheckClient]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry
-- Create date: 13/7/2022
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[usp_CheckClient] 
	-- Add the parameters for the stored procedure here
	@Password NVARCHAR(50),
	@Email NVARCHAR(320)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
		ClientId
	FROM
		Client
	WHERE
		Email = @Email
	AND
		[Password] = @Password;
END
GO
/****** Object:  StoredProcedure [dbo].[usp_CheckContractor]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry
-- Create date: 13/7/2022
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[usp_CheckContractor] 
	-- Add the parameters for the stored procedure here
	@Password NVARCHAR(50),
	@Email NVARCHAR(320)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
		ContractorId
	FROM
		Contractor
	WHERE
		Email = @Email
	AND
		[Password] = @Password;
END
GO
/****** Object:  StoredProcedure [dbo].[usp_CheckStaff]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry
-- Create date: 13/7/2022
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[usp_CheckStaff] 
	-- Add the parameters for the stored procedure here
	@Password NVARCHAR(50),
	@Email NVARCHAR(320)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
		StaffId
	FROM
		Staff
	WHERE
		Email = @Email
	AND
		[Password] = @Password;
END
GO
/****** Object:  StoredProcedure [dbo].[usp_CompleteJob]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry
-- Create date: 13/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_CompleteJob]
	-- Add the parameters for the stored procedure here
	@JobId INT,
	@Comment NVARCHAR(500),
	@DistanceTravelled NVARCHAR(10),
	@Hours DECIMAL(4,2)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE
		Job
	SET
		[Status] = 'Compeleted',
		DistanceTravelled = @DistanceTravelled,
		HoursOnJob = @Hours 
		
	WHERE
		JobId = @JobId;

	-- INSERT COMMENTS INTO FEEDBACK TABLE

	INSERT INTO Feedback(
						JobId,
						Comment)
					VALUES(
						@JobId,
						@Comment);
						
END
GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteAvailability]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_DeleteAvailability]
	-- Add the parameters for the stored procedure here
	@AvailabilityDate DATE,
	@ContractorId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	DELETE FROM 
		[Availability]
	WHERE
		ContractorId = @ContractorId
	AND
		AvailabilityDate = @AvailabilityDate;

END
GO
/****** Object:  StoredProcedure [dbo].[usp_FindAvailableContractor]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_FindAvailableContractor]
	-- Add the parameters for the stored procedure here
	@Skill NVARCHAR(25),
	@ReqCompletion DATE

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
SELECT
	CON.ContractorId,
	CON.FirstName,
	CON.LastName,
	CS.SkillTitle,
	A.AvailabilityDate,
	CON.ContractorRating
FROM
	Contractor as CON
INNER JOIN [Availability] AS A ON CON.ContractorId = A.ContractorId
INNER JOIN ContractSkill AS CS ON CON.ContractorId = CS.ContractorId
WHERE
	CS.SkillTitle = @Skill
AND
	A.AvailabilityDate = @ReqCompletion;
;
	
END
GO
/****** Object:  StoredProcedure [dbo].[usp_FindAvailableContractorBySkill&Id]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_FindAvailableContractorBySkill&Id]
	-- Add the parameters for the stored procedure here
	@Skill NVARCHAR(25),
	@ReqCompletion DATE

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
SELECT
	CON.ContractorId,
	CON.FirstName,
	CON.LastName,
	CS.SkillTitle,
	A.AvailabilityDate,
	CON.ContractorRating
FROM
	Contractor as CON
INNER JOIN [Availability] AS A ON CON.ContractorId = A.ContractorId
INNER JOIN ContractSkill AS CS ON CON.ContractorId = CS.ContractorId
WHERE
	CS.SkillTitle = @Skill
AND
	A.AvailabilityDate = @ReqCompletion;
;
	
END
GO
/****** Object:  StoredProcedure [dbo].[usp_FindContractor]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_FindContractor]
	-- Add the parameters for the stored procedure here
	@ContractorId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT
		CON.ContractorId,
		CON.FirstName,
		CON.LastName,
		CS.SkillTitle,
		A.AvailabilityDate
	FROM
		Contractor AS CON
	INNER JOIN [Availability] AS A ON CON.ContractorId = A.ContractorId
	INNER JOIN ContractSkill AS CS ON CON.ContractorId = CS.ContractorId
	WHERE
		CON.ContractorId = @ContractorId;
END
GO
/****** Object:  StoredProcedure [dbo].[usp_FindContractorRequestedJob]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_FindContractorRequestedJob]
	-- Add the parameters for the stored procedure here
	@ContractorId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT
		CON.ContractorId,
		CON.FirstName,
		CON.LastName,
		CS.SkillTitle,
		A.AvailabilityDate
	FROM
		Contractor AS CON
	INNER JOIN [Availability] AS A ON CON.ContractorId = A.ContractorId
	INNER JOIN ContractSkill AS CS ON CON.ContractorId = CS.ContractorId
	WHERE
		CON.ContractorId = @ContractorId;
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetAbsentContractorSkill]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_GetAbsentContractorSkill] 
	-- Add the parameters for the stored procedure here
	@ContractorId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT OFF;

    SELECT DISTINCT	
		S.SkillTitle
	FROM
		Skill AS S
	WHERE
		S.SkillTitle NOT IN(SELECT 
								CS.SkillTitle
							FROM
								ContractSkill AS CS
							WHERE
								CS.ContractorId = @ContractorId);
		
		
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetAllAcceptedJobs]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry
-- Create date: 13/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_GetAllAcceptedJobs]
	-- Add the parameters for the stored procedure here
	@ContractorId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
		J.JobId AS [Job Number],
		C.OrganisationName AS Client,
		C.FirstName + ' ' + C.LastName AS [Contact Name],
		C.Phone AS [Contact Number],
		CONVERT(NVARCHAR, J.RequestedCompletionDate, 6) AS [Requested Completion],
		J.SkillTitle AS [Skill Required],
		J.[Priority] AS [Job Priority],
		J.[Description] AS [Job Description]
	FROM	
		Job AS J 
	INNER JOIN Client AS C ON J.ClientId = C.ClientId
	INNER JOIN Contractor AS CON ON J.ContractorId = CON.ContractorId
	AND CON.ContractorId = @ContractorId
	AND J.[Status] = 'Accepted'
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetAllAssignedJobs]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry
-- Create date: 13/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_GetAllAssignedJobs]
	-- Add the parameters for the stored procedure here
	@ContractorId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
		J.JobId AS [Job Number],
		C.OrganisationName AS Client,
		C.FirstName + ' ' + C.LastName AS [Contact Name],
		C.Phone AS [Contact Number],
		CONVERT(NVARCHAR, J.RequestedCompletionDate, 6) AS [Requested Completion],
		J.SkillTitle AS [Skill Required],
		J.[Priority] AS [Job Priority],
		J.[Description] AS [Job Description]
	FROM	
		Job AS J 
	INNER JOIN Client AS C ON J.ClientId = C.ClientId
	INNER JOIN Contractor AS CON ON J.ContractorId = CON.ContractorId
	AND CON.ContractorId = @ContractorId
	AND J.[Status] = 'Assigned'
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetAllClientJobs]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry
-- Create date: 13/7/2022
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetAllClientJobs] 
	-- Add the parameters for the stored procedure here
	@ClientId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
		J.JobId AS [Job Number],
		CON.FirstName + ' ' + CON.LastName AS [Contractor Name],
		CONVERT(NVARCHAR, J.RequestedCompletionDate, 6) AS [Service Date],
		J.[Description] AS  [Job Description],
		F.Comment AS [Job Feedback],
		j.[Priority] AS [Job Priority],
		J.[Status] AS [Job Status]
	FROM
		Client AS C
	INNER JOIN Job AS J ON J.ClientId = C.ClientId
	INNER JOIN Contractor AS CON ON J.ContractorId = CON.ContractorId
	INNER JOIN Feedback AS F ON J.JobId = F.JobId
	AND C.ClientId = @ClientId;
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetAllClientRegions]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry
-- Create date: 13/7/2022
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetAllClientRegions] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
		Region
	FROM
		Region 	
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetAllClients]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_GetAllClients]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT
		C.ClientId,
		C.OrganisationName,
		C.FirstName,
		C.LastName,
		C.Phone,
		C.Email,
		L.Street,
		L.Suburb,
		L.[State],
		L.Zip,
		L.Region
	FROM
		Client AS C
	INNER JOIN 
		[Location] AS L ON C.ClientId = L.ClientId
	WHERE
		AccountStatus = 'Active'
	ORDER BY
		C.ClientId ASC

END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetAllCompletedJobs]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry
-- Create date: 13/7/2022
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetAllCompletedJobs] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
		J.JobId AS [Job Number],
		C.OrganisationName AS Client,
		C.FirstName + ' ' + C.LastName AS [Contact Name],
		CON.FirstName + ' ' + CON.LastName AS Contractor,
		CONVERT(NVARCHAR, J.RequestedStartDate, 6) AS [Service Date],
		CONVERT(nvarchar, J.RequestedCompletionDate, 6) AS [Requested Completion],
		J.[Status] AS [Job Status],
		j.[Description] AS [Job Description]
	FROM
		Contractor AS CON
	INNER JOIN Job AS J ON CON.ContractorId = J.ContractorId
	INNER JOIN Client AS C ON J.ClientId = C.ClientId
	AND J.[Status] = 'Completed';
		
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetAllRejectedJobs]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry
-- Create date: 13/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_GetAllRejectedJobs] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET DATEFORMAT DMY;
	SELECT
		J.JobId AS [Job Number],
		C.OrganisationName AS Client,
		C.FirstName + ' ' + C.LastName AS [Contact Name],
		CON.FirstName + ' ' + CON.LastName AS Contractor,
		R.Comment AS Reason,
		J.SkillTitle AS [Skill Required],
		CONVERT(NVARCHAR, J.RequestedStartDate, 6) AS [Service Date],
		CONVERT(nvarchar, J.RequestedCompletionDate, 6) AS [Requested Completion],
		J.[Status] AS [Job Status],
		j.[Description] AS [Job Description]
	FROM
		Contractor AS CON
	INNER JOIN Job AS J ON CON.ContractorId = J.ContractorId
	INNER JOIN Client AS C ON J.ClientId = C.ClientId
	INNER JOIN RejectedJob AS R ON J.JobId = R.JobId
 	AND J.[Status] = 'Rejected'
	ORDER BY J.JobId ASC;
		
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetAllRequestedJobs]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry
-- Create date: 13/7/2022
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetAllRequestedJobs] 
	-- Add the parameters for the stored procedure here
	@ClientId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
		J.JobId AS [Job Number],
		CON.FirstName + ' ' + CON.LastName AS [Contractor Name],
		CONVERT(NVARCHAR, J.RequestedCompletionDate, 6) AS [Service Date],
		J.[Description] AS  [Job Description],
		F.Comment AS [Job Feedback],
		j.[Priority] AS [Job Priority],
		J.[Status] AS [Job Status]
	FROM
		Client AS C
	INNER JOIN Job AS J ON J.ClientId = C.ClientId
	INNER JOIN Contractor AS CON ON J.ContractorId = CON.ContractorId
	INNER JOIN Feedback AS F ON J.JobId = F.JobId
	AND C.ClientId = @ClientId;
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetAllSkills]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry
-- Create date: 13/7/2022
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetAllSkills] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT
		SkillTitle
	FROM
		ContractSkill;
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetAvailableContractors]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_GetAvailableContractors]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
SELECT
	CON.ContractorId,
	CON.FirstName,
	CON.LastName,
	CS.SkillTitle,
	A.AvailabilityDate,
	CON.ContractorRating
FROM
	Contractor as CON
INNER JOIN [Availability] AS A ON CON.ContractorId = A.ContractorId
INNER JOIN ContractSkill AS CS ON CON.ContractorId = CS.ContractorId;
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetContractorAvailabilities]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_GetContractorAvailabilities]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT
	ContractorId,
	AvailabilityDate
	FROM	
		[Availability]
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetContractorAvailabilitiesById]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_GetContractorAvailabilitiesById]
	-- Add the parameters for the stored procedure here
	@ContractorId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT
	ContractorId,
	AvailabilityDate
	FROM	
		[Availability]
	WHERE
		ContractorId = @ContractorId;
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetContractors]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =========================================== ==
CREATE   PROCEDURE [dbo].[usp_GetContractors]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT
		ContractorId,
		FirstName,
		LastName,
		Dob,
		Street,
		Suburb,
		[State],
		Zip,
		Phone,
		Email,
		ABN,
		LicenceNumber,
		RateofPay,
		ContractorRating
	FROM	
		Contractor
	WHERE
		AccountStatus = 'Active';
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetContractorSkills]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_GetContractorSkills]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT 
		SkillTitle
	FROM
		Skill
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetContractorSkillsById]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_GetContractorSkillsById]
	-- Add the parameters for the stored procedure here
	@ContractorId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT 
		SkillTitle
	FROM
		ContractSkill
	WHERE
		ContractorId = @ContractorId
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetCoordinators]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_GetCoordinators]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT 
		StaffId,
		FirstName,
		LastName,
		Dob,
		Phone,
		Email,
		[Password]
	FROM
		Staff
	WHERE
		AccountStatus = 'Active'
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetJobs]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_GetJobs]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT
	    J.JobId,
	    C.OrganisationName AS [Organisation Name],
	    C.FirstName + ' ' + C.LastName as [Contact Name],
	    CON.FirstName AS ContractorName,
	    J.Description,
	    J.SkillTitle AS [Skill Required],
	    J.Priority,
	    S.Status,
	    C.Phone,
	    J.HoursOnJob AS [Hours On Job],
	    CONVERT(NVARCHAR, J.RequestedCompletionDate, 6) AS [Requested Completion],
	    J.DistanceTravelled AS [Distance Travelled],
	    L.Street + ' ' + L.Suburb + ', ' + L.State + ', ' + CAST(L.Zip AS NVARCHAR) AS Location
	FROM
	    Job AS J
	INNER JOIN Client AS C ON J.ClientId = C.ClientId
	INNER JOIN [Location] AS L ON J.ClientId = L.ClientId
	INNER JOIN [Status] AS S ON J.[Status] = S.[Status]
	INNER JOIN Contractor AS CON ON J.ContractorId = CON.ContractorId
	WHERE
		J.Status = 'Completed';
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetJobStatus]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_GetJobStatus]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT
		[Status]
	FROM 
		[Status]
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetRegionByClientId]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_GetRegionByClientId]
	-- Add the parameters for the stored procedure here
	@ClientId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT
		Region
	FROM
		[Location]
	WHERE
		ClientId = @ClientId;
		
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetRegions]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_GetRegions]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT
		Region
	FROM
		Region	
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetRejectedJobs]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_GetRejectedJobs]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT
		J.JobId,
		C.OrganisationName,
		C.FirstName + ' ' + C.LastName AS [Contact Name],
		CON.FirstName AS [Contractor Name],
		J.[Description],
		J.[Priority],
		S.[Status],
		J.SkillTitle,
		CONVERT(NVARCHAR, J.RequestedCompletionDate, 6) AS [Requested Completion]
	FROM
		Job AS J 
	INNER JOIN Client AS C ON J.ClientId = C.ClientId
	INNER JOIN [Status] AS S ON J.[Status] = S.[Status]
	INNER JOIN Contractor AS CON ON J.ContractorId = CON.ContractorId
	AND
		J.[Status] = 'Rejected'
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetRequestedJob]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_GetRequestedJob]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT
		J.JobId,
		C.OrganisationName,
		C.FirstName + ' ' + C.LastName AS [Contact Name],
		J.[Description],
		J.[Priority],
		S.[Status],
		J.SkillTitle,
		CONVERT(NVARCHAR, J.RequestedCompletionDate, 6) AS [Requested Completion]
	FROM	
		Job AS J
	INNER JOIN Client AS C ON J.ClientId = C.ClientId
	INNER JOIN [Status] AS S ON J.[Status] = S.[Status]
	WHERE 
		S.Status = 'Pending';
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetStaff]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_GetStaff]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT 
		StaffId,
		FirstName,
		LastName,
		Dob,
		Phone,
		Email,
		[Password]
	FROM
		Staff
	WHERE
		AccountStatus = 'Active'
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetSystemSkill]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_GetSystemSkill]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT 
		SkillTitle
	FROM
		Skill
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetSystemSkillBySkillName]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_GetSystemSkillBySkillName]
	-- Add the parameters for the stored procedure here
	@Skill NVARCHAR(30)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT 
		SkillTitle
	FROM
		Skill
	WHERE
		SkillTitle = @Skill;
END
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertAvailability]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_InsertAvailability]
	-- Add the parameters for the stored procedure here
	@AvailabilityDate DATE,
	@ContractorId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET DATEFORMAT DMY;
	INSERT INTO [Availability](
			ContractorId,
			AvailabilityDate)
		VALUES(
			@ContractorId,
			@AvailabilityDate);

END
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertClient]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_InsertClient]
	-- Add the parameters for the stored procedure here
	@OrganisationName NVARCHAR(30),
	@FirstName NVARCHAR(50),
	@LastName NVARCHAR(50),
	@Phone NCHAR(10),
	@Email NVARCHAR(320),
	@Password NVARCHAR(50),
	@Region NVARCHAR(30),
	@Street NVARCHAR(30),
	@Suburb NVARCHAR(30),
	@State NVARCHAR(3),
	@Zip NCHAR(4)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
INSERT INTO Client(
				OrganisationName,
				FirstName,
				LastName,
				Phone,
				Email,
				[Password],
				[AccountStatus])
			VALUES(
				@OrganisationName,
				@FirstName,
				@LastName,
				@Phone,
				@Email,
				@Password,
				'Active')
DECLARE @ClientId INT = @@Identity

INSERT INTO Location(
				ClientId,
				Region,
				Street,
				Suburb,
				[State],
				Zip)
			VALUES(
				@ClientId,
				@Region,
				@Street,
				@Suburb,
				@State,
				@Zip)
				
	
END
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertContractor]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_InsertContractor]
	-- Add the parameters for the stored procedure here
	@FirstName NVARCHAR(50),
	@LastName NVARCHAR(50),
	@Street NVARCHAR(30),
	@Suburb NVARCHAR(30),
	@State NVARCHAR(3),
	@Zip NCHAR(4),
	@Phone NCHAR(10),
	@Dob DATE,
	@Email NVARCHAR(320),
	@Password NVARCHAR(50),
	@ABN NVARCHAR(10),
	@LicenceNumber NVARCHAR(15),
	@RateofPay DECIMAL(4,2)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET DATEFORMAT DMY;
	INSERT INTO Contractor(
					FirstName,
					LastName,
					Street,
					Suburb,
					[State],
					Zip,
					Phone,
					Dob,
					Email,
					[Password],
					ABN,
					LicenceNumber,
					RateofPay,
					ContractorRating,
					AccountStatus)
				VALUES(
					@FirstName,
					@LastName,
					@Street,
					@Suburb,
					@State,
					@Zip,
					@Phone,
					@Dob,
					@Email,
					@Password,
					@ABN,
					@LicenceNumber,
					@RateofPay,
					'0',
					'Active');

END
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertNewClientJob]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry
-- Create date: 13/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_InsertNewClientJob]
	-- Add the parameters for the stored procedure here
	@ClientId  INT,
	@Region NVARCHAR(30),    
	@Priority NVARCHAR(10),
	@SkillTitle NVARCHAR(30),
	@Description NVARCHAR(300),
	@StartDate DATE,
	@CompletionDate DATE
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Job(
				ClientId,
				Region,
				[Priority],
				SkillTitle,
				[Description],
				RequestedStartDate,
				RequestedCompletionDate,
				[Status])
			VALUES(
				@ClientId,
				@Region,
				@Priority,
				@SkillTitle,
				@Description,
				@StartDate,
				@CompletionDate,
				'Pending');
END
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertNewJob]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_InsertNewJob]
	-- Add the parameters for the stored procedure here
	@ClientId INT,
	@Priority NVARCHAR(10),
	@SkillTitle NVARCHAR(30),
	@ReqStartDate DATE,
	@ReqCompletion DATE,
	@Description NVARCHAR(300),
	@Location NVARCHAR(30)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET DATEFORMAT DMY;
	INSERT INTO Job(
					ClientId,
					[Priority],
					SkillTitle,
					RequestedStartDate,
					RequestedCompletionDate,
					[Status],
					[Description],
					Region)
				VALUES(
					@ClientId,
					@Priority,
					@SkillTitle,
					@ReqStartDate,
					@ReqCompletion,
					'Pending',
					@Description,
					@Location);
END
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertStaff]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_InsertStaff]
	-- Add the parameters for the stored procedure here
	@FirstName NVARCHAR(50),
	@LastName NVARCHAR(50),
	@Phone NCHAR(4),
	@Dob DATE,
	@Email NVARCHAR(320),
	@Password NVARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET DATEFORMAT DMY;
	INSERT INTO Staff(
					FirstName,
					LastName,
					Phone,
					Dob,
					Email,
					[Password],
					StaffId,
					AccountStatus)
				VALUES(
					@FirstName,
					@LastName,
					@Phone,
					@Dob,
					@Email,
					@Password,
					'Coordinator',
					'Active');
END
GO
/****** Object:  StoredProcedure [dbo].[usp_InsertSystemSkill]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_InsertSystemSkill]
	-- Add the parameters for the stored procedure here
	@Skill NVARCHAR(30)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	INSERT INTO 
			Skill(
				SkillTitle)
			VALUES(
				@Skill);
END
GO
/****** Object:  StoredProcedure [dbo].[usp_JobVerified]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry
-- Create date: 13/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_JobVerified]
	-- Add the parameters for the stored procedure here
	@JobId  INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE 
		Job
	SET
		[Status] = 'Verified'
	WHERE
		JobId = @JobId;
END
GO
/****** Object:  StoredProcedure [dbo].[usp_ReadClients]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_ReadClients]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT
		C.ClientId,
		C.OrganisationName,
		C.FirstName,
		C.LastName,
		C.Phone,
		C.Email,
		L.Street,
		L.Suburb,
		L.[State],
		L.Zip,
		L.Region
	FROM
		Client AS C
	INNER JOIN 
		[Location] AS L ON C.ClientId = L.ClientId
	WHERE
		AccountStatus = 'Active'
	ORDER BY
		C.ClientId ASC

END
GO
/****** Object:  StoredProcedure [dbo].[usp_ReadContractorAvailabilies]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_ReadContractorAvailabilies]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT
	ContractorId,
	AvailabilityDate
	FROM	
		[Availability]
END
GO
/****** Object:  StoredProcedure [dbo].[usp_ReadContractors]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_ReadContractors]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT
		ContractorId,
		FirstName,
		LastName,
		Dob,
		Street,
		Suburb,
		[State],
		Zip,
		Phone,
		Email,
		ABN,
		LicenceNumber,
		RateofPay,
		ContractorRating
	FROM	
		Contractor
	WHERE
		AccountStatus = 'Active';
END
GO
/****** Object:  StoredProcedure [dbo].[usp_ReassignJob]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_ReassignJob]
	-- Add the parameters for the stored procedure here
	@ContractorId INT,
	@JobId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	UPDATE
		Job	
	SET
		[Status] = 'Assigned',
		ContractorId = @ContractorId
	WHERE
		JobId = @JobId;
END
GO
/****** Object:  StoredProcedure [dbo].[usp_RejectJob]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry
-- Create date: 13/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_RejectJob]
	-- Add the parameters for the stored procedure here
	@JobId INT,
	@ContractorId INT,
	@Comment NVARCHAR(500)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE
		Job
	SET
		[Status] = 'Rejected'
	WHERE
		JobId = @JobId;

	-- INSERT COMMENTS INTO REJECTION TABLE

	INSERT INTO RejectedJob(
						JobId,
						ContractorId,
						Comment)
					VALUES(
						@JobId,
						@ContractorId,
						@Comment);
						
END
GO
/****** Object:  StoredProcedure [dbo].[usp_RemoveClient]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_RemoveClient]
	-- Add the parameters for the stored procedure here
	@ClientId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	UPDATE 
		Client	
	SET 
		AccountStatus = 'Inactive'
	WHERE
		ClientId = @ClientId

END
GO
/****** Object:  StoredProcedure [dbo].[usp_RemoveContractor]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_RemoveContractor]
	-- Add the parameters for the stored procedure here
	@ContractorId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	UPDATE
		Contractor
	SET
		AccountStatus = 'Inactive'
	WHERE
		ContractorId = @ContractorId;


END
GO
/****** Object:  StoredProcedure [dbo].[usp_RemoveContractorSkill]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_RemoveContractorSkill]
	-- Add the parameters for the stored procedure here
	@ContractorId INT,
	@SkillTitle NVARCHAR(30)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	DELETE FROM 
		ContractSkill
	WHERE
		ContractorId = @ContractorId
	AND
		SkillTitle = @SkillTitle;
END
GO
/****** Object:  StoredProcedure [dbo].[usp_RemoveStaff]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_RemoveStaff]
	-- Add the parameters for the stored procedure here
	@StaffId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	UPDATE
		Staff
	SET
		AccountStatus = 'Inactive'
	WHERE
		StaffId = @StaffId;
END
GO
/****** Object:  StoredProcedure [dbo].[usp_SearchClient]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_SearchClient]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT
		C.ClientId,
		C.OrganisationName,
		C.FirstName,
		C.LastName,
		C.Phone,
		C.Email,
		L.Street,
		L.Suburb,
		L.[State],
		L.Zip,
		L.Region
	FROM
		Client AS C
	INNER JOIN 
		[Location] AS L ON C.ClientId = L.ClientId
	WHERE
		AccountStatus = 'Active'
	AND
		C.OrganisationName LIKE '%searchText%'

END
GO
/****** Object:  StoredProcedure [dbo].[usp_SearchClients]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_SearchClients]
	-- Add the parameters for the stored procedure here
	@searchText NVARCHAR(35)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT
		C.ClientId,
		C.OrganisationName,
		C.FirstName,
		C.LastName,
		C.Phone,
		C.Email,
		L.Street,
		L.Suburb,
		L.[State],
		L.Zip,
		L.Region
	FROM Client AS C
	INNER JOIN [Location] AS L ON C.ClientId = L.ClientId
	WHERE AccountStatus = 'Active'
	AND C.OrganisationName LIKE '%' + @searchText + '%';
END
GO
/****** Object:  StoredProcedure [dbo].[usp_SearchContractors]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_SearchContractors]
	-- Add the parameters for the stored procedure here
	@SearchText NVARCHAR(35)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT
		C.ContractorId,
		C.FirstName,
		C.LastName,
		C.Dob,
		C.Street,
		C.Suburb,
		C.[State],
		C.Zip,
		C.Phone,
		C.Email,
		C.ABN,
		C.LicenceNumber,
		C.RateofPay,
		C.ContractorRating,
		CS.SkillTitle
	FROM	
		Contractor AS C 
	INNER JOIN 
		ContractSkill AS CS ON C.ContractorId = CS.ContractorId
	WHERE
		C.FirstName LIKE '%' + @searchText + '%';
END
GO
/****** Object:  StoredProcedure [dbo].[usp_SearchCoordinators]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_SearchCoordinators]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT 
		StaffId,
		FirstName,
		LastName,
		Dob,
		Phone,
		Email,
		[Password]
	FROM
		Staff
	WHERE
		AccountStatus = 'Active'
	AND
		FirstName LIKE '%searchText%'
END
GO
/****** Object:  StoredProcedure [dbo].[usp_SearchJobs]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_SearchJobs]
	-- Add the parameters for the stored procedure here
	@SearchText NVARCHAR(35)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT
	    J.JobId,
	    C.OrganisationName AS [Organisation Name],
	    C.FirstName + ' ' + C.LastName as [Contact Name],
	    CON.FirstName AS ContractorName,
	    J.Description,
	    J.SkillTitle AS [Skill Required],
	    J.Priority,
	    S.Status,
	    C.Phone,
	    J.HoursOnJob AS [Hours On Job],
	    CONVERT(NVARCHAR, J.RequestedCompletionDate, 6) AS [Requested Completion],
	    J.DistanceTravelled AS [Distance Travelled],
	    L.Street + ' ' + L.Suburb + ', ' + L.State + ', ' + CAST(L.Zip AS NVARCHAR) AS Location
	FROM
	    Job AS J
	INNER JOIN Client AS C ON J.ClientId = C.ClientId
	INNER JOIN [Location] AS L ON J.ClientId = L.ClientId
	INNER JOIN [Status] AS S ON J.[Status] = S.[Status]
	INNER JOIN Contractor AS CON ON J.ContractorId = CON.ContractorId
	WHERE
		J.Status = 'Completed'
	AND
		C.OrganisationName LIKE '%' + @SearchText + '%';
END
GO
/****** Object:  StoredProcedure [dbo].[usp_SearchStaff]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_SearchStaff]
	-- Add the parameters for the stored procedure here
	@SearchText NVARCHAR(30)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SELECT 
		StaffId,
		FirstName,
		LastName,
		Dob,
		Phone,
		Email,
		[Password]
	FROM
		Staff
	WHERE
		AccountStatus = 'Active'
	AND
		FirstName LIKE '%' + @SearchText + '%';
END
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateClient]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_UpdateClient]
	-- Add the parameters for the stored procedure here
	@ClientId INT,
	@OrganisationName NVARCHAR(30),
	@FirstName NVARCHAR(50),
	@LastName NVARCHAR(50),
	@Phone NCHAR(10),
	@Email NVARCHAR(320),
	@Street NVARCHAR(30),
	@Suburb NVARCHAR(30),
	@State NVARCHAR(3),
	@Zip NCHAR(4)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	UPDATE 
		Client	
	SET 
		OrganisationName = @OrganisationName,
		FirstName = @FirstName,
		LastName = @LastName,
		Phone = @Phone,
		Email = @Email
	WHERE
		ClientId = @ClientId

	Update
		[Location]
	SET 
		Street = @Street,
		Suburb = @Suburb,
		[State] = @State,
		Zip = @Zip
	WHERE
		ClientId = @ClientId
END
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateContractor]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_UpdateContractor]
	-- Add the parameters for the stored procedure here
	@ContractorId INT,
	@FirstName NVARCHAR(50),
	@LastName NVARCHAR(50),
	@Street NVARCHAR(30),
	@Suburb NVARCHAR(30),
	@State NVARCHAR(3),
	@Zip NCHAR(4),
	@Phone NCHAR(10),
	@Dob DATE,
	@Email NVARCHAR(320),
	-- @Password NVARCHAR(50),
	@ABN NVARCHAR(10),
	@LicenceNumber NVARCHAR(15),
	@RateofPay DECIMAL(4,2),
	@ContractorRating NVARCHAR(5)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	UPDATE
		Contractor
	SET
		FirstName= @FirstName,
		LastName = @LastName,
		Dob = @Dob,
		Street = @Street,
		Suburb = @Suburb,
		[State] = @State,
		Zip = @Zip,
		Phone = @Phone,
		Email = @Email,
		ABN = @ABN,
		LicenceNumber = @LicenceNumber,
		RateofPay = @RateofPay,
		ContractorRating = @ContractorRating
	WHERE
		ContractorId = @ContractorId;


END
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateContractorSkill]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_UpdateContractorSkill]
	-- Add the parameters for the stored procedure here
	@ContractorId INT,
	@SkillTitle NVARCHAR(30)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	INSERT INTO ContractSkill(
					SkillTitle,
					ContractorId)
				VALUES(
					@SkillTitle,
					@ContractorId)
END
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateJobStatus]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_UpdateJobStatus]
	-- Add the parameters for the stored procedure here
	@JobId INT,
	@JobStatus NVARCHAR(25)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	UPDATE
		Job	
	SET
		[Status] = @JobStatus 
	WHERE
		JobId =@JobId;
END
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateRejectedJob]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_UpdateRejectedJob]
	-- Add the parameters for the stored procedure here
	@ContractorId INT,
	@JobId INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	UPDATE
		Job
	SET
		[Status] = 'Assigned',
		ContractorId = @ContractorId
	WHERE
		JobId = @JobId
END
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateStaff]    Script Date: 20/07/2022 11:31:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Harry 
-- Create date: 7/7/2022
-- Description:	
-- =============================================
CREATE   PROCEDURE [dbo].[usp_UpdateStaff]
	-- Add the parameters for the stored procedure here
	@StaffId INT,
	@FirstName NVARCHAR(50),
	@LastName NVARCHAR(50),
	@Phone NCHAR(10),
	@Dob DATE,
	@Email NVARCHAR(320),
	@Password NVARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	UPDATE
		Staff
	SET
		FirstName = @FirstName,
		LastName = @LastName,
		Phone = @Phone,
		Dob = @Dob,
		Email = @Email,
		[Password] = @Password
	WHERE
		StaffId = @StaffId;
END
GO
