CREATE OR REPLACE VIEW actor_info AS
SELECT a.actor_id,
       a.first_name,
       a.last_name,
       string_agg(DISTINCT c.name || ': ' || (SELECT string_agg(f.title, ', ')
                                              FROM film f
                                                       JOIN film_category fc_1 USING (film_id)
                                                       JOIN film_actor fa_1 USING (film_id)
                                              WHERE ((fc_1.category_id = c.category_id) AND (fa_1.actor_id = a.actor_id))
                                              GROUP BY fa_1.actor_id), ', ') AS film_info
FROM actor a
         LEFT JOIN film_actor fa USING (actor_id)
         LEFT JOIN film_category fc USING (film_id)
         LEFT JOIN category c USING (category_id)
GROUP BY a.actor_id, a.first_name, a.last_name;


CREATE OR REPLACE VIEW customer_list AS
SELECT cu.customer_id                       AS id,
       cu.first_name || ' ' || cu.last_name AS name,
       a.address,
       a.postal_code                        AS "zip code",
       a.phone,
       city.city,
       country.country,
       CASE
           WHEN cu.activebool THEN 'active'
           ELSE ''
           END                              AS notes,
       cu.store_id                          AS sid
FROM customer cu
         JOIN address a USING (address_id)
         JOIN city USING (city_id)
         JOIN country USING (country_id);


CREATE OR REPLACE VIEW film_list AS
SELECT film.film_id                                                 AS fid,
       film.title,
       film.description,
       category.name                                                AS category,
       film.rental_rate                                             AS price,
       film.length,
       film.rating,
       string_agg(actor.first_name || ' ' || actor.last_name, ', ') AS actors
FROM category
         LEFT JOIN film_category USING (category_id)
         LEFT JOIN film USING (film_id)
         JOIN film_actor USING (film_id)
         JOIN actor USING (actor_id)
GROUP BY film.film_id, film.title, film.description, category.name, film.rental_rate, film.length, film.rating;


CREATE OR REPLACE VIEW nicer_but_slower_film_list AS
SELECT film.film_id     AS fid,
       film.title,
       film.description,
       category.name    AS category,
       film.rental_rate AS price,
       film.length,
       film.rating,
       string_agg(
               initcap(concat(actor.first_name, ' ', actor.last_name)),
               ', ')    AS actors
FROM category
         LEFT JOIN film_category USING (category_id)
         LEFT JOIN film USING (film_id)
         JOIN film_actor USING (film_id)
         JOIN actor USING (actor_id)
GROUP BY film.film_id, film.title, film.description, category.name, film.rental_rate, film.length, film.rating;


CREATE OR REPLACE VIEW sales_by_film_category AS
SELECT c.name        AS category,
       sum(p.amount) AS total_sales
FROM payment p
         JOIN rental r USING (rental_id)
         JOIN inventory i USING (inventory_id)
         JOIN film f USING (film_id)
         JOIN film_category fc USING (film_id)
         JOIN category c USING (category_id)
GROUP BY c.name
ORDER BY total_sales DESC;


CREATE OR REPLACE VIEW sales_by_store AS
SELECT c.city || ', ' || cy.country       AS store,
       m.first_name || ' ' || m.last_name AS manager,
       sum(p.amount)                      AS total_sales
FROM payment p
         JOIN rental r USING (rental_id)
         JOIN inventory i USING (inventory_id)
         JOIN store s USING (store_id)
         JOIN address a USING (address_id)
         JOIN city c USING (city_id)
         JOIN country cy USING (country_id)
         JOIN staff m ON s.manager_staff_id = m.staff_id
GROUP BY cy.country, c.city, s.store_id, m.first_name, m.last_name
ORDER BY cy.country, c.city;


CREATE OR REPLACE VIEW staff_list AS
SELECT s.staff_id                         AS id,
       s.first_name || ' ' || s.last_name AS name,
       a.address,
       a.postal_code                      AS "zip code",
       a.phone,
       city.city,
       country.country,
       s.store_id                         AS sid
FROM staff s
         JOIN address a USING (address_id)
         JOIN city USING (city_id)
         JOIN country USING (country_id);
