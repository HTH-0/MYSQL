SELECT * FROM usertbl;
SELECT * FROM buytbl;

SELECT * FROM usertbl WHERE NAME = '김경호';

SELECT * FROM usertbl WHERE birthyear >= 1970 AND height >= 182;
SELECT * FROM usertbl WHERE birthyear >= 1970 OR height >= 182;

SELECT * FROM usertbl WHERE birthyear BETWEEN 1970 AND 1980;

SELECT * FROM usertbl WHERE addr IN('경남', '전남', '경북');

SELECT * FROM usertbl WHERE mobile1 IN('010', '011');
SELECT * FROM usertbl;
SELECT name, height FROM usertbl WHERE name LIKE '김%';
SELECT name, height FROM usertbl WHERE name LIKE '_재범';

--NULL CHECK

SELECT * FROM usertbl WHERE mobile1 IS NULL;
SELECT * FROM usertbl WHERE mobile1 IS NOT NULL;

SELECT DISTINCT * FROM usertbl;

SELECT * FROM usertbl;

SELECT name, addr, mobile1, mobile2 AS phone FROM usertbl;


SELECT * FROM buytbl;
--1
SELECT * FROM buytbl WHERE amount > 5;
--2
SELECT userid, prodName FROM buytbl WHERE price BETWEEN 50 AND 500;
--3
SELECT * FROM buytbl WHERE price >= 100;
--4
SELECT * FROM buytbl WHERE userid LIKE 'K%';
--5
SELECT * FROM buytbl WHERE groupname IN ('서적', '전자');
--6
SELECT * FROM buytbl WHERE prodname = '책' OR userid LIKE '%W';
SELECT * FROM buyTbl WHERE TRIM(UPPER(userid)) LIKE '%W';

SELECT * FROM buytbl;
SELECT * FROM usertbl;

SELECT userid, SUM(price * amount) AS 총구매
FROM buytbl
GROUP BY userid;

SELECT userid, COUNT(*)
FROM buytbl
GROUP BY userid;

SELECT addr, COUNT(*) AS 사용자수
FROM usertbl
GROUP BY addr;

SELECT groupName, SUM(price * amount) AS 판매액
FROM buytbl
WHERE groupName IS NOT NULL
GROUP BY groupName;

SELECT birthYear, COUNT(*) "인원수"
FROM usertbl
GROUP BY birthYear
ORDER BY birthYear;


SELECT name, mdate
FROM usertbl
ORDER BY mdate;

SELECT name, mdate
FROM usertbl
ORDER BY mdate desc;

SELECT name, height
FROM usertbl
ORDER BY height desc, name asc;

SELECT * FROM (SELECT rownum as RN, usertbl.* from usertbl) WHERE RN = 2;
SELECT rownum AS RN, usertbl.* FROM usertbl;

SELECT *
FROM (SELECT rownum AS RN, usertbl.* FROM usertbl)
WHERE RN >= 2 AND RN <= 4;

--1
SELECT * FROM usertbl;
SELECT addr, COUNT(userid) FROM usertbl GROUP BY addr;
--2
SELECT userid, SUM(price * amount) FROM buytbl GROUP BY userid;
--3
SELECT NVL (groupname, '미분류') AS groupname, SUM(amount) FROM buytbl GROUP BY groupname;
--4
SELECT birthYear, AVG(height) FROM usertbl GROUP BY birthyear;
--5
SELECT prodname, COUNT(*) "구매 횟수", SUM(price * amount)"총 구매액" FROM buytbl GROUP BY prodname ORDER BY "구매 횟수" DESC;
--6
SELECT NVL(mobile1, '미분류') AS mobile1, COUNT(*) FROM usertbl GROUP BY mobile1;
--7
SELECT * FROM usertbl;
SELECT addr, SUM(price * amount) FROM buytbl B
    JOIN usertbl U
    ON U.userid = B.userid
GROUP BY addr;
--8
SELECT userid, COUNT(DISTINCT prodname) FROM buytbl GROUP BY userid;
--9
SELECT mdate, COUNT(userid) FROM usertbl GROUP BY mdate;
--10
SELECT * FROM usertbl;
SELECT * FROM buytbl;
SELECT FLOOR((2023 - birthyear)/10) * 10, SUM(price * amount) FROM buytbl B
    JOIN usertbl U
    ON U.userid = B.userid
GROUP BY FLOOR((2023 - birthyear)/10) * 10;
