# Hospital Management System

## Introduction

The Hospital Management System is a comprehensive web application designed to streamline and automate various processes in a hospital environment. It provides role-based access for different hospital staff members, including clerks, doctors, nurses, lab technicians, and billing clerks, as well as a patient portal.

[Visit our deployed site](https://www.example-hospital-system.com) 

For more details about the development process and challenges overcome, check out our [final project blog article](https://www.example-blog.com/hospital-management-system-journey).

### Author

- [Clever Ncube](https://www.linkedin.com/in/cleverncube) - Full Stack Developer

## Installation

To set up the Hospital Management System locally, follow these steps:

1. Clone the repository:
   ```
   git clone https://github.com/example/hospital-management-system.git
   cd hospital-management-system
   ```

2. Set up a virtual environment:
   ```
   python -m venv venv
   source venv/bin/activate  # On Windows use `venv\Scripts\activate`
   ```

3. Install the required packages:
   ```
   pip install -r requirements.txt
   ```

4. Set up the database:
   ```
   flask db upgrade
   ```

5. Start the development server:
   ```
   flask run
   ```

The application should now be running on `http://localhost:5000`.

## Usage

After installation, you can access the system through the login page. Use the following credentials for testing:

- Clerk: username: clerk1, password: testpass1
- Doctor: username: doctor1, password: testpass2
- Nurse: username: nurse1, password: testpass3
- Patient: username: patient1, password: testpass4

Each role has access to different functionalities:

- Clerks can register new patients, schedule appointments, and manage patient records.
- Doctors can access medical records, add progress notes, and prescribe medications.
- Nurses can update Medication Administration Records and manage patient care notes.
- Patients can view their medical records, appointments, and billing information.

For a full list of features, please refer to our [user manual](https://www.example-hospital-system.com/manual).

## Contributing

We welcome contributions to the Hospital Management System! If you have suggestions for improvements or bug fixes, please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes and commit them (`git commit -am 'Add some feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Create a new Pull Request.
