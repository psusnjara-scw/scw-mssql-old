-- Return Top 10 Industries
CREATE VIEW TOP_10_Industries
AS
SELECT TOP 10 i.[IndustryName], COUNT(*) AS IndustryCount
FROM Company c 
INNER JOIN Industry i 
ON c.[CustomerIndustryID] = i.[IndustryID]
GROUP BY i.[IndustryName]
ORDER BY IndustryCount DESC
GO