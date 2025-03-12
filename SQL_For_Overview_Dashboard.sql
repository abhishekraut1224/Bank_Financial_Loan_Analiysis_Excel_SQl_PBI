use Bank_loan_DB;
-- Total loan Application by month
select monthname(issue_date) as `MonthName`, 
count(id) as Total_loan_application,
sum(loan_amount) as Total_funded_amount,
sum(total_payment) as total_received_amount
from bank_loan_data
group by month(issue_date), monthname(issue_date)
order by month(issue_date);

-- Total loan applicatio by state 
select address_state as state,
count(id) as total_loan_appiction ,
sum(loan_amount) as Total_funded_amount,
sum(total_payment) as total_received_amount
from bank_loan_data
group by address_state;

-- Total loan application by term 
select term as Total_months, 
count(id) as total_loan_appiction,
sum(loan_amount) as Total_funded_amount,
sum(total_payment) as total_received_amount
from bank_loan_data
group by term;

-- Total loan application by Employee length
select emp_length as length_of_emp, 
count(id) as total_loan_appiction,
sum(loan_amount) as Total_funded_amount,
sum(total_payment) as total_received_amount
from bank_loan_data
group by emp_length;

-- total loan applicarion by purpose
select Purpose , 
count(id) as total_loan_appiction,
sum(loan_amount) as Total_funded_amount,
sum(total_payment) as total_received_amount 
from bank_loan_data
group by Purpose;

-- Total loan aplication by home ownership
select home_ownership , 
count(id) as total_loan_appiction,
sum(loan_amount) as Total_funded_amount,
sum(total_payment) as total_received_amount
from bank_loan_data
group by home_ownership;


