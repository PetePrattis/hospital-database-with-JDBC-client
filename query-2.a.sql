select c.cnt as max_min_counts, c.drug_name -- βρίσκει τα πλήθη και τα ονόματα των φαρμάκων
from --από
(
select count (mf.drug_id) as cnt , d.name as drug_name -- την εύρεση του αθροίσματος των φαρμάκων και των ονομάτων 
from medicalfolders mf, drugs d -- από του πίνακες mf, d
where mf.drug_id=d.id -- έχοντας τα φάρμακα απο τον πίνακα mf να αντιστοιχίζονται σε id φαρμάκου από τον πίνακα d
group by  d.name --ανά ονομασία φαρμάκου
) c -- ο νέος πίνακας c με το πλήθος των φαρμάκων που έχουν χορηγηθεί για θεραπεία, ανά ονομασία φαρμάκου
where c.cnt= --που το πλήθος χορήγησής τους στον τον πίνακα c ισούται με
(
select min (e.cnt) from -- τον ελάχιστο αριθμό χορηγήσεων
	(select count (mf.drug_id) as cnt, d.name 
	 from medicalfolders mf, drugs d
	 where mf.drug_id=d.id
		group by d.name) e -- ανά ονομασία φαρμάκου
)	or
c.cnt= -- ή το μέγιστο αριθμό χορηγήσεων
(
select max (e.cnt) from -- 
	(select count (mf.drug_id) as cnt, d.name 
	 from medicalfolders mf, drugs d
	 where mf.drug_id=d.id
		group by d.name) e -- ανά ονομασία φαρμάκου
)	
