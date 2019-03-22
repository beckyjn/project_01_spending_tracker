DROP TABLE merchants;
DROP TABLE tags;
DROP TABLE accounts;

CREATE TABLE accounts (
  id SERIAL8 PRIMARY KEY,
  budget INT4
);

CREATE TABLE tags (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE merchants (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255)
);
