-- Team name: pochita

SET search_path TO A2;

-- If you define any views for a question (you are encouraged to), you must drop them
-- after you have populated the answer table for that question.
-- Good Luck!

CREATE VIEW PlayerActiveMonths AS (
    SELECT p.id AS p_id, COUNT(pR.id) AS months
    FROM Player p LEFT JOIN PlayerRatings pR ON p.id = pR.p_id AND monthly_rating > 0
    GROUP BY p.id
);

CREATE VIEW GuildRatingsLatestMonth AS (
    SELECT gR.year, gR.month
    FROM GuildRatings gR
    ORDER BY gR.year DESC, gR.month DESC
    FETCH NEXT 1 ROWS ONLY
);

-- Query 1 --------------------------------------------------
-- at least 100 rolls per month on average
CREATE VIEW Whale AS (
    SELECT p.id AS p_id, p.playername, p.email, ((CASE WHEN p.rolls / pAM.months >= 100 THEN 'whale' ELSE '' END) || '-') AS classification
    FROM Player p LEFT JOIN PlayerActiveMonths pAM ON p.id = pAM.p_id AND pAM.months >= 1
);

CREATE VIEW PlayerRarity5Lilmons AS (
    SELECT p.id as p_id, COUNT(l.id) as amount
    FROM Player p LEFT JOIN LilmonInventory lI on p.id = lI.p_id JOIN Lilmon l ON lI.l_id = l.id
    WHERE l.rarity = 5
    GROUP BY p.id
);

-- at least 5% of Lilmon inventory are rarity 5
-- divide number of owned rarity 5 Lilmons by number of player rolls
CREATE VIEW Lucky AS (
    SELECT p.id AS p_id, p.playername, p.email, ((CASE WHEN pR5L.amount / p.rolls >= 0.05 THEN 'lucky' else '' END) || '-') AS classification
    FROM Player p LEFT JOIN PlayerRarity5Lilmons pR5L ON p.id = pR5L.p_id AND p.rolls >= 1
);

-- at least 10000 coins per month on average
Create VIEW Hoarder AS (
    SELECT p.id AS p_id, p.playername, p.email, ((CASE WHEN p.coins / pAM.months >= 10000 THEN 'hoarder' else '' END)) AS classification
    FROM Player p LEFT JOIN PlayerActiveMonths pAM ON p.id = pAM.p_id AND pAM.months >= 1
);

INSERT INTO Query1 (
    SELECT w.p_id AS p_id, w.playername, w.email, (w.classification || l.classification || h.classification) AS classification
    FROM Whale w JOIN Lucky l ON w.p_id = l.p_id JOIN Hoarder h on w.p_id = h.p_id
    ORDER BY w.p_id
);

DROP VIEW IF EXISTS Whale;
DROP VIEW IF EXISTS Lucky;
DROP VIEW IF EXISTS PlayerRarity5Lilmons;
DROP VIEW IF EXISTS Hoarder;

-- Query 2 --------------------------------------------------
CREATE VIEW LilmonElement1 AS (
    SELECT l.element1 AS e, COUNT(DISTINCT (p.id, l.id)) AS popularity_count
    FROM Player p JOIN LilmonInventory lI ON p.id = lI.p_id JOIN Lilmon l ON lI.l_id = l.id
    WHERE lI.fav = TRUE OR lI.in_team = TRUE
    GROUP BY l.element1
);

CREATE VIEW LilmonElement2 AS (
    SELECT l.element2 AS e, COUNT(DISTINCT (p.id, l.id)) AS popularity_count
    FROM Player p JOIN LilmonInventory lI ON p.id = lI.p_id JOIN Lilmon l ON lI.l_id = l.id
    WHERE (l.element2 IS NOT NULL) AND (l.element2 <> l.element1) AND (lI.fav = TRUE OR lI.in_team = TRUE)
    GROUP BY l.element2
);

-- put valid elements array into view
CREATE VIEW Elements AS (
    SELECT unnest(ARRAY['Water', 'Fire', 'Air', 'Earth', 'Ice', 'Electric', 'Light', 'Dark']) AS e
);

