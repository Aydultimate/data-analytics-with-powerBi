create database projects;

use projects;

select *  from
hr;

# rename id column
alter table hr
change column ï»¿id emp_id varchar(20) null;

# check datatypes for all our columns
describe hr;

# change datatype
alter table hr
modify column birthdate date,
modify column hire_date date;
 
select distinct department from hr ;

set sql_safe_updates = 0;

update hr
set birthdate = case
when birthdate like '%/%' then date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
when birthdate like '%-%' then date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
else null
end;

update hr
set hire_date = case
when hire_date like '%/%' then date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
when hire_date like '%-%' then date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
else null
end;

alter table hr
add termdate date;

#update hr
#set termdate = case
#when termdate like '%-%' then date_format(str_to_date(termdate, '%Y-%m-%d'))
#else null
#end;

update hr
set termdate = date_format(termdate, '%Y-%m-%d');

-- avoid null values
set sql_mode = '';

update hr
set termdate = '0000-00-00' where emp_id != '00-0037846' and emp_id != '00-0037846'
and emp_id != '00-0472287' and emp_id != '01-6322845' and emp_id != '02-3429255'
and emp_id != '03-2751365' and emp_id != '04-5106789' and emp_id != '04-4554597' and  
emp_id != '02-8015603' and emp_id != '01-6322845' and emp_id != '01-2387075';

update hr
 set termdate = '2020-09-12' where emp_id = '00-0037846';
 update hr
 set termdate = '2017-03-12' where emp_id = '00-0472287';
update hr
 set termdate = '2018-09-12' where emp_id = '01-6322845';
update hr
 set termdate = '2022-09-12' where emp_id = '02-3429255';
update hr
 set termdate = '2023-09-12' where emp_id = '03-2751365';
update hr
 set termdate = '2016-09-12' where emp_id = '04-5106789';
update hr
 set termdate = '2010-09-12' where emp_id = '04-4554597';
update hr
 set termdate = '2021-09-12' where emp_id = '02-8015603';
update hr
 set termdate = '2012-09-12' where emp_id = '01-6322845';
update hr
 set termdate = '2020-10-12' where emp_id = '01-2387075';


#create age column
alter table hr
add age int;

#fill age column
update hr
set age =timestampdiff(year, birthdate, curdate());

#to check for age outliers
select 
	min(age) as youngest,
	max(age) as oldest
from hr;

select count(*) from hr
where age<0;	#we can exclude them during our analysis


