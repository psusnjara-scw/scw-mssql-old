--CREATE PROCEDURE [dbo].[ImportCompany]
	
--AS

--  This is still being debugged and included here for progress

/*
    SELECT @JSON = BulkColumn FROM OPENROWSET (BULK 'C:\aggregate_test.json', SINGLE_CLOB) as j 
	SET @JSON = replace(replace(replace(@JSON,'objectid(',''),'isodate(',''),'")','"')

    SELECT * FROM OPENJSON (@JSON) With (...)

*/
DROP TABLE #Company ;
DECLARE @JSON NVARCHAR(MAX);

CREATE TABLE [#Company] (
    [CompaniesObject_id]		VARBINARY(MAX)			NULL,
    [SsoErrorMessage]			NVARCHAR(20)			NULL,  
	[AccountOwner]				NVARCHAR(100)			NULL,
    [ExpirationDate]			NVARCHAR(MAX)			NULL, 
	[ExpirationDate_DEC]		DECIMAL(14,1)			NULL,
    [CompanyLogo]				NVARCHAR(250)			NULL,  
    [CompanySize]				NVARCHAR(40)			NULL,
    [CompanyName]				NVARCHAR(150)			NULL,
    [CustomerType]				NVARCHAR(40)			NULL,
    [CustomerIndustry]			NVARCHAR(40)			NULL,
    [I18nLanguagePreference]	CHAR(2)					NULL,
    [OnboardingMessage]			NVARCHAR(150)			NULL,  
    [LoginImage]				NVARCHAR(250)			NULL,  
    [CustomerRegion]			NVARCHAR(40)			NULL,
    [CustomerSalesforceID]		NVARCHAR(50)			NULL,
    [CustomerStatus]			NVARCHAR(10)			NULL,
	[CreatedDate]				NVARCHAR(MAX)			NULL, 
	[Allowances]				NVARCHAR(MAX)			NULL,
	[Languages]					NVARCHAR(MAX)			NULL,
	[SecurityGroups]			NVARCHAR(MAX)			NULL
)

DECLARE JSONIMPORT CURSOR FOR
 SELECT [column1]
 FROM [dbo].[companies_eu]

OPEN JSONIMPORT 
FETCH NEXT FROM JSONIMPORT INTO @JSON

WHILE @@FETCH_STATUS = 0
BEGIN

SELECT @JSON 
SELECT ISJSON(@JSON) AS IsValidJson

 INSERT INTO [#Company] (
             [CompaniesObject_id],
			 [SsoErrorMessage],
			 [AccountOwner],
             [ExpirationDate],
             [CompanyLogo],
             [CompanySize],
             [CompanyName],
             [CustomerType],
             [CustomerIndustry],
             [I18nLanguagePreference],
             [OnboardingMessage],
             [LoginImage],
             [CustomerRegion],
			 [CustomerSalesforceID],
			 [CustomerStatus],
			 [CreatedDate],
			 [Allowances],
			 [Languages],
			 [SecurityGroups]
 )
SELECT * FROM   OPENJSON (@JSON) 
            WITH(
			    [CompaniesObject_id]		VARBINARY(MAX)			'$._id."$oid"' ,
				[SsoErrorMessage]			NVARCHAR(20)			'$.ssoErrorMessage',  
				[AccountOwner]				NVARCHAR(100)			'$.accountOwnerId',
				[ExpirationDate]			NVARCHAR(MAX)			'$.expirationDate', 
				[CompanyLogo]				NVARCHAR(250)			, --'$.logo',  
				[CompanySize]				NVARCHAR(40)			'$.size',
				[CompanyName]				NVARCHAR(150)			'$.name',
				[CustomerType]				NVARCHAR(40)			'$.customerType',
				[CustomerIndustry]			NVARCHAR(40)			'$.industry',
				[I18nLanguagePreference]	CHAR(2)					'$.i18nLanguagePreference',
				[OnboardingMessage]			NVARCHAR(150)			'$.onboardingMessage',  
				[LoginImage]				NVARCHAR(250)			, --'$.loginImage',  
				[CustomerRegion]			NVARCHAR(40)			'$.region',
				[CustomerSalesforceID]		NVARCHAR(50)			'$.salesforceId',
				[CustomerStatus]			NVARCHAR(10)			'$.status',
				[CreatedDate]				NVARCHAR(MAX)						, 
				[Allowances]				NVARCHAR(MAX)			'$.allowances' AS JSON,
				[Languages]					NVARCHAR(MAX)			'$.languages' AS JSON,
				[SecurityGroups]			NVARCHAR(MAX)			'$.securityGroups' AS JSON
                        
)
SELECT * FROM #Company ;

UPDATE #Company
SET ExpirationDate_DEC = ROUND(CAST (CAST(ExpirationDate AS FLOAT) AS DECIMAL(18,1)),0)

SELECT ExpirationDate_DEC FROM #Company

UPDATE #Company
SET ExpirationDate_DEC = ExpirationDate_DEC / 60000  -- convert milliseconds to minutes

