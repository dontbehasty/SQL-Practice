# SQL-Practice
Solve SQL query questions using a practice database on https://www.sql-practice.com/

The hospital database has 4 tables (patients, admissions, doctors, province_names)

<img src="/hospital.db schema.png" width="500"/>


# Databases & SQL Information

## Database
A database is an organized collection of structured information, or data, typically stored electronically in a computer system. A database is usually controlled by a database management system (DBMS).

## Database Management Systems (DBMS)
Is the software application that is used to manage databases. It serves as an interface between an end-user and a database, allowing users to create, read, update, and delete data in the database.

## Relational Database Management System (RDBMS)
RDBMS is an advanced version of a DBMS. It provides an interface between users and applications and the database, as well as administrative functions for managing data storage, access, and performance.
Examples: MySQL, PostgreSQL, SQL Server, Oracle, Microsoft Access

## Database Table
A table is responsible for storing data in the database. Database tables consist of rows and columns. Most relational databases contain many tables.
- Rows run horizontally. They represent each record. A row is the smallest unit of data that can be inserted into a database.
- Columns run vertically. They contain the definition of each field.

## Primary Key
The primary key constraint uniquely identifies each record in a table. It must contain unique values, and cannot contain null values. A table can have only one primary key; and in the table, this primary key can consist of single or multiple columns (fields).

## Foreign Key
The foreign key constraint is used to prevent actions that would destroy links between tables.
A foreign key is a field (or collection of fields) in one table, that refers to the primary key in another table.
The table with the foreign key is called the child table, and the table with the primary key is called the referenced or parent table. The foreign key constraint prevents invalid data from being inserted into the foreign key column, because it has to be one of the values contained in the parent table.

## Index
Indexes are used to retrieve data from the database more quickly than otherwise. The users cannot see the indexes, they are just used to speed up searches/queries. 

## SQL
SQL stands for Structured Query Language. It lets you access and manipulate databases.
- SQL can execute queries against a database
- SQL can retrieve data from a database
- SQL can insert records in a database
- SQL can update records in a database
- SQL can delete records from a database
- SQL can create new databases
- SQL can create new tables in a database
- SQL can create stored procedures in a database
- SQL can create views in a database
- SQL can set permissions on tables, procedures, and views

## DDL - Data Definition Language.
It is used to create database scheme and define the structure of a database. DDL is used to create and modify database objects like tables, indexes, views, and constraints. But is not used to manipulate data directly. DDL statements are typically executed by database administrators.

Examples of DDL commands:
- CREATE 
- ALTER 
- DROP 
- TRUNCATE 
- RENAME

## DML - Data Manipulation Language
It is used to add, retrieve or update the data. DML is used to manipulate the data within the database. DML statements are typically executed by application developers or end-users.

Examples of DML commands: 
- SELECT
- INSERT
- UPDATE
- DELETE
- MERGE
