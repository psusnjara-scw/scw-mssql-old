
--
--  Import the challenge file generated from Studio3T
-- 
DECLARE @JSON NVARCHAR(MAX) ;
DECLARE @JSONImport NVARCHAR(MAX) ;


TRUNCATE TABLE import_challenges_EU
/*
CREATE TABLE Import_challenges_EU (
	challengeDetails NVARCHAR(MAX)
);
*/

BULK INSERT dbo.import_challenges_EU
FROM 'E:\SCWDemo\MongoExportEU\scw_prod_alpha_apps.challenges_EU.json' 
WITH (
    ROWTERMINATOR = '0x0a'
);


--SELECT * FROM dbo.import_challenges_EU
--
--  Reformat the data into the various tables
--

--DROP TABLE #challenge;

CREATE TABLE #challenge (
    [challengeObject_id]		NVARCHAR(40)			NOT NULL,
	[challengeStatus]			NVARCHAR(40)			NULL,
	[SuccessRatio]				INTEGER					NULL,
	[challengeOwner]			NVARCHAR(40)			NULL,
	[Author]					NVARCHAR(60)			NULL,
	[challengeName]			NVARCHAR(120)			NULL,
	[Description]				NVARCHAR(200)			NULL,
	[TimeLimit]					DECIMAL(10,1)			NULL,
	[CreateCertificate]			BIT						NULL,
	[CertificateTemplate]		NVARCHAR(150)			NULL,
	[Difficulty]				NVARCHAR(20)			NULL,
	[StartDate]					NVARCHAR(40)			NULL,
	[StartDate_DEC]				DECIMAL(14,1)			NULL,
    [InviteSendDate]			NVARCHAR(40)			NULL,
	[InviteSendDate_DEC]		DECIMAL(14,1)			NULL,
    [EndDate]					NVARCHAR(40)			NULL,
	[EndDate_DEC]				DECIMAL(14,1)			NULL,
	[TimeZone]					NVARCHAR(40)			NULL,
	[Version]					DECIMAL(10,1)			NULL,
	[SelfAssess]				BIT						NULL,
	[RetriesAllowed]			BIT						NULL,
	[FixedChallenges]			BIT						NULL,
    [InductionSuggested]		BIT						NULL,
    [NumberOfChallenges]		INTEGER					NULL,
    [_challenge]				NVARCHAR(MAX)			NULL,
	[Languages]					NVARCHAR(MAX)
	)
;

DECLARE @JSONShred  NVARCHAR(MAX) ; 

DECLARE JSONIMPORT CURSOR FOR
 SELECT challengeDetails
 FROM dbo.import_challenges_EU

OPEN JSONIMPORT 
FETCH NEXT FROM JSONIMPORT INTO @JSONShred

WHILE @@FETCH_STATUS = 0
BEGIN

--SELECT @JSONShred 
--SELECT ISJSON(@JSONShred) AS IsValidJson


INSERT INTO #challenge (
	   [challengeObject_id]
      ,[challengeStatus]
      ,[SuccessRatio]
      ,[challengeOwner]
      ,[Author]
      ,[challengeName]
      ,[Description]
      ,[TimeLimit]
      ,[CreateCertificate]
      ,[CertificateTemplate]
      ,[Difficulty]
      ,[StartDate]
      ,[InviteSendDate]
      ,[EndDate]
      ,[TimeZone]
      ,[Version]
      ,[SelfAssess]
      ,[RetriesAllowed]
      ,[FixedChallenges]
      ,[InductionSuggested]
      ,[NumberOfChallenges]
 	  ,[Languages]
)
SELECT * FROM   OPENJSON (@JSONShred) 
            WITH(
			    [challengeObject_id]		NVARCHAR(40)			'$._id."$oid"' ,
				[challengeStatus]			NVARCHAR(40)			'$.status',
				[SuccessRatio]				NVARCHAR(40)			'$.successRatio',
				[challengeOwner]			NVARCHAR(40)			'$._owner',
				[Author]					NVARCHAR(60)			'$._author',
				[challengeName]			NVARCHAR(120)			'$.name',
				[Description]				NVARCHAR(200)			'$.description',
				[TimeLimit]					DECIMAL(10,1)			'$.timeLimit',
				[CreateCertificate]			BIT						'$.emitsCertificate',
				[CertificateTemplate]		NVARCHAR(150)			'$._certificateTemplate',
				[Difficulty]				NVARCHAR(20)			'$.difficulty',
				[StartDate]					NVARCHAR(40)			'$.startDate',
				[InviteSendDate]			NVARCHAR(40)			'$.sendInvitesOn',
				[EndDate]					NVARCHAR(40)			'$.endDate',
				[TimeZone]					NVARCHAR(40)			'$.timezone',
				[Version]					DECIMAL(10,1)			'$.version',
				[SelfAssess]				BIT						'$.selfAssess',
				[RetriesAllowed]			BIT						'$.retriesAllowed',
				[FixedChallenges]			BIT						'$.fixedChallenges',
				[InductionSuggested]		BIT						'$.suggestInduction',
				[NumberOfChallenges]		INTEGER					'$.numberOfChallenges',
				[Languages]					NVARCHAR(MAX)			'$.languages' AS JSON
)

