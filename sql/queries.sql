    --Top 5 ռեստորաններ ըստ եկամտի + միջին delivery ժամանակ--
SELECT
    r.RestaurantName,
    r.Cuisine,
    r.Zone,
    COUNT(o.OrderID)              AS TotalOrders,
    ROUND(SUM(o.OrderAmount), 2)  AS TotalRevenue,
    ROUND(AVG(o.DeliveryTime), 1) AS AvgDeliveryMins,
    ROUND(AVG(od.FoodRating), 2)  AS AvgFoodRating
FROM orders o
JOIN restaurants  r  ON o.RestaurantID = r.RestaurantID
JOIN order_details od ON o.OrderID     = od.OrderID
GROUP BY r.RestaurantID
ORDER BY TotalRevenue DESC
LIMIT 5;


--Payment mode breakdown —-
SELECT
    PaymentMode,
    COUNT(*) AS OrderCount,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS PctOfTotal,
    ROUND(AVG(OrderAmount), 2)                        AS AvgOrderValue
FROM orders
GROUP BY PaymentMode
ORDER BY OrderCount DESC;


--VIP customers — (top 10)  + նրանց միջին food rating-ը--
SELECT
    c.CustomerName,
    COUNT(o.OrderID)              AS TotalOrders,
    ROUND(SUM(o.OrderAmount), 2)  AS TotalSpent,
    ROUND(AVG(od.FoodRating), 2)  AS AvgFoodRating,
    ROUND(AVG(od.DeliveryRating), 2) AS AvgDeliveryRating
FROM orders o
JOIN customers     c  ON o.CustomerID = c.CustomerID
JOIN order_details od ON o.OrderID    = od.OrderID
GROUP BY c.CustomerID
ORDER BY TotalSpent DESC
LIMIT 10;


--Zone performance-
SELECT
    r.Zone,
    COUNT(o.OrderID) AS TotalOrders,
    ROUND(AVG(o.DeliveryTime), 1) AS AvgDeliveryMins,
    ROUND(AVG(od.FoodRating), 2) AS AvgFoodRating,
    ROUND(AVG(od.DeliveryRating), 2) AS AvgDeliveryRating,
    ROUND(SUM(o.OrderAmount), 2) AS TotalRevenue
FROM orders o
JOIN restaurants   r  ON o.RestaurantID = r.RestaurantID
JOIN order_details od ON o.OrderID      = od.OrderID
GROUP BY r.Zone
ORDER BY AvgDeliveryMins ASC;


--Slow delivery detector — orders where delivery took more than 1.5× the restaurant's own average--
WITH RestaurantAvg AS (
    SELECT
        RestaurantID,
        AVG(DeliveryTime) AS AvgDelivery
    FROM orders
    GROUP BY RestaurantID
)
SELECT
    o.OrderID,
    c.CustomerName,
    r.RestaurantName,
    o.DeliveryTime AS ActualMins,
    ROUND(ra.AvgDelivery, 1) AS RestaurantAvgMins,
    ROUND(o.DeliveryTime / ra.AvgDelivery, 2) AS SlownessRatio
FROM orders o
JOIN RestaurantAvg ra ON o.RestaurantID = ra.RestaurantID
JOIN restaurants    r  ON o.RestaurantID = r.RestaurantID
JOIN customers      c  ON o.CustomerID   = c.CustomerID
WHERE o.DeliveryTime > 1.5 * ra.AvgDelivery
ORDER BY SlownessRatio DESC
LIMIT 20;


--Cuisine popularity vs. satisfaction (ո՞ր cuisine-ն է ամենաշատ պատվիրվում և ինչ rating ունի)--
SELECT
    r.Cuisine,
    COUNT(o.OrderID) AS TotalOrders,
    ROUND(AVG(o.OrderAmount), 2) AS AvgOrderValue,
    ROUND(AVG(od.FoodRating), 2) AS AvgFoodRating,
    ROUND(AVG(od.DeliveryRating), 2) AS AvgDeliveryRating
FROM orders o
JOIN restaurants   r  ON o.RestaurantID = r.RestaurantID
JOIN order_details od ON o.OrderID      = od.OrderID
GROUP BY r.Cuisine
ORDER BY TotalOrders DESC;
