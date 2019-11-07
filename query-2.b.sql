select a.diagnosis, a.t as date -- βρίσκει τις διαγνώσεις και τις ημερομηνίες
from appointments a, medicalfolders m -- απο τους πίνακες appointments και medicalfolders
where a.patientamka=m.patientamka -- όπου το αμκα ενός ασθενή απο τον πίνακα a αντιστοιχίζεται σε αμκα του πίνακα m
and a.diagnosis is not null-- και η διάγνωση στον πίνακα a για αυτό το αμκα δεν είναι κενή
and a.t > (select date(max(t))from appointments) - integer '7' -- και η ημερομηνία στον πίνακα a για αυτό το άμκα είναι μέχρι 7 μέρες πριν από την πιο πρόσφατη ημερομηνία
--and a.t>date '2017-05-01' - integer '7' -- ή χειροκίνητα ορίζω ποια είναι η τελευταία ημερομηνία
--and a.t>current_date-7 -- ή μεχρι 7 μέρες πριν την σημερινή μας ημερομηνία