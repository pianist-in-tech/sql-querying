-- Comments in SQL Start with dash-dash --
-- 1. Find the app with an ID of 1880.
playstore=# SELECT app_name FROM analytics WHERE ID = 1880;
        app_name         
-------------------------
 Web Browser for Android
(1 row)

--2. Find the ID and app name for all apps that were last updated on August 01, 2018.
playstore=# SELECT ID, app_name from analytics WHERE last_updated = '2018-08-01';
-[ RECORD 1 ]-------------------------------------------------------------------------------
id       | 10
app_name | Clash Royale
-[ RECORD 2 ]-------------------------------------------------------------------------------
id       | 11
app_name | Candy Crush Saga
-[ RECORD 3 ]-------------------------------------------------------------------------------
id       | 12
app_name | UC Browser - Fast Download Private & Secure
-[ RECORD 4 ]-------------------------------------------------------------------------------
id       | 74
app_name | Score! Hero
-[ RECORD 5 ]-------------------------------------------------------------------------------
id       | 101
app_name | Tiny Flashlight + LED
-[ RECORD 6 ]-------------------------------------------------------------------------------
id       | 102

--3. Count the number of apps in each category, e.g. “Family | 1972”.
playstore=# SELECT category, COUNT(*) AS app_count FROM analytics GROUP by category;
-[ RECORD 1 ]------------------
category  | BOOKS_AND_REFERENCE
app_count | 191
-[ RECORD 2 ]------------------
category  | COMMUNICATION
app_count | 342
-[ RECORD 3 ]------------------
category  | BEAUTY
app_count | 46
-[ RECORD 4 ]------------------
category  | EVENTS
app_count | 52
-[ RECORD 5 ]------------------
category  | PARENTING
app_count | 59
-[ RECORD 6 ]------------------
category  | PHOTOGRAPHY
app_count | 313
-[ RECORD 7 ]------------------
category  | GAME
app_count | 1110
-[ RECORD 8 ]------------------
category  | BUSINESS

--4. Find the top 5 most-reviewed apps and the number of reviews for each.
playstore=# SELECT app_name, reviews
playstore-# FROM analytics
playstore-# ORDER BY reviews DESC
playstore-# LIMIT 5;
-[ RECORD 1 ]--------------------------------------
app_name | Facebook
reviews  | 78158306
-[ RECORD 2 ]--------------------------------------
app_name | WhatsApp Messenger
reviews  | 78128208
-[ RECORD 3 ]--------------------------------------
app_name | Instagram
reviews  | 69119316
-[ RECORD 4 ]--------------------------------------
app_name | Messenger – Text and Video Chat for Free
reviews  | 69119316
-[ RECORD 5 ]--------------------------------------
app_name | Clash of Clans
reviews  | 69109672

--5. Find the app that has the most reviews with a rating greater than equal to 4.8.
playstore=# SELECT app_name, reviews
playstore-# FROM analytics
playstore-# WHERE rating >= 4.8
playstore-# ORDER BY reviews DESC
playstore-# LIMIT 1;
-[ RECORD 1 ]--------
app_name | Chess Free
reviews  | 4559407

--6. Find the average rating for each category ordered by the highest rated to lowest rated.
SELECT category, AVG(rating) AS average_rating
FROM analytics
GROUP BY category
ORDER BY average_rating DESC;

--7. Find the name, price, and rating of the most expensive app with a rating that’s less than 3.
playstore=# SELECT app_name, price, rating
playstore-# FROM analytics
playstore-# WHERE rating < 3
playstore-# ORDER BY price DESC
playstore-# LIMIT 1;
-[ RECORD 1 ]----------------
app_name | Naruto & Boruto FR
price    | 379.99
rating   | 2.9

--8. Find all apps with a min install not exceeding 50, that have a rating. Order your results by highest rated first.
playstore=# SELECT *
playstore-# FROM analytics
playstore-# WHERE min_installs <= 50 AND rating IS NOT NULL
playstore-# ORDER BY rating DESC;
-[ RECORD 1 ]---+-----------------------------------------------
id              | 9468
app_name        | DT
category        | FAMILY
rating          | 5
reviews         | 4
size            | 52M
min_installs    | 50
price           | 0
content_rating  | Everyone
genres          | {Education}
last_updated    | 2018-04-03
current_version | 1.1
android_version | 4.1 and up
-[ RECORD 2 ]---+-----------------------------------------------
id              | 9464
app_name        | DQ Akses
category        | PERSONALIZATION
rating          | 5
reviews         | 4
size            | 31M
min_installs    | 50
price           | 0.99

