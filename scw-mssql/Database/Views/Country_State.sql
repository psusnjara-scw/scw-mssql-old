-- View for countries/states
CREATE VIEW Country_State
AS
SELECT DISTINCT Billing_Country AS Country, ISNULL(Billing_State_Province, 'UNKNOWN') AS State
FROM [dbo].[ActiveCustomers3]
GO