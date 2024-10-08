CREATE DATABASE GenZ_career_aspirations;
USE GenZ_career_aspirations;

CREATE TABLE career_aspirations(
`Timestamp` timestamp,
`Country` VARCHAR(50),
`ZipCode` VARCHAR(10),
`Gender` VARCHAR(10),
`InfluencialFactor` VARCHAR(50),
`StudyAbroad` VARCHAR(50),
`WorkFor3Yrs` VARCHAR(50),
`WorkWithMissionlessCompany` VARCHAR(50),
`WorkWithMisalignedCompany` VARCHAR(50),
`WorkWithSociallyImpactlessCompany` int,
`PreferredWorkingEnv` VARCHAR(100),
`PreferredEmployer` VARCHAR(100),
`LearningEnv` VARCHAR(50),
`AspirationalJob` VARCHAR(50),
`PreferredManager` VARCHAR(100),
`FavWorkSetup` VARCHAR(100),
`CompanyWithRecentLaidOffs` VARCHAR(100),
`WorkFor7Yrs` VARCHAR(50),
`Email` VARCHAR(100),
`ExpectedSalary_3yrs` VARCHAR(25),
`ExpectedSalary_5yrs` VARCHAR(25),
`CompanyWithNoRemotePolicy` int,
`ExpectedSalary_Fresher` VARCHAR(25),
`PreferredCompany` VARCHAR(100),
`WorkAtUnhealthyWorkspace` VARCHAR(10),
`PreferredDailyWorkHours` VARCHAR(25),
`BreakToStayHealthy` VARCHAR(25),
`BoostWorkHappinessProductivity` VARCHAR(50),
`WorkFrustrations` VARCHAR(50)
);

/*------------------------------------------------------------------*/
/*--------- Data exported using `Table Data Import Wizard` ---------*/
/*------------------------------------------------------------------*/

select * from career_aspirations;

-- Q1. What is the gender distribution of respondents from India?
SELECT Gender, COUNT(*) AS No_of_Respondents
FROM career_aspirations
WHERE Country = 'IND'
GROUP BY Gender;

-- Q2. What percentage of respondents from India is interested in education abroad and sponsorship?
SELECT StudyAbroad,
    ROUND((COUNT(*) / (SELECT COUNT(*) FROM career_aspirations WHERE Country = 'IND')) * 100, 2) AS Percentage_of_Respondents
FROM career_aspirations
WHERE Country = 'IND' AND StudyAbroad IN ('Yes', 'If Sponsored')
GROUP BY StudyAbroad;

-- Q3. What are the 6 top influences on career aspirations for respondents in India?
SELECT InfluencialFactor, COUNT(*) AS No_of_Respondents
FROM career_aspirations
WHERE Country = 'IND'
GROUP BY InfluencialFactor
ORDER BY No_of_Respondents DESC
LIMIT 6;

-- Q4. How do career aspiration influences vary by gender in India?
SELECT InfluencialFactor,
COUNT(CASE WHEN Gender = 'M' THEN 1 END) AS Male_Respondents, 
COUNT(CASE WHEN Gender = 'F' THEN 1 END) AS Female_Respondents, 
COUNT(CASE WHEN Gender = 'Other' THEN 1 END) AS Other_Respondents
FROM career_aspirations
WHERE Country = 'IND'
GROUP BY InfluencialFactor
ORDER BY Male_Respondents DESC, Female_Respondents DESC, Other_Respondents DESC;

-- Q5. What percentage of respondents is willing to work for a company for at least 3 years?
SELECT ROUND((SUM(CASE WHEN WorkFor3Yrs = 'Yes' THEN 1 ELSE 0 END)
    / COUNT(*)) * 100, 2) AS Percentage_of_Respondents
FROM career_aspirations
WHERE Country = 'IND';

-- Q6. How many respondents prefer to work for socially impactful companies?
SELECT MAX(WorkWithSociallyImpactlessCompany) - WorkWithSociallyImpactlessCompany + 1 AS Preferrence_Level,
COUNT(*) AS No_of_Respondents
FROM career_aspirations
WHERE Country = 'IND' 
GROUP BY Preferrence_Level
ORDER BY Preferrence_Level;

