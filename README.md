# Stack Exchange

## About
This Project aim is to replicate the internal database of stack exchange covering immportant aspect of the mentioned site such as multiple community support, Postx, edit version, user info, reputation etc.

# Creating and Loading the DB
- The Db can be craeated  using the create.sql file located inside the main folder
- There is about 100000 rows of data that has been retrived from actual stack exchange by using the inbuilt query tool. This is the data we are gonna load into our database
- Before loading the data, the conf.json file must be updated to include users postgres db config such as dbname, port and password, A dummy data is present in the conf.json file and must be replaced with users data configurgation 
- Run the main.go program, if Go lang is not installed, you can use the exe file which is generated  using the go binary of the file.
- This will load the data into the postgress db  and will take around 5-10mins to complete (Depending on the db server)

