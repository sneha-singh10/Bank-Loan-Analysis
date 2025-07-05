-- Retrive all columns
SELECT * from financial_loan

-- Total loan Applications
SELECT COUNT(id) AS Total_Loan_Application FROM financial_loan

-- Month to Date Total loan Applications
SELECT COUNT(id) AS MTD_Total_Loan_Application FROM financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- Previous Month to Date Total loan Applications
SELECT COUNT(id) AS PMTD_Total_Loan_Application FROM financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

-- Month to Month Loan Application 
-- (MTD-PMTD)/PMTD

-- Total funded amount from bank
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM financial_loan

-- Month to Date Total funded amount from bank
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount FROM financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- Previous Month to Date Total funded amount from bank
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount FROM financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

-- Total Recived Amount
SELECT SUM(total_payment) AS Total_Recieved_Amount FROM financial_loan

-- Month to Date Total Recived Amount
SELECT SUM(total_payment) AS MTD_Total_Recieved_Amount FROM financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- Previous Month to Date Total Recived Amount
SELECT SUM(total_payment) AS PMTD_Total_Recieved_Amount FROM financial_loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--Average Interest Rate
SELECT ROUND(AVG(int_rate)*100,2) AS Average_interest_rate FROM financial_loan

-- Month to Date/Current Month Average Interest Rate
SELECT ROUND(AVG(int_rate)*100,2) AS MTD_Average_interest_rate FROM financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- Average DTI
SELECT ROUND(AVG(dti)*100,2) AS Average_DTI FROM financial_loan

-- Month to Date Average DTI
SELECT ROUND(AVG(dti)*100,2) AS MTD_Average_DTI FROM financial_loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

-- Good Loan
SELECT
      (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END)*100)/COUNT(id) 
      AS Good_loan_percentage FROM financial_loan

-- Good Loan Application
SELECT COUNT(id) AS Good_loan_Application FROM financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

-- Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_loan_funded_amount FROM financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

-- Good Loan Recieved Amount
SELECT SUM(total_payment) AS Good_loan_recieved_amount FROM financial_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

-- Bad Loan
SELECT
      (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END)*100.0)/COUNT(id) 
      AS Bad_loan_percentage FROM financial_loan

-- Bad Loan Application
SELECT COUNT(id) AS Bad_loan_Application FROM financial_loan
WHERE loan_status = 'Charged Off'

-- Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_loan_funded_amount FROM financial_loan
WHERE loan_status = 'Charged Off'

-- Bad Loan Recieved Amount
SELECT SUM(total_payment) AS Bad_loan_recieved_amount FROM financial_loan
WHERE loan_status = 'Charged Off'

-- Loan Summary
SELECT loan_status,
COUNT(id) AS Total_Loan_Application,
SUM(total_payment) AS Total_Amount_Recieved,
SUM(loan_amount) AS Total_Funded_Amount,
AVG(int_rate * 100) AS Interest_Rate,
AVG(dti*100) AS DTI
FROM financial_loan
GROUP BY loan_status

-- Month to Date Summary
SELECT loan_status,
SUM(total_payment) AS MTD_Total_Amount_Recieved,
SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM financial_loan
WHERE MONTH(issue_date) = 12
GROUP BY loan_status

-- Monthly trend by Issue Date
SELECT
MONTH(issue_date) AS Month_Number,
DATENAME(MONTH, issue_date) AS Month_Name,
COUNT(id) AS Total_Loan_Application,
SUM(total_payment) AS Total_Amount_Recieved,
SUM(loan_amount) AS Total_Funded_Amount
FROM financial_loan
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date) DESC

-- Regional Analysis
SELECT
address_state,
COUNT(id) AS Total_Loan_Application,
SUM(total_payment) AS Total_Amount_Recieved,
SUM(loan_amount) AS Total_Funded_Amount
FROM financial_loan
GROUP BY address_state
ORDER BY SUM(loan_amount)

-- Loan Term Analysis
SELECT
term AS Term,
COUNT(id) AS Total_Loan_Application,
SUM(total_payment) AS Total_Amount_Recieved,
SUM(loan_amount) AS Total_Funded_Amount
FROM financial_loan
GROUP BY term
ORDER BY SUM(loan_amount)

-- Employee Length Analysis
SELECT
emp_length AS Employee_Length,
COUNT(id) AS Total_Loan_Application,
SUM(total_payment) AS Total_Amount_Recieved,
SUM(loan_amount) AS Total_Funded_Amount
FROM financial_loan
GROUP BY emp_length
ORDER BY emp_length

--Loan Purpose Breakdown
SELECT
purpose AS Loan_Purpose,
COUNT(id) AS Total_Loan_Application,
SUM(total_payment) AS Total_Amount_Recieved,
SUM(loan_amount) AS Total_Funded_Amount
FROM financial_loan
GROUP BY purpose
ORDER BY COUNT(id) DESC

-- Home Ownership Analysis
SELECT
home_ownership ,
COUNT(id) AS Total_Loan_Application,
SUM(total_payment) AS Total_Amount_Recieved,
SUM(loan_amount) AS Total_Funded_Amount
FROM financial_loan
GROUP BY home_ownership
ORDER BY COUNT(id) DESC

