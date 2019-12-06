CREATE TABLE [dbo].[ApiLogQuery] (
   [ApiLogQueryID]					INTEGER IDENTITY(1,1)	NOT NULL,
   [ApiLogID]						INTEGER					NOT NULL,
   [QueryType]						NVARCHAR(100)			NULL,
   [QueryValue]						NVARCHAR(400)			NULL,
   [LastUpdatedUTCDate]				DATETIME2				NOT NULL,
   
   	CONSTRAINT PK_ApiLogQuery PRIMARY KEY CLUSTERED ([ApiLogQueryID]),
	CONSTRAINT FK_ApiLogQuery_ApiLog_ApiLogID FOREIGN KEY (ApiLogID) REFERENCES [dbo].[ApiLog] (ApiLogID),

);
