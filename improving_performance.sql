/*To download the zip file containing the database, copy and paste the following into the Terminal:
wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0231EN-SkillsNetwork/datasets/employeesdb.zip
unzip employeesdb.zip
cd employeesdb
mysql --host=127.0.0.1 --port=3306 --user=root --password -t < employees.sql 
when prompted enter the password
*/
/*inside the mysql cli*/
use employees
show tables;
/*The EXPLAIN statement, which provides information about how MySQL executes your statement, will offer you insight about the number of rows your query is planning on looking through.
This statement can be helpful when your query is running slow. For example, is it running slow because it’s scanning the entire table each time?*/
EXPLAIN SELECT * FROM employees;
/*To begin, let’s take at the existing indexes. We can do that by entering the following command:*/
SHOW INDEX FROM employees;
/*Remember that indexes for primary keys are created automatically, as we can see above. An index has already been created for the primary key, 
emp_no. If we think about this, this makes sense because each employee number is unique to the employee, with no NULL values.
Now, let’s say we wanted to see all the information about employees who were hired on or after January 1, 2000. We can do that with the query:*/
SELECT * FROM employees WHERE hire_date >= '2000-01-01';
EXPLAIN SELECT * FROM employees WHERE hire_date >= '2000-01-01';
/*This query results in a scan of 299,423 rows, which is nearly the entire table!
By adding an index to the hire_date column, we’ll be able to reduce the query’s need to search through every entry of the table, instead only searching through what it needs.
You can add an index with the following:*/
CREATE INDEX hire_date_index ON employees(hire_date);
/*The CREATE INDEX command creates an index called hire_date_index on the table employees on column hire_date.
Create an Index on Hire Date
To check your index, you can use the SHOW INDEX command:*/
SHOW INDEX FROM employees;
SELECT * FROM employees WHERE hire_date >= '2000-01-01';
/*The difference is quite evident! Rather than taking about 0.17 seconds to execute the query, it takes 0.00 seconds—almost no time at all.
Now, if you want to remove the index, enter the following into the Terminal:*/
DROP INDEX hire_date_index ON employees;
/*Sometimes, you might want to run a query using the OR operator with LIKE statements. In this case, using a UNION ALL clause can improve the speed of your query,
particularly if the columns on both sides of the OR operator are indexed.

To start, let’s run this query:
This query searches for first names or last names that start with “C”. It returned 28,970 rows, taking about 0.20 seconds.
Check using the EXPLAIN command to see how many rows are being scanned!
Once more, we can see that almost all the rows are being scanned, so let’s add indexes to both the first_name and last_name columns.*/
SELECT * FROM employees WHERE first_name LIKE 'C%' OR last_name LIKE 'C%';
/*Try adding an index to both the first_name and last_name columns.*/

CREATE INDEX first_name_index ON employees(first_name);
CREATE INDEX last_name_index ON employees(last_name);
/*Please note, the name of your indexes (first_name_index and last_name_index) can be named differently.
You can also check to see if your indexes have been added with the SHOW INDEX command:
Add an Index to First Name and Last Name and Show Current Indexes*/
SELECT * FROM employees WHERE first_name LIKE 'C%' OR last_name LIKE 'C%';
EXPLAIN SELECT * FROM employees WHERE first_name LIKE 'C%' OR last_name LIKE 'C%';

/*Let’s use the UNION ALL clause to improve the performance of this query.
We can do this with the following:*/
SELECT * FROM employees WHERE first_name LIKE 'C%' UNION ALL SELECT * FROM employees WHERE last_name LIKE 'C%';
/*Sample UNION ALL Query*/

/*As we can see, this query only takes 0.11 seconds to execute, running faster than when we used the OR operator.
Using the EXPLAIN statement, we can see why that might be:
Sample EXPLAIN UNION ALL Query
As the EXPLAIN statement reveals, there were two SELECT operations performed, with the total number of rows scanned sitting at 54,790.
This is less than the original query that scanned the entire table and, as a result, the query performs faster.
Please note, if you choose to perform a leading wildcard search with an index, the entire table will still be scanned. You can see this yourself with the following query:*/

/*In general, it’s best practice to only select the columns that you need. For example, if you wanted to see the names and hire dates of the various employees, you could show that with the following query:*/
/*Selectivity*/
SELECT * FROM employees;
/*Sample Select All from Employees Table
If we, however, only wanted to see the names and hire dates, then we should select those columns:*/
SELECT first_name, last_name, hire_date FROM employees;










