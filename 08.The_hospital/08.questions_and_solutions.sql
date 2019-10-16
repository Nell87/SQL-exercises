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
SELECT  Pa.Name AS patient_name, Ap.Start, Ap.End, Phy.Name AS phy_name, nurse.Name AS nurse_name, Ap.ExaminationRoom, PhyPCP.Name AS PCP   
FROM patient Pa
LEFT JOIN appointment Ap ON Pa.SSN = Ap.Patient
	LEFT JOIN physician Phy ON Ap.Physician = Phy.EmployeeID
		LEFT JOIN nurse ON Ap.PrepNurse = nurse.EmployeeID
			LEFT JOIN physician PhyPCP ON Pa.PCP = PhyPCP.EmployeeID
				WHERE Pa.PCP NOT LIKE Ap.Physician;
		
# 06. The Patient field in Undergoes is redundant, since we can obtain it from the Stay table. There are no constraints in force 
# to prevent inconsistencies between these two tables. More specifically, the Undergoes table may include a row where the patient ID 
# does not match the one we would obtain from the Stay table through the Undergoes.Stay foreign key. 
# Select all rows from Undergoes that exhibit this inconsistency.
SELECT *
FROM undergoes U 
INNER JOIN stay 	
	ON U.Stay = stay.StayID
    WHERE U.Patient NOT LIKE stay.Patient;

# 07. Obtain the names of all the nurses who have ever been on call for room 123.
SELECT N.Name
FROM nurse N
WHERE EmployeeID in (
					SELECT on_call.nurse FROM on_call, room
                    WHERE on_call.BlockFloor = room.BlockFloor
                    AND on_call.BlockCode = room.BlockCode
                    AND room.RoomNumber=123
					);

# 08. The hospital has several examination rooms where appointments take place. Obtain the number of appointments 
# that have taken place in each examination room.
SELECT COUNT(*) AS total, ExaminationRoom
FROM appointment
GROUP BY ExaminationRoom;

# 09. Obtain the names of all patients (also include, for each patient, the name of the patient's primary care physician), 
# such that all the following are true:
# - The patient has been prescribed some medication by his/her primary care physician.
# - The patient has undergone a procedure with a cost larger that $5,000
# - The patient has had at least two appointment where the nurse who prepped the appointment was a registered nurse.
# - The patient's primary care physician is not the head of any department.
    
SELECT Pa.Name AS patient_name, Phy.Name AS phy_name
FROM patient Pa, physician Phy
WHERE Pa.PCP=Phy.EmployeeID
	AND EXISTS
		(
        SELECT* FROM prescribes Pr
        WHERE Pr.Physician = Pa.PCP
        AND Pr.Patient = Pa.SSN
        )
	AND EXISTS
		(
		SELECT * FROM undergoes, procedures
		WHERE undergoes.Procedures = procedures.Code
		AND procedures.cost>5000
		)
   AND 2 <=
       (
         SELECT COUNT(Ap.AppointmentID) FROM Appointment Ap, Nurse N
          WHERE Ap.PrepNurse = N.EmployeeID
            AND N.Registered = 1
       )
   AND NOT Pa.PCP IN
       (
          SELECT Head FROM Department
       );
