#Hospital
create table hospital (
	id varchar(20),
	name varchar(100) NOT NULL,
	phone varchar(20),
	address text NOT NULL,
	description text,
	primary key (id)
);

#Department
create table department (
	id varchar(20),
	hospital_id varchar(20),
	name varchar(100) NOT NULL,
	phone varchar(20),
	address text,
	description text,
	primary key (id),
	foreign key (hospital_id) REFERENCES hospital(id) 
	ON UPDATE CASCADE ON DELETE CASCADE	
);

#Doctor
create table doctor (
	id varchar(20),
	department_id varchar(20),
	password varchar(100) NOT NULL,
	name varchar(100) NOT NULL,
	email varchar(100) UNIQUE NOT NULL,
	phone varchar(20),
	address text,
	primary key (id),
	foreign key (department_id) REFERENCES department(id)
	ON UPDATE CASCADE ON DELETE SET NULL
);

#Nurse
create table nurse (
	id varchar(20),
	department_id varchar(20),
	password varchar(100) NOT NULL,
	name varchar(100) NOT NULL,
	email varchar(100) UNIQUE NOT NULL,
	phone varchar(20),
	address text,
	primary key (id),
	foreign key (department_id) REFERENCES department(id)
	ON UPDATE CASCADE ON DELETE SET NULL
);

#Patient
create table patient (
	id varchar(20),
	password varchar(100) NOT NULL,
	name varchar(100) NOT NULL,
	email varchar(100) UNIQUE NOT NULL,
	phone varchar(20),
	address text,
	age tinyint UNSIGNED,
	gender enum('male', 'female'),
	blood_type varchar(10),
	allergies text,
	primary key (id)
);

#Time slot
create table time_slot (
	id varchar(20),
	doctor_id varchar(20) NOT NULL,
	slot_date date NOT NULL,
	slot_time time NOT NULL,
	n_total int NOT NULL,
	n_booked int DEFAULT 0 ,
	primary key (id),
	foreign key (doctor_id) references doctor(id)
);

#Application-Appointment
create table application (
	id varchar(20),
	time_slot_id varchar(20),
	doctor_id varchar(20),
	approver_id varchar(20),
	patient_id varchar(20),
	app_timestamp timestamp,
	symptoms text,
	status enum('approved', 'rejected', 'pending', 'finished') DEFAULT 'pending' NOT NULL,
	reject_reason text,
	primary key (id),
	foreign key (time_slot_id) references time_slot(id),
	#??????
	foreign key (doctor_id) references doctor(id),
	foreign key (approver_id) references nurse(id),
	foreign key (patient_id) references patient(id)
);

#Medical record
create table medical_record (
	id varchar(20),
	patient_id varchar(20),
	appt_id varchar(20),
	nurse_id varchar(20),
	body_temperature float(1),
	body_pressure float(1),
	heart_rate int,
	weight float(1),
	state enum('conscious', 'coma') DEFAULT 'conscious',
	primary key (id),
	foreign key (patient_id) references patient(id),
	foreign key (appt_id) references application(id),
	foreign key (nurse_id) references nurse(id)
);

#Prescription
create table prescription (
	id varchar(20),
	mc_id varchar(20),
	medicine text,
	dose text,
	comments text,
	primary key (id),
	foreign key (mc_id) references medical_record(id)
);

#Lab report type
create table lab_report_type (
	type varchar(50),
	description text,
	primary key (type)
);

#Lab repot
create table lab_report (
	id varchar(20),
	type varchar(50),
	medical_record_id varchar(20),
	uploader_id varchar(20),
	patient_id varchar(20),
	file longblob,
	comments text,
	primary key (id),
	foreign key (type) REFERENCES lab_report_type(type)
	ON UPDATE CASCADE,
	foreign key (medical_record_id) REFERENCES medical_record(id)
	ON UPDATE CASCADE,
	foreign key (uploader_id) REFERENCES nurse(id)
	ON UPDATE CASCADE,
	foreign key (patient_id) REFERENCES patient(id)
	ON UPDATE CASCADE
);


