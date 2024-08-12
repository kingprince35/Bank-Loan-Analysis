use bankloan;
-- Total Loan Applications
select count(*) from financial_loan;
-- ANS :- 38576

-- MTD loan applications (MTD = Month to date)
select count(*) from financial_loan where Month(issue_date) = 12 AND YEAR(issue_date) = 2021; 
-- ANS :- 4314

-- PMTD Loan applications (PMTD = Previous month to date)
select count(*) from financial_loan where Month(issue_date) = 11 AND YEAR(issue_date) = 2021; 
-- ANS :- 4035

-- Total Funded (loan amount)
select sum(loan_amount) from financial_loan;
-- ANS :- 435,757,075

-- MTD Total Funded (loan amount)
select sum(loan_amount) from financial_loan where Month(issue_date) = 12;
-- ANS :- 53,981,425

-- PMTD Total Funded (loan amount)
select sum(loan_amount) from financial_loan where Month(issue_date) = 11;
-- ANS :- 47,754,825

-- Total Amount recieved
select sum(total_payment) as Total_Amount from financial_loan;
-- ANS :- 473070933

-- MTD Total amount Recieved
select sum(total_payment) as MTD_Amount from financial_loan where Month(issue_date) = 12;
-- ANS :- 58074380

-- PMTd Total amount recieved
select sum(total_payment) as PMTD_Amount from financial_loan where Month(issue_date) = 11;
-- ANS :- 50132030

-- Average Interest Rate
select avg(int_rate)*100 as avg_interest from financial_loan;
-- ANS :- 12.04883130

-- MTD AVG Interest Rate
select avg(int_rate)*100 as mtd_avg_int_rate from financial_loan where MONTH(issue_date) = 12;
-- ANS :- 12.35604070

-- PMTD AVG Interest Rate
select avg(int_rate)*100 as pmtd_avg_int_rate from financial_loan where MONTH(issue_date) = 11;
-- ANS :- 11.94171740

-- GOOD LOAN VS BAD LOAN

-- Good Loan Per.
select (count(case when loan_status = "Fully Paid" OR loan_status ="Current" then id end)*100)/count(id) as Good_loan_percentage from financial_loan;
-- ANS :- 86.1753

-- Good Loan Applications
select count(id) as Good_loan_application from financial_loan where loan_status = "Fully Paid" OR loan_status = "Current";
-- ANS :- 33243

-- Good Loan fund Amount
select sum(loan_amount) as Good_loan_amount from financial_loan where loan_status = "Fully Paid" OR loan_status = "Current";
-- ANS :- 370224850

-- Good Loan Amount Recieved
select sum(total_payment) as Good_loan_amount from financial_loan where loan_status = "Fully Paid" OR loan_status = "Current";
-- ANS :- 435786170

-- Bad Loan per.
select (count(case when loan_status="Charged off" then id end)*100)/count(id) as Bad_loan_percentage from financial_loan;
-- ANS :- 13.8247

-- Bad Loan Applications;
select count(id) from financial_loan where loan_status = "Charged off";
-- ANS :- 5333

-- Bad Loan Funded Amount
select sum(loan_amount) as Bad_loan_funded_amount from financial_loan where loan_status = "Charged off";
-- ANS :- 65532225

-- Bad Loan Amount Recieved
select sum(total_payment) as Bad_loan_amount_recieved from financial_loan where loan_status = "Charged off";
-- ANS :- 37284763	

-- LOAN STATUS

select loan_status, count(id) as LoanCount, sum(total_payment) as Total_amouint_recieved, sum(loan_amount) as Total_amount, avg(int_rate)*100 as Interest_rate, avg(dti)*100 as DTI from financial_loan group by loan_status;
-- ANS:- 
-- Charged Off	5333	37284763	65532225	13.87857490	 14.00473270
-- Fully Paid	32145	411586256	351358350	11.64107070	 13.16735070
-- Current	    1098	24199914	18866500	15.09932600	 14.72434420

select loan_status , sum(total_payment) as MTD_total_amount_recieved , sum(loan_amount) as MTD_total_funded from financial_loan where MONTH(issue_date) = 12 group by loan_status;
-- ANS :-
-- Fully Paid	47815851	41302025
-- Charged Off	5324211	    8732775
-- Current	    4934318	    3946625

-- Month wise total Amount recieved, total amount fund, Total Loan application.
select month(issue_date) as Month_number,monthname(issue_date) as Month_name,sum(loan_amount) as Total_amount,sum(total_payment) as Total_amount_recieved from financial_loan group by Month_number,Month_name order by 1;

-- State wise total Amount recieved, total amount fund
select address_state as state, count(id) as Total_loan_applications, sum(loan_amount) as Total_amount,sum(total_payment) as Total_amount_recieved from financial_loan group by address_state order by 1;

-- Term wise
select term, count(id) as Total_loan_applications, sum(loan_amount) as Total_amount,sum(total_payment) as Total_amount_recieved from financial_loan group by term order by 1;

-- Employee length 
select emp_length, count(id) as Total_loan_applications, sum(loan_amount) as Total_amount,sum(total_payment) as Total_amount_recieved from financial_loan group by emp_length order by 1;

-- Purpose 
select purpose, count(id) as Total_loan_applications, sum(loan_amount) as Total_amount,sum(total_payment) as Total_amount_recieved from financial_loan group by purpose order by 1;

-- Home Ownership
select home_ownership, count(id) as Total_loan_applications, sum(loan_amount) as Total_amount,sum(total_payment) as Total_amount_recieved from financial_loan group by home_ownership order by 1;

-- Profitability Analysis by  Loan Grade
select grade ,sum(total_payment - loan_amount) as total_profit , avg(int_rate)*100 as avg_int_rate from financial_loan group by grade order by 1;

-- Risk analysis by Loan term
select term , count(*) as Total_loans , sum(case when loan_status = "Charged Off" then 1 else 0 end) as Charged_off_loans,(sum(case when loan_status = "Charged Off" then 1 else 0 end)/count(*))*100 as Charged_off_rate from financial_loan group by term order by 3;