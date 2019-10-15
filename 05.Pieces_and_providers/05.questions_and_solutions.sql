# 1. Select the name of all the pieces. (Seleccione el nombre de todas las piezas).
SELECT Name
FROM pieces;

# 2. Select all the providers' data. (Seleccione todos los datos de los proveedores (providers)).
SELECT *
FROM providers;

# 3. Obtain the average price of each piece (show only the piece code and the average price).
SELECT Piece, AVG(Price)
FROM provides
GROUP BY Piece;

# 4. Obtain the names of all providers who supply piece 1.
SELECT PName.Name 
FROM providers PName
WHERE PName.Code IN (
					SELECT Prov.Provider FROM Provides Prov WHERE Piece=1
					);
 
# 5. Select the name of pieces provided by provider with code "HAL".
SELECT Pi.Name
FROM pieces Pi
WHERE Pi.Code IN (
				 SELECT Prov.Piece FROM Provides Prov WHERE Prov.Provider="HAL"
				 );

# 6. For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price 
# (note that there could be two providers who supply the same piece at the most expensive price).
SELECT Pi.Name, Providers.Name, Prov.Price
FROM pieces Pi
INNER JOIN Provides Prov ON Pi.Code= Prov.Piece
INNER JOIN Providers     ON Prov.Provider = Providers.Code
WHERE Prov.Price = (
					SELECT MAX(Price) FROM provides WHERE Piece=Pi.Code
					);
                    
# 7. Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each.
INSERT INTO provides(Piece, Provider, Price)
VALUES(1, "TNBC", 7);

# 8. Increase all prices by one cent.
UPDATE provides
SET Price = Price + 1;

# 9. Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).
DELETE FROM provides
WHERE Provider = "RBT" AND Piece=4; 

# 10. Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces 
# (the provider should still remain in the database).
DELETE FROM provides
WHERE Provider = "RBT";
 