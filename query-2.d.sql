select p.name as patient_name, p.surname as patient_surname, -- βρίσκει όνομα, επώνυμο 
count(distinct doctoramka) as distinct_doctors_count-- μετρώντας το πλήθος των διακριτών αμκα γιατρών
from appointments a, patients p --από τους πίνακες a, p
where a.patientamka=p.patientamka -- με αμκα ασθενών κοινά σε πίνακες a, p
group by p.name, p.surname --ανά όνομα και επώνυμο ασθενών
having count(*)>1 -- και αυτό το πλήθος να είναι μεγαλύτερο του 1
