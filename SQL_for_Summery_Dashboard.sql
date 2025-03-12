create database Bank_loan_DB;
use Bank_loan_DB;
select * from bank_loan_data;
alter table bank_loan_data add primary key (id);



-- ==========================================================================
-- KPI's
/* MTD means from the start of the month to current date 
here our Dec is the last month of the data thats why DEC of the 2021 is our MTD 
and NOV of 2021 is our Prev-MTD
-- ==========================================================================

-- 1). Total Loan Applications
select count(id) as total_oan_application from bank_loan_data;
DESCRIBE bank_loan_data;

-- Month_to_date(MTD) mean last month applications
select count(id) as MTD_Loan_applications from bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021;

-- Previous Month to date loan application
select count(id) as Prev_MTD_Loan_applications from bank_loan_data
where month(issue_date) = 11 and year(issue_date) = 2021;

-- 2). Total Funded amount in million
select concat(round(sum(loan_amount/1000000),2), ' M') as total_funded_amount from bank_loan_data;


-- Total MTD_Funded amount in million
select concat(round(sum(loan_amount/1000000),2), ' M') as MTD_total_funded_amount from bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021;

-- Total Prev_MTD_Funded amount in million
select concat(round(sum(loan_amount/1000000),2), ' M') as MTD_total_funded_amount from bank_loan_data
where month(issue_date) = 11 and year(issue_date) = 2021;

-- 3). Total amount received
select concat(round(sum(total_payment/1000000),2), ' M') as MTD_total_funded_amount from bank_loan_data;

-- Total MTD_amount received
select concat(round(sum(total_payment/1000000),2), ' M') as Prev_MTD_total_funded_amount from bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021;

-- Total Prev_MTD_amount received
select concat(round(sum(total_payment/1000000),2), ' M') as MTD_total_funded_amount from bank_loan_data
where month(issue_date) = 11 and year(issue_date) = 2021;


-- 4). Avg interest rate
select concat(round(avg(int_rate)*100,2), " %") avg_interest_rate from bank_loan_data;

-- MTD avg interest rate
select concat(round(avg(int_rate)*100,2), " %") avg_interest_rate from bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021;

-- Prev_MTD_int_rate
select concat(round(avg(int_rate)*100,2), " %") avg_interet_rate from bank_loan_data
where month(issue_date) = 11 and year(issue_date) = 2021;

-- 5). AVG Dept_to_Income Ratio 

-- --> used by banks and financial institutions to assess a borrower's ability to manage debt and repay loans.

select round(avg(dti)*100, 2) as Avg_DTI from bank_loan_data;

/*
 ✅ A DTI below 35% is considered healthy and increases your chances of loan approval.
 ⚠️ A DTI above 43% is risky and may result in loan rejection or higher interest rates.
 ❌ A DTI above 50% is a warning sign that you may struggle with debt repayment.
*/

-- MTD AVG Dept_to_Income Ratio
select round(avg(dti)*100, 2) as Avg_DTI from bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021;

-- Prev_MTD AVG Dept_to_Income Ratio
select round(avg(dti)*100, 2) as Avg_DTI from bank_loan_data
where month(issue_date) = 11 and year(issue_date) = 2021;


-- ======================================================================
-- Good Loan vs Bad Loan Kpi's
-- ======================================================================

select * from bank_loan_data;

select distinct(loan_status) from bank_loan_data;




/*
 we have Good and Bad Loan type of loans in loan_Status
1. Good Loan
Fully paid -- repay all the loan -- 
Current -- that me they are paying the loan

2. Bad Loan
Charges Off -- Defaulters people -- Bad Loan
*/

-- Good Loan Kpi's

-- 1. Good Loan Application Percentage 
select concat(round(
	(select count(ID) from bank_loan_data
	where loan_status IN ("Fully Paid", "Current"))
	/
	(select count(id) from bank_loan_data) * 100, 
1), " %") as good_loan_Applicaion_percntage;

-- Better wrt to Performance and readability
select 
	concat(round((count(case	
			when loan_status in ("Fully Paid" ,"Current") then id end)
	/
    count(id)) * 100, 2), " %")  as good_loan_Applicaion_percntage
from bank_loan_data ;


-- 2. Good loan Applications
select count(id) as Good_loan_Applications from bank_loan_data
where loan_status in ("Fully Paid" ,"Current") ;

-- 3. Good Loan Funded Amount in Million
select concat(round(sum(loan_amount)/1000000,2), "M") as Good_Loan_Funded_Amount from bank_loan_data
where loan_status in ("Fully Paid" ,"Current");

-- 4. Good loan Total Received Amount in Million
select concat(round(sum(total_payment)/1000000,2), "M") as Good_Loan_Received_Amount from bank_loan_data
where loan_status in ("Fully Paid" ,"Current");


-- Bad Loan KPI's
-- 1. Bad Loan Application Percentage 

select 
	concat(round((count(case	
			when loan_status = "Charged Off" then id end)
	/
    count(id)) * 100, 2), " %")  as Bad_loan_Applicaion_percntage
from bank_loan_data ;


-- 2. Bad loan Applications
select count(id) as Bad_loan_Applications from bank_loan_data
where loan_status = "Charged Off" ;

-- 3. Bad Loan Funded Amount in Million
select concat(round(sum(loan_amount)/1000000,2), "M") as Bad_Loan_Funded_Amount from bank_loan_data
where loan_status = "Charged Off";

-- 4. Bad loan Total Received Amount in Million
select concat(round(sum(total_payment)/1000000,2), "M") as Bad_Loan_Received_Amount from bank_loan_data
where loan_status = "Charged Off";

-- ====================================================================================
-- Loan Status Gride View

/* In order to gain a comprehensive overview of our leading operations and monitor the performance of loans, 
 we aim to create grideview report categorized by "Loan Status"
 by proiding insights into matrics such as 
 'Total Loan Applications,' 'Total Funded Amount,' 'Total Amount Received,' 'Month-to-Date (MTD) Funded Amount,' 
 'MTD Amount Received,' 'Average Interest Rate,' and 'Average Debt-to-Income Ratio (DTI),'
 this grid view will empower us to make data-driven decisions and assess the health of our loan portfolio.
 */
-- ====================================================================================

create view Loan_Status as
select loan_status,
	   count(ID) as Total_loan_application,
	   sum(loan_amount) as Total_funded_amount,
       sum(total_payment) as Total_amount_received,
       sum(case when month(issue_date) = 12 and year(issue_date) = 2021 then loan_amount end) as MTD_Funded_Amount,
       sum(case when month(issue_date) = 12 and year(issue_date) = 2021 then total_payment end) as MTD_Amount_received,
       round(avg(int_rate)*100, 2) as Avg_interest_rate,
       round(Avg(dti)*100,2) as avg_DTI
from bank_loan_data
group by loan_status
order by loan_status desc;

select * from Loan_Status;


-- =========================================================================


-- --> most of the bad loans are for which Purpose

set sql_safe_updates = 0;

select distinct loan_status, GoodLoan_and_BadLoan from bank_loan_data;
alter table bank_loan_data add column GoodLoan_and_Badloan varchar(50);

update bank_loan_data
set GoodLoan_and_BadLoan = 
	case when loan_status = "Fully Paid" or loan_status = "Current" then "Good Loan"
    else "Bad Loan"
end;




select * from bank_loan_data;

select loan_status, GoodLoan_and_BadLoan, Purpose from bank_loan_data
where GoodLoan_and_BadLoan = "Bad Loan";


