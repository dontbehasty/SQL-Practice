-- SQL Practice (https://www.sql-practice.com/)
-- hospital.db
-- Medium Questions

-- Show unique birth years from patients and order them by ascending.
SELECT DISTINCT YEAR(birth_date) AS birth_year
FROM patients
ORDER BY birth_year;

SELECT year(birth_date)
FROM patients
GROUP BY year(birth_date);

-- Show unique first names from the patients table which only occurs once in the list.
-- For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output.
SELECT first_name
FROM patients
GROUP BY first_name
HAVING count(first_name) = 1;

SELECT first_name
FROM (
    SELECT
      first_name,
      count(first_name) AS occurrencies
    FROM patients
    GROUP BY first_name
  )
WHERE occurrencies = 1;

-- Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
SELECT patient_id, first_name
FROM patients
WHERE first_name LIKE "s%s"
AND LEN(first_name) >= 6;

SELECT
  patient_id,
  first_name
FROM patients
WHERE first_name LIKE 's____%s';

SELECT
  patient_id,
  first_name
FROM patients
WHERE
  first_name LIKE 's%'
  AND first_name LIKE '%s'
  AND len(first_name) >= 6;

-- Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'. 
-- Primary diagnosis is stored in the admissions table.
SELECT a.patient_id, p.first_name, p.last_name
FROM patients p, admissions a
WHERE p.patient_id = a.patient_id
AND diagnosis = 'Dementia';

SELECT
  patients.patient_id,
  first_name,
  last_name
FROM patients
  JOIN admissions ON admissions.patient_id = patients.patient_id
WHERE diagnosis = 'Dementia';

SELECT
  patient_id,
  first_name,
  last_name
FROM patients
WHERE patient_id IN (
    SELECT patient_id
    FROM admissions
    WHERE diagnosis = 'Dementia'
  );

-- Display every patient's first_name. Order the list by the length of each name and then by alphbetically
SELECT first_name
FROM patients
ORDER BY len(first_name) ASC, first_name ASC;

-- Show the total amount of male patients and the total amount of female patients in the patients table.
-- Display the two results in the same row.
SELECT
(SELECT COUNT(*) from patients WHERE gender = 'M') AS Male_Count,
(SELECT COUNT(*) from patients WHERE gender = 'F') AS Female_Count;

SELECT 
  SUM(Gender = 'M') as male_count, 
  SUM(Gender = 'F') AS female_count
FROM patients

SELECT 
  sum(case when gender = 'M' then 1 end) as male_count,
  sum(case when gender = 'F' then 1 end) as female_count 
FROM patients;

-- Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. 
-- Show results ordered ascending by allergies then by first_name then by last_name.
SELECT first_name, last_name, allergies
FROM patients
WHERE allergies IN ('Penicillin', 'Morphine')
ORDER BY allergies, first_name, last_name;

SELECT
  first_name,
  last_name,
  allergies
FROM
  patients
WHERE
  allergies = 'Penicillin'
  OR allergies = 'Morphine'
ORDER BY
  allergies ASC,
  first_name ASC,
  last_name ASC;

  -- Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
SELECT patient_id, diagnosis
FROM admissions
GROUP BY patient_id, diagnosis
HAVING count(diagnosis) > 1;

-- Show the city and the total number of patients in the city.
-- Order from most to least patients and then by city name ascending.
SELECT city, COUNt(patient_id)
FROM patients
GROUP BY city
ORDER BY COUNt(patient_id) DESC, city ASC;

-- Show first name, last name and role of every person that is either patient or doctor. The roles are either "Patient" or "Doctor"
SELECT first_name, last_name, 'Patient' AS Role from patients
UNION ALL
SELECT first_name, last_name, 'Doctor' AS Role from doctors;

-- Show all allergies ordered by popularity. Remove NULL values from query.
SELECT allergies, COUNT(*) AS allergies_count 
FROM patients
WHERE allergies is not null
GROUP BY allergies
ORDER BY allergies_count DESC;

SELECT
  allergies,
  count(*)
FROM patients
WHERE allergies NOT NULL
GROUP BY allergies
ORDER BY count(*) DESC

SELECT
  allergies,
  count(allergies) AS total_diagnosis
FROM patients
GROUP BY allergies
HAVING
  allergies IS NOT NULL
ORDER BY total_diagnosis DESC

-- Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. 
-- Sort the list starting from the earliest birth_date.
SELECT first_name, last_name, birth_date 
FROM patients
WHERE birth_date >= '1970-01-01' 
AND birth_date <= '1979-12-31'
ORDER BY birth_date;

SELECT
  first_name,
  last_name,
  birth_date
FROM patients
WHERE
  YEAR(birth_date) BETWEEN 1970 AND 1979
ORDER BY birth_date ASC;

SELECT
  first_name,
  last_name,
  birth_date
FROM patients
WHERE year(birth_date) LIKE '197%'
ORDER BY birth_date ASC

-- We want to display each patient's full name in a single column. 
-- Their last_name in all upper letters must appear first, then first_name in all lower case letters. 
--Separate the last_name and first_name with a comma. Order the list by the first_name in decending order EX: SMITH,jane
SELECT CONCAT(UPPER(last_name),',', lower(first_name)) AS full_name
FROM patients
ORDER BY first_name DESC;

SELECT UPPER(last_name) || ',' || LOWER(first_name) AS new_name_format
FROM patients
ORDER BY first_name DESC;

-- Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
SELECT province_id, SUM(height) AS sum_height
FROM patients
GROUP BY province_id
HAVING SUM(height) > 7000;

-- Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
SELECT (MAX(weight) - Min(weight)) AS weight_difference
FROM patients
WHERE last_name = 'Maroni';

-- Show all of the days of the month (1-31) and how many admission_dates occurred on that day. 
-- Sort by the day with most admissions to least admissions.
SELECT DAY(admission_date), COUNT(*)
FROM admissions
GROUP BY DAY(admission_date)
ORDER BY COUNT(*) DESC;

SELECT
  DAY(admission_date) AS day_number,
  COUNT(*) AS number_of_admissions
FROM admissions
GROUP BY day_number
ORDER BY number_of_admissions DESC

-- Show all columns for patient_id 542's most recent admission_date.
SELECT *
FROM admissions
WHERE patient_id = '542'
AND admission_date = (
	SELECT MAX(admission_date)
  	FROM admissions
	WHERE patient_id = '542'
);

SELECT *
FROM admissions
WHERE patient_id = 542
GROUP BY patient_id
HAVING
  admission_date = MAX(admission_date);

SELECT *
FROM admissions
WHERE patient_id = 542
ORDER BY admission_date DESC
LIMIT 1

SELECT *
FROM admissions
GROUP BY patient_id
HAVING
  patient_id = 542
  AND max(admission_date)

-- Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
-- 1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
-- 2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.
SELECT patient_id, attending_doctor_id, diagnosis
FROM admissions
WHERE (patient_id % 2 <> 0
    AND attending_doctor_id IN ('1', '5', '19'))
OR (attending_doctor_id LIKE ('%2%')
    AND LEN(patient_id) = 3);

-- Show first_name, last_name, and the total number of admissions attended for each doctor.
-- Every admission has been attended by a doctor.
SELECT d.first_name, d.last_name, count(*)
FROM admissions a, doctors d
WHERE a.attending_doctor_id = d.doctor_id
GROUP BY a.attending_doctor_id;

SELECT
  first_name,
  last_name,
  count(*) AS admissions_total
FROM admissions a
  JOIN doctors ph ON ph.doctor_id = a.attending_doctor_id
GROUP BY attending_doctor_id

-- For each doctor, display their id, full name, and the first and last admission date they attended.
SELECT d.doctor_id, (d.first_name || " " || d.last_name) AS full_name,
	(SELECT MIN(a.admission_date) from admissions) AS first_date,
    (SELECT MAX(a.admission_date) from admissions) AS last_date
FROM admissions a, doctors d
WHERE a.attending_doctor_id = d.doctor_id
GROUP BY a.attending_doctor_id;

select
  doctor_id,
  first_name || ' ' || last_name as full_name,
  min(admission_date) as first_admission_date,
  max(admission_date) as last_admission_date
from admissions a
  join doctors ph on a.attending_doctor_id = ph.doctor_id
group by doctor_id;

-- Display the total amount of patients for each province. Order by descending.
SELECT pn.province_name, COUNT(p.patient_id) as total_patients
FROM province_names pn, patients p
WHERE pn.province_id = p.province_id
GROUP BY pn.province_name
ORDER BY total_patients DESC;

SELECT
  province_name,
  COUNT(*) as patient_count
FROM patients pa
  join province_names pr on pr.province_id = pa.province_id
group by pr.province_id
order by patient_count desc;

-- For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.
SELECT (p.first_name || ' ' || p.last_name) as patient_name,
	    a.diagnosis,
       (d.first_name || ' ' || d.last_name) as doctor_name
FROM admissions a 
JOIN patients p ON p.patient_id = a.patient_id
JOIN doctors d ON a.attending_doctor_id = d.doctor_id;

SELECT
  CONCAT(patients.first_name, ' ', patients.last_name) as patient_name,
  diagnosis,
  CONCAT(doctors.first_name,' ',doctors.last_name) as doctor_name
FROM patients
  JOIN admissions ON admissions.patient_id = patients.patient_id
  JOIN doctors ON doctors.doctor_id = admissions.attending_doctor_id;

-- Display the number of duplicate patients based on their first_name and last_name.
SELECT first_name, last_name, COUNT(*) AS duplicates
FROM patients
group by first_name, last_name
having duplicates > 1;

-- Display patient's full name, height in the units feet rounded to 1 decimal,
-- weight in the unit pounds rounded to 0 decimals, birth_date, gender non abbreviated.
-- Convert CM to feet by dividing by 30.48.
-- Convert KG to pounds by multiplying by 2.205.
SELECT (first_name || ' ' || last_name) as full_name,
		ROUND((height/30.48), 1) AS height,
        ROUND((weight*2.205), 0) As weight,
        birth_date,
        CASE
          WHEN gender = 'M' THEN 'Male'
          WHEN gender = 'F' THEN 'Female'
  		END AS gender
FROM patients;

select
    concat(first_name, ' ', last_name) AS 'patient_name', 
    ROUND(height / 30.48, 1) as 'height "Feet"', 
    ROUND(weight * 2.205, 0) AS 'weight "Pounds"', birth_date,
CASE
	WHEN gender = 'M' THEN 'MALE' 
  ELSE 'FEMALE' 
END AS 'gender_type'
FROM patients


-- Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. 
-- (Their patient_id does not exist in any admissions.patient_id rows.)
SELECT p.patient_id, p.first_name, p.last_name
FROM patients p
WHERE NOT EXISTS (SELECT b.patient_id
                  FROM admissions b
                  WHERE b.patient_id = p.patient_id);

SELECT
  patients.patient_id,
  first_name,
  last_name
from patients
where patients.patient_id not in (
    select admissions.patient_id
    from admissions
  )

SELECT
  patients.patient_id,
  first_name,
  last_name
from patients
  left join admissions on patients.patient_id = admissions.patient_id
where admissions.patient_id is NULL