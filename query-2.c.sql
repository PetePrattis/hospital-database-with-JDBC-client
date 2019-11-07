select p.name as patient_name, p.surname as patient_surname, a.t as date -- finds name, surname, and date
from appointments a, doctors d, patients p --from tables a, d, p
where a.patientamka=p.patientamka and a.doctoramka=d.doctoramka -- with patient and doctor codes(amka) from table a corresponding to amka from p and d
and a.t>(select date(max(t))from appointments) - integer '30' --and the date in table a for these abacus is up to 30 days before the most recent date
--and a.t>current_date-30
and d.doctoramka='3531589109644678'-- provided that the doctor's amp in table d is '3531589109644678'
--and d.name='Kevin' and d.surname='Arnold'
