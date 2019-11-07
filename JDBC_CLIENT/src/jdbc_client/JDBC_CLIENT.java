package jdbc_client;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.Scanner;
/**
 *
 * @author Παναγιώτης Πράττης
 */
public class JDBC_CLIENT {


    public static void main(String[] args) {
        Connection c = null;
        Statement stmt=null;
        ResultSet rs=null;
        Scanner reader = new Scanner(System.in);

        System.out.println("Give Password for postgres database:");
        String pass = reader.nextLine();
        System.out.println();
        
        try {
            c = DriverManager.getConnection("jdbc:postgresql://Localhost/postgres", "postgres", pass);
            
            System.out.println("Opened database successfully\n");
            
            stmt = c.createStatement();
            
            System.out.println("Create statement successfully\n");                                  
            
            System.out.println("These are the queries:\n"
                    + "a) Ποια είναι τα φάρμακα (μέγιστο και ελάχιστο πλήθος) που συνταγογραφούνται. Στο\n" +
                    "αποτέλεσμα πρέπει να εμφανίζονται ποσότητα και όνομα φαρμάκου.\n"
                    + "b) Ποιες είναι οι διαγνώσεις της τελευταίας εβδομάδας.\n"
                    + "c) Ποια είναι τα ραντεβού του γιατρού ‘X’ τον τελευταία μήνα.\n"
                    + "d) Ποιοι είναι οι ασθενείς που τους έχουν δει παραπάνω από ένας γιατροί.\n"
                    + "e) Από ποιο τμήμα έχουν εξεταστεί οι περισσότεροι ασθενείς.\n"
                    + "f) Ποιος είναι ο μέσος αριθμός των ασθενών που έχουν εξεταστεί (δηλαδή, υπάρχει\n" +
                    "διάγνωση) ανά τμήμα.\n"
                    ); 
            
            String querya="select c.cnt as max_min_counts, c.drug_name \n" +
                "from\n" +
                "(\n" +
                "select count (mf.drug_id) as cnt , d.name as drug_name\n" +
                "from medicalfolders mf, drugs d\n" +
                "where mf.drug_id=d.id\n" +
                "group by  d.name\n" +
                ") c\n" +
                "where c.cnt=\n" +
                "(\n" +
                "select min (e.cnt) from\n" +
                "(select count (mf.drug_id) as cnt, d.name \n" +
                "from medicalfolders mf, drugs d\n" +
                "where mf.drug_id=d.id\n" +
                "group by d.name) e\n" +
                ")or\n" +
                "c.cnt=\n" +
                "(\n" +
                "select max (e.cnt) from\n" +
                "(select count (mf.drug_id) as cnt, d.name \n" +
                " from medicalfolders mf, drugs d\n" +
                "where mf.drug_id=d.id\n" +
                "group by d.name) e\n" +
                ")";
                       
            String queryb="select a.diagnosis, a.t as date\n" +
                "from appointments a, medicalfolders m\n" +
                "where a.patientamka=m.patientamka\n" +
                "and a.diagnosis is not null\n" +
                "and a.t > (select date(max(t))from appointments) - integer '7'";
            
            //δεν θα χρησιμοποιηθεί το queryc αλλά αυτούσιος ο κώδικας του στο executeQuery() 
            //για να γίνει σωστά η αρχικοποίηση του amka γιατί αλλιώς θα είναι με οτι 
            //το αρχικοποιώ στην επόμενη γραμμή και δεν θα μπορώ να το αλλάξω
            String amka="";
            String queryc="select p.name as patient_name, p.surname as patient_surname, a.t as date\n" +
                "from appointments a, doctors d, patients p\n" +
                "where a.patientamka=p.patientamka and a.doctoramka=d.doctoramka\n" +
                "and a.t>(select date(max(t))from appointments) - integer '30'\n" +
                "--and a.t>current_date-30\n" +
                "and d.doctoramka='"+amka+"'";
            
            
            String queryd="select p.name as patient_name, p.surname as patient_surname, \n" +
                "count(distinct doctoramka) as distinct_doctors_count\n" +
                "from appointments a, patients p\n" +
                "where a.patientamka=p.patientamka \n" +
                "group by p.name, p.surname\n" +
                "having count(*)>1";
            
            String querye="select c.name as most_visited_departments from\n" +
                "(select dp.name as name, count(a.id) as cnt\n" +
                "from appointments a, doctors d, departments dp\n" +
                "where a.doctoramka=d.doctoramka and d.specialty=dp.id\n" +
                "and a.diagnosis is not null\n" +
                "group by dp.name) c\n" +
                "where c.cnt= (select max(e.cnt) from \n" +
                "(select dp.name as name, count(a.id) as cnt\n" +
                "from appointments a, doctors d, departments dp\n" +
                "where a.doctoramka=d.doctoramka and d.specialty=dp.id\n" +
                "and a.diagnosis is not null\n" +
                "group by dp.name) e\n"+
                ")";
            
            String queryf="select avg(c.cnt) as average_diagnosed_patients from\n" +
                "(select dp.name as name, count(a.id) as cnt\n" +
                "from appointments a, doctors d, departments dp\n" +
                "where a.doctoramka=d.doctoramka and d.specialty=dp.id\n" +
                "and a.diagnosis is not null\n" +
                "group by dp.name) c";
            
            String input="";           
            boolean b=false;
            
            while(true){
                b=false;
                System.out.println("Give a letter from a to f to execute a query or give 'END' to stop the procedure.\n");
                while(!b){
                    input = reader.nextLine();
                    if("a".equals(input) || "b".equals(input) || "c".equals(input) || "d".equals(input) || "e".equals(input) || "f".equals(input) || "END".equals(input))
                        b=true;                   
                    else
                        System.out.println("Give a letter from a to f or 'END'");
                }
                
                if("a".equals(input)){
                    rs = stmt.executeQuery(querya);
                    while ( rs.next() ) {
                        String maxmincounts = rs.getString(1);
                        String drugnames = rs.getString(2);

                        System.out.println( "Max & Min Counts = " + maxmincounts );
                        System.out.println( "Drug Names = " + drugnames );

                        System.out.println();

                    }
                }
                else if("b".equals(input)){
                    rs = stmt.executeQuery(queryb);
                    while ( rs.next() ) {
                        String diagnosis = rs.getString(1);
                        String date = rs.getString(2);

                        System.out.println( "Diagnosis = " + diagnosis );
                        System.out.println( "Date = " + date );

                        System.out.println();

                    }
                }
                else if("c".equals(input)){
                    System.out.println("Give doctor AMKA");                    
                    amka = reader.nextLine();
                    //rs = stmt.executeQuery(queryc);--δεν λειτουργεί γιατί πρεπει κάθε φορά να αρχικοποιούμε νέο amka 
                    rs = stmt.executeQuery("select p.name as patient_name, p.surname as patient_surname, a.t as date\n" +
                                            "from appointments a, doctors d, patients p\n" +
                                            "where a.patientamka=p.patientamka and a.doctoramka=d.doctoramka\n" +
                                            "and a.t>(select date(max(t))from appointments) - integer '30'\n" +
                                            "--and a.t>current_date-30\n" +
                                            "and d.doctoramka='"+amka+"'");
                    int count=0;
                    while ( rs.next() ) {
                        count++;
                        String patientname = rs.getString(1);
                        String patientsurname = rs.getString(2);
                        String date = rs.getString(3);

                        System.out.println( "Patient Name = " + patientname );
                        System.out.println( "Patient Surname = " + patientsurname );
                        System.out.println( "Date = " + date );

                        System.out.println();

                        }
                        if(count==0)
                            System.out.println("This doctor had no dates the past month or AMKA is wrong\n");
                                       
                }
                else if("d".equals(input)){
                    rs = stmt.executeQuery(queryd);
                    while ( rs.next() ) {
                        String patientname = rs.getString(1);
                        String patientsurname = rs.getString(2);
                        String distinctdoctorscount = rs.getString(3);

                        System.out.println( "Patient Name = " + patientname );
                        System.out.println( "Patient Surname = " + patientsurname );
                        System.out.println( "Number of different doctors = " + distinctdoctorscount );

                        System.out.println();

                    }
                }
                else if("e".equals(input)){
                    rs = stmt.executeQuery(querye);
                    while ( rs.next() ) {
                        String department = rs.getString(1);                      

                        System.out.println( "Most Visited Department(s) = " + department );
                       
                        System.out.println();

                    }
                }
                else if("f".equals(input)){
                    rs = stmt.executeQuery(queryf);
                    while ( rs.next() ) {
                        String avgdiagnosedpatients = rs.getString(1);                      

                        System.out.println( "Average Diagnosed Patients = " + avgdiagnosedpatients );
                       
                        System.out.println();

                    }
                }
                else if("END".equals(input))
                        System.exit(1);
                
            }
            
                        
        } catch (SQLException ex) {
            Logger.getLogger(JDBC_CLIENT.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (c != null) {
                    c.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(JDBC_CLIENT.class.getName()).log(Level.SEVERE, null, ex);
            }
        }


    }
    
    
}
