# food_delivery_data_pipeline
Project Overview

This project was created to simulate a simple real-world data pipeline. The main goal was to take raw food delivery data, clean and transform it, and store it in a structured relational database for further analysis.

The project follows the ETL (Extract – Transform – Load) process:

Extract → load raw data from CSV files
Transform → clean and organize the data
Load → insert cleaned data into a database

After loading the data, SQL queries were used to analyze customer behavior, restaurant performance, delivery times, and payment trends.
The dataset used in this project is a Food Delivery Dataset downloaded from Kaggle.

The dataset contains information about:

Customer orders
Restaurants
Payment methods
Delivery times
Customer ratings
Food categories and cuisines

The raw data is stored inside the data/ folder.

ETL Pipeline Description
1. Extract

The extraction step reads raw CSV files using pandas.

The following datasets are loaded:

orders.csv
restaurants.csv

This step is implemented in:
app/extract.py

2. Transform

The transformation step prepares the raw data for database storage.

The following preprocessing steps were applied:

Removed duplicate records
Created a CustomerID because the dataset only contained customer names
Split raw data into separate tables
Renamed columns for consistency

The data was normalized into four tables:

Customers

Stores customer information.

Restaurants

Stores restaurant details such as cuisine, zone, and category.

Orders

Stores order-related information such as payment method, order amount, and delivery time.

Order Details

Stores order quantities and customer ratings.

This step is implemented in:

app/transform.py
3. Load

After transformation, the cleaned data is inserted into a SQLite database.

Database file:

food_delivery.db

The loading process is implemented in:

app/load.py
Database Schema

The database consists of four related tables:

customers
restaurants
orders
order_details

Relationships are created using primary keys and foreign keys to avoid unnecessary duplication and improve data organization.

Data Cleaning and Preprocessing

Several preprocessing steps were performed:

Duplicate rows were removed
Customer IDs were generated from customer names
Column names were standardized
Data was split into relational tables
Data consistency between orders and restaurants was maintained

These steps helped organize the data into a cleaner and more structured format for SQL analysis.
