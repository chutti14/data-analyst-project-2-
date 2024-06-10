Use HR_Analytics_DB;

Select * from hr1;
Select * from hr2;

### KPI 1 - Average Attrition rate for all Departments
SELECT hr1.Department, CONCAT(Format(AVG(CASE WHEN hr1.attrition = 'Yes' THEN 1 ELSE 0 END) * 100, 2), '%') as Avg_Attrition_rate
FROM hr1
GROUP BY hr1.Department 
ORDER BY Avg_Attrition_rate;

### KPI 2 - Average Hourly rate of Male Research Scientist
SELECT Gender, JobRole, Format(AVG(HourlyRate),2) as Avg_HourlyRate
FROM hr1 
WHERE Gender = 'Male' AND JobRole = 'Research Scientist';

### KPI 3 - Attrition rate Vs Monthly income stats
SELECT  h1.Department,  -- h1.JobRole,
		COUNT(h1.EmployeeNumber) AS TotalEmployees,
		CONCAT(Format(AVG(CASE WHEN h1.attrition = 'Yes' THEN 1 ELSE 0 END)*100,2), '%') as Avg_Attrition_rate,
        Format(AVG(h2.monthlyincome),2) as Avg_Monthly_Income
FROM hr1 as h1 INNER JOIN hr2 as h2 ON h2.EmployeeID = h1.EmployeeNumber
GROUP BY h1.Department
-- GROUP BY h1.JobRole
ORDER BY Avg_Attrition_rate;

### KPI 4 - Average working years for each Department
SELECT a.Department, Format(AVG(b.TotalWorkingYears),2) as Avg_Working_Year
FROM hr1 as a INNER JOIN hr2 as b ON b.EmployeeID = a.EmployeeNumber
GROUP BY a.Department
ORDER BY Avg_Working_Year;

### KPI 5 - Job Role Vs Work life balance
SELECT  a.JobRole, 
		COUNT(b.WorkLifeBalance) as Total_Employee, 
		SUM(CASE WHEN WorkLifeBalance = 1 THEN 1 ELSE 0 END) as 1st_Rating_Total,
		SUM(CASE WHEN WorkLifeBalance = 2 THEN 1 ELSE 0 END) as 2nd_Rating_Total,
		SUM(CASE WHEN WorkLifeBalance = 3 THEN 1 ELSE 0 END) as 3rd_Rating_Total,
		SUM(CASE WHEN WorkLifeBalance = 4 THEN 1 ELSE 0 END) as 4th_Rating_Total, 
		Format(AVG(b.WorkLifeBalance),2) as Avg_WorkLifeBalance_Rating
FROM hr1 as a INNER JOIN hr2 as b ON b.EmployeeID = a.Employeenumber
GROUP BY a.jobrole
ORDER BY a.jobrole;

### KPI 6 - Attrition rate Vs Year since last promotion relation
SELECT  h1.JobRole, -- h1.Department,
		COUNT(h1.EmployeeNumber) AS TotalEmployees,
		CONCAT(Format(AVG(CASE WHEN h1.attrition = 'Yes' THEN 1 ELSE 0 END)*100,2), '%') as Avg_Attrition_rate,
		Format(AVG(h2.YearsSinceLastPromotion),2) as Avg_YearsSinceLastPromotion
FROM hr1 as h1 INNER JOIN hr2 as h2 ON h2.EmployeeID = h1.EmployeeNumber
GROUP BY h1.JobRole
-- GROUP BY h1.Department
ORDER BY Avg_Attrition_rate;
