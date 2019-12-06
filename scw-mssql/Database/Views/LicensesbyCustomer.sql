--  Licences for active customers based on Expiry Date
CREATE VIEW LicencesbyCustomer AS 
SELECT	da.Month_Year
		,lat.LicenceAllowanceTypeDesc
		,ca.LicenseType
		,SUM(ca.AvailableLicences)  AS AvailableLicences
		,SUM(ca.GrantedLicences) AS GrantedLicences
		,SUM(ca.UsedLicences) AS UsedLicences
		,SUM(ca.ReservedLicences) AS ReservedLicences
FROM Company c
INNER JOIN CompanyAllowance ca
on c.CompanyID = ca.CompanyID
INNER JOIN LicenceAllowanceType lat
ON lat.LicenceAllowanceTypeID = ca.CompanyAllowanceTypeID
INNER JOIN TempExpirationDates te
ON te.CompanyID = c.CompaniesObject_id_text
INNER JOIN (SELECT DISTINCT Month_Year AS Month_Year, Calendar_Year AS Calendar_Year, Month_Number AS Month_Number 
			FROM D_Date 
			) da
ON SUBSTRING((CONVERT(CHAR(8), te.CompanyExpirationDate, 112)),1 ,6) >= da.Month_Year

WHERE c.CustomerTypeID = 2 -- client
AND da.Month_Year BETWEEN 201612 AND 201911
AND SUBSTRING((CONVERT(CHAR(8), 
				DATEADD( SECOND, 
				CAST(CONVERT(BINARY(4), '0x'+SUBSTRING(CompaniesObject_id_text, 1, 8), 1) AS BIGINT), 
				CAST('1970-01-01 00:00' AS DATETIME)
			   )
				, 112)),1 ,6) <= CAST(da.Month_Year AS CHAR(8))
--AND lat.LicenceAllowanceTypeDesc = 'Training'
GROUP BY 
		da.Month_Year
		,lat.LicenceAllowanceTypeDesc
		,ca.LicenseType

--ORDER BY da.Month_Year DESC, lat.LicenceAllowanceTypeDesc 
GO

