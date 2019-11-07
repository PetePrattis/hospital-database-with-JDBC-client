select c.cnt as max_min_counts, c.drug_name -- finds the number and the names of the drugs
from --από
(
select count (mf.drug_id) as cnt , d.name as drug_name -- finding the sum of drugs and names 
from medicalfolders mf, drugs d -- from tables mf, d
where mf.drug_id=d.id -- having the drugs from the mf table match the drug id from the table d
group by  d.name --per drug name
) c -- the new table c with the number of medicines given for treatment, by drug name
where c.cnt= --whose number in the table c is equal to
(
select min (e.cnt) from -- the minimum number of loans
	(select count (mf.drug_id) as cnt, d.name 
	 from medicalfolders mf, drugs d
	 where mf.drug_id=d.id
		group by d.name) e -- per drug name
)	or
c.cnt= -- or the maximum number of administration of drug
(
select max (e.cnt) from -- 
	(select count (mf.drug_id) as cnt, d.name 
	 from medicalfolders mf, drugs d
	 where mf.drug_id=d.id
		group by d.name) e -- per drug name
)	
