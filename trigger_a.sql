CREATE FUNCTION f_appointments() RETURNS trigger AS $appointments_au$ --δημιουργία function που επιστρέφει έναν trigger
    DECLARE
        max_id          integer;--δήλωση του max id
    BEGIN
    
      select max(id)+1 into max_id -- το οποίο κάθε φορά το αρχικοποιώ με το μέγιστο id +1
      from medicalfolders;--από τον πίνακα medicalfolders
      
      IF old.diagnosis IS NULL and new.diagnosis is not null THEN--αν γίνει αλλαγή της διάγνωσης και από κενή δεν είναι πλέον κενή
    insert into medicalfolders --εισαγωγή στον πίνακα medicalfolders
        (id,
         patientamka,
         cure,
         drug_id)
         values --τις νέες τιμές (το νέο id που είναι τώρα το τελευταίο id, το παλιο αμκα (που ταυτίζεται με το νέο), ένα κείμενο θεραπείας, το drug id)
         (max_id,
          old.patientamka,
          'CURE01',
          10);
       RETURN NEW; --επιστρέφει αυτές τις αλλαγές
      end if; --τελειώνει το if
    END; --και τέλος της συνάρτησης
$appointments_au$ LANGUAGE plpgsql;

CREATE TRIGGER appointments_au after UPDATE ON appointments --δημιουργία του trigger
    FOR EACH ROW 
     WHEN (OLD.DIAGNOSIS IS NULL AND NEW.DIAGNOSIS IS NOT NULL)--κάθε φορά που αλλάζει η διάγνωση από κενή σε μη κενή
    EXECUTE PROCEDURE f_appointments();--εκτελεί την παραπάνω συνάρτηση
	
	UPDATE appointments SET diagnosis = 'healthy' WHERE id = 1 and diagnosis is null;--παράδειγμα κώδικα που μπορεί να θέσει σε εκτέλεση την συνάρτηση αλλάζοντας μια κενή διάγνωση