CREATE TABLE customers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    email TEXT);
    
INSERT INTO customers (name, email) VALUES ("Doctor Who", "doctorwho@timelords.com");
INSERT INTO customers (name, email) VALUES ("Harry Potter", "harry@potter.com");
INSERT INTO customers (name, email) VALUES ("Captain Awesome", "captain@awesome.com");

CREATE TABLE orders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER,
    item TEXT,
    price REAL);

INSERT INTO orders (customer_id, item, price)
    VALUES (1, "Sonic Screwdriver", 1000.00);
INSERT INTO orders (customer_id, item, price)
    VALUES (2, "High Quality Broomstick", 40.00);
INSERT INTO orders (customer_id, item, price)
    VALUES (1, "TARDIS", 1000000.00);
    
    
/*Come up with a query that lists the name and email of every
 customer followed by the item and price of orders they've made. Use a LEFT OUTER JOIN 
 so that a customer is listed even if they've made no orders, and don't add any 
 ORDER BY.*/
 
SELECT c.name, c.email, o.item, o.price
FROM customers as c
LEFT OUTER JOIN orders as o
ON c.id = o.customer_id;


/*Create another query that will result in one row per each customer, 
with their name, email, and total amount of money they've spent on orders. 
Sort the rows according to the total money spent, from the most spent to the least spent.*/

SELECT c.name, c.email, SUM(o.price) AS "total"
FROM customers as c
LEFT OUTER JOIN orders as o
ON c.id = o.customer_id
GROUP BY c.id
ORDER BY o.price DESC
