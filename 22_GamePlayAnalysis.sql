Game Play Analysis IV

WITH FirstLogin AS (
    SELECT player_id, MIN(event_date) AS first_login_date
    FROM Activity
    GROUP BY player_id
)

SELECT ROUND(
    IFNULL(
        (SELECT COUNT(DISTINCT a.player_id)
         FROM Activity a
         JOIN FirstLogin f ON a.player_id = f.player_id
         WHERE a.event_date = DATE_ADD(f.first_login_date, INTERVAL 1 DAY))
        /
        (SELECT COUNT(DISTINCT player_id) FROM Activity),
    0),
2) AS fraction;
