---Homework_3---
SELECT * FROM geography;
---1st---
WITH CTE1 AS (SELECT name FROM geography where name like 'R%')
SELECT name FROM CTE1;
---2nd---
WITH CTE2 AS (SELECT name FROM geography where name like 'R%'),
CTE3 AS (SELECT name FROM CTE2 where name like '%e')
SELECT name FROM CTE3;
---3rd---
;WITH CTE4 (region_id, place_id, name, Placelevel) AS
(SELECT region_id, id, name, Placelevel=1 FROM geography WHERE REGION_ID=1)
SELECT * FROM CTE4;
---4---
;WITH CTE5(region_id, place_id, name, Placelevel) AS
(SELECT region_id, id, name, Placelevel=-1 FROM geography 
WHERE name='Ivano-Frankivsk' UNION ALL
SELECT g.region_id, g.id, g.name, f.Placelevel+1 FROM geography g 
INNER JOIN CTE5 f ON g.region_id=f.place_id)
SELECT region_id, place_id, name, Placelevel FROM CTE5 WHERE Placelevel>=0;
---5---
WITH CTE_6 as 
(SELECT 1 as Item  union all SELECT Item +1 FROM CTE_6 where Item<10000)   
SELECT * FROM CTE_6 option (maxrecursion 0)
---Task #6---
WITH CTE_7 as (SELECT 1 as Item  union all SELECT Item +1 FROM CTE_7 where Item<100000)   
SELECT * FROM CTE_7 option (maxrecursion 0)
---7---
WITH rr (D, name) as 
(SELECT CAST('20190101' AS DATE) D, DATENAME(WEEKDAY, '20190101') UNION ALL
SELECT DATEADD(DAY, 1, D), DATENAME(WEEKDAY, DATEADD(DAY, 1, D)) FROM RR WHERE D<'20191231'),
rr1 AS (SELECT D, name FROM RR WHERE name IN ('Saturday','Sunday'))
SELECT COUNT(*) FROM rr1 OPTION (maxrecursion 367)
---Task #8---
SELECT distinct maker FROM product where type='pc' and maker not in (SELECT maker FROM product where type='laptop');
---Task #9---
SELECT distinct maker FROM product where type='pc' and maker<>all (SELECT maker FROM product where type='laptop');
---Task #10---
SELECT distinct maker FROM product where type='pc' and not maker=any (SELECT maker FROM product where type='laptop');
---Task #11---
SELECT distinct maker FROM product where type='pc' and maker in (SELECT maker FROM product where type='laptop');
---Task #12---
SELECT distinct maker FROM product where type='pc' and not maker<>all (SELECT maker FROM product where type='laptop');
---Task #13---
SELECT distinct maker FROM product where type='pc' and maker=any (SELECT maker FROM product where type='laptop');
---Task #14---
SELECT distinct maker FROM product where model in (SELECT model FROM pc where pc.model=product.model);
---Task #15---
SELECT c.country, c.class FROM classes c WHERE c.country = 'Ukraine' 
AND EXISTS (SELECT c.country, c.class FROM classes c WHERE c.country = 'Ukraine' )
UNION ALL SELECT c.country, c.class FROM classes c WHERE NOT EXISTS (SELECT c.country, c.class FROM classes c WHERE c.country = 'Ukraine' )
---Task #16---
SELECT t.name FROM (SELECT o.ship AS name, battle FROM Outcomes o) t, Battles b
WHERE t.battle = b.name GROUP BY t.name HAVING (SELECT result FROM Outcomes, Battles 
WHERE ship = t.name AND battle = name AND date = MIN(b.date)) = 'damaged' AND 
(SELECT result FROM Outcomes, Battles WHERE ship = t.name AND battle = name AND date = MAX(b.date)) IN ('damaged', 'ok', 'sunk') AND COUNT(t.name) > 1;
---Task #17---
SELECT DISTINCT maker FROM Product
WHERE type = 'pc' AND EXISTS (SELECT model FROM pc WHERE pc.model = product.model);
---Task #18---
SELECT DISTINCT maker FROM product
WHERE model IN ( SELECT model FROM pc WHERE speed = (SELECT MAX(speed) FROM pc))
AND maker IN ( SELECT maker FROM product WHERE type='printer')
---Task #19---
SELECT cl.class FROM Classes cl
LEFT JOIN Ships s ON s.class = cl.class
WHERE cl.class IN (SELECT ship FROM Outcomes WHERE result = 'sunk') OR
s.name IN (SELECT ship FROM Outcomes WHERE result = 'sunk')
GROUP BY cl.class
---Task #20---
SELECT model, price FROM printer where price=(SELECT MAX(price) FROM printer);
---Task #21---
SELECT type='Laptop', laptop.model, laptop.speed FROM laptop where speed<(SELECT MIN(speed) FROM PC);
---Task #22---
SELECT price FROM printer where price=(SELECT MIN(price) where color='y' FROM printer) as red;
---Task #23---
SELECT DISTINCT o.battle
FROM outcomes o
LEFT JOIN ships s ON s.name = o.ship
LEFT JOIN classes c ON o.ship = c.class OR s.class = c.class
WHERE c.country IS NOT NULL
GROUP BY c.country, o.battle
HAVING COUNT(o.ship) >= 2
---Task #24---
SELECT MAKER, COUNT(LAPTOP.model) AS LAPTOP, NULL AS PC, NULL AS PRINTER
FROM Product INNER JOIN LAPTOP ON LAPTOP.model = Product.model
GROUP BY MAKER
UNION SELECT MAKER, NULL AS LAPTOP, COUNT(PC.model) AS PC, NULL AS PRINTER
FROM Product INNER JOIN PC ON PC.model = Product.model
GROUP BY MAKER
UNION SELECT MAKER, NULL AS LAPTOP, NULL AS PC, COUNT(PRINTER.model) AS PRINTER
FROM Product INNER JOIN PRINTER ON PRINTER.model = Product.model
GROUP BY MAKER;
---Task #25---
SELECT maker, (SELECT CASE WHEN COUNT(pc.model)=0 THEN 'NO'
ELSE CONCAT('YES (',COUNT(PC.MODEL),')') END) PC
FROM PRODUCT P LEFT JOIN PC ON P.MODEL=PC.MODEL
GROUP BY MAKER
---Task #26---
SELECT in1.point, in1.date, inc, out
FROM income_o in1 LEFT JOIN outcome_o ou2 ON in1.point = ou2.point
AND in1.date = ou2.date
UNION
SELECT ou2.point, ou2.date, inc, out
FROM income_o in1 RIGHT JOIN outcome_o ou2 ON in1.point = ou2.point
AND in1.date = ou2.date
-----Task #27---
SELECT name
FROM Ships AS s JOIN Classes AS cl1 ON s.class = cl1.class
WHERE
CASE WHEN numGuns = 8 THEN 1 ELSE 0 END +
CASE WHEN bore = 15 THEN 1 ELSE 0 END +
CASE WHEN displacement = 32000 THEN 1 ELSE 0 END +
CASE WHEN type = 'bb' THEN 1 ELSE 0 END +
CASE WHEN country = 'USA' THEN 1 ELSE 0 END > = 4 +
CASE WHEN launched = 1915 THEN 1 ELSE 0 END +
CASE WHEN s.class = 'Kongo' THEN 1 ELSE 0 END 
-----Task #28---
SELECT ONSE.POINT, ONSE.DATE, CASE 
WHEN COALESCE(ONSE.OUT, 0) > COALESCE(MORE.SUM_OUT, 0) THEN 'ONCE A DAY'
WHEN COALESCE(ONSE.OUT, 0) = COALESCE(MORE.SUM_OUT, 0) THEN 'BOTH'
ELSE 'MORE THAN ONCE A DAY' END AS RESULT
FROM (SELECT POINT, DATE, SUM(OUT) AS SUM_OUT FROM OUTCOME GROUP BY DATE, POINT) MORE 
FULL JOIN OUTCOME_O ONSE ON MORE.DATE=ONSE.DATE AND MORE.POINT=ONSE.POINT 
---Task #29---
SELECT DISTINCT product.maker, product.model, product.type, pc.price
FROM Product JOIN pc ON product.model = pc.model WHERE maker = 'B'
UNION
SELECT DISTINCT product.maker, product.model, product.type, laptop.price
FROM product JOIN laptop ON product.model=laptop.model WHERE maker='B'
UNION
SELECT DISTINCT product.maker, product.model, product.type, printer.price
FROM product JOIN printer ON product.model=printer.model WHERE maker='B';
---Task #30---
SELECT name FROM ships where class = name
union
SELECT ship as name FROM classes,outcomes where classes.class = outcomes.ship
---Task #31---
SELECT aa.class
FROM (SELECT a.class AS class, COUNT(b.name) AS coun
FROM Classes a LEFT JOIN Ships b ON b.class = a.class GROUP BY a.class
UNION ALL 
SELECT a1.class AS class, COUNT(ship) AS coun 
FROM Classes a1 LEFT JOIN Outcomes d ON d.ship = a1.class
WHERE d.ship NOT IN (SELECT b.name FROM Ships b)
GROUP BY a1.class) aa
GROUP BY aa.class
HAVING SUM(aa.coun) = 1;
---Task #32---
SELECT name FROM Ships WHERE launched < 1941
UNION 
SELECT ship FROM Outcomes JOIN Battles ON Battles.name = Outcomes.battle WHERE date < '19410101'
UNION 
SELECT ship  FROM Outcomes WHERE ship IN (SELECT class FROM Ships WHERE launched < 1941);