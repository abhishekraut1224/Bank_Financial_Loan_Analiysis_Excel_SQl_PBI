# Bank_Financial_Loan_Analiysis. 

# What Problm I are solving in this project 

### A financial institution needed insights into its data to understand better loan performance, applicant behavior, and regional trends. 

### My Goal
My task was to analyze the loan dataset and create a dashboard that highlights key metrics like:

Total loan applications

Funded amount vs amount received

Average interest rates

Debt-to-income ratios

And breakdowns of good vs bad loans, loan purposes, and regional performance


## The Dashboard is divided into 3 parts 
### 1) Summary
![image](https://github.com/user-attachments/assets/94281c72-8fb6-4a2a-9128-37434822c6d2)

### Slicers
1)  Purpose 
2)  Grade 
3)  State

### 2) Overview
![image](https://github.com/user-attachments/assets/0b52ac18-d6c0-4d86-80a5-4f25bbe62d23)

### Slicers
1) Select Measure -->
                 Total Amount received
                 Total Funded Amount
                 Total Loan Application
2) Good loan vs Bad Loan
3) Grade
4) State

#### so the whole dashboard will change for the slicer

### 3)Details
![image](https://github.com/user-attachments/assets/d2f64e7a-fe39-4afc-abda-efc4b41ce396)

### Slicers
1) Good vs Bad Loan
2) Grade
3) State


## Tools and use case
I used a combination of Excel, SQL, and Power BI:

In Excel, I cleaned the raw CSV data, handled missing values, and did initial exploration.

Using SQL, I wrote queries to extract KPIs like monthly loan applications, funded amounts, and average DTI. I also used SQL to validate the backend data logic powering the dashboard.

Finally, I used Power BI to design a 3-page dashboard:

Summary for high-level KPIs,

Overview for monthly and regional trends,

Details for deeper insights like loan purposes, employment length, and home ownership.



## Conclusion
The dashboard provided clear insights:

Identified that most loans were issued in states like California and Texas,

Found that good loans outnumbered bad loans significantly,

And showed that customers with longer employment length had a lower default rate.
These insights help the bank improve risk assessment and target the right customer segments.

#### Attachments
- SQL Queries File
- PowerPoint Presentation
- Power BI Report
- Dataset (CSV)
- README File
- My Approach
