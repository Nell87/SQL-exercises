# 1. Select all warehouses.
SELECT *
FROM warehouses;

# 2. Select all boxes with a value larger than $150.
SELECT *
FROM boxes
WHERE Value > 150;

# 3. Select all distinct contents in all the boxes.
SELECT DISTINCT Contents
FROM boxes;

# 4. Select the average value of all the boxes.
SELECT AVG(Value) AS avg_value
FROM boxes;

# 5. Select the warehouse code and the average value of the boxes in each warehouse.
SELECT Code,AVG(Value) AS avg_value
FROM boxes
GROUP BY Warehouse;

# 6. Same as previous exercise, but select only those warehouses where the average value of the boxes is greater than 150.
SELECT Code,AVG(Value) AS avg_value
FROM boxes
GROUP BY Warehouse
HAVING avg_value >150;

# 7. Select the code of each box, along with the name of the city the box is located in.
SELECT B.Code, W.Location
FROM boxes B
INNER JOIN warehouses W
	ON B.Warehouse = W.Code;
    
# 8. Select the warehouse codes, along with the number of boxes in each warehouse. Optionally, take into account that 
# some warehouses are empty (i.e., the box count should show up as zero, instead of omitting the warehouse from the result).
SELECT W.Code, COUNT(B.Warehouse) AS number_boxes
FROM warehouses W
INNER JOIN boxes B 
	ON W.Code=B.Warehouse
GROUP BY W.Code;

# 9. Select the codes of all warehouses that are saturated (a warehouse is saturated if the number of boxes 
# in it is larger than the warehouse's capacity).
SELECT W.Code, COUNT(B.Warehouse) AS number_boxes, Capacity
FROM warehouses W
INNER JOIN boxes B 
	ON W.Code=B.Warehouse
GROUP BY W.Code
HAVING number_boxes > Capacity;

# 10. Select the codes of all the boxes located in Chicago.
SELECT B.Code, W.Location
FROM boxes B
INNER JOIN warehouses W
	ON B.Warehouse=W.Code
WHERE Location = "Chicago";

# 11. 11. Create a new warehouse in New York with a capacity for 3 boxes.
INSERT INTO warehouses(Location, Capacity)
VALUES("New York", 3);

# 12. Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.
INSERT INTO boxes(Code, Contents, Value, Warehouse)
VALUES("H5RT", "Papers", 200, 2);

# 13. Reduce the value of all boxes by 15%.
UPDATE boxes
SET Value = Value *0.85;

# 14. Apply a 20% value reduction to boxes with a value larger than the average value of all the boxes.
UPDATE boxes
SET Value = Value *0.80
WHERE Value > (
				SELECT AVG(Value) FROM boxes
			  );

# 15. Remove all boxes with a value lower than $100.
DELETE 
FROM boxes
WHERE Value<100; 

# 16. Remove all boxes from saturated warehouses.
DELETE FROM Boxes 
WHERE Warehouse IN
				   ( 
                   SELECT Code
				   FROM Warehouses
				   WHERE Capacity <
					   (
						 SELECT COUNT(*)
						   FROM Boxes
						   WHERE Warehouse = Warehouses.Code
					   )
					
				   );                  