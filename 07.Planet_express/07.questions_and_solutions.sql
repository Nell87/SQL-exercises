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

# 3. Which pilots transported those packages?
