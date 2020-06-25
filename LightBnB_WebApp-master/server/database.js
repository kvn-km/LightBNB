const properties = require('./json/properties.json');
const users = require('./json/users.json');
const { Pool } = require('pg');
const pool = new Pool({
  user: 'vagrant',
  password: '123',
  host: 'localhost',
  database: 'lightbnb'
});

/// Users

const getUserWithEmail = function(email) {
  const queryString = `SELECT * FROM users WHERE email LIKE $1;`;
  const values = `${email}`;
  return pool.query(queryString, [values])
    .then(res => res.rows[0])
    .catch(error => console.log("User Email Error:", error));
};

const getUserWithId = function(id) {
  const queryString = `SELECT * FROM users WHERE id = $1;`;
  const values = `${id}`;
  return pool.query(queryString, [values])
    .then(res => res.rows[0])
    .catch(error => console.log("User ID Error:", error));
};

const addUser = function(user) {
  const insertString = `
    INSERT INTO users (name, password, email)
    VALUES ($1, $2, $3)
    RETURNING *;
  `;
  const values = [`${user.name}`, `${user.password}`, `${user.email}`];
  return pool.query(insertString, values)
    .then(res => res.rows[0].id)
    .catch(error => console.log("User ID Error:", error));
};

/// Reservations

const getAllReservations = function(guest_id, limit = 10) {
  const queryString = `
    SELECT *
    FROM reservations
    WHERE guest_id = $1
    LIMIT $2;
  `;
  const values = [`${guest_id}`, limit];
  return pool.query(queryString, values)
    .then(res => res.rows)
    .catch(error => console.log("Get All Reservations Error:", error));
};

/// Properties

/**
 * Get all properties.
 * @param {{}} options An object containing query options.
 * @param {*} limit The number of results to return.
 * @return {Promise<[{}]>}  A promise to the properties.
 */
const getAllProperties = function(options, limit = 10) {
  const queryParams = [];

  const queryString = `
    SELECT properties.*, avg(property_reviews.rating) as average_rating
    FROM properties
    JOIN property_reviews ON properties.id = property_id    
  `;

  let optionsKeys = Object.keys(options);
  console.log(optionsKeys); // tester
  if (optionsKeys) {
    let hasWhere = false;
    optionsKeys.forEach(option => {
      if (hasWhere = false) {
        queryString += "WHERE ";
        hasWhere = true;
      } else if (hasWhere = true) {
        queryString += "AND ";
      }
      // options
      switch (option) {
        case "city":
          queryParams.push(`%${options.city}%`);
          queryString += `city LIKE $${queryParams.length}`;
          break;
        case "owner_id":
          queryParams.push(`${options.owner_id}`);
          queryString += `owner_id = $${queryParams.length}`;
          break;
        case "minimum_price_per_night":
          queryParams.push(`${options.minimum_price_per_night}`);
          queryString += `cost_per_night >= $${queryParams.length}`;
          break;
        case "maximum_price_per_night":
          queryParams.push(`${options.maximum_price_per_night}`);
          queryString += `cost_per_night <= $${queryParams.length}`;
          break;
        case "minimum_rating":
          queryParams.push(`${options.minimum_rating}`);
          queryString += `average_rating >= $${queryParams.length}`;
          break;
      } // end switch
    }); // end forEach
  }; // end if has options

  queryParams.push(limit);
  queryString += `;
    GROUP BY properties.id;
    ORDER BY cost_per_night;
    LIMIT $${queryParams.length};
  `;

  console.log(queryString, queryParams); // tester

  return pool.query(queryString, queryParams)
    .then(res => res.rows);
};

/**
 * Add a property to the database
 * @param {{}} property An object containing all of the property details.
 * @return {Promise<{}>} A promise to the property.
 */
const addProperty = function(property) {
  const propertyId = Object.keys(properties).length + 1;
  property.id = propertyId;
  properties[propertyId] = property;
  return Promise.resolve(property);
};



// exports

exports.getUserWithEmail = getUserWithEmail;
exports.getUserWithId = getUserWithId;
exports.addUser = addUser;
exports.getAllReservations = getAllReservations;
exports.getAllProperties = getAllProperties;
exports.addProperty = addProperty;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;