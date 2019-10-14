# 1. Select the names of all the products in the store.
SELECT Name
FROM products;

# 2. Select the names and the prices of all the products in the store.
SELECT Name,Price
FROM products;

# 3. Select the name of the products with a price less than or equal to $200.
SELECT Name 
FROM products
WHERE Price <=200;

# 4. Select all the products with a price between $60 and $120.
SELECT * 
FROM products
WHERE price BETWEEN 60 AND 120;

# 5. Select the name and price in cents (i.e., the price must be multiplied by 100).
SELECT Name,  Price*100 AS Price_cents
FROM products;

# 6. Compute the average price of all the products.
SELECT AVG(price) AS avg_price
FROM products;

# 7. Compute the average price of all products with manufacturer code equal to 2.
SELECT AVG(price) AS avg_price
FROM products
WHERE Manufacturer = 2;

# 8. Compute the number of products with a price larger than or equal to $180.
SELECT COUNT(*) AS products_morethan_180
FROM products
WHERE Price >=180;

# 9. Select the name and price of all products with a price larger than or equal to $180, 
#    and sort first by price (in descending order), and then by name (in ascending order).
SELECT Name, Price
FROM products
WHERE Price >=180
ORDER BY Price DESC, Name;

# 10. Select all the data from the products, including all the data for each product's manufacturer.
SELECT *
FROM products
INNER JOIN manufacturers
	ON products.Manufacturer = manufacturers.Code;

# 11. Select the product name, price, and manufacturer name of all the products.
SELECT products.Name, Price, manufacturers.Name
FROM products
INNER JOIN manufacturers
	ON products.Manufacturer=manufacturers.Code;
    
# 12. Select the average price of each manufacturer's products, showing only the manufacturer's code.
SELECT AVG(Price) AS avg_price, Manufacturer
FROM products
GROUP BY Manufacturer;

# 13. Select the average price of each manufacturer's products, showing the manufacturer's name.
SELECT AVG(Price) AS avg_price, manufacturers.Name
FROM products
INNER JOIN manufacturers
	ON products.Manufacturer=manufacturers.Code
GROUP BY manufacturers.Name;

# 14. Select the names of manufacturer whose products have an average price larger than or equal to $150.
SELECT manufacturers.Name, AVG(Price) AS avg_price
FROM products
INNER JOIN manufacturers
	ON manufacturers.Code = products.Manufacturer
GROUP BY manufacturers.Name
HAVING avg_price >=150;

# 15. Select the name and price of the cheapest product.
SELECT Name, Price
FROM products
WHERE Price = (SELECT MIN(Price) FROM products);

# 16. Select the name of each manufacturer along with the name and price of its most expensive product.
  SELECT P.Name, P.Price, M.Name
   FROM Products P 
   INNER JOIN Manufacturers M
	 ON P.Manufacturer = M.Code
     AND P.Price =
     (
       SELECT MAX(P.Price)
         FROM Products P
         WHERE P.Manufacturer = M.Code
     );

# 17. Add a new product: Loudspeakers, $70, manufacturer 2.
INSERT INTO products (Code,Name, Price, Manufacturer)
VALUES (11,"Loudspeakers", 70, 2);

# 18. Update the name of product 8 to "Laser Printer".
UPDATE products
	SET	Name = "Laser Printer"
	WHERE Code = 8;

# 19. Apply a 10% discount to all products.
UPDATE products
	SET Price = Price - (Price *0.1);
    
# 20. Apply a 10% discount to all products with a price larger than or equal to $120.
UPDATE products
	SET Price = Price - (Price *0.1)
    WHERE Price >=120;