-- element is alias for Elements.e
INSERT INTO Query2(
    SELECT Elements.e AS element, COALESCE(e1.popularity_count, 0) + COALESCE(e2.popularity_count, 0) AS popularity_count
    FROM LilmonElement1 e1 FULL JOIN LilmonElement2 e2 ON e1.e = e2.e RIGHT JOIN Elements ON Elements.e = e1.e
    ORDER BY popularity_count DESC
);

DROP VIEW IF EXISTS LilmonElement1;
DROP VIEW IF EXISTS LilmonElement2;
DROP VIEW IF EXISTS Elements;

-- Query 3 --------------------------------------------------
INSERT INTO Query3(
    SELECT AVG(incomplete) AS avg_ig_per_month_per_player
    FROM (
         SELECT (p.total_battles - (p.wins + p.losses)) / GREATEST(pAM.months, 1) AS incomplete
         FROM Player p JOIN PlayerActiveMonths pAM ON p.id = pAM.p_id
    ) as month_avg
);

-- Query 4 --------------------------------------------------
-- count distinct player-Lilmon pairs
INSERT INTO Query4(
    SELECT l.id, l.name, l.rarity, count(DISTINCT (p.id, l.id)) AS popularity_count
    FROM Player p JOIN LilmonInventory lI on p.id = lI.p_id JOIN Lilmon l ON l.id = lI.l_id
    WHERE lI.fav = TRUE OR lI.in_team = TRUE
    GROUP BY l.id, l.name, l.rarity
    ORDER BY popularity_count DESC, rarity DESC, id DESC
);

-- Query 5 --------------------------------------------------
-- remove WHERE clause for sub-query
CREATE VIEW PlayerRatingsLast6Months AS (
    SELECT *
    FROM (
        SELECT *, RANK() OVER (
            PARTITION BY pR.p_id
            ORDER BY pR.year DESC, pr.month DESC
        )
        FROM PlayerRatings pR
    ) AS MonthFilter
    WHERE MonthFilter.rank <= 6
);

-- check if player country is IN Canada, USA, or Mexico
INSERT INTO Query5(
    SELECT p.id AS p_id, p.playername, p.email, MIN(pRL6M.monthly_rating) AS min_mr, MAX(pRL6M.monthly_rating) AS max_mr
    FROM Player p JOIN PlayerRatingsLast6Months pRL6M ON p.id = pRL6M.p_id
    WHERE p.country_code IN ('CAN', 'USA', 'MEX')
    GROUP BY p.id, p.playername, p.email
    HAVING MAX(pRL6M.all_time_rating) >= 2000 AND MAX(pRL6M.monthly_rating) - MIN(pRL6M.monthly_rating) <= 50
    ORDER BY max_mr DESC, min_mr DESC, p.id
);

DROP VIEW IF EXISTS PlayerRatingsLast6Months;

-- Query 6 --------------------------------------------------
-- large guild size is put in the ELSE clause
CREATE VIEW GuildSize AS (
    SELECT g.id, (CASE WHEN COUNT(p.id) < 100 THEN 'small' WHEN COUNT(p.id) >= 100 AND COUNT(p.id) <= 499 THEN 'medium' ELSE 'large' END) as size
    FROM Guild g JOIN Player p ON g.id = p.guild
    GROUP BY g.id
);

-- Only check guild rating from latest month
INSERT INTO Query6(
    SELECT g.id AS g_id, g.guildname, g.tag, g.leader AS leader_id, p.playername AS leader_name, p.country_code AS leader_country , gS.size,
           (
           CASE WHEN gR.all_time_rating IS NULL THEN 'new'
                WHEN (size = 'small' AND gR.all_time_rating >= 1500) OR (size = 'medium' AND gR.all_time_rating >= 1750) OR (size = 'large' AND all_time_rating >= 2000) THEN 'elite'
                WHEN (size = 'small' AND gR.all_time_rating >= 1000) OR (size = 'medium' AND gR.all_time_rating >= 1250) or (size = 'large' AND all_time_rating >= 1500) THEN 'average'
                ELSE 'casual'
                END
           ) AS classification
    FROM Guild g JOIN GuildSize gS ON g.id = gS.id JOIN Player p ON g.leader = p.id LEFT JOIN GuildRatings gR on g.id = gR.g_id
    WHERE (gR.year = (SELECT gRLM.year FROM GuildRatingsLatestMonth gRLM) AND gR.month = (SELECT gRLM.month FROM GuildRatingsLatestMonth gRLM))
        OR (gr.year IS NULL AND gr.month IS NULL)
);

