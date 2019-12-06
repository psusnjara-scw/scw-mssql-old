-- View for mismatched customers
CREATE VIEW  MismatchedCustomers AS
SELECT a.*, ISNULL(c.[CustomerStatus], 'UNKNOWN') AS CustomerStatus, ct.CustomerTypeDropdown AS CustomerType
FROM [ActiveCustomers3] a
LEFT OUTER JOIN Company c
ON (c.[CustomerSalesforceID] = a.[Unique_VLE_Identifier]
	OR c.[CustomerSalesforceID] = SUBSTRING(a.Unique_VLE_Identifier,3,8)
	)
LEFT OUTER JOIN [CustomerType] ct
ON c.[CustomerTypeID] = ct.[CustomerTypeID]
WHERE Unique_VLE_Identifier NOT IN (SELECT Unique_VLE_Identifier FROM Customer_Region_Country_State)
