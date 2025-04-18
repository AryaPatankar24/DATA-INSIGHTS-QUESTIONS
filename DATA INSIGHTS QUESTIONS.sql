USE sakila;

#41. Find the customer who has rented the most films.

SELECT 
c.customer_id,
CONCAT(c.first_name, ' ' , c.last_name) AS Customer_Name,
COUNT(r.rental_id) AS Total_Rentals
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY Total_Rentals DESC
LIMIT 1;

#42. Identify the most popular film category based on the number of rentals.
SELECT 
c.name AS Category_Name,
COUNT(r.rental_id) AS Total_Rentals
FROM rental r 
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON  fc.category_id = c.category_id
GROUP BY c.category_id
ORDER BY Total_Rentals desc
LIMIT 1;

#43. Determine the least rented film and its category. 

SELECT f.title AS Film_Title,
c.name AS Category_Name,
COUNT(r.rental_id) AS Total_Rentals
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, c.category_id
ORDER BY Total_Rentals ASC
LIMIT 1;

#44. List the total revenue generated by each store. 

SELECT s.store_id,
SUM(p.amount) AS Total_Revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
GROUP BY s.store_id
ORDER BY Total_Revenue DESC;

#45. Find the top 5 highest-grossing films.

SELECT f.title AS Film_Title,
SUM(p.amount) AS Total_Revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.film_id
ORDER BY Total_Revenue DESC
LIMIT 1;