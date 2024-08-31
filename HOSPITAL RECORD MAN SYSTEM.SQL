-- Step 1: Create the Database
CREATE DATABASE "HOSPITAL_RECORD_MAN_SYSTEM";

-- Connect to the Database
\c HOSPITAL_RECORD_MAN_SYSTEM;

-- Step 2: Create Tables

-- Users Table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    role VARCHAR(20) NOT NULL, -- (Doctor, Nurse, Admin, Patient)
    contact_number VARCHAR(15),
    date_joined TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP
);

-- Patients Table
CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(10) NOT NULL,
    address TEXT NOT NULL,
    contact_number VARCHAR(15),
    emergency_contact VARCHAR(15),
    medical_history TEXT, -- JSON or TEXT depending on storage needs
    insurance_id INTEGER REFERENCES insurance(id)
);

-- Appointments Table
CREATE TABLE appointments (
    id SERIAL PRIMARY KEY,
    patient_id INTEGER REFERENCES patients(id),
    doctor_id INTEGER REFERENCES users(id),
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    reason_for_visit TEXT,
    status VARCHAR(20) NOT NULL, -- (Scheduled, Completed, Cancelled)
    notes TEXT
);

-- Medical Records Table
CREATE TABLE medical_records (
    id SERIAL PRIMARY KEY,
    patient_id INTEGER REFERENCES patients(id),
    doctor_id INTEGER REFERENCES users(id),
    record_date DATE NOT NULL DEFAULT CURRENT_DATE,
    chief_complaint TEXT,
    diagnosis TEXT,
    prescribed_medication TEXT,
    prescribed_tests TEXT,
    prescribed_operations TEXT,
    progress_notes TEXT
);

-- Tests and Results Table
CREATE TABLE tests_results (
    id SERIAL PRIMARY KEY,
    patient_id INTEGER REFERENCES patients(id),
    test_name VARCHAR(100) NOT NULL,
    test_date DATE NOT NULL,
    test_results TEXT,
    doctor_id INTEGER REFERENCES users(id),
    status VARCHAR(20) NOT NULL, -- (Pending, Completed)
    result_date DATE
);

-- Medications Table
CREATE TABLE medications (
    id SERIAL PRIMARY KEY,
    patient_id INTEGER REFERENCES patients(id),
    doctor_id INTEGER REFERENCES users(id),
    medication_name VARCHAR(100) NOT NULL,
    dosage VARCHAR(50) NOT NULL,
    frequency VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    administration_times TEXT -- JSON or TEXT for storing multiple times
);

-- Admissions Table
CREATE TABLE admissions (
    id SERIAL PRIMARY KEY,
    patient_id INTEGER REFERENCES patients(id),
    admission_date DATE NOT NULL,
    admission_time TIME NOT NULL,
    admission_reason TEXT NOT NULL,
    assigned_room VARCHAR(50),
    assigned_bed VARCHAR(50),
    discharge_date DATE,
    discharge_summary TEXT
);

-- Billing Table
CREATE TABLE billing (
    id SERIAL PRIMARY KEY,
    patient_id INTEGER REFERENCES patients(id),
    appointment_id INTEGER REFERENCES appointments(id),
    amount DECIMAL(10, 2) NOT NULL,
    billing_date DATE NOT NULL DEFAULT CURRENT_DATE,
    status VARCHAR(20) NOT NULL, -- (Paid, Unpaid, Partially Paid)
    payment_method VARCHAR(50),
    insurance_claim_id INTEGER REFERENCES insurance_claims(id)
);

-- Insurance Table
CREATE TABLE insurance (
    id SERIAL PRIMARY KEY,
    patient_id INTEGER REFERENCES patients(id),
    insurance_provider VARCHAR(100) NOT NULL,
    policy_number VARCHAR(100) NOT NULL,
    coverage_details TEXT, -- JSON or TEXT
    expiration_date DATE
);

-- Insurance Claims Table
CREATE TABLE insurance_claims (
    id SERIAL PRIMARY KEY,
    insurance_id INTEGER REFERENCES insurance(id),
    billing_id INTEGER REFERENCES billing(id),
    claim_status VARCHAR(20) NOT NULL, -- (Submitted, Approved, Rejected, Pending)
    claim_amount DECIMAL(10, 2) NOT NULL,
    submission_date DATE NOT NULL DEFAULT CURRENT_DATE,
    approval_date DATE
);

-- Referrals Table
CREATE TABLE referrals (
    id SERIAL PRIMARY KEY,
    patient_id INTEGER REFERENCES patients(id),
    referring_doctor_id INTEGER REFERENCES users(id),
    referred_specialist_id INTEGER REFERENCES users(id),
    referral_reason TEXT NOT NULL,
    referral_date DATE NOT NULL DEFAULT CURRENT_DATE,
    status VARCHAR(20) NOT NULL, -- (Pending, Completed, Cancelled)
    specialist_notes TEXT
);

-- Discharge Summaries Table
CREATE TABLE discharge_summaries (
    id SERIAL PRIMARY KEY,
    patient_id INTEGER REFERENCES patients(id),
    doctor_id INTEGER REFERENCES users(id),
    discharge_date DATE NOT NULL,
    summary TEXT NOT NULL,
    follow_up_instructions TEXT,
    next_appointment_date DATE
);

-- Consent Forms Table
CREATE TABLE consent_forms (
    id SERIAL PRIMARY KEY,
    patient_id INTEGER REFERENCES patients(id),
    form_type VARCHAR(50) NOT NULL, -- (Surgery, Treatment, Research, etc.)
    form_date DATE NOT NULL DEFAULT CURRENT_DATE,
    signed_by_patient BOOLEAN NOT NULL DEFAULT FALSE,
    signed_by_doctor BOOLEAN NOT NULL DEFAULT FALSE,
    form_content TEXT -- JSON or File link
);

-- Medical Certificates Table
CREATE TABLE medical_certificates (
    id SERIAL PRIMARY KEY,
    patient_id INTEGER REFERENCES patients(id),
    doctor_id INTEGER REFERENCES users(id),
    certificate_type VARCHAR(50) NOT NULL, -- (Sick Leave, Fitness for Work, etc.)
    issue_date DATE NOT NULL DEFAULT CURRENT_DATE,
    certificate_details TEXT
);

-- Analytics Table
CREATE TABLE analytics (
    id SERIAL PRIMARY KEY,
    report_type VARCHAR(100) NOT NULL, -- (Financial, Patient Outcome, Resource Utilization, etc.)
    generated_date DATE NOT NULL DEFAULT CURRENT_DATE,
    report_data TEXT, -- JSON or File link
    generated_by INTEGER REFERENCES users(id)
);

-- System Settings Table
CREATE TABLE system_settings (
    id SERIAL PRIMARY KEY,
    setting_name VARCHAR(100) NOT NULL,
    setting_value VARCHAR(255) NOT NULL,
    description TEXT
);

-- Notifications Table
CREATE TABLE notifications (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    notification_type VARCHAR(100) NOT NULL, -- (Appointment Reminder, Test Result Ready, etc.)
    notification_message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL DEFAULT 'Unread' -- (Unread, Read)
);
