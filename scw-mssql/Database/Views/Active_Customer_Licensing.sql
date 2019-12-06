-- View for licenses by active customers
CREATE VIEW Active_Customer_Licensing AS
SELECT  a.Account_Name, DataSource AS DataSourceRegion, Billing_Country AS Country, Billing_State_Province AS State, Region AS CustomerRegion, CustomerTypeName AS CustomerType,
		c.[CustomerStatus] AS CustomerStatus, SUBSTRING(a.Unique_VLE_Identifier,3,8) AS VLE_Substring, Unique_VLE_Identifier,
		[CustomerSalesforceID] , 1 AS 'Licence Count',
		cs.CompanySizeDropdown AS 'Company Size/Tier', i.IndustryDropdown AS 'Industry Name',
		ca.LicenseType AS 'Licence Type', ca.AvailableLicences, lat.LicenceAllowanceTypeDropDown AS 'Licence Allowance Type', ca.TolerantStatus, ca.GrantedLicences, ca.UsedLicences, ca.ReservedLicences,
		ca.GrantedOverrun, ca.AvailableOverrun, ca.ReservedOverrun, ca.UsedOverrun
FROM [dbo].[ActiveCustomers3] a 
LEFT OUTER JOIN Company c
ON (c.[CustomerSalesforceID] = a.[Unique_VLE_Identifier]
	OR c.[CustomerSalesforceID] = SUBSTRING(a.Unique_VLE_Identifier,3,8)
	)
LEFT OUTER JOIN [CustomerType] ct
ON c.[CustomerTypeID] = ct.[CustomerTypeID]
INNER JOIN [CompanySize] cs
ON c.CompanySizeID = cs.CompanySizeID
INNER JOIN [Industry] i
ON c.CustomerIndustryID = i.IndustryID
INNER JOIN CompanyAllowance ca
ON c.CompanyID = ca.CompanyID
INNER JOIN [LicenceAllowanceType] lat
ON ca.CompanyAllowanceTypeID = lat.LicenceAllowanceTypeID
WHERE	c.CustomerStatus = 'enabled'
AND		UPPER(ct.CustomerTypeName) = 'CLIENT'
AND		Unique_VLE_Identifier IS NOT NULL
GO