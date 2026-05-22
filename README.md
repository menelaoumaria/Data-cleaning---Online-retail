# Data-cleaning-Online-retail

Due to limitations of the SQL environment, data cleaning was performed using SELECT-based transformations rather than updating the original dataset. In production environments, this logic would typically be used to create a cleaned table for downstream analysis.

SQL playground used: RunSQL

Dataset used: Kaggle - Online retail data set (https://www.kaggle.com/datasets/ulrikthygepedersen/online-retail-dataset)

Data cleaning steps

To prepare the dataset for analysis, I performed a series of data cleaning steps:

- Standardised text fields (description, country) using TRIM and LOWER
- Converted key identifiers (invoice_no, customer_id) to string format to preserve alphanumeric values
- Removed or handled invalid values such as negative quantities and zero prices
- Created derived date fields (order_date) from timestamps
- Identified and handled cancelled transactions (invoice numbers starting with “C”)
- Removed duplicate records using window functions (ROW_NUMBER)
- Performed validation checks to ensure data consistency

When performing the validation checks, the total revenue was actually higher from the clean table rather than the raw one. Transactions with negative quantities or prices were treated as invalid for analysis and excluded from revenue calculations. This results in higher total revenue compared to the raw dataset, as return transactions (negative values) are removed.
