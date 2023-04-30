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
