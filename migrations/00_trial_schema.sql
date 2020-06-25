CREATE TABLE users (
  id SERIAL PRIMARY KEY NOT NULL,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL
);

CREATE TABLE properties (
  id SERIAL PRIMARY KEY NOT NULL,
  owner_id INTEGER REFERENCES users(id),
  title VARCHAR(255) NOT NULL,
  description TEXT,
  cost_per_night INT NOT NULL,
  parking_spaces INT,
  number_of_bathrooms INT,
  number_of_bedrooms INT,
  thumbnail_photo_url VARCHAR(255),
  cover_photo_url VARCHAR(255),
  country VARCHAR(255) NOT NULL,
  province VARCHAR(255) NOT NULL,
  city VARCHAR(255) NOT NULL,
  street VARCHAR(255) NOT NULL,
  post_code VARCHAR(255) NOT NULL,
  is_active BOOLEAN DEFAULT true
  );

CREATE TABLE reservations (
  id SERIAL PRIMARY KEY NOT NULL,
  guest_id INT REFERENCES users(id) NOT NULL,
  property_id INT REFERENCES properties(id) NOT NULL,
  start_date DATE,
  end_date DATE
);

CREATE TABLE property_reviews (
  id SERIAL PRIMARY KEY NOT NULL,
  guest_id INT REFERENCES users(id) NOT NULL,
  property_id INT REFERENCES properties(id) NOT NULL,
  reservation_id INT REFERENCES reservations(id) NOT NULL,
  rating SMALLINT NOT NULL,
  message VARCHAR(255)
);