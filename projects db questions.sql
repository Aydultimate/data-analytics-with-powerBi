-- QUESTIONS 

-- 1. What is the gender breakdown of employees in the company
select gender, count(*) as count
from hr
where age >= 18 and termdate = '0000-00-00'
group by gender;

-- 2. What is the race/ethnicity breakdown of employees in the company
select race, count(*) as count
from hr
where age >=18 and termdate = '0000-00-00'
group by race
order by count(*) desc;

-- 3. what is the age distribution of employess in the company?
select
	min(age) as youngest,
    max(age) as oldest
from hr
where age >=18 and termdate = '0000-00-00';

-- to know which age group has the highest number of employee and which one has the lowest
select
	case
		when age>=18 and age<=24 then '18-24'
        when age>=25 and age<=30 then '25-30'
        when age>=31 and age<=35 then '31-35'
        when age>=36 and age<=45 then '36-45'
        when age>=46 and age<=55 then '46-55'
        when age>=56 and age<=64 then '56-64'
        else '65+'
	end as age_group,
	count(*) as count
	from hr
	where age >= 18 and termdate = '0000-00-00'
    group by age_group
    order by age_group;

-- How is the gender distributed among the age group?
select
	case
		when age>=18 and age<=24 then '18-24'
        when age>=25 and age<=30 then '25-30'
        when age>=31 and age<=35 then '31-35'
        when age>=36 and age<=45 then '36-45'
        when age>=46 and age<=55 then '46-55'
        when age>=56 and age<=64 then '56-64'
        else '65+'
	end as age_group, gender,
	count(*) as count
	from hr
	where age >= 18 and termdate = '0000-00-00'
    group by age_group, gender
    order by age_group, gender;
    
-- 4. How many employees work at headquarters versus remote locations?
select location, count(*) as count
from hr
where age >= 18 and termdate = '0000-00-00'
group by location;

-- 5. The average length of employment for employess who have been terminated
select
	round(avg(datediff(termdate, hire_date))/365,0) as avg_len_of_employment
    from hr
    where termdate <= curdate() and termdate != '0000-00-00' and age >= 18;
    
-- 6. How does the gender disrtibution vary across departments and job titles
select department, gender, count(*) as count
from hr
where age >= 18 and termdate ='0000-00-00'
group by department, gender
order by department;

-- 7. what is the distribution of job  titles across the company
select jobtitle, count(*) as count
from hr
where age >= 18 and termdate ='0000-00-00'
group by jobtitle
order by jobtitle desc;

-- 8.  which department has the highest turnover rate
select department, total_count, terminated_count,
terminated_count/total_count as termination_rate
from(
	select department, count(*) as total_count, 
    sum(case when termdate != '00000-00-00' and termdate <= curdate() then 1 else 0 end) as
    terminated_count
    from hr
    where age > 18
    group by department
    ) as subquery
order by termination_rate desc;

-- what is the distribution of employees across location by cities and states
select location_state, count(*) as count
from hr
where age >= 18 and termdate ='0000-00-00'
group by location_state
order by count desc;

-- 10. How has the company's employees count changed overtime based on hire and termdate?
select 
year,
hires,
terminations,
hires - terminations as net_change,
round((hires - terminations)/hires * 100,2) as net_change_percent
from(
	select 
		YEAR(hire_date) as year,
        count(*) as hires,
        sum(case when termdate != '0000-00-00' and termdate <= curdate() then 1 else 0 end) as terminations
        from hr
        where age >= 18
        group by YEAR(hire_date)
        ) as subquery
	order by year asc;      -- to see from earliest year to latest
    
-- 11. what is the tenure distribution for each department?
select department, round(avg(datediff(termdate, hire_date)/365),0) as avg_tenure
from hr
where termdate != '0000-00-00' and termdate <= curdate() and age >= 18
group by department;