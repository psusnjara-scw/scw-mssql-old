/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

:r .\ins_Industry.sql
:r .\ins_Language.sql
:r .\ins_LicenceAllowanceType.sql
:r .\ins_Region.sql
:r .\ins_CompanySize.sql
:r .\ins_CustomerType.sql
:r .\ins_UserPreferenceValues.sql
