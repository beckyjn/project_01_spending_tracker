DROP TABLE transactions;
DROP TABLE merchants;
DROP TABLE tags;
DROP TABLE accounts;


CREATE TABLE accounts (
  id SERIAL8 PRIMARY KEY,
  budget DECIMAL(7,2)
);

CREATE TABLE tags (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE merchants (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE transactions (
  id SERIAL8 PRIMARY KEY,
  tag_id INT8 REFERENCES tags(id) ON DELETE CASCADE,
  merchant_id INT8 REFERENCES merchants(id) ON DELETE CASCADE,
  account_id INT8 REFERENCES accounts(id) ON DELETE CASCADE,
  spend DECIMAL(7,2),
  date DATE
);
