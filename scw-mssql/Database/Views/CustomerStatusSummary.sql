-- View for customers by customer status
CREATE VIEW  CustomerStatusSummary AS
SELECT  DataSource AS DataSourceRegion, Billing_Country AS Country, Billing_State_Province AS State, Region AS CustomerRegion, CustomerTypeName AS CustomerType,
		c.[CustomerStatus] AS CustomerStatus, ISNULL(SUBSTRING(a.Unique_VLE_Identifier,3,8), 'UNKNOWN') AS VLE_Substring,
		[CustomerSalesforceID] , 1 AS 'RowCount'
FROM Company c
INNER JOIN [CustomerType] ct
ON c.[CustomerTypeID] = ct.[CustomerTypeID]
LEFT OUTER JOIN [dbo].[ActiveCustomers3] a
ON c.[CustomerSalesforceID] = a.[Unique_VLE_Identifier]
	OR c.[CustomerSalesforceID] = SUBSTRING(a.Unique_VLE_Identifier,3,8)
	
GO