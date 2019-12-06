-- VIew for tournaments by active customers
CREATE VIEW TournamentsbyCompany AS
SELECT	t.StartDate,t.FinishDate, i.IndustryDropdown AS 'Industry Name', a.Billing_Country, a.Billing_State_Province, a.Region AS 'Customer Region', a.Account_Name,
		cs.CompanySizeDropdown AS 'Customer Size', l.LanguageName + l.LanguageFramework AS 'Language Name and Framework',
		1 AS [RowCount]
FROM Tournament t
INNER JOIN Company c
ON t.CompanyID = c.CompaniesObject_id_text
INNER JOIN Industry i 
ON c.[CustomerIndustryID] = i.[IndustryID] 
INNER JOIN [dbo].[ActiveCustomers3] a 
ON c.[CustomerSalesforceID] = a.[Unique_VLE_Identifier]
	OR c.[CustomerSalesforceID] = SUBSTRING(a.Unique_VLE_Identifier,3,8)
INNER JOIN CompanySize cs
ON c.CompanySizeID = cs.CompanySizeID
INNER JOIN TournamentLanguage tl
ON t.TournamentID = tl.TournamentID
INNER JOIN Language l
ON tl.LanguageID = l.LanguageID
--ORDER BY StartDate
GO
