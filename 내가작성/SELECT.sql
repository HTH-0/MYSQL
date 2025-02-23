SELECT * FROM usertbl;
SELECT * FROM buytbl;

SELECT * FROM buytbl WHERE amount > 5;

SELECT * FROM buytbl WHERE groupName = '서적' OR groupName = '전자';

SELECT userID, prodName FROM buytbl WHERE groupName IS NULL;

SELECT * FROM buytbl WHERE amount BETWEEN 3 and 10 ORDER BY price;

SELECT * FROM buytbl WHERE userID LIKE 'k%';

SELECT DISTINCT userID FROM buytbl ORDER BY userID DESC;

SELECT name, birthYear, addr FROM usertbl WHERE birthYear > 1970;

## SELECT 실습 문제 2
SELECT MAX(Population), MIN(population) FROM city WHERE CountryCode = 'kor';

SELECT * FROM countrylanguage;
SELECT COUNT(DISTINCT language) FROM countrylanguage;

SELECT COUNT(*), countrycode FROM city
GROUP BY countryCode ORDER BY COUNT(district) DESC;

SELECT district, COUNT(*) FROM city WHERE CountryCode = 'kor'
GROUP BY district having COUNT(*) >= 5;

USE practice;
SELECT addr, AVG(height) FROM usertbl
GROUP BY addr
ORDER BY AVG(height) LIMIT 3;
