CREATE FUNCTION f_appointments() RETURNS trigger AS $appointments_au$ --create a function that returns a trigger
    DECLARE
        max_id          integer;--max id statement
    BEGIN
    
      select max(id)+1 into max_id -- which I initialize each time with the maximum id +1
      from medicalfolders;--from the medicalfolders table
      
      IF old.diagnosis IS NULL and new.diagnosis is not null THEN--if the diagnosis is changed and empty it is no longer empty
    insert into medicalfolders --introduction to the medicalfolders table
        (id,
         patientamka,
         cure,
         drug_id)
         values --the new values (the new id that is now the last id, the old amka (identified with the new one), a treatment text, the drug id)
         (max_id,
          old.patientamka,
          'CURE01',
          10);
       RETURN NEW; --returns these changes
      end if; --ends if
    END; --and end of the function
$appointments_au$ LANGUAGE plpgsql;

CREATE TRIGGER appointments_au after UPDATE ON appointments --create trigger
    FOR EACH ROW 
     WHEN (OLD.DIAGNOSIS IS NULL AND NEW.DIAGNOSIS IS NOT NULL)--every time the diagnosis changes from blank to non-blank
    EXECUTE PROCEDURE f_appointments();--executes the above function
	
	UPDATE appointments SET diagnosis = 'healthy' WHERE id = 1 and diagnosis is null;--example code that can execute the function by changing a blank diagnosis
