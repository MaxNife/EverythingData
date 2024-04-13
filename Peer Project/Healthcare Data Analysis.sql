SELECT *
FROM dbo.healthcare_dataset

--HEALTH ANALYSIS QUESTIONS:


--1. Which insurance provider was most used by patients?
SELECT 
	Insurance_Provider, 
	COUNT(*) AS Total_users
FROM dbo.healthcare_dataset
GROUP BY Insurance_Provider
ORDER BY Total_users DESC 

--2. What is the blood group distribution by gender?
SELECT 
	Gender, 
	Blood_Type, 
	COUNT(Blood_Type) AS BT_Count 
FROM dbo.healthcare_dataset
GROUP BY Gender, Blood_Type
ORDER BY Blood_Type DESC

--3. Which medical condition had the highest number of cases recorded?
SELECT 
	Medical_Condition, 
	COUNT(*) as Total_Cases 
FROM dbo.healthcare_dataset
GROUP BY Medical_Condition
ORDER BY Total_Cases DESC

--4. What is the admission type applied to each medical condition?
SELECT 
	Medical_Condition,
	Admission_Type, 
	COUNT(*) AS Total_Cases 
FROM dbo.healthcare_dataset
GROUP BY Medical_Condition, Admission_Type
ORDER BY Total_Cases 


--5. How many obesity cases were recorded per hospital?
SELECT 
	Hospital, 
	COUNT(Medical_Condition) AS Obesity_Cases
FROM dbo.healthcare_dataset
WHERE Medical_Condition= 'Obesity'
GROUP BY Hospital
ORDER BY Obesity_Cases DESC
 
--6. How many cancer cases were recorded per hospital?
SELECT 
	Hospital, 
	COUNT(Medical_Condition) AS Cancer_Cases
FROM dbo.healthcare_dataset
WHERE Medical_Condition= 'Cancer'
GROUP BY Hospital
ORDER BY Cancer_Cases DESC

--7.How many Hypertension cases were recorded per hospital?
SELECT 
	Hospital, 
	COUNT(Medical_Condition) AS Hypertension_Cases
FROM dbo.healthcare_dataset
WHERE Medical_Condition= 'Hypertension '
GROUP BY Hospital
ORDER BY Hypertension_Cases DESC

--8.How many Arthritis cases were recorded per hospital?
SELECT 
	Hospital, 
	COUNT(Medical_Condition) AS Arthritis_Cases
FROM dbo.healthcare_dataset
WHERE Medical_Condition= 'Arthritis'
GROUP BY Hospital
ORDER BY Arthritis_Cases DESC

--9.How many Asthma cases were recorded per hospital?
SELECT 
	Hospital, 
	COUNT(Medical_Condition) AS Asthma_Cases
FROM dbo.healthcare_dataset
WHERE Medical_Condition= 'Asthma'
GROUP BY Hospital
ORDER BY Asthma_Cases DESC

--10.How many Diabetes cases were recorded per hospital?
SELECT 
	Hospital, 
	COUNT(Medical_Condition) AS Diabetes_Cases
FROM dbo.healthcare_dataset
WHERE Medical_Condition= 'Diabetes '
GROUP BY Hospital
ORDER BY Diabetes_Cases DESC

--11. What is the evarage billing amount for each medical condition?
SELECT 
	Medical_Condition, 
	ROUND(AVG(Billing_Amount),2) AS AVG_BillingAmt
FROM dbo.healthcare_dataset
GROUP BY Medical_Condition
ORDER BY AVG_BillingAmt DESC

--12. What is the total number of cases per age group?
SELECT 
	(CASE WHEN Age BETWEEN 0 AND 12 THEN 'Child'
		WHEN Age BETWEEN 13 AND 19 THEN 'Teenager'
		WHEN Age BETWEEN 20 AND 35 THEN 'Young Adult'
		WHEN Age BETWEEN 36 AND  50 THEN 'Adult'
		ELSE 'Elderly' END) AS Age_Group,COUNT(*) AS Number_ofcases
FROM dbo.healthcare_dataset
GROUP BY (
	CASE WHEN Age BETWEEN 0 AND 12 THEN 'Child'
		WHEN Age BETWEEN 13 AND 19 THEN 'Teenager'
		WHEN Age BETWEEN 20 AND 35 THEN 'Young Adult'
		WHEN Age BETWEEN 36 AND  50 THEN 'Adult'
		ELSE 'Elderly' END)


--13. Which is the most used medication for Asthma?
SELECT 
	Medication,
	COUNT(Medication) AS MD_Count
FROM dbo.healthcare_dataset
WHERE Medical_Condition = 'Asthma'
GROUP BY Medication
ORDER BY MD_Count DESC

--14. Which is the most used medication for Arthritis?
SELECT 
	Medication,
	COUNT(Medication) AS MD_Count
FROM dbo.healthcare_dataset
WHERE Medical_Condition = 'Arthritis'
GROUP BY Medication
ORDER BY MD_Count DESC

--15. Which is the most used medication for Diabetes?
SELECT 
	Medication,
	COUNT(Medication) AS MD_Count
FROM dbo.healthcare_dataset
WHERE Medical_Condition = 'Diabetes'
GROUP BY Medication
ORDER BY MD_Count DESC

--16. Which is the most used medication for Cancer?
SELECT 
	Medication,
	COUNT(Medication) AS MD_Count
FROM dbo.healthcare_dataset
WHERE Medical_Condition = 'Cancer'
GROUP BY Medication
ORDER BY MD_Count DESC

--17. Which is the most used medication for Hypertension?
SELECT 
	Medication,
	COUNT(Medication) AS MD_Count
FROM dbo.healthcare_dataset
WHERE Medical_Condition = 'Hypertension'
GROUP BY Medication
ORDER BY MD_Count DESC

--18. Which is the most used medication for Obesity?
SELECT 
	Medication,
	COUNT(Medication) AS MD_Count
FROM dbo.healthcare_dataset
WHERE Medical_Condition = 'Obesity'
GROUP BY Medication
ORDER BY MD_Count DESC

--19.  What is the distribution of Patients per doctor?
SELECT 
	Doctor,
	COUNT(*) AS Number_ofpatients
FROM dbo.healthcare_dataset
GROUP BY  Doctor
ORDER BY Number_ofpatients DESC

--20. Which patients were attended to by Michael Johnson?
SELECT Name
FROM dbo.healthcare_dataset
WHERE Doctor = 'Michael Johnson'


