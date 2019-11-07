CREATE OR REPLACE FUNCTION get_patients () --δημιουργία συνάρτησης 
	RETURNS TABLE (--η function that returns a table με 3 στοιχεία
 		patient_name TEXT,
 		patient_surname TEXT,     
 		distinct_doctors_count INT
	) 
AS $$
DECLARE --δήλωση του cursor patients ως το query από το ερώτημα d)
patients cursor for 
    select p.name as patient_name, p.surname as patient_surname, 
    count(distinct doctoramka) as distinct_doctors_count
    from appointments a, patients p
    where a.patientamka=p.patientamka 
    group by p.name, p.surname
    having count(*)>1;
    i record; -- τα records του cursor
BEGIN
   FOR i IN patients LOOP--για κάθε record στον cursor
    	patient_name := i.patient_name ; --αποδίδω τις τιμές των records από το select του cursor στις κολώνες του function table
   		patient_surname := i.patient_surname;
    	distinct_doctors_count := i.distinct_doctors_count;
              RETURN NEXT;--πηγαίνει στο επόμενο record
   END LOOP; -- τελειώνει το loop του cursor
END; $$ 
 
LANGUAGE 'plpgsql';

select * from get_patients ()--και εμφανίζω στο τέλος αυτό το table από το function που το επιστρέφει