/*
	Insert into Company table
*/
INSERT INTO [dbo].[Company] ([CompaniesObject_id],[SsoErrorMessage],[AccountOwnerID],[ExpirationDate],[CompanyLogo],[CompanySizeID]
      ,[CompanyName]
      ,[CustomerTypeID]
      ,[CustomerIndustryID]
      ,[I18nLanguagePreference]
      ,[OnboardingMessage]
      ,[LoginImage]
      ,[CustomerRegionID]
      ,[CustomerSalesforceID]
      ,[CustomerStatus]
      ,[CreatedDate]
	  ,DataSource
		)
SELECT	c.[CompaniesObject_id], 
		c.[SsoErrorMessage],
		NULL, -- u.[UserID],
		DATEADD(MINUTE, ExpirationDate_DEC, '1970-01-01') AS ExpirationDate,  -- Date is stored as an DECIMAL(14,1) in MongoDB
		c.[CompanyLogo],
		cs.[CompanySizeID],
		c.[CompanyName],
		ct.[CustomerTypeID],
		i.[IndustryID], 
		c.[I18nLanguagePreference],
		c.[OnboardingMessage],
		c.[LoginImage],
		r.[RegionID], 
		c.[CustomerSalesforceID],
		c.[CustomerStatus],
		GETUTCDATE(), --ISNULL(c.[CustomerStatus], GETUTCDATE() ),
		'EU'
FROM #Company c
INNER JOIN [dbo].[Region] r
	ON c.CustomerRegion = r.RegionName
INNER JOIN [dbo].[Industry] i
	ON c.CustomerIndustry = i.IndustryName
INNER JOIN [dbo].[CompanySize] cs
	ON c.CompanySize = cs.CompanySizeName
INNER JOIN [dbo].[CustomerType] ct
	ON c.CustomerType = ct.CustomerTypeName
--LEFT OUTER JOIN [dbo].[SCWUser] u
--	ON c.AccountOwner = u.UsersObject_id    --  Match on MonogDB _id

;

/*
	Insert into Company Language table
*/
INSERT INTO [dbo].[CompanyLanguage]
SELECT	com.CompanyID,
		l.LanguageID--,
		--[Languages],
		--JSON_VALUE(lan.[value], '$._framework') AS LanguagesFramework,
		--JSON_VALUE(lan.[value], '$._id') AS Languagesid
FROM #Company c
LEFT OUTER JOIN [dbo].[Company] com
	ON c.CompaniesObject_id = com.CompaniesObject_id
CROSS APPLY OPENJSON(JSON_QUERY(Languages, '$'))  lan
INNER JOIN [dbo].[Language] l
	ON l.LanguageName = JSON_VALUE(lan.[value], '$._id')
	AND l.LanguageFramework = JSON_VALUE(lan.[value], '$._framework')

/*
	Insert into Company Allowances table
*/
INSERT INTO [dbo].[CompanyAllowance]
SELECT	[LicenceAllowanceTypeID],
		com.CompanyID,
		--l.LicenceAllowanceTypeDesc,
		--[Allowances],
		--lan.[key],
		--l.*,
		JSON_VALUE(lan.[value], '$.available') AS AvailableLicenses,
		JSON_VALUE(lan.[value], '$.granted') AS GrantedLicenses,
		JSON_VALUE(lan.[value], '$.used') AS UsedLicenses,
		JSON_VALUE(lan.[value], '$.reserved') AS ReservedLicenses,
		JSON_VALUE(lan.[value], '$.license') AS Licenses,	
		JSON_VALUE(lan.[value], '$.isTolerant') AS TolerantStatus,
		JSON_VALUE(lan.[value], '$.available_overrun') AS AvailableOverrunLicenses,
		JSON_VALUE(lan.[value], '$.granted_overrun') AS GrantedOverrunLicenses,
		JSON_VALUE(lan.[value], '$.used_overrun') AS UsedOverrunLicenses,
		JSON_VALUE(lan.[value], '$.reserved_overrun') AS ReservedOverrunLicenses
FROM #Company c
LEFT OUTER JOIN [dbo].[Company] com
	ON c.CompaniesObject_id = com.CompaniesObject_id
CROSS APPLY OPENJSON(JSON_QUERY(Allowances, '$'))  lan
INNER JOIN [dbo].[LicenceAllowanceType] l
	ON LOWER(l.LicenceAllowanceTypeDesc) = CAST(lan.[key] AS NVARCHAR(30)) COLLATE Latin1_General_CS_AS

	TRUNCATE TABLE #Company
	FETCH NEXT FROM JSONIMPORT INTO @JSON

END

CLOSE JSONIMPORT
DEALLOCATE JSONIMPORT

/*
TRUNCATE TABLE [dbo].[Company]
TRUNCATE TABLE [dbo].[CompanyAllowance]
TRUNCATE TABLE [dbo].[CompanyLanguage]

DELETE FROM [dbo].[Company]
DELETE FROM [dbo].[CompanyAllowance]
DELETE FROM [dbo].[CompanyLanguage]
*/
