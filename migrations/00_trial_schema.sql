CREATE TABLE addresses
(
  id SERIAL PRIMARY KEY NOT NULL,
  country VARCHAR(255) NOT NULL,
  province VARCHAR(255) NOT NULL,
  city VARCHAR(255) NOT NULL,
  street VARCHAR(255) NOT NULL,
  post_code VARCHAR(255) NOT NULL
);

CREATE TABLE guest
(
  id SERIAL PRIMARY KEY NOT NULL,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL
);

CREATE TABLE owners
(
  id SERIAL PRIMARY KEY NOT NULL,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL
);

CREATE TABLE properties
(
  id SERIAL PRIMARY KEY NOT NULL,
  title VARCHAR(255) NOT NULL,
  description VARCHAR(255),
  cost_per_night INTEGER NOT NULL,
  parking_spaces INTEGER,
  number_of_bathrooms INTEGER,
  number_of_bedrooms INTEGER,
  photo_url VARCHAR(255),
  is_active BOOLEAN DEFAULT t,
  owner_id INTEGER REFERENCES owners(id) NOT NULL,
  address_id INTEGER REFERENCES addresses(id) NOT NULL
);

CREATE TABLE reservations
(
  id SERIAL PRIMARY KEY NOT NULL,
  start_date date,
  end_date date,
  guest_id INTEGER REFERENCES guests(id) NOT NULL,
  property_id INTEGER REFERENCES properties(id) NOT NULL
);

CREATE TABLE reviews
(
  id SERIAL PRIMARY KEY NOT NULL,
  rating INTEGER NOT NULL,
  message VARCHAR(255),
  guest_id INTEGER REFERENCES guests(id) NOT NULL,
  property_id INTEGER REFERENCES properties(id) NOT NULL
);