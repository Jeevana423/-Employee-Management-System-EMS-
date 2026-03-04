create database EMS;
use EMS;
-- Table 1: Job Department
CREATE TABLE JobDepartment (
    Job_ID INT PRIMARY KEY,
    jobdept VARCHAR(50),
    name VARCHAR(100),
    description TEXT,
    salaryrange VARCHAR(50)
);
-- Table 2: Salary/Bonus
CREATE TABLE SalaryBonus (
    salary_ID INT PRIMARY KEY,
    Job_ID INT,
    amount DECIMAL(10,2),
    annual DECIMAL(10,2),
    bonus DECIMAL(10,2),
    CONSTRAINT fk_salary_job FOREIGN KEY (job_ID) REFERENCES JobDepartment(Job_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);
-- Table 3: Employee
CREATE TABLE Employee (
    emp_ID INT PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    gender VARCHAR(10),
    age INT,
    contact_add VARCHAR(100),
    emp_email VARCHAR(100) UNIQUE,
    emp_pass VARCHAR(50),
    Job_ID INT,
    CONSTRAINT fk_employee_job FOREIGN KEY (Job_ID)
        REFERENCES JobDepartment(Job_ID)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- Table 4: Qualification
CREATE TABLE Qualification (
    QualID INT PRIMARY KEY,
    Emp_ID INT,
    Position VARCHAR(50),
    Requirements VARCHAR(255),
    Date_In DATE,
    CONSTRAINT fk_qualification_emp FOREIGN KEY (Emp_ID)
        REFERENCES Employee(emp_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Table 5: Leaves
CREATE TABLE Leaves (
    leave_ID INT PRIMARY KEY,
    emp_ID INT,
    date DATE,
    reason TEXT,
    CONSTRAINT fk_leave_emp FOREIGN KEY (emp_ID) REFERENCES Employee(emp_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table 6: Payroll
CREATE TABLE Payroll (
    payroll_ID INT PRIMARY KEY,
    emp_ID INT,
    job_ID INT,
    salary_ID INT,
    leave_ID INT,
    date DATE,
    report TEXT,
    total_amount DECIMAL(10,2),
    CONSTRAINT fk_payroll_emp FOREIGN KEY (emp_ID) REFERENCES Employee(emp_ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_payroll_job FOREIGN KEY (job_ID) REFERENCES JobDepartment(job_ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_payroll_salary FOREIGN KEY (salary_ID) REFERENCES SalaryBonus(salary_ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_payroll_leave FOREIGN KEY (leave_ID) REFERENCES Leaves(leave_ID)
        ON DELETE SET NULL ON UPDATE CASCADE
);
show tables;
select * from employee;
select * from jobdepartment;
select * from leaves;
select * from payroll;
select * from qualification;
select * from salarybonus;


----- Analysis
----- 1.EMPLOYEE INSIGHTS
-- 1
SELECT COUNT(*) AS UNIQYE_EMP FROM EMPLOYEE E;
-- 2
SELECT J.JOBDEPT,COUNT(E.EMP_ID) AS EMPLOYEE_COUNT 
FROM EMPLOYEE e
JOIN JOBDEPARTMENT J ON E.JOB_ID=J.JOB_ID
GROUP BY J.JOBDEPT
ORDER BY EMPLOYEE_COUNT DESC;
-- 3
SELECT j.jobdept,AVG(s.amount) as avg_salary
from jobdepartment j
join salarybonus s on j.job_id = s.job_id
group by j.jobdept
order by avg_salary asc;

-- 4
select e.emp_id,e.firstname,e.lastname,s.amount as max_salary
from employee e
join salarybonus s on e.job_id=s.job_id
order by max_salary desc
limit 5;

-- 5
select sum(s.amount) as total_salary_expenditure
from employee e
join salarybonus s on e.job_id = s.job_id;

----- 2.JOB ROLE AND DEPARTMENT ANALYSIS
-- 1
select jobdept,count(distinct name) as no_of_roles
from jobdepartment
group by jobdept;

-- 2
select j.jobdept,avg(s.amount) as avg_salary 
from jobdepartment j 
join salarybonus s on j.job_id = s.job_id
group by j.jobdept;

-- 3
select j.name,j.jobdept,s.amount as highest_salary 
from jobdepartment j
join salarybonus s on j.job_id = s.job_id
order by highest_salary desc;

-- 4
select j.jobdept,sum(s.amount) as highest_total_salary 
from jobdepartment j 
join salarybonus s on j.job_id = s.job_id
group by j.jobdept
order by highest_total_salary desc;

-------- 3.qualification & skills analysis
-- 1
select count(distinct emp_id) as employees_with_qualification
from qualification;

-- 2
select position,count(*) as qualification_count
from qualification
group by position
order by qualification_count desc;

-- 3
select e.emp_id,e.firstname,e.lastname,count(q.requirements) as highest_num_qualification
from employee e
join qualification q on e.emp_id = q.emp_id
group by e.emp_id,e.firstname,e.lastname
order by highest_num_qualification desc;

----------- 4. leave & absence 
-- 1
select year(date) as leave_year,count(distinct emp_id) as emp_id
from leaves
group by leave_year
order by emp_id desc;

-- 2
select j.jobdept,avg(sub.emp_leave_count) as avg_leave
from (
select e.emp_id,e.job_id,count(l.leave_id) as emp_leave_count
from employee e
join leaves l on e.emp_id = l.emp_id 
group by e.emp_id,e.job_id)
as sub
join jobdepartment j on sub.job_id=j.job_id
group by j.jobdept;

-- 3
select e.emp_id,e.firstname,e.lastname,count(l.leave_id) as highest_leaves
from employee e
join leaves l on e.emp_id=l.emp_id
group by e.emp_id,e.firstname,e.lastname
order by highest_leaves desc;

-- 4
select count(*) as total_leaves from leaves;

-- 5
select e.emp_id,count(l.leave_id) as total_leaave,sum(p.total_amount) as total_payment
from employee e
left join leaves l on e.emp_id=l.emp_id
left join payroll p on l.emp_id=p.emp_id
group by e.emp_id;

----------- payroll & compensation
-- 1
select year(date),month(date),sum(total_amount) as amount
from payroll 
group by year(date),month(date)
order by amount desc;

-- 2
select j.jobdept,avg(s.bonus) as avg_bonus
from jobdepartment j
join salarybonus s on j.job_id=s.job_id
group by j.jobdept;

-- 3
select j.jobdept,sum(s.bonus) as highest_bonus
from jobdepartment j
join salarybonus s on j.job_id = s.job_id
group by j.jobdept
order by highest_bonus desc;

-- 4
select j.jobdept,avg(p.total_amount) as avg_final_salary 
from payroll p 
join jobdepartment j on p.job_id=j.job_id
group by j.jobdept
order by avg_final_salary desc;