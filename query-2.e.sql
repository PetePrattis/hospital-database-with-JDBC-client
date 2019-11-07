select c.name as most_visited_departments from -- βρίσκει το όνομα από
(select dp.name as name, count(a.id) as cnt-- την εύρεση  του ονόματος και του πλήθους των id 
from appointments a, doctors d, departments dp -- από τους πίνακες a, d, dp
where a.doctoramka=d.doctoramka and d.specialty=dp.id -- με τα αμκα των γιατρών να αντιστοιχίζονται στους πίνακες a, d και το ίδιο και η ειδικότητα στους πίνακες d, dp
and a.diagnosis is not null -- και η διάγνωση  από τον πίνακα a να μην είναι κενή
group by dp.name) c -- ανά ονομασία τμήματος στον νέο πίνακα c που έχει τα ονόματα και τα αθροίσματα των ιατρών του εκάστοτε τμήματος
where c.cnt= (select max(e.cnt) from --όπου το πλήθος είναι ίσο με την επιλογή του μαξ από
(select dp.name as name, count(a.id) as cnt--την εύρεση του ονοματος του τμήματος και το πλήθος από γιατρούς του εκάστοτε τμήματος
from appointments a, doctors d, departments dp --απο τους πίνακες a, d, dp
where a.doctoramka=d.doctoramka and d.specialty=dp.id
and a.diagnosis is not null
group by dp.name) e -- ανά ονομασία τμήματος στον νέο πίνακα e που έχει τα ονόματα και τα πλήθη των ιατρών του εκάστοτε τμήματος
)              



