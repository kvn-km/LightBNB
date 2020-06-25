-- users            | id, name, email, password
--------------------|
-- properties       | id, owner_id, title, description, thumbnail_photo_url,
--                  | cover_photo_url, cost_per_night, parking_spaces,
--                  | number_of_bathrooms, number_of_bedrooms, country, street,
--                  | city, province, post_code, active
--------------------|
-- reservations     | id, start_date, end_date, property_id, guest_id
--------------------|
-- property_reviews | id, guest_id, property_id, reservation_id, rating, message

DELETE FROM users;
DELETE FROM properties;
DELETE FROM reservations;
DELETE FROM property_reviews;

INSERT INTO users (name, email, password)
VALUES ('Kevin Kim', 'kevin@kvnkm.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u.'),
       ('Joanne Fung', 'joanne@kvnkm.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u.'),
       ('Leona Kim', 'leona@kvnkm.com', '$2a$10$FB/BOAVhpuLvpOREQVmvmezD4ED/.JBIDRh70tGevYzYzQgFId2u.');

INSERT INTO properties(owner_id, title, description, thumbnail_photo_url, cover_photo_url, cost_per_night, parking_spaces, number_of_bathrooms, number_of_bedrooms, country, street, city, province, post_code, active)
VALUES (1, 'Porter', 'A description for Porter', 'https://www.pexels.com/photo/woman-wearing-orange-sweater-2613260/', 'https://www.pexels.com/photo/woman-wearing-orange-sweater-2613260/', 900, 2, 3, 3, 'Canada', 'Porter Ave', 'Vaughan', 'Ontario', 'A1B2C3', true),
       (1, 'Shemer', 'A description for Shemer', 'https://www.pexels.com/photo/woman-wearing-orange-sweater-2613260/', 'https://www.pexels.com/photo/woman-wearing-orange-sweater-2613260/', 1000, 4, 4, 3, 'Canada', 'Shemer Dr', 'Vaughan', 'Ontario', 'B2C3D4', false),
       (2, 'Hiking', 'A description for Hiking', 'https://www.pexels.com/photo/woman-wearing-orange-sweater-2613260/', 'https://www.pexels.com/photo/woman-wearing-orange-sweater-2613260/', 1500, 8, 6, 5, 'Canada', 'Hiking Crt', 'Brampton', 'Ontario', 'C3D4E5', true);

INSERT INTO reservations (start_date, end_date, property_id, guest_id)
VALUES ('2020-01-01', '2020-02-01', 3, 3),
       ('2019-02-03', '2019-03-04', 2, 3),
       ('2018-03-04', '2019-04-05', 1, 3);

INSERT INTO property_reviews (guest_id, property_id, reservation_id, rating, message)
VALUES (3, 1, 3, 5, 'A message for Porter'),
       (3, 2, 2, 5, 'A message for Shemer'),
       (3, 3, 1, 5, 'A message for Hiking');

