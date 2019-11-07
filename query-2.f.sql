select avg(c.cnt) as average_diagnosed_patients from-- εύρεση του μ.ο. από
(select dp.name as name, count(a.id) as cnt--την εύρεση  του ονόματος και του πλήθους των id 
from appointments a, doctors d, departments dp --στους πίνακες a, d, dp
where a.doctoramka=d.doctoramka and d.specialty=dp.id--με τα αμκα των γιατρων από τους πίνακες a, d να αντιστοιχίζονται όπως και η ειδικότητα από τους πίνακες d, dp
and a.diagnosis is not null--και η διάγνωση να μην είναι κενή 
group by dp.name) c--ανά τμήμα

