select p.name as patient_name, p.surname as patient_surname, --finds name, surname 
count(distinct doctoramka) as distinct_doctors_count-- counting the multitude of discrete doctor amps
from appointments a, patients p --from tables a, p
where a.patientamka=p.patientamka -- with patients' codes(amka) common in tables a, p
group by p.name, p.surname --by name and surname of patients
having count(*)>1 -- and this number is greater than 1
