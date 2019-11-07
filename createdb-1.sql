CREATE TABLE Departments(
	id SERIAL NOT NULL,
    name TEXT NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE Doctors(
	doctorAMKA BIGINT NOT NULL,
    username TEXT NOT NULL,
    password TEXT NOT NULL,
    name TEXT NOT NULL,
    surname TEXT NOT NULL,
    specialty INTEGER references Departments(id),
    PRIMARY KEY(doctorAMKA)    
);

CREATE TABLE Drugs(
	id SERIAL NOT NULL,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    PRIMARY KEY(id)    
);

CREATE TABLE Patients(
	patientAMKA BIGINT NOT NULL,
    userid TEXT NOT NULL,
    password TEXT NOT NULL,
    name TEXT NOT NULL,
    surname TEXT NOT NULL,
    gender TEXT NOT NULL,
    PRIMARY KEY(patientAMKA)
);

CREATE TABLE Appointments(
	id SERIAL NOT NULL,
    t TIMESTAMP NOT NULL,
    patientAMKA BIGINT references Patients(patientAMKA),
    doctorAMKA BIGINT references Doctors(doctorAMKA),
    diagnosis TEXT,
    PRIMARY KEY(id)    
);

CREATE TABLE MedicalFolders(
	id SERIAL NOT NULL,
    patientAMKA BIGINT references Patients(patientAMKA),
    cure TEXT NOT NULL,
    drug_id INTEGER references Drugs(id),
    PRIMARY KEY(id)
);

COPY Departments FROM 'C:\...location...\departments.csv'
WITH(FORMAT CSV, DELIMITER ',', HEADER);

COPY Drugs FROM 'C:\...location...\drugs.csv'
WITH(FORMAT CSV, DELIMITER ',', HEADER);

COPY Doctors FROM 'C:\...location...\doctor.csv'
WITH(FORMAT CSV, DELIMITER ',', HEADER);

COPY Patients FROM 'C:\...location...\patient.csv'
WITH(FORMAT CSV, DELIMITER ',', HEADER);

COPY Appointments FROM 'C:\...location...\appointments.csv'
WITH(FORMAT CSV, DELIMITER ',', HEADER);

COPY MedicalFolders FROM 'C:\...location...\medical_folder.csv'
WITH(FORMAT CSV, DELIMITER ',', HEADER);

