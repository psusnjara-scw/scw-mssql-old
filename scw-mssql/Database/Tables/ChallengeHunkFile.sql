CREATE TABLE [dbo].[ChallengeHunkFile] (
    [ChallengeHunkFileID]		INTEGER IDENTITY(1,1)	NOT NULL,
	[ChallengeHunkID]			INTEGER					NOT NULL,
	[FileNumber]				INTEGER					NOT NULL,
	[FileObject_id]				VARBINARY(12)			NOT NULL,
    [FilePath]					NVARCHAR(200)			NOT NULL,
    [FileMarkerID]				INTEGER					NOT NULL,

    CONSTRAINT PK_ChallengeHunkFile PRIMARY KEY CLUSTERED ([ChallengeHunkFileID]),
	CONSTRAINT FK_ChallengeHunkFile_ChallengeHunk_ChallengeHunkID FOREIGN KEY (ChallengeHunkID) REFERENCES [dbo].[ChallengeHunk] (ChallengeHunkID)

);

