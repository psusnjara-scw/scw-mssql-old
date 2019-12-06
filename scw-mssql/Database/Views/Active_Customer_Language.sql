-- View for languages by active customers
CREATE VIEW Active_Customer_Language AS
SELECT  DataSource AS DataSourceRegion, Billing_Country AS Country, Billing_State_Province AS State, Region AS CustomerRegion, CustomerTypeName AS CustomerType,
		c.[CustomerStatus] AS CustomerStatus, SUBSTRING(a.Unique_VLE_Identifier,3,8) AS VLE_Substring, Unique_VLE_Identifier,
		[CustomerSalesforceID] , 1 AS 'Language Count',
		l.LanguageName + l.LanguageFramework AS 'Language Name and Framework', cs.CompanySizeDropdown AS 'Company Size/Tier', i.IndustryDropdown AS 'Industry Name'
FROM [dbo].[ActiveCustomers3] a 
LEFT OUTER JOIN Company c
ON (c.[CustomerSalesforceID] = a.[Unique_VLE_Identifier]
	OR c.[CustomerSalesforceID] = SUBSTRING(a.Unique_VLE_Identifier,3,8)
	)
LEFT OUTER JOIN [CustomerType] ct
ON c.[CustomerTypeID] = ct.[CustomerTypeID]
INNER JOIN [CompanyLanguage] cl
ON c.CompanyID = cl.CompanyID
INNER JOIN [Language] l
ON cl.LanguageID = l.LanguageID
INNER JOIN [CompanySize] cs
ON c.CompanySizeID = cs.CompanySizeID
INNER JOIN [Industry] i
ON c.CustomerIndustryID = i.IndustryID
WHERE	c.CustomerStatus = 'enabled'
AND		UPPER(ct.CustomerTypeName) = 'CLIENT'
AND		Unique_VLE_Identifier IS NOT NULL
GO