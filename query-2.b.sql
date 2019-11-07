select a.diagnosis, a.t as date -- finds diagnoses and dates
from appointments a, medicalfolders m -- from the appointments and medicalfolders tables
where a.patientamka=m.patientamka -- where the patient's amp of table a corresponds to the amp of table m
and a.diagnosis is not null-- and the diagnosis in table a for this abca is not empty
and a.t > (select date(max(t))from appointments) - integer '7' -- and the date in table a for this code(amka) is up to 7 days before the most recent date
--and a.t>date '2017-05-01' - integer '7' -- or manually specify what is the last date
--and a.t>current_date-7 --or up to 7 days before our current date
