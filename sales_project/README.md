# Sales Dataset Analysis & Transformation Project

This project aims to analyze and transform a sales dataset using **DBT** to create a data warehouse. The project involves multiple steps of data cleaning, aggregation, and analysis, with a focus on improving sales performance and customer behavior insights. The final models are materialized as tables and views to enable efficient reporting and analysis.

## Project Overview

The goal of this project is to extract, clean, transform, and aggregate raw sales data to build a comprehensive sales analysis pipeline. Key insights like **customer lifetime value (CLV)**, **monthly sales by region**, and **product performance** are created using DBT transformations, all of which can be analyzed using tools like Looker Studio or any other BI tools.

## Technologies Used
- **DBT**: For data transformations, building the data models, and testing the data quality.
- **SQL**: For writing queries and building the logic for each transformation and model.
- **BigQuery**: Used for managing the database and running the DBT models.

## Directory Structure

- **models**:
    - `dim/`: Contains dimension tables (e.g., `dim_customer`, `dim_product`, `dim_date`).
    - `fct/`: Contains fact tables (e.g., `fct_sales`).
    - `mart/`: Contains aggregated models, ready for analysis (e.g., `mart_clv`, `mart_monthly_sales_by_region`, `mart_summary`).
    - `stg/`: Contains staging models used for cleaning and transforming raw data (e.g., `stg_sales`).

## Models

### 1. **Staging Models (stg_*)**
- **stg_sales**: Cleans raw sales data and generates surrogate keys for customers and order lines.
- Materialized as **view** to keep it lightweight and not use unnecessary storage.

### 2. **Dimension Models (dim_*)**
- **dim_customer**: Contains customer information like name, address, and region.
- **dim_product**: Contains product-level details like product category, MSRP, and average unit price.
- **dim_date**: Date-related dimension for aggregating sales data by time (monthly, yearly).

### 3. **Fact Models (fct_*)**
- **fct_sales**: Aggregates raw sales data and links it to customer and product dimensions, along with other relevant sales metrics like total quantity ordered, total sales, and order status.

### 4. **Mart Models (mart_*)**
- **mart_clv**: Calculates customer lifetime value (CLV) based on total revenue, purchase frequency, and customer lifetime days.
- **mart_monthly_sales_by_region**: Aggregates sales data by region and month, including metrics like total orders, total quantity ordered, and total sales.
- **mart_summary**: Provides summary-level metrics on sales, including average order value, total sales, and distinct customers, aggregated by day, month, and year.

## Key Transformations

- **Sales Aggregation**: The data is aggregated at various levels, including by month, year, and region, to analyze sales trends.
- **Customer Lifetime Value (CLV)**: CLV is calculated based on total revenue, purchase frequency, and customer lifetime days to understand customer value over time.
- **Product Performance**: Each product is analyzed using aggregated data such as sales volume, quantity ordered, and average sales price.

## Testing and Quality Assurance

- **DBT Tests**: DBT’s built-in testing framework has been used to ensure the integrity of the data models. For example, tests are applied to ensure that there are no missing values for essential fields like `product_id`, `customer_id`, and `order_id`.

## Project Setup and Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/pmmaria/dbt-sales-dataset.git

2. **Install dependencies**: Make sure DBT is installed, and install the necessary dependencies:

    ```bash
    pip install -r requirements.txt
    
3. **Configure DBT profile**: Configure your DBT profile to connect to the target database (BigQuery in this case). Ensure the `profiles.yml` file is correctly set up with the necessary credentials.

4. **Run DBT models**: After setting up the configuration, you can run the DBT models with the following command:

    ```bash
    dbt run

5. **Run DBT tests**: After running the models, it's important to test the integrity of the data:

    ```bash
    dbt test 

## Key Insights & Analysis ##

- ### Customer Lifetime Value (CLV):
     The mart_clv model calculates CLV based on the total revenue generated, purchase frequency, and customer lifetime days. This metric helps identify high-value customers and prioritize retention strategies.

- ### Sales by Region: 
     The mart_monthly_sales_by_region model aggregates sales data by region (country/city), providing insights into geographic trends and the performance of various markets.

- ### Monthly Sales Trends: 
    The mart_summary model aggregates sales data by day, month, and year. This model provides valuable insights into overall sales trends, total sales volume, and average order value over time.

## Future Improvements

- ### Customer Segmentation: 
    Implement more advanced customer segmentation (e.g., based on deal size, territory, or recency of purchase) to further refine the analysis of CLV and retention strategies.

- ### Sales Forecasting: 
    Introduce predictive models using time series forecasting techniques to predict future sales trends based on historical data.

- ### Product Performance: 
    Add more detailed product performance metrics, such as product lifecycle analysis, sales trends, and profitability analysis, to optimize inventory and pricing strategies.

## Conclusion

This project serves as a comprehensive example of how to use DBT for data transformation, aggregation, and analysis. By creating key models such as CLV, monthly sales by region, and product performance, the project offers valuable insights that can drive business decisions. It also demonstrates the process of data cleaning, aggregation, and modeling in a production-ready data warehouse environment.