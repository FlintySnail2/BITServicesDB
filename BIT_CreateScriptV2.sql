USE MASTER
GO
IF EXISTS (SELECT *
			FROM	MASTER..sysdatabases
			WHERE	NAME= N'BIT_JobManagement'
		  )
DROP DATABASE BIT_JobManagement
GO
CREATE DATABASE BIT_JobManagement
GO
USE BIT_JobManagement
GO
CREATE TABLE Region (
                Region NVARCHAR(30) NOT NULL,
                CONSTRAINT Region_pk PRIMARY KEY (Region)
)
GO
CREATE TABLE Skill (
                SkillTitle NVARCHAR(30) NOT NULL,
                CONSTRAINT Skill_pk PRIMARY KEY (SkillTitle)
)
GO
CREATE TABLE Contractor (
                ContractorId INT IDENTITY NOT NULL,
                FirstName NVARCHAR(50) NOT NULL,
                LastName NVARCHAR(50) NOT NULL,
                Street NVARCHAR(30) NOT NULL,
                Suburb NVARCHAR(50) NOT NULL,
                [State] NVARCHAR(3) NOT NULL,
                Zip NCHAR(4) NOT NULL,
                Phone NCHAR(10) NOT NULL,
                Dob DATE NOT NULL,
                Email NVARCHAR(320) NOT NULL,
                [Password] NVARCHAR(50) NOT NULL,
                ABN NVARCHAR(10) NOT NULL,
                LicenceNumber NVARCHAR(15) NOT NULL,
                RateofPay DECIMAL(4,2) NOT NULL,
                ContractorRating NVARCHAR(5) NOT NULL,
				AccountStatus NVARCHAR(10) NOT NULL
                CONSTRAINT Contractor_pk PRIMARY KEY (ContractorId)
)
GO
CREATE TABLE ContractSkill (
                ContractorId INT NOT NULL,
                SkillTitle NVARCHAR(30) NOT NULL
                CONSTRAINT ContractSkill_pk PRIMARY KEY (ContractorId, SkillTitle)
)
GO
CREATE TABLE [Availability] (
                AvailabilityDate DATE NOT NULL,
                ContractorId INT NOT NULL,
                CONSTRAINT Availability_pk PRIMARY KEY (AvailabilityDate,ContractorId)
)
GO
CREATE TABLE [Status] (
                [Status] NVARCHAR(25) NOT NULL,
                CONSTRAINT Status_pk PRIMARY KEY ([Status])
)
GO
CREATE TABLE Client (
                ClientId INT IDENTITY NOT NULL,
                OrganisationName NVARCHAR(30) NOT NULL,
                FirstName NVARCHAR(50) NOT NULL,
                LastName NVARCHAR(50) NOT NULL,
                Phone NCHAR(10) NOT NULL,
                Email NVARCHAR(320) NOT NULL,
                [Password] NVARCHAR(50) NOT NULL,
				AccountStatus NVARCHAR(10) NOT NULL
                CONSTRAINT Client_pk PRIMARY KEY (ClientId)
)
GO
CREATE TABLE [Location] (
                ClientId INT NOT NULL,
				Region NVARCHAR(30) ,
                Street NVARCHAR(30) NOT NULL,
                Suburb NVARCHAR(30) NOT NULL,
                [State] NVARCHAR(3) NOT NULL,
                Zip NCHAR(4) NOT NULL,
                CONSTRAINT Location_pk PRIMARY KEY (Region, ClientId)
)
GO
CREATE TABLE Job (
                JobId INT IDENTITY NOT NULL,
                ClientId INT NOT NULL,
                RequestedStartDate DATE NOT NULL,
                RequestedCompletionDate DATE ,
                [Priority] NVARCHAR(10) NOT NULL,
                [Description] NVARCHAR(300) NOT NULL,
                HoursOnJob DECIMAL(4,2),
                DistanceTravelled NVARCHAR(20),
                [Status] NVARCHAR(25),
                SkillTitle NVARCHAR(30) NOT NULL,
                ContractorId INT,
                Region NVARCHAR(30) NOT NULL,
                CONSTRAINT Job_pk PRIMARY KEY (JobId)
)
GO
CREATE TABLE RejectedJob (
                ContractorId INT NOT NULL,
                JobId INT NOT NULL,
                Comment NVARCHAR(150) NOT NULL,
                CONSTRAINT Rejected_Job_pk PRIMARY KEY (ContractorId, JobId)
)
GO
CREATE TABLE Feedback (
                FeedbackItem INT NOT NULL,
                JobId INT NOT NULL,
                Comment NVARCHAR(500),
                CONSTRAINT Feedback_pk PRIMARY KEY (FeedbackItem, JobId)
)
GO
CREATE TABLE StaffType (
                StaffType NVARCHAR(15) NOT NULL,
                CONSTRAINT StaffType_pk PRIMARY KEY (StaffType)
)
GO
CREATE TABLE Staff (
                StaffId INT IDENTITY NOT NULL,
                FirstName NVARCHAR(50) NOT NULL,
                LastName NVARCHAR(50) NOT NULL,
                Phone NCHAR(10) NOT NULL,
                Dob DATE NOT NULL,
                Email NVARCHAR(320) NOT NULL,
                [Password] NVARCHAR(50) NOT NULL,
                StaffType NVARCHAR(15) NOT NULL,
				AccountStatus NVARCHAR(10) NOT NULL
                CONSTRAINT Staff_pk PRIMARY KEY (StaffId)
)


