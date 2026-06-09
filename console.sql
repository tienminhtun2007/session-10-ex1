CREATE TABLE products(
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION update_last_modified()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    NEW.last_modified := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_update_last_modified
    BEFORE INSERT OR UPDATE ON products
    FOR EACH ROW
    EXECUTE FUNCTION update_last_modified();

INSERT INTO products (name, price) VALUES
                                       ('Laptop Dell', 15000000),
                                       ('Chuột Logitech', 500000),
                                       ('Bàn phím Mechanical', 2000000);


SELECT * FROM products;


UPDATE products SET price = 16000000 WHERE id = 1;
SELECT * FROM products;


UPDATE products SET price = price * 1.1 WHERE id IN (2, 3);
SELECT * FROM products;
