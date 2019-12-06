CREATE TABLE [dbo].[ApiLogFwdPath] (
   [ApiLogFwdPathD]					INTEGER IDENTITY(1,1)	NOT NULL,
   [ApiLogID]						INTEGER					NOT NULL,
   [PathValue]						NVARCHAR(100)			NULL,
   [LastUpdatedUTCDate]				DATETIME2				NOT NULL,
   
   	CONSTRAINT PK_ApiLogFwdPath PRIMARY KEY CLUSTERED ([ApiLogFwdPathID]),
	CONSTRAINT FK_ApiLogFwdPath_ApiLog_ApiLogID FOREIGN KEY (ApiLogID) REFERENCES [dbo].[ApiLog] (ApiLogID),

);
