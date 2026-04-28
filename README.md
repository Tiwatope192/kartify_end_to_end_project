# Kartify End-to-End Data Engineering & Analytics Project

## Overview
This project implements an end-to-end data pipeline for a simulated e-commerce platform (Kartify), transforming raw transactional data into analytics-ready datasets and business dashboards.

The pipeline follows a modern ELT approach and applies the **Medallion Architecture (Bronze, Silver, Gold)** to progressively refine data quality and structure for analytical use.

> **Note:** Kartify is a simulated e-commerce platform developed for this project.  
> All data modeling and transformations were performed directly in Snowflake using SQL, without the use of dbt, to demonstrate hands-on data warehouse design and transformation workflows.

## Project Objectives
- Build a structured data pipeline from raw data to analytics-ready tables  
- Apply Medallion Architecture for data transformation  
- Design reliable and reusable data models  
- Create business-focused dashboards for decision-making  
- Demonstrate best practices in data engineering and analytics
  
 ## Repository Structure
kartify_end_to_end_project/
## Project Workflow
1. **Documentation & Data Modeling** → `01_docs/`  
2. **Data Exploration & Ingestion** → `02_notebooks/`  
3. **Data Transformation (Medallion Architecture)** → `03_sql/`  
4. **Visualization & Dashboards** → `04_dashboards/`  
  
## Data Pipeline Architecture
The project is structured into the following stages:

### 1. Data Ingestion (Python)
Raw data is extracted and prepared using Python scripts.

### 2. Data Warehouse & Transformation (Snowflake)

Data is stored and transformed in Snowflake using the **Medallion Architecture**:

#### 🟤 Bronze Layer (Raw Data)
- Stores raw ingested data  
- Minimal transformation  
- Preserves original structure  

#### ⚪ Silver Layer (Cleaned Data)
- Data cleaning and standardization  
- Handling missing values and inconsistencies  
- Applying business rules  

#### 🟡 Gold Layer (Analytics Layer)
- Aggregated and business-ready datasets  
- Fact tables optimized for reporting  
- Directly used in Power BI dashboards
  
### 3. Data Visualization (Power BI)
Interactive dashboards are built on top of the Gold layer to deliver business insights.

## Data Model
The Gold layer contains aggregated fact tables designed for reporting:
- `FACT_CUSTOMER_METRICS`  
- `FACT_SALES_SUMMARY`  
- `FACT_PAYMENT_SUMMARY`  
- `FACT_PRODUCT_PERFORMANCE`  
- `FACT_DELIVERY_PERFORMANCE`  
- `FACT_INVENTORY_STATUS`  
- `FACT_REVIEW_SUMMARY`  

These tables are optimized for analytical queries and Power BI dashboards.

## Dashboards

### 1. Customer Metrics Dashboard
Provides insights into customer behavior and value.

**Key Metrics:**
- Total Customers  
- Total Revenue  
- Average Customer Value  
- Customer Activity (Active vs Inactive)  

**Key Insight:**
A small group of high-value customers contributes disproportionately to total revenue, indicating opportunities for targeted retention strategies.

### 2. Payment Performance Dashboard
Analyzes payment activity and system reliability.

**Key Metrics:**
- Total Transactions  
- Total Payment Amount  
- Successful vs Failed Payments  
- Payment Failure Rate  

**Key Insight:**
Payment failures are concentrated on a single day, indicating a one-time anomaly rather than a recurring issue.

## Tech Stack
- **Python** → Data ingestion and preprocessing  
- **Snowflake** → Data warehouse and transformations  
- **SQL** → Data modeling and aggregation  
- **Power BI** → Data visualization and dashboards  

## Key Features
- End-to-end ELT pipeline  
- Implementation of Medallion Architecture (Bronze → Silver → Gold)  
- Structured and scalable data modeling  
- Business-oriented fact tables  
- Clean and consistent metric definitions  
- Interactive dashboards with actionable insights
  
## Key Learnings
- Designing scalable data pipelines  
- Implementing Medallion Architecture in Snowflake  
- Building layered data transformation workflows  
- Creating analytical fact tables  
- Translating data into business insights  
- Applying visualization and dashboard design best practices  

## Conclusion
This project demonstrates how raw e-commerce data can be transformed into structured, reliable, and insight-driven analytics using a well-designed data pipeline and Medallion Architecture.
It highlights the importance of:
- structured data transformation  
- data quality and consistency  
- and effective communication of insights in supporting data-driven decision-making.

## Author
Peju Sokunle

