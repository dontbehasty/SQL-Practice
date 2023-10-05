-- SQL Practice (https://www.sql-practice.com/)
-- hospital.db
-- Easy Questions

-- Show first name, last name, and gender of patients whose gender is 'M'
SELECT first_name, last_name, gender 
FROM patients
WHERE gender = 'M';

-- Show first name and last name of patients who does not have allergies. (null)
SELECT first_name, last_name
FROM patients
WHERE allergies is null;

-- Show first name of patients that start with the letter 'C'
SELECT first_name
FROM patients
WHERE first_name like 'C%';

-- Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
SELECT first_name, last_name
FROM patients
WHERE weight BETWEEN '100' and '120';

-- Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
UPDATE patients
SET allergies = 'NKA'
WHERE allergies is null;

-- Show first name and last name concatinated into one column to show their full name.
SELECT first_name || ' ' || last_name
FROM patients;

 SELECT
  CONCAT(first_name, ' ', last_name) AS full_name
FROM patients;

-- Show first name, last name, and the full province name of each patient.
SELECT first_name, last_name, province_name
FROM patients, province_names
WHERE patients.province_id = province_names.province_id;

SELECT first_name, last_name, province_name
FROM patients
  JOIN province_names ON province_names.province_id = patients.province_id;

--  Show how many patients have a birth_date with 2010 as the birth year.
SELECT Count (*)
FROM patients
where birth_date like '2010%';

SELECT COUNT(*) AS total_patients
FROM patients
WHERE YEAR(birth_date) = 2010;

SELECT count(first_name) AS total_patients
FROM patients
WHERE birth_date >= '2010-01-01'
  AND birth_date <= '2010-12-31'

-- Show the first_name, last_name, and height of the patient with the greatest height.
SELECT first_name, last_name, height
FROM patients
WHERE height = (SELECT max(height) FROM patients);

SELECT
  first_name,
  last_name,
  MAX(height) AS height
FROM patients;

-- Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000
SELECT *
FROM patients
WHERE patient_id IN ('1','45','534','879','1000');

-- Show the total number of admissions
SELECT COUNT(*) AS total_admissions
FROM admissions;

-- Show all the columns from admissions where the patient was admitted and discharged on the same day.
SELECT *
FROM admissions
WHERE admission_date = discharge_date;

-- Show the patient id and the total number of admissions for patient_id 579.
SELECT patient_id, COUNT(*) AS total_admissions
FROM admissions
WHERE patient_id = 579;

-- Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
SELECT DISTINCT(city) AS unique_cities
FROM patients
WHERE province_id = 'NS';

-- Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70
SELECT first_name, last_name, birth_date 
FROM patients
WHERE height > 160 
AND weight > 70;

-- Write a query to find list of patients first_name, last_name, and allergies from Hamilton where allergies are not null
SELECT first_name, last_name, allergies
FROM patients
WHERE city = 'Hamilton'
AND allergies IS NOT null;