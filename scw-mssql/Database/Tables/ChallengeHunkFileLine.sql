CREATE TABLE [dbo].[ChallengeHunkFileLine] (
    [ChallengeHunkFileLineID]		INTEGER IDENTITY(1,1)	NOT NULL,
	[ChallengeHunkFileID]			INTEGER					NOT NULL,
	[LineNumber]					INTEGER					NOT NULL,  -- Could potentially have this as a delimeted list in the parent table

    CONSTRAINT PK_ChallengeHunkFileLine PRIMARY KEY CLUSTERED ([ChallengeHunkFileLineID]),
	CONSTRAINT FK_ChallengeHunkFileLine_ChallengeHunkFile_ChallengeHunkFileID 
		FOREIGN KEY (ChallengeHunkFileID) REFERENCES [dbo].[ChallengeHunkFile] (ChallengeHunkFileID)

);

