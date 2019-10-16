# 01. Obtain the names of all physicians that have performed a medical procedure they have never been certified to perform.
SELECT Name 
FROM Physician
WHERE EmployeeID IN
   (
      SELECT Undergoes.Physician
      FROM Undergoes 
      LEFT JOIN Trained_In
				 ON Undergoes.Physician=Trained_In.Physician
                 AND Undergoes.Procedures=Trained_In.Treatment
      WHERE Treatment IS NULL
   );

# 02. Same as the previous query, but include the following information in the results: Physician name, name of procedure, 
# date when the procedure was carried out, name of the patient the procedure was carried out on.
SELECT Phy.Name, Pro.Name AS proced_name, U.DateUndergoes, Pa.Name AS patient_name
FROM physician Phy
LEFT JOIN undergoes U
	ON Phy.EmployeeID = U.Physician
LEFT JOIN procedures Pro
	ON U.procedures = Pro.Code
LEFT JOIN patient Pa 	
	ON U.Patient = Pa.SSN
WHERE Phy.EmployeeID IN (
				SELECT U.Physician
				FROM undergoes U
				LEFT JOIN trained_in Tra 
					ON  U.Physician = Tra.Physician
					AND U.Procedures = Tra.Treatment
				WHERE Treatment IS NULL
			);

# 03. Obtain the names of all physicians that have performed a medical procedure that they are certified to perform, but such that 
# the procedure was done at a date (Undergoes.Date) after the physician's certification expired (Trained_In.CertificationExpires).
SELECT Phy.Name, U.DateUndergoes, U.Procedures
FROM physician Phy
LEFT JOIN undergoes U
	ON Phy.EmployeeID = U.Physician
WHERE Phy.EmployeeID IN (
						SELECT U.Physician
						FROM undergoes U
						LEFT JOIN trained_in Tra 
							ON U.Physician = Tra.Physician
							AND U.Procedures = Tra.Treatment
						WHERE Treatment IS NOT NULL AND DateUndergoes >CertificationExpires
						);

# 04. Same as the previous query, but include the following information in the results: Physician name, name of procedure, 
# date when the procedure was carried out, name of the patient the procedure was carried out on, and date when the certification expired.
SELECT Phy.Name, U.DateUndergoes, Pro.Name, P.Name, Tra.CertificationExpires
FROM physician Phy
LEFT JOIN undergoes U ON Phy.EmployeeID = U.Physician
	LEFT JOIN procedures Pro  ON U.Procedures = Pro.Code
		LEFT JOIN patient P  ON U.Patient = P.SSN
			LEFT JOIN trained_in Tra  ON U.Physician = Tra.Physician
									  AND U.Procedures = Tra.Treatment
				WHERE CertificationExpires < DateUndergoes;

# 05. Obtain the information for appointments where a patient met with a physician other than his/her primary care physician. 
# Show the following information: Patient name, physician name, nurse name (if any), start and end time of appointment, 
# examination room, and the name of the patient's primary care physician.



        
             
SELECT * FROM physician;
SELECT * FROM trained_in;
SELECT * FROM procedures;
SELECT * FROM undergoes;
SELECT * FROM patient;


# 06. The Patient field in Undergoes is redundant, since we can obtain it from the Stay table. There are no constraints in force to prevent inconsistencies between these two tables. More specifically, the Undergoes table may include a row where the patient ID does not match the one we would obtain from the Stay table through the Undergoes.Stay foreign key. Select all rows from Undergoes that exhibit this inconsistency.

# 07. Obtain the names of all the nurses who have ever been on call for room 123.

# 08. The hospital has several examination rooms where appointments take place. Obtain the number of appointments that have taken place in each examination room.

# 09. Obtain the names of all patients (also include, for each patient, the name of the patient's primary care physician), such that \emph{all} the following are true:
 


