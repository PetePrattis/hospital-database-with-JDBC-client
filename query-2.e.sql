select c.name as most_visited_departments from -- finds the name from
(select dp.name as name, count(a.id) as cnt-- finding the name and number of ids
from appointments a, doctors d, departments dp -- from tables a, d, dp
where a.doctoramka=d.doctoramka and d.specialty=dp.id -- with the physicians' codes(amka) being assigned to tables a, d and so is the specialty to tables d, dp
and a.diagnosis is not null -- and the diagnosis from table a is not empty
group by dp.name) c -- per department name in the new table c containing the names and totals of the doctors in each department
where c.cnt= (select max(e.cnt) from --where the crowd is equal to the selection of max
(select dp.name as name, count(a.id) as cnt--finding the name of the ward and the number of doctors in the ward
from appointments a, doctors d, departments dp --from tables a, d, dp
where a.doctoramka=d.doctoramka and d.specialty=dp.id
and a.diagnosis is not null
group by dp.name) e -- per department name in the new table e containing the names and numbers of doctors in each department
)              



