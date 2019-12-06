CREATE TABLE [dbo].[QuestChallenge] (
	[QuestChallengeID]	INTEGER IDENTITY (1,1)	NOT NULL,
	[QuestID]			INTEGER					NOT NULL,
	[ChallengeID]		INTEGER					NOT NULL,

    CONSTRAINT PK_QuestChallenge PRIMARY KEY CLUSTERED ([QuestChallengeID]),
	CONSTRAINT FK_QuestChallenge_Quest_QuestID FOREIGN KEY (QuestID) REFERENCES [dbo].[Quest] (QuestID),
	CONSTRAINT FK_QuestChallenge_Challenge_ChallengeID FOREIGN KEY (ChallengeID) REFERENCES [dbo].[Challenge] (ChallengeID)

);
