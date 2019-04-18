---Homework_2---
---1
SELECT distinct maker, type, speed, hd FROM pc INNER JOIN product ON 
pc.model=product.model WHERE hd<=8;
---2
SELECT distinct maker FROM pc INNER JOIN product ON 
pc.model=product.model WHERE speed>=600;
---3
SELECT distinct maker FROM pc INNER JOIN product ON 
pc.model=product.model WHERE speed<=500;
---4
SELECT distinct laptop1.model , laptop2.model, laptop1.speed, laptop1.ram
FROM laptop as laptop1, laptop as laptop2
WHERE laptop1.hd = laptop2.hd AND laptop1.ram = laptop2.ram 
AND laptop1.model > laptop2.model
---5
SELECT country FROM classes GROUP BY country HAVING COUNT(DISTINCT type) = 2;
---6
SELECT distinct product.model, product.maker 
FROM dbo.pc INNER JOIN product ON pc.model=product.model WHERE price<600;
---7
SELECT distinct product.model, product.maker 
FROM dbo.pc INNER JOIN product ON pc.model=product.model WHERE price>300;
---8
SELECT maker, Product.model AS model_1, PC.model AS model_2, price
FROM Product INNER JOIN PC ON PC.model = Product.model
ORDER BY maker, PC.model;
---9---
SELECT maker, Product.model AS model_1, price
FROM Product LEFT JOIN PC ON PC.model = Product.model
WHERE type = 'PC'
ORDER BY maker, PC.model;
---10
SELECT product.maker, product.type, product.model, laptop.speed
FROM product 
join laptop ON product.model=laptop.model WHERE speed<=600
GROUP BY product.maker, product.type, product.model, laptop.speed
---11
SELECT ships.name, classes.displacement 
FROM ships left join classes ON ships.class=classes.class
---12
SELECT battles.name, battles.date 
FROM outcomes join battles ON outcomes.battle=battles.name 
WHERE result in ('ok', 'damaged')
 ---13
SELECT ships.name, classes.country
FROM ships join classes ON ships.class=classes.class 
---14---
SELECT trip.plane, company.name FROM trip left join company ON trip.ID_comp=company.ID_comp
WHERE plane='Boeing'
GROUP BY trip.plane, company.name;
---15---
SELECT passenger.name, pass_in_trip.date 
FROM passenger left join pass_in_trip ON passenger.ID_psg=pass_in_trip.ID_psg
---16---
SELECT product.model, pc.speed, pc.hd 
FROM pc left join product ON pc.model=product.model 
WHERE type='pc' and hd in (10, 20) and maker='A'
order by pc.speed;
---17---
SELECT maker, [pc], [laptop], [printer]
FROM Product 
PIVOT (COUNT(model)
FOR type IN([pc], [laptop], [printer])) p;
---18---
SELECT [average],[11],[12],[14],[15]
FROM (SELECT 'average' AS 'average', screen, price FROM Laptop) s
PIVOT (AVG(price)
FOR screen IN([11],[12],[14],[15])) p;
---19---
SELECT p.maker, l.*  FROM Product p
CROSS APPLY (SELECT * FROM Laptop l WHERE p.model= l.model) l;
---20---
SELECT * FROM laptop L1
CROSS APPLY
(SELECT MAX(price) max_price  FROM Laptop L2
JOIN  Product P1 ON L2.model=P1.model 
WHERE maker = (SELECT maker FROM Product P2 WHERE P2.model= L1.model)) X;
---21---
SELECT * FROM laptop L1
CROSS APPLY
(SELECT TOP 1 * FROM Laptop L2 
WHERE L1.model < L2.model OR (L1.model = L2.model AND L1.code < L2.code) 
ORDER BY model, code) X
ORDER BY L1.model;
---22---
SELECT * FROM laptop L1
OUTER APPLY
(SELECT TOP 1 * 
FROM Laptop L2 
WHERE L1.model < L2.model OR (L1.model = L2.model AND L1.code < L2.code) 
ORDER BY model, code) X
ORDER BY L1.model;
---23---
SELECT X.* FROM 
(SELECT DISTINCT type FROM product) Pr1 
CROSS APPLY 
(SELECT TOP 3 * FROM product Pr2 WHERE  Pr1.type=Pr2.type 
ORDER BY pr2.model) x;
---24---
SELECT code, name, value FROM Laptop
CROSS APPLY
(VALUES('speed', speed)
,('ram', ram)
,('hd', hd)
,('screen', screen)
) spec(name, value)
WHERE code < 4
ORDER BY code, name, value;