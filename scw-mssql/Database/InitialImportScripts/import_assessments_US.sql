
--
--  Import the assessment file generated from Studio3T
-- 
DECLARE @JSON NVARCHAR(MAX) ;
DECLARE @JSONImport NVARCHAR(MAX) ;


TRUNCATE TABLE import_assessments_US
/*
CREATE TABLE Import_Assessments_US (
	AssessmentDetails NVARCHAR(MAX)
);
*/

BULK INSERT dbo.import_assessments_US
FROM 'E:\SCWDemo\MongoExportUS\scw_prod_alpha_game_013.assessments_US.json' 
WITH (
    ROWTERMINATOR = '0x0a'
);


--SELECT * FROM dbo.import_assessments_US
--
--  Reformat the data into the various tables
--

DROP TABLE #Assessment;

CREATE TABLE #Assessment (
    [AssessmentObject_id]		NVARCHAR(40)			NOT NULL,
	[AssessmentStatus]			NVARCHAR(40)			NULL,
	[SuccessRatio]				DECIMAL(10,1)			NULL,
	[AssessmentOwner]			NVARCHAR(40)			NULL,
	[Author]					NVARCHAR(60)			NULL,
	[AssessmentName]			NVARCHAR(120)			NULL,
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
    [_assessment]				NVARCHAR(MAX)			NULL,
	[Languages]					NVARCHAR(MAX)
	)
;

DECLARE @JSONShred  NVARCHAR(MAX) ; 

DECLARE JSONIMPORT CURSOR FOR
 SELECT AssessmentDetails
 FROM dbo.import_assessments_US

OPEN JSONIMPORT 
FETCH NEXT FROM JSONIMPORT INTO @JSONShred

WHILE @@FETCH_STATUS = 0
BEGIN

--SELECT @JSONShred 
--SELECT ISJSON(@JSONShred) AS IsValidJson


INSERT INTO #Assessment (
	   [AssessmentObject_id]
      ,[AssessmentStatus]
      ,[SuccessRatio]
      ,[AssessmentOwner]
      ,[Author]
      ,[AssessmentName]
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
			    [AssessmentObject_id]		NVARCHAR(40)			'$._id."$oid"' ,
				[AssessmentStatus]			NVARCHAR(40)			'$.status',
				[SuccessRatio]				NVARCHAR(40)			'$.successRatio',
				[AssessmentOwner]			NVARCHAR(40)			'$._owner',
				[Author]					NVARCHAR(60)			'$._author',
				[AssessmentName]			NVARCHAR(120)			'$.name',
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

UPDATE #Assessment
	SET StartDate_DEC = ROUND(CAST (CAST(StartDate AS FLOAT) AS DECIMAL(18,1)),0),
		EndDate_DEC = ROUND(CAST (CAST(EndDate AS FLOAT) AS DECIMAL(18,1)),0),
		InviteSendDate_DEC = ROUND(CAST (CAST(InviteSendDate AS FLOAT) AS DECIMAL(18,1)),0)

--SELECT StartDate_DEC, EndDate_DEC, InviteSendDate_DEC  FROM #Assessment

UPDATE #Assessment
	SET StartDate_DEC = StartDate_DEC / 60000,	-- convert milliseconds to minutes
		EndDate_DEC = EndDate_DEC / 60000,  -- convert milliseconds to minutes
		InviteSendDate_DEC = InviteSendDate_DEC / 60000

--SELECT StartDate_DEC, EndDate_DEC, InviteSendDate_DEC  FROM #Assessment


INSERT INTO [dbo].[Assessment]
SELECT [AssessmentObject_id]
      ,[AssessmentStatus]
      ,[SuccessRatio]
      ,[AssessmentOwner]
      ,[Author]
      ,[AssessmentName]
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

FROM	#Assessment
/*
	Insert into Assessment Language table
*/
INSERT INTO [dbo].[AssessmentLanguage]
SELECT	tou.AssessmentID,
		l.LanguageID--,
		--[Languages],
		--JSON_VALUE(lan.[value], '$._framework') AS LanguagesFramework,
		--JSON_VALUE(lan.[value], '$._id') AS Languagesid
FROM #Assessment c
LEFT OUTER JOIN [dbo].[Assessment] tou
	ON c.AssessmentObject_id = tou.AssessmentObject_id
CROSS APPLY OPENJSON(JSON_QUERY(Languages, '$'))  lan
INNER JOIN [dbo].[Language] l
	ON l.LanguageName = JSON_VALUE(lan.[value], '$._id')
	AND l.LanguageFramework = JSON_VALUE(lan.[value], '$._framework')
--SELECT * FROM #Assessment

	TRUNCATE TABLE #Assessment
	FETCH NEXT FROM JSONIMPORT INTO @JSONShred

END

CLOSE JSONIMPORT
DEALLOCATE JSONIMPORT

/*

Debugging

SELECT len(BulkColumn) , BulkColumn
SELECT *
FROM OPENROWSET (BULK 'E:\SCWDemo\MongoExportEU\scw_prod_alpha_game_013.assessments_EU.json', SINGLE_CLOB) as j
CROSS APPLY OPENJSON(BulkColumn) 
WITH (name NVARCHAR(100) '$.name')

SELECT * FROM Assessment
ORDER BY AssessmentObject_id

select count(*)

*/