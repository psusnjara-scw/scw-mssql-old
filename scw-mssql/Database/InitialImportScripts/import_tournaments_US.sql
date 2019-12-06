
--
--  Extract the data from the import file
-- 
DECLARE @JSON NVARCHAR(MAX) ;
DECLARE @Split NVARCHAR (18)
SET @Split = '{ "_id" : { "$oid"'

SELECT @JSON = BulkColumn 
FROM OPENROWSET (BULK 'E:\SCWDemo\MongoExportUS\scw_prod_alpha_tournaments.tournaments_US.json', SINGLE_CLOB) as j
;

DECLARE @JSONImport TABLE (
	ID INT,
	TournamentDetails NVARCHAR(MAX)
	)
INSERT INTO @JSONImport
SELECT Id, '{'+ Data FROM Split(@JSON, @Split)
WHERE Id > 1
ORDER BY Id

SELECT *
FROM @JSONImport

--
--  Reformat the data into the various tables
--
DECLARE @JSONShred  NVARCHAR(MAX) ; 

DROP TABLE #Tournament;

CREATE TABLE #Tournament (
    [TournamentID]			INTEGER 	 NULL,
    [TournamentObject_id]	VARBINARY(MAX)			NOT NULL,
    [CompanyID]				NVARCHAR(60)					 NULL,
    [TeamID]				NVARCHAR(60)					 NULL,
    [TournamentAuthor]		NVARCHAR(100)			 NULL,
    [TournamentName]		NVARCHAR(100)			 NULL,
    [SharedSecret]			NVARCHAR(60)			NULL,
    [TournamentDescription] NVARCHAR(60)			NULL,
    [DisplayPic]			NVARCHAR(120)			NULL,
    [TournamentRules]		NVARCHAR(120)			NULL,
    [PublishedStatus]		BIT						 NULL,
    [StartDate]				NVARCHAR(60)				 NULL,
	[StartDate_DEC]			DECIMAL(14,1)			NULL,
    [FinishDate]			NVARCHAR(60)				NULL,
	[FinishDate_DEC]			DECIMAL(14,1)			NULL,
    [TimeZone]				NVARCHAR(100)			 NULL,
    [NumberOfChallenges]	INTEGER					 NULL,
    [MaxPlayers]			INTEGER					,
    [SuggestInduction]		BIT						 NULL,
    [ScoringPreset]			NVARCHAR(20)			 NULL,
    [NumberofPlayers]		INTEGER					 NULL,
    [Version]				INTEGER					 NULL,
	[MaximumPoints]			INTEGER					 NULL,
	[Languages]					NVARCHAR(MAX)
	)
;

DECLARE JSONIMPORT CURSOR FOR
 SELECT TournamentDetails
 FROM @JSONImport

OPEN JSONIMPORT 
FETCH NEXT FROM JSONIMPORT INTO @JSONShred

WHILE @@FETCH_STATUS = 0
BEGIN

SELECT @JSONShred 
SELECT ISJSON(@JSONShred) AS IsValidJson


INSERT INTO #Tournament (
				[TournamentObject_id],
				[CompanyID],
				[TeamID],
				[TournamentAuthor],
				[TournamentName],
				[SharedSecret],
				[TournamentDescription],
				[DisplayPic],
				[TournamentRules],
				[PublishedStatus],
				[StartDate],
				[FinishDate],
				[TimeZone],
				[NumberOfChallenges],
				[MaxPlayers],
				[SuggestInduction],
				[ScoringPreset],
				[NumberofPlayers],
				[Version],
				[MaximumPoints],
				[Languages]
)
SELECT * FROM   OPENJSON (@JSONShred) 
            WITH(
				[TournamentObject_id]	VARBINARY(MAX)			'$._id."$oid"' ,
				[CompanyID]				NVARCHAR(100)			'$._company',
				[TeamID]				NVARCHAR(100)			'$._team',
				[TournamentAuthor]		NVARCHAR(100)			'$._author',
				[TournamentName]		NVARCHAR(100)			'$.name',
				[SharedSecret]			NVARCHAR(60)			'$.sharedSecret',
				[TournamentDescription] NVARCHAR(60)			'$.description',
				[DisplayPic]			NVARCHAR(120)			,
				[TournamentRules]		NVARCHAR(120)			'$.rulesText',
				[PublishedStatus]		BIT						'$.published',
				[StartDate]				NVARCHAR(60)			'$.startTime',
				[FinishDate]			NVARCHAR(60)			'$.finishTime',
				[TimeZone]				NVARCHAR(100)			'$.timezone',
				[NumberOfChallenges]	INTEGER					'$.numberOfChallenges',
				[MaxPlayers]			INTEGER					'$.maxPlayers',
				[SuggestInduction]		BIT						,
				[ScoringPreset]			NVARCHAR(20)			'$.scoringPreset',
				[NumberofPlayers]		INTEGER					'$.numPlayers',
				[Version]				INTEGER					'$.version',
				[MaximumPoints]			INTEGER					'$.maxPoints',
				[Languages]					NVARCHAR(MAX)			'$.languages' AS JSON
)

UPDATE #Tournament
SET StartDate_DEC = ROUND(CAST (CAST(StartDate AS FLOAT) AS DECIMAL(18,1)),0)

SELECT StartDate_DEC FROM #Tournament

UPDATE #Tournament
SET StartDate_DEC = StartDate_DEC / 60000  -- convert milliseconds to minutes

UPDATE #Tournament
SET FinishDate_DEC = ROUND(CAST (CAST(FinishDate AS FLOAT) AS DECIMAL(18,1)),0)

SELECT FinishDate_DEC FROM #Tournament

UPDATE #Tournament
SET FinishDate_DEC = FinishDate_DEC / 60000  -- convert milliseconds to minutes

INSERT INTO [dbo].[Tournament]
SELECT [TournamentObject_id],
				[CompanyID],
				[TeamID],
				[TournamentAuthor],
				[TournamentName],
				[SharedSecret],
				[TournamentDescription],
				[DisplayPic],
				[TournamentRules],
				[PublishedStatus],
				DATEADD(MINUTE, StartDate_DEC, '1970-01-01') AS StartDate,
				DATEADD(MINUTE, FinishDate_DEC, '1970-01-01') AS FinishDate,
				[TimeZone],
				[NumberOfChallenges],
				[MaxPlayers],
				[SuggestInduction],
				[ScoringPreset],
				[NumberofPlayers],
				[Version],
				[MaximumPoints]
FROM	#Tournament
/*
	Insert into Tournament Language table
*/
INSERT INTO [dbo].[TournamentLanguage]
SELECT	tou.TournamentID,
		l.LanguageID--,
		--[Languages],
		--JSON_VALUE(lan.[value], '$._framework') AS LanguagesFramework,
		--JSON_VALUE(lan.[value], '$._id') AS Languagesid
FROM #Tournament c
LEFT OUTER JOIN [dbo].[Tournament] tou
	ON c.TournamentObject_id = tou.TournamentObject_id
CROSS APPLY OPENJSON(JSON_QUERY(Languages, '$'))  lan
INNER JOIN [dbo].[Language] l
	ON l.LanguageName = JSON_VALUE(lan.[value], '$._id')
	AND l.LanguageFramework = JSON_VALUE(lan.[value], '$._framework')
--SELECT * FROM #Tournament

	TRUNCATE TABLE #Tournament
	FETCH NEXT FROM JSONIMPORT INTO @JSONShred

END

CLOSE JSONIMPORT
DEALLOCATE JSONIMPORT