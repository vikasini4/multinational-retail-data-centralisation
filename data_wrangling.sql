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
