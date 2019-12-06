CREATE TABLE [dbo].[Repository] (
    [RepositoryID]			INTEGER IDENTITY(1,1)	NOT NULL,
    [RepositoryObject_id]	VARBINARY(12)			NOT NULL,
    [Repository__v]			INTEGER					NULL,
    [CategoryType]			NVARCHAR(20)			NOT NULL,
    [FriendlyID]			INTEGER					NOT NULL,
    [RepositoryName]		NVARCHAR(120)			NOT NULL,
    [SourceLink]			NVARCHAR(120)			NOT NULL,
    [RepositoryStatus]		NVARCHAR(40)			NOT NULL,
    [RepositoryType]		NVARCHAR(40)			NOT NULL,
    
	CONSTRAINT PK_Repository PRIMARY KEY CLUSTERED ([RepositoryID])
	
);
