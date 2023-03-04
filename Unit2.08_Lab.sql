USE sakila;

#1.Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
SELECT title, length, DENSE_RANK() OVER (ORDER BY length DESC) as length_rating
FROM film
WHERE length IS NOT NULL AND length <> 0;

#2.Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.
SELECT title, length, rating, DENSE_RANK() OVER (PARTITION BY rating ORDER BY length DESC) AS ranking
FROM film
WHERE length IS NOT NULL AND length <> 0;

#3.How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".
SELECT cat.name, COUNT(film_cat.film_id)
FROM category AS cat
INNER JOIN film_category AS film_cat
ON cat.category_id = film_cat.category_id
GROUP BY cat.name
ORDER BY COUNT(film_cat.film_id) DESC
LIMIT 10;

#4.Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
SELECT A.actor_id, A.first_name, A.last_name, COUNT(FA.film_id) as n_films
FROM actor A
JOIN film_actor FA
ON A.actor_id = FA.actor_id
GROUP BY A.actor_id, A.first_name, A.last_name
ORDER BY n_films DESC
LIMIT 1;

#5.Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
SELECT C.customer_id, COUNT(R.rental_id) as n_rentals
FROM customer C
JOIN rental R 
ON C.customer_id = R.customer_id
GROUP BY C.customer_id
ORDER BY n_rentals DESC
LIMIT 1;