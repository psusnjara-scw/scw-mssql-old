CREATE TABLE [dbo].[ApplicationCategory]
(
   [ApplicationCategoryID]				INTEGER IDENTITY(1,1)	NOT NULL,
   [CategoryType]						NVARCHAR(40)			NOT NULL,
   [Category]							NVARCHAR(40)			NOT NULL,
   [SubCategory]						NVARCHAR(40)			NOT NULL,
   [WhatDescription]					NVARCHAR(200)			NOT NULL,
   [WhereDescription]					NVARCHAR(200)			NOT NULL,
   
   	CONSTRAINT PK_ApplicationCategory PRIMARY KEY CLUSTERED ([ApplicationCategoryID])
)
