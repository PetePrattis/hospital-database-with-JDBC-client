select avg(c.cnt) as average_diagnosed_patients from-- find the average from
(select dp.name as name, count(a.id) as cnt--finding the name and number of ids
from appointments a, doctors d, departments dp --in tables a, d, dp
where a.doctoramka=d.doctoramka and d.specialty=dp.id--with the physicians' plates from tables a, d matched as the specialty from tables d, dp
and a.diagnosis is not null--and the diagnosis is not empty 
group by dp.name) c--per section

