-- Which accounts placed the earliest orders?
SELECT a.name, o.occurred_at
FROM accounts AS a
JOIN orders AS o
ON a.id = o.account_id
ORDER BY occurred_at;

-- Region for each sales rep along with their associated accounts
SELECT  
	a.name AS account, 
	r.name AS region, 
	s.name AS rep
FROM sales_reps AS s
JOIN region AS r
ON s.region_id = r.id
JOIN accounts AS a
ON a.sales_rep_id = s.id
ORDER BY a.name;

-- Number of sales reps in each region
SELECT r.name, COUNT(*) AS num_reps
FROM region AS r
JOIN sales_reps AS s
ON r.id = s.region_id
GROUP BY r.name
ORDER BY num_reps;

-- Average amount spent per order of paper by each account
SELECT a.name, 
	AVG(o.standard_amt_usd) AS avg_stand, 
	AVG(o.gloss_amt_usd) AS avg_gloss, 
	AVG(o.poster_amt_usd) AS avg_post
FROM accounts AS a
JOIN orders AS o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY a.name;

--  Number of times a particular channel was used by each sales rep
SELECT s.name, w.channel, COUNT(*) AS num_events
FROM accounts AS a
JOIN web_events AS w
ON a.id = w.account_id
JOIN sales_reps AS s
ON s.id = a.sales_rep_id
GROUP BY s.name, w.channel
ORDER BY num_events DESC;

-- Number of times a channel was used by each region
SELECT r.name, w.channel, COUNT(*) AS num_events
FROM accounts AS a
JOIN web_events AS w
ON a.id = w.account_id
JOIN sales_reps AS s
ON s.id = a.sales_rep_id
JOIN region AS r
ON r.id = s.region_id
GROUP BY r.name, w.channel
ORDER BY r.name;

--Which account has the most orders?
SELECT a.id, a.name, COUNT(*) AS num_orders
FROM accounts AS a
JOIN orders AS o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY num_orders DESC
LIMIT 1;

--Which account has spent the most with us?
SELECT a.id, a.name, SUM(o.total_amt_usd) AS total_spent
FROM accounts AS a
JOIN orders AS o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent DESC
LIMIT 1;

--Which account has spent the least with us?
SELECT a.id, a.name, SUM(o.total_amt_usd) AS total_spent
FROM accounts AS a
JOIN orders AS o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent
LIMIT 1;

--Which channel was most frequently used by most accounts?
SELECT a.id, a.name, w.channel, COUNT(*) AS use_of_channel
FROM accounts AS a
JOIN web_events AS w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC;

--Who are the top performing Sales reps?
SELECT 
	s.name, 
	COUNT(*) AS num_orders,
	(CASE WHEN COUNT(*) > 200 THEN 'top'
        ELSE 'not' END) AS sales_rep_level
FROM orders AS o
JOIN accounts AS a
ON o.account_id = a.id 
JOIN sales_reps AS s
ON s.id = a.sales_rep_id
GROUP BY s.name
ORDER BY num_orders DESC;

-- Top Sales reps in each region
WITH t1 AS (
     SELECT 
		s.name AS rep_name, 
		r.name AS region_name, 
		SUM(o.total_amt_usd) AS total_amt
      FROM sales_reps AS s
      JOIN accounts AS a
      ON a.sales_rep_id = s.id
      JOIN orders AS o
      ON o.account_id = a.id
      JOIN region AS r
      ON r.id = s.region_id
      GROUP BY rep_name, region_name
      ORDER BY total_amt DESC), 
t2 AS (
      SELECT region_name, MAX(total_amt) total_amt
      FROM t1
      GROUP BY region_name)
SELECT t1.rep_name, t1.region_name, t1.total_amt
FROM t1
JOIN t2
ON t1.region_name = t2.region_name AND t1.total_amt = t2.total_amt;