CREATE TABLE [dbo].[ApiLog] (
    [ApiLogID]					INTEGER IDENTITY(1,1)	NOT NULL,
    [ApiLogObject_id]			NVARCHAR(40)			NOT NULL,
	[CompanyID]					INTEGER					NOT NULL,
	[HeaderHost]				NVARCHAR(40)			NULL,
	[HeaderUserAgent]			INTEGER					NULL,
	[HeaderXForwardedFor]		NVARCHAR(40)			NULL,
	[Operation]					NVARCHAR(60)			NULL,
	[Path]						NVARCHAR(100)			NULL,
	[Protocol]					NVARCHAR(10)			NULL,
	[ResponseCode]				INTEGER					NULL,
	[ApiLogDate]				DATETIME2				NULL,
	[Version]					INTEGER					NULL,
	[LastUpdatedUTCDate]		DATETIME2				NOT NULL,
           
	CONSTRAINT PK_ApiLog PRIMARY KEY CLUSTERED ([ApiLogID]),
	CONSTRAINT FK_ApiLog_Company_CompanyID FOREIGN KEY (CompanyID) REFERENCES [dbo].[Company] (CompanyID),
	CONSTRAINT FK_ApiLog_User_UserID FOREIGN KEY (UserID) REFERENCES [dbo].[SCWUser] (UserID)

);
