---Homework_1---
---Task #1---
use [labor_sql]; 
SELECT maker, type FROM dbo.product WHERE type = 'laptop' ORDER BY maker;
---Task #2---
SELECT model, ram, screen, price FROM dbo.laptop WHERE price>1000 ORDER BY ram, price DESC;
---Task #3---
SELECT * FROM dbo.printer WHERE color='y' ORDER BY price DESC;
---Task #4---
SELECT model, speed, hd, cd, price FROM dbo.pc WHERE price<600 and (cd='12x' or cd='24x') ORDER BY speed DESC;
---Task #5---
SELECT distinct(name), class FROM dbo.ships ORDER BY name;
---Task #6---
SELECT model, speed, hd, cd, price FROM pc WHERE speed<=500 and price<800 ORDER BY price DESC;
---Task #7---
SELECT * FROM dbo.printer WHERE type<>'Matrix' and price<300 ORDER BY type DESC;
---Task #8---
SELECT model, speed FROM dbo.pc WHERE price>=400 and price<=600 ORDER BY hd;
---Task #9---
SELECT model, speed, hd, price FROM dbo.laptop WHERE screen>=12 ORDER BY ram, price DESC;
---Task #10---
SELECT model, type, price FROM dbo.printer WHERE price<300 ORDER BY type DESC;
---Task #11---
SELECT model, ram, price FROM dbo.laptop WHERE ram=64 ORDER BY screen;
---Task #12---
SELECT model, ram, price FROM dbo.pc WHERE ram>64 ORDER BY hd;
---Task #13---
SELECT model, speed, price FROM dbo.pc WHERE speed>=500 and speed<=750 ORDER BY hd DESC;
---Task #14---
SELECT * FROM dbo.outcome_o WHERE out>2000 ORDER BY date DESC;
---Task #15---
SELECT * FROM dbo.income_o WHERE inc>=5000 and inc<=10000 ORDER BY inc;
---Task #16---
SELECT * FROM dbo.income WHERE point=1 ORDER BY inc;
---Task #17---
SELECT * FROM dbo.outcome WHERE point=2 ORDER BY out;
---Task #18---
SELECT * FROM classes WHERE country='Japan' ORDER BY type DESC;
---Task #19---
SELECT name, launched FROM ships WHERE launched>=1920 and launched<=1942 ORDER BY launched DESC;
---Task #20---
SELECT ship, battle, result FROM outcomes WHERE battle='Guadalcanal' and result!='sunk' ORDER BY ship DESC;
---Task #21---
SELECT ship, battle, result FROM outcomes WHERE result='sunk' ORDER BY ship DESC;
---Task #22---
SELECT class, displacement FROM classes WHERE displacement>=40000 ORDER BY type;
---Task #23---
SELECT trip_no, town_from, town_to FROM trip WHERE town_from='London' or town_to='London' ORDER BY time_out;
---Task #24---
SELECT trip_no, plane, town_from, town_to FROM trip WHERE plane='TU-134' ORDER BY time_out DESC;
---Task #25---
SELECT trip_no, plane, town_from, town_to FROM trip WHERE plane!='IL-86' ORDER BY plane;
---Task #26---
SELECT trip_no, town_from, town_to FROM trip WHERE town_from!='Rostov' and town_to!='Rostov' ORDER BY plane;
---Task #27---
SELECT * FROM pc WHERE model like '1%1';
---Task #28---
SELECT * FROM outcome WHERE date between '2001-03-01 00:00:00.000' and '2001-03-31 00:00:00.000';
SELECT * FROM outcome WHERE DATEPART(MONTH, date) = 3;
---Task #29---
SELECT * FROM outcome WHERE DATEPART(DAY, date) = 14 ;
---Task #30---
SELECT name FROM ships WHERE name like 'W%n';
---Task #31---
SELECT name FROM ships WHERE name like '%e%e%';
---Task #32---
SELECT name, launched FROM ships WHERE name not like '%a';
---Task #33---
SELECT name FROM battles WHERE name like '% %' and name not like '%c';
---Task #34---
SELECT * FROM trip WHERE time_out between '12:00:00.000'and '17:00:00.000';
---Task #35---
SELECT * FROM trip WHERE time_in between '17:00:00.000'and '23:00:00.000';
---Task #36---
SELECT * FROM trip WHERE time_in>='21:00:00.000' or time_in<='10:00:00.000';
---Task #37---
SELECT date FROM pass_in_trip WHERE place like '1%';
---Task #38---
SELECT date FROM pass_in_trip WHERE place like '%c';
---Task #39---
SELECT * FROM passenger WHERE name like '% C%';
---Task #40---
SELECT * FROM passenger WHERE name not like '% J%';
---Task #41---
SELECT 'середня ціна = ' + CAST(AVG(price) AS CHAR(11)) FROM laptop;
---Task #42---
SELECT 'код: ' + CAST(code AS CHAR(11)), 
'модель: ' + CAST(model AS CHAR(11)), 
'частота: ' + CAST(speed AS CHAR(11)), 
'Оперативка: ' + CAST(ram AS CHAR(11)), 
'Вінчестер: ' + CAST(hd AS CHAR(11)),
'Диск: ' + cd , 
'ціна: ' + CAST(price AS CHAR(11)) FROM pc;
---Task #43---
SELECT CAST(date as DATE) dd FROM income;
---Task #44---
UPDATE outcomes SET result='Потонув' WHERE result='sunk'
UPDATE outcomes SET result='Добре' WHERE result='OK'
UPDATE outcomes SET result='Зруйновано' WHERE result='damaged';
---Task #45---
SELECT 'ряд: ' + SUBSTRING (place, 1, 1) as rows, 'місце:' + SUBSTRING (place, 2, 1) as places  FROM pass_in_trip
---Task #46---
SELECT trip_no, id_comp, plane, 
concat('FROM ', town_from, 'to ', town_to) as destination, time_out, time_in FROM trip;
---Task #47---
SELECT CONCAT(left(trip_no, 1), right(trip_no, 1), left(id_comp, 1), right(id_comp, 1), 
left(plane, 1), right(plane, 1), left(town_FROM, 1), right(town_FROM, 1), left(town_to, 1), right(town_to, 1), 
left(CONVERT(varchar, time_out, 24), 1), right(CONVERT(varchar, time_out, 24), 1), 
left(CONVERT(varchar, time_in, 24), 1), right(CONVERT(varchar, time_in, 24), 1)) as combined FROM trip;
---Task #48---
SELECT maker, COUNT(model) NumberOfmodels FROM product WHERE type='pc' GROUP BY maker HAVING COUNT(model) >= 2 
---Task #49---
SELECT town_FROM, COUNT(town_FROM) + COUNT(town_to) NumberOfFlights FROM trip 
group by town_FROM 
---Task #50---
SELECT type, COUNT(model) NumberOfmodels FROM printer GROUP BY type; 
---Task #51---
SELECT model, COUNT (DISTINCT cd) NumberOfcd FROM pc GROUP BY model; 
SELECT cd, COUNT (DISTINCT model) NumberOfmodels FROM pc GROUP BY cd;
---Task #52---
declare @time_out datetime, @time_in datetime 
SELECT ABS(DATEDIFF(hour, time_out, time_in)) FROM trip; 
---Task #53---
SELECT point, date, SUM(out) SUMofOut, MIN(out) MinAmount, MAX(out) MaxAmount 
FROM outcome group by point, date;  ---за кожне число
SELECT date, SUM(out) SUMofOut, MIN(out) MinAmount, MAX(out) MaxAmount 
FROM outcome group by date; ---за всі дати
---Task #54---
SELECT trip_no, left(place, 1) as RowNumber, COUNT(left(place, 1)) as NumberOfSeats 
FROM pass_in_trip group by trip_no, left(place, 1) ORDER BY trip_no;
---Task #55---
SELECT 
COUNT(CASE WHEN name like '% S%' then 1 end) as NameWithS, 
COUNT(CASE WHEN name like '% B%' then 1 end) as NameWithB,  
COUNT(CASE WHEN name like '% A%' then 1 end) as NameWithA 
FROM passenger;

