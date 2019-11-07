CREATE OR REPLACE FUNCTION get_patients () --creation of function
	RETURNS TABLE (--the function that returns a table with 3 elements
 		patient_name TEXT,
 		patient_surname TEXT,     
 		distinct_doctors_count INT
	) 
AS $$
DECLARE --declare the cursor patients as the query d)
patients cursor for 
    select p.name as patient_name, p.surname as patient_surname, 
    count(distinct doctoramka) as distinct_doctors_count
    from appointments a, patients p
    where a.patientamka=p.patientamka 
    group by p.name, p.surname
    having count(*)>1;
    i record; -- the records of the cursor
BEGIN
   FOR i IN patients LOOP--for each record in cursor
    	patient_name := i.patient_name ; --attribute records values from the cursor select to the function table columns
   		patient_surname := i.patient_surname;
    	distinct_doctors_count := i.distinct_doctors_count;
              RETURN NEXT;--goes to the next record
   END LOOP; -- end the loop of the cursor
END; $$ 
 
LANGUAGE 'plpgsql';

select * from get_patients ()--and I print this table at the end of the function that returns it
