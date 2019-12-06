--  View to match active customers
CREATE VIEW Customer_Region_Country_State AS
SELECT  DataSource AS DataSourceRegion, Billing_Country AS Country, Billing_State_Province AS State, Region AS CustomerRegion, CustomerTypeName AS CustomerType,
		c.[CustomerStatus] AS CustomerStatus, SUBSTRING(a.Unique_VLE_Identifier,3,8) AS VLE_Substring, Unique_VLE_Identifier,
		[CustomerSalesforceID] , 1 AS 'RowCount'
FROM [dbo].[ActiveCustomers3] a 
LEFT OUTER JOIN Company c
ON (c.[CustomerSalesforceID] = a.[Unique_VLE_Identifier]
	OR c.[CustomerSalesforceID] = SUBSTRING(a.Unique_VLE_Identifier,3,8)
	)
LEFT OUTER JOIN [CustomerType] ct
ON c.[CustomerTypeID] = ct.[CustomerTypeID]
WHERE	c.CustomerStatus = 'enabled'
AND		UPPER(ct.CustomerTypeName) = 'CLIENT'
AND		Unique_VLE_Identifier IS NOT NULL

GO