ALTER TABLE Location ADD CONSTRAINT Region_Location_fk
FOREIGN KEY (Region)
REFERENCES Region (Region)
ON DELETE NO ACTION
ON UPDATE CASCADE

ALTER TABLE Job ADD CONSTRAINT Skill_Job_fk
FOREIGN KEY (SkillTitle)
REFERENCES Skill (SkillTitle)
ON DELETE NO ACTION
ON UPDATE CASCADE

ALTER TABLE ContractSkill ADD CONSTRAINT SkillContract_Skill_fk
FOREIGN KEY (SkillTitle)
REFERENCES Skill (SkillTitle)
ON DELETE NO ACTION
ON UPDATE CASCADE

ALTER TABLE RejectedJob ADD CONSTRAINT Contractor_RejectedJob_fk
FOREIGN KEY (ContractorId)
REFERENCES Contractor (ContractorId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE Availability ADD CONSTRAINT Contractor_Availability_fk
FOREIGN KEY (ContractorId)
REFERENCES Contractor (ContractorId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE ContractSkill ADD CONSTRAINT Contractor_Skill_fk
FOREIGN KEY (ContractorId)
REFERENCES Contractor (ContractorId)
ON DELETE NO ACTION
ON UPDATE CASCADE

ALTER TABLE Job ADD CONSTRAINT Contractor_Job_fk
FOREIGN KEY (ContractorId)
REFERENCES Contractor (ContractorId)
ON DELETE NO ACTION
ON UPDATE CASCADE

ALTER TABLE Job ADD CONSTRAINT Status_Job_fk
FOREIGN KEY ([Status])
REFERENCES Status ([Status])
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE Job ADD CONSTRAINT Client_Job_fk
FOREIGN KEY (ClientId)
REFERENCES Client (ClientId)
ON DELETE NO ACTION
ON UPDATE CASCADE

ALTER TABLE Location ADD CONSTRAINT Client_Location_fk
FOREIGN KEY (ClientId)
REFERENCES Client (ClientId)
ON DELETE NO ACTION
ON UPDATE CASCADE

ALTER TABLE Job ADD CONSTRAINT Location_Job_fk
FOREIGN KEY (Region, ClientId)
REFERENCES Location (Region, ClientId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE Feedback ADD CONSTRAINT Job_Feedback_fk
FOREIGN KEY (JobId)
REFERENCES Job (JobId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE RejectedJob ADD CONSTRAINT Job_RejectedJob_fk
FOREIGN KEY (JobId)
REFERENCES Job (JobId)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE Staff ADD CONSTRAINT StaffType_Staff_fk
FOREIGN KEY (StaffType)
REFERENCES StaffType (StaffType)
ON DELETE NO ACTION
ON UPDATE NO ACTION



-- =========================================================
--INSERT DATA HERE PLLLLLZZZZZZ
-- =========================================================

USE BIT_JobManagement
GO
SET DATEFORMAT dmy;
GO
INSERT INTO Region(Region) VALUES 
('North Sydney'),
('Western Sydney'),
('Eastern Sydney'),
('South Sydney')
GO
INSERT INTO Skill(SkillTitle) VALUES
('Network Engineer'),
('Software Engineer'),
('System Analyst'),
('Database Engineer'),
('UI Designer'),
('UX Designer'),
('Graphic Designer'),
('Web Developer'),
('C# Programmer'),
('Python Programmer')
GO
-- ==================================================================================================================
INSERT INTO Contractor(FirstName,LastName,Street,Suburb,[State],Zip,Phone,Dob,Email,[Password],ABN,LicenceNumber,RateofPay,ContractorRating,AccountStatus) VALUES
--North Sydney Region
('Steven','Good','11 Florence St','Castle Hill','NSW','2077','0400987654','19-10-1971','StevenGood@mail.com','StevenGood','00000002N','1111110C',35.90,'3','Active'),
--South Sydney Region
('Tim','Chan','45 Avoca Street','Randwick','NSW','2031','0450000700','3-03-1990', 'TimChan@mail.com','TimChan','00000003N','2222220C',41.80,'4.5','Active'),
--East Sydney Region
('Terry', 'Lee','23 Eucalyptus Way','Pymble','NSW','2073','0404900800','4-12-1987','TerryLee@mail.com','TerryLee','00000004N','0000001N',53.47,'5','Active'),
--West Sydney Region
('Fred','Durst','78 High Street','Penrith','NSW','2750','0475800400','7-7-1996','FredDurst@mail.com','FredDurst','00000005N','3333330C', 25.50,'2','Active')
GO
-- =====================================================
INSERT INTO ContractSkill (ContractorId, SkillTitle) VALUES
(1,'Network Engineer'),
(1,'System Analyst'),
(2,'System Analyst'),
(3,'C# Programmer'),
(3,'Python Programmer'),
(4,'Web Developer'),
(4,'UI Designer'),
(4,'UX Designer')


GO
-- ====================================================================================================================
INSERT INTO[Availability](ContractorId,AvailabilityDate) VALUES
(1,'10-6-2022'),
(1,'11-6-2022'),
(1,'12-6-2022'),
(1,'13-6-2022'),
(1,'17-6-2022'),
(1,'21-6-2022'),
(1,'22-6-2022'),
(1,'23-6-2022'),
(2,'13-6-2022'),
(2,'14-6-2022'),
(2,'15-6-2022'),
(3,'16-6-2022'),
(3,'17-6-2022'),
(3,'18-6-2022'),
(3,'22-6-2022'),
(3,'23-6-2022'),
(3,'24-6-2022'),
(4,'19-6-2022'),
(4,'20-6-2022'),
(4,'21-6-2022')
GO
-- ====================================================================================================================
INSERT INTO [Status]([Status]) VALUES
('Verified'),
('Send For Payment'),
('Completed'),
('Assigned'),
('Accepted'),
('Rejected'),
('Pending')
GO
-- ====================================================================================================================
INSERT INTO Client(OrganisationName,FirstName,LastName,Phone,Email,[Password],AccountStatus) VALUES
('BillTech Industries','Bill','Brown','0470123321','Bill@BillTech.com','BillTech','Active'),
('Datacom Solutions', 'Fred', 'Data', '0493100001', 'Fred@Datacom.com', 'FredGerms','Active'),
('Integrated Tech Solutions','Eugene', 'White', '0490999999', 'EugeneWhite@IntTech.com','EugeneWhite','Active'),
('Cyber Security Solutions','Tim','Secure','0477777777','TimSecure@Cyber.com','TimSecure','Active')
GO
-- ====================================================================================================================
INSERT INTO [Location](ClientId, Region,Street, Suburb,[State],Zip) VALUES
-- North Sydney
(1,'North Sydney','13 Talavera Rd','Macquarie Park','NSW','2113'),
-- South Sydney
(3,'South Sydney','17 Cawarra Rd','Caringbah','NSW','2011'),
-- East Sydney
(2,'Eastern Sydney','76 Smith Street','Mascot','NSW','2011'),
-- West Sydney
(4,'Western Sydney','107 Cobb Avenue','Jamisontown','NSW','2750')
GO
-- ====================================================================================================================
SET IDENTITY_INSERT dbo.[Job] ON;
GO
INSERT INTO Job(JobId, ClientId,RequestedStartDate,RequestedCompletionDate,[Priority],[Description],HoursOnJob,DistanceTravelled,[Status],SkillTitle,ContractorId,Region) VALUES
(1,1,'10-6-2022','11-6-2022','High','  Network fault, unable to connect to server',4,'35','Completed','Network Engineer',1,'North Sydney'),
(2,1,'10-6-2022','12-3-2022','Medium','System requires remodelling',0,'0','Assigned','System Analyst',1,'North Sydney'),
(3,1,'11-6-2022','13-6-2022','Low','   Network connection keeps cutting out',0,'0','Accepted','Web Developer',4,'North Sydney'),
(4,1,'13-6-2022','14-6-2022','medium','System perfomance slow',0,'0','Accepted','System Analyst',2,'North Sydney'),
(5,2,'14-6-2022','15-6-2022','Medium','Medium Prioroty Job Suitable Tech for the job required',2,'12','Completed', 'System Analyst',2,'Eastern Sydney'),
(6,3,'16-6-2022','17-6-2022','Medium',' Medium priority Job',0,'0','Pending','C# Programmer',3,'South Sydney'),
(7,4,'19-6-2022','20-6-2022', 'Low', ' Low Priority Job', 0, '0', 'Pending','Web Developer',4,'Western Sydney'),
(8,4,'21-6-2022','23-6-2022','High','  Cannot connect to the server on site server',0,'0','Accepted','Network Engineer',1,'Western Sydney'),
(9,3,'22-6-2022','24-6-2022','Medium','Desktop application keeps crashing',0,'0','Rejected','C# Programmer',3,'South Sydney'),
(10,2,'13-6-2022','15-6-2022','Low','  Would like more screens on desktop application',0,'0','Rejected','C# Programmer',2,'Eastern Sydney')
GO
SET IDENTITY_INSERT dbo.[Job] OFF;
GO

-- ========================================================================================================================
INSERT INTO RejectedJob(ContractorId, JobId, Comment) VALUES
(3,9,'Postive Covid 19 Test Result'),
(2,10,'Family Emergency')


GO
-- ========================================================================================================================
INSERT INTO Feedback (FeedbackItem, JobId, Comment) VALUES
(1,1, 'Job completed on timem no extra resources were required'),
(2,5, 'Job took longer than expected, additonal resources were required'),
(3,6,'Job completed'),
(4,7,'Took longer than expected')

GO
--=========================================================================================================================
INSERT INTO StaffType(StaffType) VALUES
('Administrator'),
('Coordinator')
GO
-- ===========================================================================================================================
INSERT INTO Staff (FirstName, LastName, Phone, Dob, Email, [Password], StaffType, AccountStatus) VALUES
('Van', 'Gou', '0480547981', '21-7-1986','VanWild@mail.com','VanGou', 'Coordinator','Active'),
('Gerald', 'White', '0457751941', '3-11-1978', 'GeraldWhite@mail.com', 'GeraldWhite78', 'Administrator','Active')

-- ========================================================