DROP VIEW IF EXISTS GuildSize;

-- Query 7 --------------------------------------------------
INSERT INTO Query7(
    SELECT p.country_code, AVG(pAM.months) as player_retention
    FROM Player p JOIN PlayerActiveMonths pAM ON p.id = pAM.p_id
    WHERE pAM.months > 0
    GROUP BY p.country_code
    ORDER BY player_retention DESC
);

-- Query 8 --------------------------------------------------
INSERT INTO Query8 (
    SELECT p.id as p_id, p.playername, p.wins::float / (p.wins + p.losses) as player_wr, p.guild as g_id, g.guildname,
           g.tag, (gR.wins::float / (gR.wins + gR.losses)) as guild_aggregate_wr
    FROM Player p LEFT JOIN (Guild g JOIN (
        SELECT g2.id, SUM(p2.wins) as wins, SUM(p2.losses) as losses
        FROM Guild g2 JOIN Player p2 ON p2.guild = g2.id
        GROUP BY g2.id
    ) gR ON gR.id = g.id) ON p.guild = g.id
    WHERE p.wins + p.losses > 0
    ORDER BY player_wr DESC, guild_aggregate_wr DESC
);

-- Query 9 --------------------------------------------------
CREATE VIEW TopTenGuilds AS (
    SELECT gR.g_id, g.guildname, gR.monthly_rating, gR.all_time_rating
    FROM Guild g JOIN GuildRatings gR ON g.id = gR.g_id
    WHERE gr.month = (SELECT gRLM.month FROM GuildRatingsLatestMonth gRLM) AND gr.year = (SELECT gRLM.year FROM GuildRatingsLatestMonth gRLM)
    ORDER BY gr.all_time_rating DESC, gr.monthly_rating DESC, g.id DESC
    FETCH NEXT 10 ROWS ONLY
);

CREATE VIEW CountryGuildCount AS (
     SELECT tTG.g_id, p.country_code, COUNT(p.country_code) as country_pcount
     FROM TopTenGuilds tTG, Player p
     WHERE p.guild = ttg.g_id
     GROUP BY ttg.g_id, guildname, p.country_code, monthly_rating, all_time_rating
);

CREATE VIEW TotalGuildCount AS (
   SELECT tTG.g_id, COUNT(tTG.g_id) as total_pcount
   FROM TopTenGuilds tTG, Player p
   WHERE p.guild = tTG.g_id
   GROUP BY tTG.g_id
);

CREATE VIEW MaxCountryCount AS (
   SELECT cGC.g_id, MAX(cGC.country_pcount) as country_pcount
   FROM CountryGuildCount cGC
   GROUP BY cGC.g_id
);

INSERT INTO Query9 (
    SELECT tTG.g_id, tTG.guildname, tTG.monthly_rating, tTG.all_time_rating, mCC.country_pcount, tGC.total_pcount, cGC.country_code
    FROM TopTenGuilds tTG JOIN (MaxCountryCount mCC JOIN CountryGuildCount cGC on mCC.g_id = cGC.g_id AND mCC.country_pcount = cGC.country_pcount)
        ON tTG.g_id = mCC.g_id JOIN TotalGuildCount tGC ON tTG.g_id = tGC.g_id
    ORDER BY all_time_rating DESC, monthly_rating DESC, tTG.g_id
);

DROP VIEW IF EXISTS MaxCountryCount;
DROP VIEW IF EXISTS CountryGuildCount;
DROP VIEW IF EXISTS TotalGuildCount;
DROP VIEW IF EXISTS TopTenGuilds;

-- Query 10 --------------------------------------------------
INSERT INTO Query10(
    SELECT g.id as g_id, g.guildname, avg(years) as avg_veteranness
    FROM (
             SELECT p.id, p.guild, avg(pAM.months) / 12.0 as years
             FROM Player p JOIN PlayerActiveMonths pAM ON pAM.p_id = p.id
             GROUP BY p.id, p.guild
         ) Veteranness JOIN Guild g ON Veteranness.guild = g.id
    GROUP BY g.id, g.guildname
    ORDER BY avg_veteranness DESC, g.id
);

DROP VIEW IF EXISTS PlayerActiveMonths;
DROP VIEW IF EXISTS GuildRatingsLatestMonth;
