# Employee-Management-System(EMS)
📌 Project Overview

The Employee Management System (EMS) is a SQL-based relational database project designed to manage and analyze employee information within an organization.

This project demonstrates database design, table relationships, and business insights using SQL queries.

The system tracks:

👨‍💼 Employees
🏢 Departments & Job Roles
💰 Salaries & Bonuses
📅 Leaves & Absences
🎓 Employee Qualifications
🧾 Payroll Information

The project also includes analytical SQL queries to generate insights from the database.

🗄️ Database Architecture

The EMS database consists of 6 interconnected tables.

Table	Description
👨‍💼 Employee	Stores employee personal information
🏢 JobDepartment	Stores department and job role details
💰 SalaryBonus	Salary and bonus structure
🎓 Qualification	Employee qualifications and skills
📅 Leaves	Employee leave records
🧾 Payroll	Employee payroll transactions

All tables are connected using Primary Keys and Foreign Keys to maintain data integrity and relational structure.

🧱 Database Tables
👨‍💼 Employee

Stores personal details of employees.

Columns

emp_ID

firstname

lastname

gender

age

contact_add

emp_email

emp_pass

Job_ID

🏢 JobDepartment

Stores job roles and department information.

Columns

Job_ID

jobdept

name

description

salaryrange

💰 SalaryBonus

Stores salary and bonus details.

Columns

salary_ID

Job_ID

amount

annual

bonus

🎓 Qualification

Stores employee qualifications.

Columns

QualID

Emp_ID

Position

Requirements

Date_In

📅 Leaves

Tracks employee leave records.

Columns

leave_ID

emp_ID

date

reason

🧾 Payroll

Stores payroll transactions.

Columns

payroll_ID

emp_ID

job_ID

salary_ID

leave_ID

date

report

total_amount

📊 SQL Data Analysis

This project includes multiple analytical SQL queries to generate business insights.

👥 Employee Insights

✔ Total number of employees
✔ Department-wise employee distribution
✔ Average salary per department
✔ Top 5 highest paid employees
✔ Total salary expenditure

🏢 Department Analysis

✔ Number of roles in each department
✔ Average salary per department
✔ Highest salary roles
✔ Department salary distribution

🎓 Qualification Analysis

✔ Employees with qualifications
✔ Most common qualifications
✔ Employees with highest qualifications

📅 Leave Analysis

✔ Leave trends by year
✔ Average leaves per department
✔ Employees with highest leaves
✔ Total leaves taken

💰 Payroll & Compensation Analysis

✔ Monthly payroll spending
✔ Department-wise bonus analysis
✔ Highest bonus distribution
✔ Average final salary by department

🛠️ Technologies Used
Tool	Purpose
🗄️ MySQL	Database management
📊 SQL	Data querying & analysis
🧠 Relational Database Design	Table relationships
📂 Project Structure
Employee-Management-System
│
├── EMSproject.sql
├── EMS-ER.pdf
└── README.md
💡 Skills Demonstrated

🔹 SQL Query Writing
🔹 Database Design
🔹 Data Analysis using SQL
🔹 Relational Database Modeling
🔹 Business Insights Extraction

🚀 Future Improvements

✨ Build a Power BI dashboard
✨ Create a web interface for EMS
✨ Add employee performance analytics
✨ Implement stored procedures and triggers

👩‍💻 Author

Jeevana

📊 Data Analyst
💻 SQL | Python | Power BI

⭐ Support

If you like this project:

⭐ Star this repository on GitHub
