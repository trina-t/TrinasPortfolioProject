
/*
My primary objective is to derive insightful and data-driven statistics pertaining to customer behaviors 
and order patterns. This aims to provide a comprehensive understanding of the customers' preferences and 
revenue. Through this project, I can find areas of opportunities to capitalize on, identify product trends,
and suggestions for targeted improvements.
*/



/*
1. How many orders were placed in January? And how many of those orders were for an iPhone?
*/

SELECT COUNT(orderID) 
FROM BIT_DB.JanSales
WHERE length(orderID) = 6
AND orderID <> 'Order ID'
AND Product = 'iPhone'



/*
2. Select the customer account numbers for all the orders that were placed in February.
*/
 
SELECT acctnum FROM customers
JOIN FebSales
ON customers.acctnum = FebSales.orderID
WHERE length(orderID) = 6
AND orderID <> 'Order ID'



/*
3. Which product was the cheapest one sold in January, and what was the price? 
*/

SELECT product, MIN(price) FROM JanSales LIMIT 1



/*
4. What is the total revenue for each product sold in January?
*/

SELECT product, sum(quantity)*price as revenue FROM JanSales
WHERE length(orderID) = 6
AND orderID <> 'Order ID'
GROUP BY product



/*
5. How many customers ordered more than 2 products at a time, and what was the average amount spent for those customers? 
*/
SELECT COUNT(distinct cust.acctnum), AVG(quantity*price)
FROM BIT_DB.FebSales Feb
LEFT JOIN BIT_DB.customers cust
ON FEB.orderid=cust.order_id
WHERE Feb.Quantity>2
AND length(orderid) = 6 
AND orderid <> 'Order ID'



/*
6. Which products were sold in February at 548 Lincoln St, Seattle, WA 98101.
How many of each were sold, and what was the total revenue?
*/

SELECT product, quantity, sum(quantity)*price as revenue FROM FebSales
WHERE length(orderID) = 6
AND orderID <> 'Order ID'
AND location = '548 Lincoln St, Seattle, WA 98101'
GROUP BY product



/*
7. List all the products sold in Los Angeles in February, and include how many of each were sold?
*/

SELECT Product, SUM(Quantity) FROM FebSales
WHERE location LIKE '%Los Angeles%'
GROUP BY Product



/*
8. Which locations in New York received at least 3 orders in January, and how many orders did they each receive?
*/

SELECT distinct location, Count(orderID) FROM BIT_DB.JanSales
WHERE length(orderID) = 6
AND orderID <> 'Order ID'
AND location like '%NY%'
GROUP BY location
HAVING COUNT(orderID)>2



/*
9. How many of each type of headphone was sold in February?
*/

SELECT Product, SUM(Quantity) FROM BIT_DB.FebSales
WHERE length(orderID) = 6
AND orderID <> 'Order ID'
AND Product Like '%Headphone%'
GROUP BY Product



/*
10. What was the average amount spent per account in February?
*/

SELECT sum(quantity*price)/count(cust.acctnum)
FROM BIT_DB.FebSales Feb
LEFT JOIN BIT_DB.customers cust
ON FEB.orderid=cust.order_id
WHERE length(orderid) = 6 
AND orderid <> 'Order ID'



/*
11. Which product brought in the most revenue in January and how much revenue did it bring in total?
*/

SELECT product, 
sum(quantity*price)
FROM BIT_DB.JanSales 
GROUP BY product
ORDER BY sum(quantity*price) desc 
LIMIT 1



/*
12. What was the average quantity of products purchased per account in February? 
*/

select sum(quantity)/count(cust.acctnum)
FROM BIT_DB.FebSales Feb
LEFT JOIN BIT_DB.customers cust
ON FEB.orderid=cust.order_id
WHERE length(orderid) = 6 
AND orderid <> 'Order ID'


