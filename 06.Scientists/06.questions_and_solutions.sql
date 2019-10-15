# List all the scientists' names, their projects' names, and the hours worked by that scientist on each project, 
# in alphabetical order of project name, then scientist name.
SELECT S.Name, P.Name, P.Hours
FROM scientists S
INNER JOIN assignedto A ON S.SSN = A.Scientist
INNER JOIN projects P ON A.Project = P.Code
ORDER BY P.Name ASC, S.Name ASC;