-- Q7. How does the preference for socially impactful companies vary by gender?
SELECT MAX(WorkWithSociallyImpactlessCompany) - WorkWithSociallyImpactlessCompany + 1 AS Preferrence_Level,
COUNT (CASE WHEN Gender = 'M' THEN 1 END) AS Male_Respondents,
COUNT (CASE WHEN GENDER = 'F' THEN 1 END) AS Female_Respondents, 
COUNT (CASE WHEN GENDER = 'OTHER' THEN 1 END) AS Other_Respondents
FROM career_aspirations
WHERE Country = 'IND'
GROUP BY Preferrence_Level
ORDER BY Preferrence_Level;

-- Q8. What is the distribution of minimum expected salary in the first three years among respondents?
SELECT ExpectedSalary_3yrs, COUNT(*) AS No_of_Respondents
FROM career_aspirations
WHERE Country = 'IND'
GROUP BY ExpectedSalary_3yrs
ORDER BY No_of_Respondents;

-- Q9. What is the expected minimum monthly salary in hand?
SELECT ExpectedSalary_Fresher, COUNT(*) AS No_of_Respondents
FROM career_aspirations
WHERE Country = 'IND' AND ExpectedSalary_Fresher IS NOT NULL
GROUP BY ExpectedSalary_Fresher
ORDER BY No_of_Respondents;

-- Q10. What percentage of respondents prefers remote working?
SELECT PreferredWorkingEnv,
ROUND((COUNT(*) / (SELECT COUNT(*) FROM career_aspirations))*100, 2) AS Percentage_of_Respondents
FROM career_aspirations
WHERE Country = 'IND' AND PreferredWorkingEnv = 'Remote'
GROUP BY PreferredWorkingEnv;

-- Q11. What is the preferred number of daily work hours?
SELECT PreferredDailyWorkHours, COUNT(*) AS No_of_Respondents
FROM career_aspirations
WHERE Country = 'IND'
GROUP BY PreferredDailyWorkHours
ORDER BY No_of_Respondents DESC;

-- Q12. What are the common work frustrations among respondents?
SELECT WorkFrustrations, COUNT(*) AS No_of_Respondents
FROM career_aspirations
WHERE Country = 'IND'
GROUP BY WorkFrustrations
ORDER BY No_of_Respondents DESC;

-- Q13. How does the need for work-life balance interventions vary by gender?
SELECT Gender, BreakToStayHealthy, COUNT(*) AS No_of_Respondents
FROM career_aspirations
WHERE Country = 'IND'
GROUP BY Gender, NeedForWorkLifeBalance
ORDER BY Gender, No_of_Respondents DESC;

-- Q14. How many respondents are willing to work under an abusive manager?
SELECT COUNT(*) AS No_of_Respondents
FROM career_aspirations
WHERE Country = 'IND' AND PreferredManager LIKE '%unrealistic target%';

-- Q15. What is the distribution of minimum expected salary after five years?
SELECT ExpectedSalary_5yrs, COUNT(*) AS No_of_Respondents
FROM career_aspirations
WHERE Country = 'IND'
GROUP BY ExpectedSalary_5yrs
ORDER BY No_of_Respondents DESC;

-- Q16. What are the remote working preferences by gender?
SELECT Gender, PreferredWorkingEnv, COUNT(*) AS No_of_Respondents
FROM career_aspirations
WHERE Country = 'IND' AND PreferredWorkingEnv = 'Remote'
GROUP BY Gender;

-- Q17. What are the top work frustrations for each gender?
SELECT Gender, WorkFrustrations,
    COUNT(*) AS No_of_Respondents,
ROW_NUMBER() OVER (PARTITION BY Gender ORDER BY No_of_Respondents DESC) AS row_num
FROM career_aspirations
WHERE Country = 'IND' AND WorkFrustrations IS NOT NULL
GROUP BY Gender, WorkFrustrations
ORDER BY Gender;

-- Q18. What factors boost work happiness and productivity for respondents?
SELECT BoostWorkHappinessProductivity,
    COUNT(*) AS No_of_Respondents
FROM career_aspirations
WHERE Country = 'IND'
GROUP BY BoostWorkHappinessProductivity
ORDER BY No_of_Respondents DESC;

-- Q19. What percentage of respondents needs sponsorship for education abroad?
SELECT StudyAbroad,
    ROUND((COUNT(*) / (SELECT COUNT(*) FROM career_aspirations)) * 100, 2) AS Percentage_of_Respondents
FROM career_aspirations
WHERE Country = 'IND' AND StudyAbroad = 'If Sponsored'
GROUP BY StudyAbroad;