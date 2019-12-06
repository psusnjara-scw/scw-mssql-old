--  Return Company Languages paid for
CREATE VIEW CompanyLanguages_Licensed
AS
SELECT TOP 100 PERCENT LanguageName, LanguageFramework, COUNT(*) AS LanguageCount
FROM dbo.CompanyLanguage cl
INNER JOIN Language l
ON cl.LanguageID = l.LanguageID
GROUP BY LanguageName, LanguageFramework
ORDER BY LanguageCount DESC
GO