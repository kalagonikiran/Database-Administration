#(A logical backup creates a file containing DDL (such as create table) and DML commands (such as insert) that recreate the objects and data in the database.  
As such, you can use this file to recreate the database on the same or on another system. Generally, when you perform a logical backup and restore, 
you reclaim any wasted space from the original database since the restoration process creates a clean version of the tables. Logical backups enable you to backup granular objects. 
For example, you can back up an individual database table, however, you cannot use it to backup log files or database configuration settings. 
Suppose you are in a situation where you dropped one or more tables of a database accidentally. 
This is where you make use of the logical backup of a database table to restore the structure and data of the table.)
example:logical backup
mysqldump --host=127.0.0.1 --port=3306 --user=root --password world countrylanguage > world_countrylanguage_mysql_backup.sql
dropping a table:   
mysql --host=127.0.0.1 --port=3306 --user=root --password --execute="DROP TABLE world.countrylanguage;"
example:logical restore:
mysql --host=127.0.0.1 --port=3306 --user=root --password world < world_countrylanguage_mysql_backup.sql


#point-in-time backup(Say you have a full logical backup of your whole database in your last mysqldump file as of yesterday evening. 
However, several changes may have been made (including data loss) since then. 
Using point-in-time backup and restore, you can get each and every change that occurred since then, 
so that even after your last logical backup you have a record of all new transactions. 
Point-in-time backup is the set of binary log files generated subsequent to a logical backup operation of a database.
The binary log files contain events that describe database changes such as table creation operations or changes to table data. 
To restore a database to a point-in-time, you will be using binary log files containing changes of a database for a time interval along with the last logical backup of the database.)
example:
step 1:performing full backup
mysqldump --host=127.0.0.1 --port=3306 --user=root --password --flush-logs --delete-master-logs  --databases world > world_mysql_full_backup.sql
step 2:seeing binary files
mysql --host=127.0.0.1 --port=3306 --user=root --password --execute="SHOW BINARY LOGS;
step 3:writing log files to single log file
docker exec mysql-mysql-1 mysqlbinlog /var/lib/mysql/binlog.000003 /var/lib/mysql/binlog.000004 > logfile.sql
step 4:point in time backup
mysql --host=127.0.0.1 --port=3306 --user=root --password < world_mysql_full_backup.sql

#physical backup(A physical or raw backup creates a copy of all the physical storage files and directories that belong to a table,
database, or other object, including the data files, configuration files, and log files. Physical backups are often smaller and quicker than logical backups, 
so are useful for large or important databases that require fast recovery times. You will be performing a storage level snapshots as physical backup. 
This method is common for databases utilizing specialized cloud storage systems like the one you are using for this lab provide by the Skills Network Labs.)
example:
docker cp mysql-mysql-1:/var/lib/mysql  /home/project/mysql_backup
docker cp /home/project/mysql_backup/. mysql-mysql-1:/var/lib/mysql








