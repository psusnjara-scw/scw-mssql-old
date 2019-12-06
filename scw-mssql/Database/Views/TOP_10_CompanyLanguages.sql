--  Return Top 10 Company Languages paid for
CREATE VIEW TOP_10_CompanyLanguages
AS
SELECT TOP 10 LanguageName, LanguageFramework, COUNT(*) AS LanguageCount
FROM dbo.CompanyLanguage cl
INNER JOIN Language l
ON cl.LanguageID = l.LanguageID
GROUP BY LanguageName, LanguageFramework
ORDER BY LanguageCount DESC
GO