CREATE TABLE [dbo].[Team] (
    [TeamID]						INTEGER IDENTITY(1,1)	NOT NULL,
    [TeamObject_id]					VARBINARY(12)			NOT NULL,
    [CompanyID]						INTEGER					NOT NULL,
    [TeamName]						NVARCHAR(60)			NOT NULL,
    [OnboardingMessage]				NVARCHAR(100)			NULL,
    [TeamStatus]					NVARCHAR(20)			NOT NULL,
    [DefaultRuleSettingsEnabled]	BIT						NOT NULL,
    [MemberJoinToken]				NVARCHAR(100)			NOT NULL,
    [DedupCode]						NVARCHAR(20)			NULL,
    [ActivationDate]				DATETIME2				NOT NULL,
    [ExpirationDate]				DATETIME2				NOT NULL,
	[CreatedDate]					DATETIME2				NOT NULL,  -- From object id

    CONSTRAINT PK_Team PRIMARY KEY CLUSTERED ([TeamID]),
	CONSTRAINT FK_Team_Company_CompanyID FOREIGN KEY (CompanyID) REFERENCES [dbo].[Company] (CompanyID) 
);	