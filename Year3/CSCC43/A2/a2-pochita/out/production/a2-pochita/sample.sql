SET search_path TO A2;

-- Player 1
INSERT INTO Player VALUES (1, 'player1', 'player1@email.com', 'USA', 100000, 200, 5, 5, 10, NULL);
INSERT INTO PlayerRatings (p_id, month, year, monthly_rating, all_time_rating) VALUES (1, 1, 2022, 1600, 1600);
INSERT INTO Lilmon VALUES (1, 'AYAYA', 'Ice', NULL, 5);
INSERT INTO LilmonInventory (l_id, p_id, in_team, fav) VALUES (1, 1, FALSE, FALSE);
INSERT INTO Guild VALUES (1, 'guild1', 'g1', 1);
UPDATE Player SET guild = 1 WHERE Player.id = 1;

-- Player 2
INSERT INTO Player VALUES (2, 'player2', 'player2@email.com', 'CAN', 5000, 50, 3, 1, 5, NULL);
INSERT INTO PlayerRatings (p_id, month, year, monthly_rating, all_time_rating)
VALUES (2, 1, 2022, 1600, 1600);
INSERT INTO Lilmon VALUES (2, 'Lisa', 'Electric', NULL, 4);
INSERT INTO LilmonInventory (l_id, p_id, in_team, fav) VALUES (2, 2, FALSE, TRUE);

-- Player 3
INSERT INTO Player VALUES (3, 'player3', 'player3@email.com', 'CAN', 100000, 50, 3, 0, 5, NULL);
INSERT INTO PlayerRatings (p_id, month, year, monthly_rating, all_time_rating) VALUES (3, 1, 2022, 1500, 1500);
INSERT INTO PlayerRatings (p_id, month, year, monthly_rating, all_time_rating) VALUES (3, 12, 2021, 1600, 1600);
INSERT INTO LilmonInventory (l_id, p_id, in_team, fav) VALUES (2, 3, TRUE, TRUE);
INSERT INTO LilmonInventory (l_id, p_id, in_team, fav) VALUES (1, 3, TRUE, FALSE);

-- Player 4
INSERT INTO Player VALUES (4, 'player4', 'player4@email.com', 'MEX', 0, 1, 10, 0, 11, NULL);
INSERT INTO PlayerRatings (p_id, month, year, monthly_rating, all_time_rating) VALUES (4, 1, 2022, 2000, 2000);
INSERT INTO PlayerRatings (p_id, month, year, monthly_rating, all_time_rating) VALUES (4, 12, 2021, 2050, 2050);
INSERT INTO PlayerRatings (p_id, month, year, monthly_rating, all_time_rating) VALUES (4, 11, 2021, 2050, 2050);
INSERT INTO PlayerRatings (p_id, month, year, monthly_rating, all_time_rating) VALUES (4, 10, 2021, 2050, 2050);
INSERT INTO PlayerRatings (p_id, month, year, monthly_rating, all_time_rating) VALUES (4, 9, 2021, 2050, 2050);
INSERT INTO PlayerRatings (p_id, month, year, monthly_rating, all_time_rating) VALUES (4, 8, 2021, 2050, 2050);
INSERT INTO PlayerRatings (p_id, month, year, monthly_rating, all_time_rating) VALUES (4, 7, 2021, 1750, 1750);
INSERT INTO LilmonInventory (l_id, p_id, in_team, fav) VALUES (1, 4, TRUE, FALSE);

-- Guild 1
INSERT INTO GuildRatings (g_id, month, year, monthly_rating, all_time_rating) VALUES (1, 1, 2022, 1600, 1600);

-- Squid Game Stuff
INSERT INTO Player VALUES (6, 'squid1', 'squid1@email.com', 'KOR', 100, 10, 50, 5, 60, NULL);
INSERT INTO Guild VALUES (2, 'Squid Game', 'SQ', 6);
UPDATE Player SET guild = 2 WHERE Player.id = 6;
INSERT INTO Player VALUES (7, 'squid2', 'squid2@email.com', 'KOR', 1000, 100, 300, 50, 400, 2);
INSERT INTO Player VALUES (8, 'fakesquid', 'fakesquid@email.com', 'CAN', 0, 0, 0, 0, 0, 2);
INSERT INTO GuildRatings (g_id, month, year, monthly_rating, all_time_rating) VALUES (2, 1, 2022, 1800, 1800);

--Throwaway stuff
INSERT INTO Player VALUES (666, 'xxxxx', 'x@email.com', 'IRE');
INSERT INTO Guild VALUES (666, 'orion', 'OP', 666);
UPDATE Player SET guild = 666 WHERE Player.id = 666;