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

/* Create the junction table for medical_histories and treatments */

ALTER TABLE invoice_items
ADD FOREIGN KEY (treatment_id) REFERENCES medical_histories(id);

-- Indexes
CREATE INDEX medical_histories_id_index ON medical_histories_and_treatments_junction_table(medical_histories_id DESC);
CREATE INDEX treatments_id_index ON medical_histories_and_treatments_junction_table(treatments_id DESC);

/* Set Foreign Keys */

/* medical_histories */

BEGIN;

ALTER TABLE medical_histories
ADD FOREIGN KEY (patient_id) REFERENCES patients(id);

COMMIT;

/* invoice_items */

BEGIN;

ALTER TABLE invoice_items
ADD FOREIGN KEY (treatment_id) REFERENCES treatments(id);

ALTER TABLE invoice_items
ADD FOREIGN KEY (invoice_id) REFERENCES medical_histories(id);

COMMIT;

/* invoices */

BEGIN;

ALTER TABLE invoices
ADD FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id);

COMMIT;
