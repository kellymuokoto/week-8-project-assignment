
-- Clinic Booking System SQL Schema and Sample Data

-- Drop existing tables
DROP TABLE IF EXISTS Prescription, Appointment, Doctor_Specialty, Specialty, Patient, Doctor;

-- Table: Patient
CREATE TABLE Patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other'),
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    address TEXT
);

-- Table: Doctor
CREATE TABLE Doctor (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE,
    years_experience INT DEFAULT 0
);

-- Table: Specialty
CREATE TABLE Specialty (
    specialty_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Table: Doctor_Specialty (M-M)
CREATE TABLE Doctor_Specialty (
    doctor_id INT,
    specialty_id INT,
    PRIMARY KEY (doctor_id, specialty_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id) ON DELETE CASCADE,
    FOREIGN KEY (specialty_id) REFERENCES Specialty(specialty_id) ON DELETE CASCADE
);

-- Table: Appointment
CREATE TABLE Appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    reason TEXT,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id) ON DELETE CASCADE
);

-- Table: Prescription
CREATE TABLE Prescription (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    medication VARCHAR(255) NOT NULL,
    dosage VARCHAR(100) NOT NULL,
    instructions TEXT,
    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id) ON DELETE CASCADE
);

-- Sample Data

-- Patients
INSERT INTO Patient (full_name, date_of_birth, gender, phone, email, address) VALUES
('Fluffy Puppy', '2023-01-11', 'Female', '0712345678', 'fluffy@gmail.com', '12 Main Street'),
('Buster Boer', '2018-12-01', 'Male', '0732223334', 'buster@gmail.com', '45 Side Avenue');

-- Doctors
INSERT INTO Doctor (full_name, email, phone, years_experience) VALUES
('Dr. Kelly Trish', 'kelly.trish@clinic.com', '0744445556', 10),
('Dr. Bongani Allan', 'bongani.allan@clinic.com', '0745556667', 7);

-- Specialties
INSERT INTO Specialty (name) VALUES ('General Practice'), ('Dermatology'), ('Cardiology');

-- Doctor Specialties
INSERT INTO Doctor_Specialty (doctor_id, specialty_id) VALUES
(1, 1), (2, 1), (2, 3);

-- Appointments
INSERT INTO Appointment (patient_id, doctor_id, appointment_date, reason, status) VALUES
(1, 1, '2025-05-15 10:00:00', 'Regular Checkup', 'Scheduled'),
(2, 2, '2025-05-16 09:00:00', 'Chest Pain', 'Scheduled');

-- Prescriptions
INSERT INTO Prescription (appointment_id, medication, dosage, instructions) VALUES
(1, 'Paracetamol', '500mg', 'Take 1 tablet every 6 hours'),
(2, 'Aspirin', '75mg', 'Take once daily with food');
