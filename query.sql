-- CASE 1: seconds

-- drop the table if exits
DROP TABLE IF EXISTS atable;

-- create the table
CREATE TABLE atable (
  sensor_id text,
  time timestamp without time zone,
  value smallint
  )
;

-- insert some sample data
INSERT INTO atable (sensor_id, time, value) VALUES ('ABC', '2022-04-08 09:00:00', 27);
INSERT INTO atable (sensor_id, time, value) VALUES ('ABC', '2022-04-08 09:00:01', 30);
INSERT INTO atable (sensor_id, time, value) VALUES ('ABC', '2022-04-08 09:00:21', 22);

INSERT INTO atable (sensor_id, time, value) VALUES ('ABC', '2022-04-08 09:01:14', 31);
INSERT INTO atable (sensor_id, time, value) VALUES ('ABC', '2022-04-08 09:01:21', 28);
INSERT INTO atable (sensor_id, time, value) VALUES ('ABC', '2022-04-08 09:01:38', 35);

INSERT INTO atable (sensor_id, time, value) VALUES ('ABC', '2022-04-08 09:02:07', 33);
INSERT INTO atable (sensor_id, time, value) VALUES ('ABC', '2022-04-08 09:02:11', 19);
INSERT INTO atable (sensor_id, time, value) VALUES ('ABC', '2022-04-08 09:02:56', 25);

INSERT INTO atable (sensor_id, time, value) VALUES ('XYZ', '2022-04-08 09:00:00', 26);
INSERT INTO atable (sensor_id, time, value) VALUES ('XYZ', '2022-04-08 09:00:25', 37);
INSERT INTO atable (sensor_id, time, value) VALUES ('XYZ', '2022-04-08 09:00:47', 29);

-- see what we have in `atable`
SELECT * FROM atable;

-- see how date_trunc() works
SELECT sensor_id, date_trunc('minute', time) AS truncated_time, value FROM atable;

-- query to get only the most recent data point within a minute
SELECT
  t.*  /* you might want to be more specific here */
FROM atable t
  INNER JOIN (
    SELECT
      sensor_id,
      MAX(time) AS time
    FROM atable
    --GROUP BY sensor_id, DIV(extract(epoch FROM time)::integer, 60)
    GROUP BY sensor_id, date_trunc('minute', time)
  ) m ON t.time = m.time AND t.sensor_id = m.sensor_id
ORDER BY sensor_id, time;

-- query to get only the most recent data point within a minute, with CTE
WITH times_cte AS
(
	SELECT
		sensor_id,
		MAX(time) AS time
	FROM atable
  --GROUP BY sensor_id, DIV(extract(epoch FROM time)::integer, 60)
	GROUP BY sensor_id, date_trunc('minute', time)
)
SELECT
  t.*  /* you might want to be more specific here */
FROM atable t
  INNER JOIN times_cte m 
  	ON t.time = m.time AND t.sensor_id = m.sensor_id
ORDER BY sensor_id, time;


--------------------------------------------------------------------------
-- CASE 2: miliseconds
-- This is another example, this time timestamps have up to the milisecond
-- part and we want to downsample to the second.  

-- drop the table if exits
DROP TABLE IF EXISTS btable;

-- create the table
CREATE TABLE btable (
  sensor_id text,
  time timestamp without time zone,
  value smallint
  )
;

-- insert some sample data
INSERT INTO btable (sensor_id, time, value) VALUES ('DEF', '2022-04-12 16:00:00.113', 98);
INSERT INTO btable (sensor_id, time, value) VALUES ('DEF', '2022-04-12 16:00:00.231', 75);
INSERT INTO btable (sensor_id, time, value) VALUES ('DEF', '2022-04-12 16:00:00.578', 81);

INSERT INTO btable (sensor_id, time, value) VALUES ('DEF', '2022-04-12 16:00:01.188', 55);
INSERT INTO btable (sensor_id, time, value) VALUES ('DEF', '2022-04-12 16:00:01.325', 70);
INSERT INTO btable (sensor_id, time, value) VALUES ('DEF', '2022-04-12 16:00:01.762', 83);

INSERT INTO btable (sensor_id, time, value) VALUES ('DEF', '2022-04-12 16:00:02.114', 76);
INSERT INTO btable (sensor_id, time, value) VALUES ('DEF', '2022-04-12 16:00:02.349', 71);
INSERT INTO btable (sensor_id, time, value) VALUES ('DEF', '2022-04-12 16:00:02.629', 87);

INSERT INTO btable (sensor_id, time, value) VALUES ('RST', '2022-04-12 16:00:00.147', 13);
INSERT INTO btable (sensor_id, time, value) VALUES ('RST', '2022-04-12 16:00:00.451', 24);
INSERT INTO btable (sensor_id, time, value) VALUES ('RST', '2022-04-12 16:00:00.924', 31);

-- see what we have in `btable`
SELECT * FROM btable;

-- see how date_trunc() works
SELECT sensor_id, date_trunc('second', time) AS truncated_time, value FROM btable;

-- query to get only the most recent data point within a second
SELECT
  t.*  /* you might want to be more specific here */
FROM btable t
  INNER JOIN (
    SELECT
      sensor_id,
      MAX(time) AS time
    FROM btable
    --GROUP BY sensor_id, DIV(extract(epoch FROM time)::integer, 1000)
    GROUP BY sensor_id, date_trunc('second', time)
  ) m ON t.time = m.time AND t.sensor_id = m.sensor_id
ORDER BY sensor_id, time;
