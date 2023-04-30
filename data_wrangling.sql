ALTER TABLE orders_table 
ALTER COLUMN date_uuid TYPE UUID USING date_uuid::UUID;

ALTER TABLE orders_table 
ALTER COLUMN user_uuid TYPE UUID USING user_uuid::UUID;

ALTER TABLE orders_table 
ALTER COLUMN card_number TYPE VARCHAR(?) USING card_number::VARCHAR;

ALTER TABLE orders_table 
ALTER COLUMN store_code TYPE VARCHAR(?) USING store_code::VARCHAR;

ALTER TABLE orders_table 
ALTER COLUMN product_code TYPE VARCHAR(?) USING product_code::VARCHAR;

ALTER TABLE orders_table 
ALTER COLUMN product_quantity TYPE SMALLINT USING product_quantity::BIGINT::SMALLINT;
--
ALTER TABLE dim_user_table 
ALTER COLUMN first_name TYPE VARCHAR(255) USING first_name::VARCHAR(255);

ALTER TABLE dim_user_table 
ALTER COLUMN last_name TYPE VARCHAR(255) USING last_name::VARCHAR(255);

ALTER TABLE dim_user_table 
ALTER COLUMN date_of_birth TYPE DATE USING date_of_birth::DATE;

ALTER TABLE dim_user_table 
ALTER COLUMN country_code TYPE VARCHAR(?) USING country_code::VARCHAR;

ALTER TABLE dim_user_table 
ALTER COLUMN user_uuid TYPE UUID USING user_uuid::UUID;

ALTER TABLE dim_user_table 
ALTER COLUMN join_date TYPE DATE USING join_date::DATE;
__
-- Merge the two latitude columns
ALTER TABLE store_details_table
ADD COLUMN new_latitude FLOAT;

UPDATE store_details_table
SET new_latitude = CAST(latitude1 AS FLOAT)
WHERE latitude1 IS NOT NULL;

UPDATE store_details_table
SET new_latitude = CAST(latitude2 AS FLOAT)
WHERE latitude1 IS NULL AND latitude2 IS NOT NULL;

ALTER TABLE store_details_table
DROP COLUMN latitude1,
DROP COLUMN latitude2,
RENAME COLUMN new_latitude TO latitude;

-- Change data types
ALTER TABLE store_details_table
ALTER COLUMN longitude TYPE FLOAT USING longitude::FLOAT;

ALTER TABLE store_details_table
ALTER COLUMN locality TYPE VARCHAR(255) USING locality::VARCHAR(255);

ALTER TABLE store_details_table
ALTER COLUMN store_code TYPE VARCHAR(?) USING store_code::VARCHAR;

ALTER TABLE store_details_table
ALTER COLUMN staff_numbers TYPE SMALLINT USING staff_numbers::SMALLINT;

ALTER TABLE store_details_table
ALTER COLUMN opening_date TYPE DATE USING opening_date::DATE;

ALTER TABLE store_details_table
ALTER COLUMN store_type TYPE VARCHAR(255) USING store_type::VARCHAR(255);

ALTER TABLE store_details_table
ALTER COLUMN latitude TYPE FLOAT USING latitude::FLOAT;

ALTER TABLE store_details_table
ALTER COLUMN country_code TYPE VARCHAR(?) USING country_code::VARCHAR;

ALTER TABLE store_details_table
ALTER COLUMN continent TYPE VARCHAR(255) USING continent::VARCHAR(255);

-- Replace null values with "N/A"
UPDATE store_details_table
SET location = 'N/A'
WHERE location IS NULL AND website IS NOT NULL;
--
-- Remove the £ character from product_price
UPDATE products
SET product_price = REPLACE(product_price, '£', '');

-- Add the weight_class column
ALTER TABLE products
ADD COLUMN weight_class VARCHAR(?);

-- Update the weight_class values based on the weight range
UPDATE products
SET weight_class = CASE 
                        WHEN weight < 2 THEN 'Light'
                        WHEN weight >= 2 AND weight < 40 THEN 'Mid_Sized'
                        WHEN weight >= 40 AND weight < 140 THEN 'Heavy'
                        WHEN weight >= 140 THEN 'Truck_Required'
                        ELSE NULL
                   END;

-- Replace the ? placeholder with the appropriate VARCHAR length for the weight_class column.

-- Rename the removed column to still_available
ALTER TABLE dim_products
RENAME COLUMN removed TO still_available;

-- Change the data types of the columns
ALTER TABLE dim_products
ALTER COLUMN product_price TYPE FLOAT USING product_price::FLOAT;
ALTER TABLE dim_products
ALTER COLUMN weight TYPE FLOAT USING weight::FLOAT;
ALTER TABLE dim_products
ALTER COLUMN EAN TYPE VARCHAR(?);
ALTER TABLE dim_products
ALTER COLUMN product_code TYPE VARCHAR(?);
ALTER TABLE dim_products
ALTER COLUMN date_added TYPE DATE USING date_added::DATE;
ALTER TABLE dim_products
ALTER COLUMN uuid TYPE UUID USING uuid::UUID;
ALTER TABLE dim_products
ALTER COLUMN still_available TYPE BOOL USING CASE 
                                                  WHEN still_available = 'TRUE' THEN TRUE
                                                  WHEN still_available = 'FALSE' THEN FALSE
                                                  ELSE NULL
                                              END;
ALTER TABLE dim_products
ALTER COLUMN weight_class TYPE VARCHAR(?);

-- Replace the ? placeholders with the appropriate VARCHAR lengths for the EAN, product_code, and weight_class columns.



