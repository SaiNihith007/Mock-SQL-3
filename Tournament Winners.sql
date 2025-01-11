WITH CTE1 AS(
    SELECT first_player AS plr, SUM(first_score) AS pts
    FROM Matches
    GROUP BY first_player
UNION ALL

SELECT second_player AS plr, SUM(second_score) AS pts
    FROM Matches
    GROUP BY second_player

),

CTE2 AS (
    SELECT plr, SUM(pts) AS score
    FROM CTE1
    GROUP BY plr
),


CTE3 AS(
SELECT p.group_id, c.plr AS player_id, c.score, RANK() OVER(PARTITION BY group_id ORDER BY score DESC, player_id ASC ) AS rnk
FROM Players p
INNER JOIN
CTE2 c
ON 
p.player_id = c.plr
)

SELECT group_id,  player_id
FROM CTE3
WHERE rnk = 1