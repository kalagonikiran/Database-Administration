#Management(User management is the process of controlling which users are allowed to connect to the MySQL server and what permissions they have on each database. 
phpMyAdmin does not handle user management, rather it passes the username and password on to MySQL, 
which then determines whether a user is permitted to perform a particular action. Within phpMyAdmin, 
administrators have full control over creating users, viewing and editing privileges for existing users, and removing users.)


# Access control:example:Making an exception to the user definition of db_owner role you created,
you will modify privileges of this user so that this user won’t be able to update other columns except a specifc column of a specific table of a specific database.
You will restrict db_owner from updating all the other columns except the column Population of the table city of the database world.



#Security:AES (Advanced Encryption Standard) algorithm is a symmetric encryption where the same key is used to encrypt and decrypt the data. The AES standard permits various key lengths. By default, key length of 128-bits is used. Key lengths of 196 or 256 bits can be used. The key length is a trade off between performance and security. Let’s get started.

step 1:First, you will need to hash your passphrase (consider your passphrase is My secret passphrase) with a specific hash length (consider your hash length is 512) using a hash function (here you will use hash function from SHA-2 family). It is good practice to hash the passphrase you use, since storing the passphrase in plaintext is a significant security vulnerability. Use the following command in the terminal to use the SHA2 algorithm to hash your passphrase and assign it to the variable key_str:
SET @key_str = SHA2('My secret passphrase', 512);

step 2:
To encrypt the Percentage column, we will first want to convert the data in the column into binary byte strings of length 255
by entering the following command into the CLI:
ALTER TABLE countrylanguage MODIFY COLUMN Percentage varbinary(255); and then
UPDATE countrylanguage SET Percentage = AES_ENCRYPT(Percentage, @key_str);
for decryption
SELECT cast(AES_DECRYPT(Percentage, @key_str) as char(255)) FROM countrylanguage;









