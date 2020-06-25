SELECT city, COUNT(reservations.*) AS "total"
FROM properties JOIN reservations ON properties.id = property_id
GROUP BY city
ORDER BY "total" DESC;