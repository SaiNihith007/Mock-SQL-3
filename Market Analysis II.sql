WITH CTE AS (
    SELECT o.order_id,o.order_date,o.item_id,o.seller_id,u.favorite_brand, RANK() OVER(PARTITION BY o.seller_id ORDER BY o.order_date) AS rnk
    FROM
    Orders o LEFT JOIN Users u
    ON o.seller_id = u.user_id
),

CTE2 AS (
    SELECT c1.seller_id AS 'id'
    FROM CTE c1 INNER JOIN 
    Items i
    ON c1.item_id =  i.item_id AND c1.favorite_brand = i.item_brand
    WHERE c1.rnk = '2'  
    
)
-- SELECT * FROM CTE
-- SELECT * FROM CTE2
SELECT a.user_id AS seller_id, CASE
    WHEN c2.id IS NOT NULL THEN 'yes'
    ELSE 'no'
    END
 AS '2nd_item_fav_brand'
FROM Users a
LEFT JOIN CTE2 c2
ON a.user_id = c2.id