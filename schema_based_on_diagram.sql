/* Create Tables */

CREATE TABLE invoice_items (
  id SERIAL PRIMARY KEY,
  unit_price DECIMAL,
  quantity INTEGER,
  total_price DECIMAL,
  invoice_id INTEGER,
  treatment_id INTEGER
)


CREATE TABLE treatments (
  id SERIAL PRIMARY KEY,
  type VARCHAR(50),
  name VARCHAR(100)
)

CREATE TABLE medical_histories (
  id SERIAL PRIMARY KEY,
  admitted_at TIMESTAMP,
  patient_id INTEGER,
  status VARCHAR(50)
)

CREATE TABLE patients (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  date_of_birth DATE
)

CREATE TABLE invoices (
  id SERIAL PRIMARY KEY,
  total_amount DECIMAL,
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INTEGER
)

/* Set Foreign Keys */

/* medical_histories */

BEGIN;

ALTER TABLE medical_histories
ADD FOREIGN KEY (patient_id) REFERENCES patients(id);

ALTER TABLE medical_histories
ADD FOREIGN KEY (id) REFERENCES treatments(id);

COMMIT;

/* invoice_items */

BEGIN;

ALTER TABLE invoice_items
ADD FOREIGN KEY (treatment_id) REFERENCES treatments(id);

COMMIT;

/* invoices */

BEGIN;

ALTER TABLE invoices
ADD FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id);

COMMIT;
