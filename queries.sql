WITH cleaned_data AS (
    SELECT
    -- IDs (keep as text)
    CAST(TRIM(invoice_no) AS VARCHAR) AS invoice_no,
    TRIM(stock_code) AS stock_code,

    -- Clean text
    TRIM(LOWER(COALESCE(description, 'unknown'))) AS description,
    TRIM(INITCAP(LOWER(country))) AS country,

    -- Clean quantity
    CASE 
      WHEN quantity <= 0 THEN NULL
        ELSE quantity
        END AS quantity,

    -- Clean price
    CASE 
      WHEN unit_price <= 0 THEN NULL
        ELSE unit_price
        END AS unit_price,

    -- Clean customer_id
    CASE 
      WHEN customer_id IS NULL THEN NULL
        ELSE CAST(customer_id AS VARCHAR)
        END AS customer_id,

    -- Keep timestamp
    invoice_date,

    -- Derived fields
    DATE(invoice_date) AS order_date,

    -- Cancellation flag
    CASE 
      WHEN invoice_no LIKE 'C%' THEN TRUE
        ELSE FALSE
        END AS is_cancelled,

    -- Duplicate handling
    ROW_NUMBER() OVER (
        PARTITION BY invoice_no, stock_code
        ORDER BY invoice_date
        ) AS rn

    FROM online_retail
)

-- Validation checks   
SELECT SUM(quantity * unit_price)
FROM cleaned_data
WHERE rn = 1;

SELECT SUM(quantity * unit_price) FROM online_retail;
