create database Insurance_Analysis;
use Insurance_Analysis;

select * from brokerage;
select * from fees;
select * FROM individual_budgets;
select * FROM invoice;
select * FROM opportunity;
select * FROM meeting;
 
-- 1-No of Invoice by Accnt Exec
 
SELECT Account_Executive, COUNT(invoice_number) AS Number_Of_Invoices
FROM invoice
GROUP BY Account_Executive
Order by COUNT(invoice_number) ;

 

-- 2-Yearly Meeting Count
 select  year(meeting_date) as Years , count(meeting_date) as Meeting_Count from meeting
 group by year(meeting_date) 
 order by count(meeting_date) ;
 
 -- 4. Stage Funnel by Revenue
SELECT stage, sum(revenue_amount) as Revenue FROM opportunity
group by stage 
order by sum(revenue_amount) ;

-- 5. No of meeting By Account Exe
select Account_Executive, count(meeting_date) as Meeting_Count  from  meeting
group by Account_Executive
 order by count(meeting_date) ;

-- 6-Top Open Opportunity
select opportunity_name , max(revenue_amount) from opportunity
group by opportunity_name
order by max(revenue_amount) desc
limit 5 ;

 
-- 3.1Cross Sell--Target,Achive,new

SELECT 'Target' AS `Cross Sell`, SUM(Cross_Sell_Budget) AS Amount
FROM Individual_Budgets

UNION ALL

SELECT 'Achieve' AS `Cross Sell`, ROUND(SUM(Amount), 2) AS Amount
FROM (
    SELECT Amount FROM Brokerage WHERE income_class = 'Cross Sell'
    UNION ALL
    SELECT Amount FROM Fees WHERE income_class = 'Cross Sell'
) AS AchieveData

UNION ALL

SELECT 'New' AS `Cross Sell`, SUM(Amount) AS Amount
FROM Invoice
WHERE income_class = 'Cross Sell';

 -- 3.2 New-Target,Achive,new


SELECT 'Target' AS `New`, SUM(New_Budget) AS Amount
FROM Individual_Budgets

UNION ALL

SELECT 'Achieve' AS `New`, ROUND(SUM(Amount), 2) AS Amount
FROM (
    SELECT Amount FROM Brokerage WHERE income_class = 'New'
    UNION ALL
    SELECT Amount FROM Fees WHERE income_class = 'New'
) AS AchieveData

UNION ALL

SELECT 'New' AS `New`, SUM(Amount) AS Amount
FROM Invoice
WHERE income_class = 'New';

-- 3.3 Renewal-Target, Achive,new

SELECT 'Target' AS `Renewal`, SUM(Renewal_Budget) AS Amount
FROM Individual_Budgets

UNION ALL

SELECT 'Achieve' AS `Renewal`, ROUND(SUM(Amount), 2) AS Amount
FROM (
    SELECT Amount FROM Brokerage WHERE income_class = 'Renewal'
    UNION ALL
    SELECT Amount FROM Fees WHERE income_class = 'Renewal'
) AS AchieveData

UNION ALL

SELECT 'New' AS `Renewal`, SUM(Amount) AS Amount
FROM Invoice
WHERE income_class = 'Renewal';