UPDATE #challenge
SET StartDate_DEC = ROUND(CAST (CAST(StartDate AS FLOAT) AS DECIMAL(18,1)),0)
SELECT StartDate_DEC FROM #challenge

UPDATE #challenge
SET StartDate_DEC = StartDate_DEC / 60000  -- convert milliseconds to minutes

UPDATE #challenge
SET EndDate_DEC = ROUND(CAST (CAST(EndDate AS FLOAT) AS DECIMAL(18,1)),0)
SELECT EndDate_DEC FROM #challenge

UPDATE #challenge
SET EndDate_DEC = EndDate_DEC / 60000  -- convert milliseconds to minutes

-- InviteSendDate
UPDATE #challenge
SET InviteSendDate_DEC = ROUND(CAST (CAST(InviteSendDate AS FLOAT) AS DECIMAL(18,1)),0)
SELECT InviteSendDate_DEC FROM #challenge

UPDATE #challenge
SET InviteSendDate_DEC = InviteSendDate_DEC / 60000  -- convert milliseconds to minutes



INSERT INTO [dbo].[challenge]
SELECT [challengeObject_id]
      ,[challengeStatus]
      ,[SuccessRatio]
      ,[challengeOwner]
      ,[Author]
      ,[challengeName]
      ,[Description]
      ,[TimeLimit]
      ,[CreateCertificate]
      ,[CertificateTemplate]
      ,[Difficulty]
      ,DATEADD(MINUTE, StartDate_DEC, '1970-01-01') AS [StartDate]
      ,DATEADD(MINUTE, InviteSendDate_DEC, '1970-01-01') AS [InviteSendDate]
      ,DATEADD(MINUTE, EndDate_DEC, '1970-01-01') AS [EndDate]
      ,[TimeZone]
      ,[Version]
      ,[SelfAssess]
      ,[RetriesAllowed]
      ,[FixedChallenges]
      ,[InductionSuggested]
      ,[NumberOfChallenges]
	  ,NULL

FROM	#challenge
/*
	Insert into challenge Language table
*/
INSERT INTO [dbo].[challengeLanguage]
SELECT	tou.challengeID,
		l.LanguageID--,
		--[Languages],
		--JSON_VALUE(lan.[value], '$._framework') AS LanguagesFramework,
		--JSON_VALUE(lan.[value], '$._id') AS Languagesid
FROM #challenge c
LEFT OUTER JOIN [dbo].[challenge] tou
	ON c.challengeObject_id = tou.challengeObject_id
CROSS APPLY OPENJSON(JSON_QUERY(Languages, '$'))  lan
INNER JOIN [dbo].[Language] l
	ON l.LanguageName = JSON_VALUE(lan.[value], '$._id')
	AND l.LanguageFramework = JSON_VALUE(lan.[value], '$._framework')
--SELECT * FROM #challenge

	TRUNCATE TABLE #challenge
	FETCH NEXT FROM JSONIMPORT INTO @JSONShred

END

CLOSE JSONIMPORT
DEALLOCATE JSONIMPORT

/*

Debugging

SELECT len(BulkColumn) , BulkColumn
SELECT *
FROM OPENROWSET (BULK 'E:\SCWDemo\MongoExportEU\scw_prod_alpha_game_013.challenges_EU.json', SINGLE_CLOB) as j
CROSS APPLY OPENJSON(BulkColumn) 
WITH (name NVARCHAR(100) '$.name')

SELECT * FROM challenge
ORDER BY challengeObject_id

*/