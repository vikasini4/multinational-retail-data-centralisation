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

