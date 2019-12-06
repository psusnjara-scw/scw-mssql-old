-- View for Assessment
ALTER VIEW Assessments_Taken AS
SELECT a.AssessmentStatus, a.Difficulty, a.StartDate, a.EndDate, a.InviteSendDate, a.NumberOfChallenges AS 'No of Assessment Challenges', l.LanguageName + l.LanguageFramework AS 'Language Name/Framework'
FROM Assessment a
INNER JOIN AssessmentLanguage al
on a.AssessmentID = al.AssessmentID
INNER JOIN Language l
ON al.LanguageID = l.LanguageID
GO