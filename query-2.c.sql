select p.name as patient_name, p.surname as patient_surname, a.t as date -- βρίσκει το όνομα , επώνυμο, και ημερομηνία
from appointments a, doctors d, patients p --από τους πίνακες a, d, p
where a.patientamka=p.patientamka and a.doctoramka=d.doctoramka -- με τα αμκα ασθενούς και γιατρού απο τον πίνακα a να έχουν αντιστοίχιση σε αμκα απο τον πίνακα p και d
and a.t>(select date(max(t))from appointments) - integer '30' --και η ημερομηνία στον πίνακα a για αυτά τα άμκα είναι μέχρι 30 μέρες πριν από την πιο πρόσφατη ημερομηνία
--and a.t>current_date-30
and d.doctoramka='3531589109644678'-- έχοντας προϋπόθεση το αμκα του γιατρου στον πίνακα d να είναι '3531589109644678'
--and d.name='Kevin' and d.surname='Arnold'