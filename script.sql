SELECT * FROM parts ORDER BY id LIMIT 10;

ALTER TABLE parts
ALTER COLUMN code SET NOT NULL;

ALTER TABLE parts 
ADD UNIQUE (code);

UPDATE parts 
SET description = 'TBD'
WHERE description IS NULL;

ALTER TABLE parts 
ALTER COLUMN description SET NOT NULL;

/*
INSERT INTO parts(id,code,manufacturer_id)
VALUES(54,'V1-009',9);
*/

ALTER TABLE reorder_options
ADD CHECK(price_usd IS NOT NULL AND quantity IS NOT NULL);

ALTER TABLE reorder_options
ADD CHECK(price_usd > 0 AND quantity > 0);

ALTER TABLE reorder_options 
ADD CHECK((price_usd/quantity)>0.02 AND (price_usd/quantity)< 25.00);

ALTER TABLE parts
ADD PRIMARY KEY(id); 

ALTER TABLE reorder_options
ADD FOREIGN KEY (part_id)
REFERENCES parts(id);

ALTER TABLE locations
ADD CHECK(qty>0);

ALTER TABLE locations
ADD UNIQUE (part_id,location);

--location has a part_id of 54 which isnt't present in parts.id. This removes it to clear the error'
DELETE FROM locations 
WHERE part_id = 54;

ALTER TABLE locations
ADD FOREIGN KEY (part_id) REFERENCES parts(id);

ALTER TABLE parts
ADD FOREIGN KEY (manufacturer_id) REFERENCES manufacturers (id);

INSERT INTO manufacturers(name, id) 
VALUES ('Pip-NNC Industrial', 11);

SELECT * FROM parts;
SELECt * FROM manufacturers;

UPDATE parts
SET manufacturer_id = 11
WHERE manufacturer_id = 1 OR manufacturer_id = 2;


