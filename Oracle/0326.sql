SELECT * FROM usertbl;
SELECT * FROM buytbl;

SELECT *
FROM usertbl u
    CROSS JOIN buytbl b;

SELECT *
FROM buytbl b
    JOIN buytbl bu
    ON b.userid = bu.userid;
    
SELECT *
FROM usertbl u1
    JOIN usertbl u2
    ON u1.birthyear = u2.birthyear
    WHERE u1.userid <> u2.userid;


SELECT * FROM usertbl;
SELECT *
FROM usertbl u1
    JOIN usertbl u2
    ON u1.managerid = u2.userid;
    
SELECT u.name 유저명, m.managerid 관리자명
FROM userselftesttbl U
    JOIN userselftesttbl M
    ON u.userid = m.managerid;
    
SELECT e.empname 상사, m.empname 사원
FROM emptbl e
    JOIN emptbl m
    ON e.empid = m.managerid
    WHERE e.managerid IS NOT NULL;
    
--문제 INNER JOIN
--1
SELECT * FROM usertbl;
SELECT u.name, b.price, b.amount FROM buytbl b
    FULL JOIN usertbl u
    ON u.userid = b.userid
WHERE b.price IS NOT NULL;
    
--2
SELECT * FROM usertbl;
SELECT u.name, SUM(b.price * b.amount) "총 구매금액" FROM buytbl b
    JOIN usertbl u
    ON u.userid = b.userid
GROUP BY u.name
ORDER BY SUM(b.price * b.amount) DESC;
    
--3
SELECT DISTINCT(u.name) FROM usertbl u
    JOIN buytbl b
    ON b.userid = u.userid
WHERE prodname = '책' ;

--4
SELECT * FROM usertbl;
SELECT u.name, u.mdate, b.prodname FROM usertbl u
    JOIN buytbl b
    ON u.userid = b.userid
WHERE u.mdate > '2010-01-01';

--5
SELECT * FROM(
SELECT u.name, COUNT(b.prodname) FROM usertbl u
    JOIN buytbl b
    ON u.userid = b.userid
GROUP BY u.name
ORDER BY COUNT(b.prodname) DESC
)
WHERE rownum = 1;

--6
SELECT * FROM usertbl;
SELECT u.name, b.prodname FROM usertbl u
    JOIN buytbl b
    ON u.userid = b.userid
WHERE u.height > 175 AND b.prodname IS NOT NULL;
    
--7
SELECT NVL(b.groupname,'미분류') AS "b.groupname", SUM(b.price * b.amount) FROM buytbl b
GROUP BY b.groupname;

--8
SELECT u.name, b.prodname, b.amount FROM usertbl u
    JOIN buytbl b
    ON u.userid = b.userid
WHERE u.addr = '서울';
    
--9
SELECT b.prodname, COUNT(DISTINCT(u.name)) FROM usertbl u
    JOIN buytbl b
    ON u.userid = b.userid
GROUP BY b.prodname;

--10
SELECT u.name, ROUND(SUM(price * amount)/COUNT(b.prodname)) FROM usertbl u
    JOIN buytbl b
    ON u.userid = b.userid
GROUP BY u.name;

--문제 OUTER JOIN
--1
SELECT * FROM usertbl u1
    LEFT JOIN usertbl u2
    ON u1.addr = u2.addr
WHERE u1.userid <> u2.userid;

--2
SELECT * FROM usertbl;
SELECT u1.name 나, u2.name "더 큰 사람", u1.height 내키, u2.height "걔 키" FROM usertbl u1
    LEFT JOIN usertbl u2
    ON u1.height < u2.height;
    
--3
SELECT * FROM usertbl u1
    LEFT JOIN usertbl u2
    ON u1.birthyear = u2.birthyear
WHERE u1.userid <> u2.userid;

--4
SELECT * FROM usertbl u1
    LEFT JOIN usertbl u2
    ON u1.mdate = u2.mdate
WHERE u1.userid <> u2.userid; --결과가 없다

--5
SELECT * FROM usertbl u1
    LEFT JOIN usertbl u2
    ON u1.height = u2.height
WHERE u1.userid <> u2.userid;


--

SELECT *
FROM usertbl u
    NATURAL JOIN buytbl b;

SELECT *
FROM usertbl u
    JOIN buytbl b
    ON u.userid = b.userid;

SELECT *
FROM usertbl u
    JOIN buytbl b
    USING(userid);
    
-- 서브쿼리 문제

--1
SELECT name, height FROM usertbl
WHERE addr = '서울'
AND height > (SELECT AVG(height) FROM usertbl);

--2
SELECT distinct(u.name), u.addr FROM usertbl u
    LEFT JOIN buytbl b
    ON u.userid = b.userid
    WHERE b.amount IS NOT NULL;
SELECT name, addr FROM usertbl
WHERE userid IN(SELECT DISTINCT userid FROM buytbl);

--3

SELECT u.name, b.prodname, b.price
FROM buytbl b
    JOIN usertbl u
    ON u.userid = b.userid
WHERE price = (
SELECT MAX(price) FROM buytbl
WHERE groupname = '전자'
);

--4
SELECT u.name, SUM(b.price * b.amount)
FROM buytbl b
    JOIN usertbl u
    ON u.userid = b.userid
    GROUP BY u.userid, u.name
    HAVING SUM(b.price * b.amount) > (
        SELECT AVG(total)
        FROM (
            SELECT SUM(price * amount) AS total
            FROM buytbl
            GROUP BY userid)
        );
        
--5
SELECT u.name, u.mdate FROM usertbl u
    lEFT JOIN buytbl b
    ON u.userid = b.userid
WHERE amount IS NULL;

SELECT name, mdate FROM usertbl
WHERE userid NOT IN(
    SELECT userid FROM buytbl
    );
    
--6
SELECT * FROM buytbl;
SELECT * FROM usertbl
WHERE addr IN(
    SELECT addr FROM usertbl 
    WHERE userid IN(
        SELECT userid FROM buytbl
        WHERE prodname = '청바지'
    )
) AND userid NOT IN (
    SELECT userid FROM buytbl
    WHERE prodname = '청바지'
);

--7

SELECT userid, prodname, price FROM buytbl
WHERE price = (
    SELECT MAX(price)
    FROM buytbl
);

--8
SELECT * FROM buytbl;
SELECT COUNT(userid), addr FROM usertbl
GROUP BY addr
HAVING COUNT(userid) > (
SELECT COUNT(DISTINCT(userid)) FROM buytbl
WHERE prodname = '운동화');

--9
SELECT * FROM buytbl;
SELECT * FROM buytbl
WHERE price > (
    SELECT price FROM buytbl
    WHERE prodname = '책'
);
SELECT userid FROM buytbl
WHERE prodname ='책';