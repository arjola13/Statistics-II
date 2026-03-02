*****************************************************
* AMAZON DATASET - UNIVARIATE EDA
*****************************************************

clear all
set more off

* 1. Import data

import delimited "/Users/arjolaarapi-gjini/Desktop/amz_uk_price_prediction_dataset.csv", clear 

* 2. Overview of dataset
describe
summarize
summarize, detail

* 3. Identify variable types
ds, has(type numeric)
ds, has(type string)

*****************************************************
* PRICE VARIABLE ANALYSIS
*****************************************************

* Summary statistics
summarize price
summarize price, detail

* Missing values
count if missing(price)

* Check non-positive prices
count if price <= 0

* Histogram
histogram price, bin(50)

* Log transformation
generate log_price = log(price)
histogram log_price, bin(50)

* Boxplot
graph box price

*****************************************************
* CATEGORY ANALYSIS
*****************************************************

* Frequency table
tabulate category

* Top categories
contract category
gsort category
list in 1/10

*****************************************************
* STARS (RATINGS) ANALYSIS
*****************************************************

* Frequency table
tabulate stars

* Summary statistics
summarize stars, detail

* Histogram
histogram stars, bin(50)

*****************************************************
* END OF FILE
*****************************************************
