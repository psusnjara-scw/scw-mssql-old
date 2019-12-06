--  Tournaments by Active Customers
CREATE VIEW Active_Company_TournamentsRun AS
SELECT convert(VARCHAR(6), t.StartDate, 112) AS TournamentMonth, COUNT(*) AS TournamentsHeld
FROM [ActiveCustomers3] a 
INNER JOIN Company c
ON (c.[CustomerSalesforceID] = a.[Unique_VLE_Identifier]
	OR c.[CustomerSalesforceID] = SUBSTRING(a.Unique_VLE_Identifier,3,8)
	)
INNER JOIN Tournament t
ON t.CompanyID = c.CompaniesObject_id_text
GROUP BY convert(VARCHAR(6), StartDate, 112)
GO