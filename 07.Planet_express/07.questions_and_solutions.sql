# 1. Who received a 1.5kg package?
SELECT client.Name
FROM client
WHERE client.AccountNumber IN (
							  SELECT P.Recipient FROM package P 
                              WHERE P.Weight=1.5
							  );
                              
SELECT Client.Name
FROM Client 
INNER JOIN package   
  ON client.AccountNumber = package.Recipient 
WHERE Package.weight = 1.5;    

# 2. What is the total weight of all the packages that he sent?
SELECT SUM(package.Weight) as total_weight
FROM package
INNER JOIN client
	ON package.Sender= client.AccountNumber
WHERE client.Name=(
					SELECT Client.Name
					FROM Client 
					INNER JOIN package   
					ON client.AccountNumber = package.Recipient 
					WHERE Package.weight = 1.5
					);

# 3. Which pilots transported those packages?
SELECT Name 
FROM employee
INNER JOIN shipment
	ON employee.EmployeeID=shipment.Manager
INNER JOIN package
	ON shipment.ShipmentID=package.PackageNumber
WHERE Sender IN (
				SELECT client.AccountNumber
				FROM Client 
				INNER JOIN package   
				ON client.AccountNumber = package.Recipient 
				WHERE Package.weight = 1.5
			  );