--9. Find the names of all apps that are rated less than 3 with at least 10000 reviews.
playstore=# SELECT app_name
playstore-# FROM analytics
playstore-# WHERE rating < 3 AND reviews >= 10000;
-[ RECORD 1 ]---------------------------------------------
app_name | The Wall Street Journal: Business & Market News
-[ RECORD 2 ]---------------------------------------------
app_name | Vikings: an Archer’s Journey
-[ RECORD 3 ]---------------------------------------------
app_name | Shoot Em Down Free

--10. Find the top 10 most-reviewed apps that cost between 10 cents and a dollar.
playstore=# SELECT app_name, reviews
playstore-# FROM analytics
playstore-# WHERE price >= 0.1 AND price <= 1
playstore-# ORDER BY reviews DESC
playstore-# LIMIT 10;
-[ RECORD 1 ]-----------------------------------------
app_name | Free Slideshow Maker & Video Editor
reviews  | 408292
-[ RECORD 2 ]-----------------------------------------
app_name | Couple - Relationship App
reviews  | 85468
-[ RECORD 3 ]-----------------------------------------
app_name | Anime X Wallpaper
reviews  | 84114
-[ RECORD 4 ]-----------------------------------------
app_name | Dance On Mobile
reviews  | 61264
-[ RECORD 5 ]-----------------------------------------
app_name | Marvel Unlimited
reviews  | 58617
-[ RECORD 6 ]-----------------------------------------
app_name | FastMeet: Chat, Dating, Love
reviews  | 58614
-[ RECORD 7 ]-----------------------------------------
app_name | IHG®: Hotel Deals & Rewards
reviews  | 48754
-[ RECORD 8 ]-----------------------------------------
app_name | Live Weather & Daily Local Weather Forecast

--11. Find the most out of date app. Hint: You don’t need to do it this way, but it’s possible to do with a subquery: http://www.postgresqltutorial.com/postgresql-max-function/
playstore=# SELECT app_name, last_updated
playstore-# FROM analytics
playstore-# WHERE last_updated = (
playstore(#   SELECT MAX(last_updated)
playstore(#   FROM analytics
playstore(# );
-[ RECORD 1 ]+-----------------------------
app_name     | True Skate
last_updated | 2018-08-08
-[ RECORD 2 ]+-----------------------------
app_name     | CBS News
last_updated | 2018-08-08
-[ RECORD 3 ]+-----------------------------
app_name     | Wallpapers Toyota FJ Cruiser
last_updated | 2018-08-08
-[ RECORD 4 ]+-----------------------------
app_name     | ReactNative BG Geolocation
last_updated | 2018-08-08
-[ RECORD 5 ]+-----------------------------
app_name     | QC
last_updated | 2018-08-08

--12. Find the most expensive app (the query is very similar to #11).
playstore=# SELECT app_name, price
playstore-# FROM analytics
playstore-# ORDER BY price DESC
playstore-# LIMIT 1;
-[ RECORD 1 ]----------------
app_name | Cardi B Piano Game
price    | 400

--13. Count all the reviews in the Google Play Store.
playstore=# SELECT SUM(reviews) AS total_reviews
playstore-# FROM analytics;
-[ RECORD 1 ]-+-----------
total_reviews | 4814575866

--14. Find all the categories that have more than 300 apps in them.
playstore=# SELECT category, COUNT(*) AS app_count
playstore-# FROM analytics
playstore-# GROUP BY category
playstore-# HAVING COUNT(*) > 300;
-[ RECORD 1 ]--------------
category  | COMMUNICATION
app_count | 342
-[ RECORD 2 ]--------------
category  | PHOTOGRAPHY
app_count | 313
-[ RECORD 3 ]--------------
category  | GAME
app_count | 1110
-[ RECORD 4 ]--------------
category  | BUSINESS
app_count | 313
-[ RECORD 5 ]--------------
category  | MEDICAL
app_count | 350
-[ RECORD 6 ]--------------
category  | TOOLS
app_count | 753
-[ RECORD 7 ]--------------
category  | LIFESTYLE
app_count | 319
-[ RECORD 8 ]--------------
category  | PRODUCTIVITY

--15. Find the app that has the highest proportion of min_installs to reviews, among apps that have been installed at least 100,000 times. Display the name of the app along with the number of reviews, the min_installs, and the proportion.
playstore=# SELECT app_name, reviews, min_installs, (min_installs::float / reviews) AS proportion
playstore-# FROM analytics
playstore-# WHERE min_installs >= 100000
playstore-# ORDER BY proportion DESC
playstore-# LIMIT 1;
-[ RECORD 1 ]+-------------------
app_name     | Kim Bu Youtuber?
reviews      | 66
min_installs | 10000000
proportion   | 151515.15151515152