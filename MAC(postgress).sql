#In the PostgreSQL CLI, type in the command \i <file_name>. In your case, the filename will be the name of the file you downloaded, flights_RUSSIA_small.sql. This will restore the data into a new database called demo.
#In PostgreSQL, users, groups, and roles are all the same entity, with the difference being that users can log in by default.
#In this exercise, you will create two new roles: read_only and read_write, then grant them the relevant privileges.
#To begin, ensure that you have the PostgreSQL Command Line Interface open and connected to the demo database, as such:
#PostgreSQL CLI

#Create a read_only role and grant it privileges
#To create a new role named read_only, enter the following command into the CLI:
CREATE ROLE read_only;

#First, this role needs the privilege to connect to the demo database itself. To grant this privilege, enter the following command into the CLI:
GRANT CONNECT ON DATABASE demo TO read_only;

#Next, the role needs to be able to use the schema in use in this database. In our example, this is the bookings schema. Grant the privilege for the read_only role to use the schema by entering the following:
GRANT USAGE ON SCHEMA bookings TO read_only;

#To access the information in tables in a database, the SELECT command is used. For the read_only role, we want it to be able to access the contents of the database but not to edit or alter it. So for this role, 
#only the SELECT privilege is needed. To grant this privilege, enter the following command:
GRANT SELECT ON ALL TABLES IN SCHEMA bookings TO read_only;
#This allows the read_only role to execute the SELECT command on all tables in the bookings schema.

#Create a read_write role and grant it privileges #Similarly, create a new role called read_write with the following command in the PostgreSQL CLI:
CREATE ROLE read_write;

#As in Task A, this role should first be given the privileges to connect to the demo database. Grant this privilege by entering the following command:
GRANT CONNECT ON DATABASE demo TO read_write;

#Give the role the privileges to use the bookings schema that is used in the demo database with the following:
GRANT USAGE ON SCHEMA bookings TO read_write;

#So far the commands for the read_write role have been essentially the same as for the read_only role.
GRANT SELECT, INSERT, DELETE, UPDATE ON ALL TABLES IN SCHEMA bookings TO read_write;


##Add a New User and Assign them a Relevant Role
#To create a new user named user_a, enter the following command into the PostgreSQL CLI:
CREATE USER user_a WITH PASSWORD 'user_a_password';

#In practice, you would enter a secure password in place of ‘user_a_password’, which will be used to access the database through this user.

#Next, assign user_a the read_only role by executing the following command in the CLI:

GRANT read_only TO user_a;

#You can list all the roles and users by typing the following command: \du

##Suppose there is no need for the information and help desk at the airport to access information stored in the aircrafts_data table. In this exercise, you will revoke the SELECT privilege on the aircrafts_data table in the demo database from user_a.
#You can use the REVOKE command in the Command Line Interface to remove specific privileges from a role or user in PostgreSQL. 
REVOKE SELECT ON aircrafts_data FROM user_a;

#Now suppose user_a is transferred departments within the airport and no longer needs to be able to access the demo database at all. You can remove all their SELECT privileges by simply revoking the read_only role you assigned to them earlier. You can do this by entering the following command in the CLI:
REVOKE read_only FROM user_a;

#Now you can check all the users and their roles again to see that the read_only role was successfully revoked from user_a by entering the following command again: \du




