SELECT * FROM usertbl;
SELECT * FROM buytbl;
SELECT * FROM buytbl WHERE amount > 5;
SELECT * FROM buytbl WHERE groupName = '서적' OR groupName = '전자';
SELECT userID, prodName FROM buytbl WHERE groupName IS NULL
SELECT * FROM buytbl WHERE amount = BETWEEN (3 AND 10) ORDER BY price ASC;
SELECT * FROM buytbl WHERE userID LIKE 'k%';