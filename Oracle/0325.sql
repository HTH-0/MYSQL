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
SELECT 
    CASE
        WHEN groupName IS NULL
        THEN '미분류'
        ELSE groupName
    END AS 카테고리, SUM(amount)AS 총합계
FROM buytbl
GROUP BY groupName;

--4
SELECT birthYear, AVG(height) FROM usertbl GROUP BY birthyear;
--5
SELECT prodname, COUNT(*) "구매 횟수", SUM(price * amount)"총 구매액" FROM buytbl GROUP BY prodname ORDER BY "구매 횟수" DESC;
--6
SELECT NVL(mobile1, '미분류') AS mobile1, COUNT(*) FROM usertbl GROUP BY mobile1;
--7
SELECT * FROM usertbl;
SELECT U.addr, SUM(price * amount) "총 구매액" FROM buytbl B
    JOIN usertbl U
    ON U.userid = B.userid
GROUP BY U.addr;
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

--Having

SELECT userid, SUM(price * amount)
FROM buytbl
GROUP BY userid
HAVING SUM(price * amount) >= 1000 ;

SELECT addr, AVG(height) AS "평균키"
FROM usertbl
GROUP BY addr
HAVING AVG(height) > 175;

SELECT userid, COUNT(*) AS 구매횟수, SUM(price * amount) 총구매액
FROM buytbl
GROUP BY userid
HAVING COUNT(*) >= 3 AND SUM(price * amount) >= 100;

SELECT u.addr, b.groupname , SUM(b.amount * b.price)
FROM usertbl u
    join buytbl b
    ON u.userid = b.userid
GROUP BY u.addr, b.groupname
ORDER BY SUM(b.amount * b.price);

-- ROLL UP

SELECT NVL(groupname, '총합') AS 그룹명,
SUM(price * amount)
FROM buytbl
GROUP BY ROLLUP(groupname);

SELECT 
    CASE 
        WHEN GROUPING(groupname) = 1 THEN '총합'
        WHEN groupname IS NULL THEN '미분류'
        ELSE groupname
    END AS 그룹명,
    SUM(price * amount) AS 총금액
FROM buytbl
GROUP BY ROLLUP(groupname);



--문제
--1
SELECT * FROM buytbl;
SELECT userid, SUM(price * amount)
FROM buytbl
GROUP BY userid
HAVING SUM(price * amount)>=1000;

--2
SELECT * FROM usertbl;
SELECT addr, COUNT(userid)
FROM usertbl
GROUP BY addr
HAVING COUNT(userid)>=2;

--3
SELECT * FROM buytbl;
SELECT prodName,AVG(price)
FROM buytbl
GROUP BY prodname
HAVING AVG(price) >= 100;

--4
SELECT * FROM usertbl;
SELECT birthyear, AVG(height)
FROM usertbl
GROUP BY birthyear
HAVING AVG(height) >= 175;

--5
SELECT * FROM buytbl;
SELECT userid, COUNT(prodname)
FROM buytbl
GROUP BY userid
HAVING COUNT(prodname) >= 2;

--6
SELECT * FROM usertbl;
SELECT addr, SUM(price) FROM buytbl b
    JOIN usertbl u
    ON u.userid = b.userid
GROUP BY addr
HAVING SUM(price) > 200;

--7
SELECT * FROM buytbl;
SELECT userid, COUNT(prodname), SUM(price * amount)
FROM buytbl
GROUP BY userid
HAVING COUNT(prodname) >= 3 AND SUM(price * amount) >= 500;

--8
SELECT * FROM usertbl;
SELECT addr, AVG(height)
FROM usertbl
GROUP BY addr
HAVING AVG(height) = (SELECT MAX(avg) FROM(
SELECT addr, (AVG(height)) avg
FROM usertbl
GROUP BY addr
));

--9
SELECT * FROM buytbl;
SELECT userid, SUM(price * amount)
FROM buytbl
GROUP BY userid
HAVING SUM(price * amount) > (
    SELECT AVG(price * amount)
    FROM buytbl
);

--10
SELECT * FROM usertbl;
SELECT b.userid, u.addr, SUM(price * amount) FROM buytbl b
    JOIN usertbl u
    ON b.userid = u.userid
GROUP BY u.addr, b.userid
HAVING SUM(b.price * b.amount) > (
    SELECT avg(sumVal)
    FROM(
        SELECT u2.addr, SUM(b2.price * b2.amount) AS sumVal 
        FROM buytbl b2
            JOIN usertbl u2
            ON u2.userid = b2.userid
        GROUP BY u2.addr, u2.addr
        HAVING u2.addr = u2.addr
    )
);

-- 대소문자 변환
SELECT userID,
       LOWER(userID) AS lower_id,         -- 소문자 변환
       UPPER(name) AS upper_name,         -- 대문자 변환
       INITCAP(LOWER(name)) AS init_cap   -- 첫 글자만 대문자로 변환
FROM userTbl;

-- 문자열 길이
SELECT name, 
       LENGTH(name) AS name_length,       -- 이름의 문자 개수
       LENGTH(addr) AS addr_length        -- 주소의 문자 개수
FROM userTbl;

-- 문자열 추출
SELECT name,
       SUBSTR(name, 1, 1) AS first_char,  -- 이름의 첫 글자
       SUBSTR(userID, 2) AS userid_part   -- userID의 두 번째 문자부터 끝까지
FROM userTbl;

-- 문자 위치 찾기
SELECT name, 
       INSTR(name, '김') AS position_kim   -- '김'이 있는 위치 (없으면 0)
FROM userTbl;

-- 문자열 채우기
SELECT userID,
       LPAD(userID, 10, '*') AS lpad_id,  -- userID 왼쪽을 *로 채워 10자리로
       RPAD(name, 10, '-') AS rpad_name   -- name 오른쪽을 -로 채워 10자리로
FROM userTbl;

-- 공백 제거
SELECT TRIM(' SQL ') AS trim_result,      -- 양쪽 공백 제거: 'SQL'
       LTRIM(' SQL ') AS ltrim_result,    -- 왼쪽 공백 제거: 'SQL '
       RTRIM(' SQL ') AS rtrim_result     -- 오른쪽 공백 제거: ' SQL'
FROM dual;

-- 문자열 치환
SELECT name,
       REPLACE(mobile1, NULL, '없음') AS replace_null,   -- NULL을 '없음'으로 대체
       REPLACE(addr, '서울', 'SEOUL') AS replace_addr   -- '서울'을 'SEOUL'로 대체
FROM userTbl;

-- 문자열 연결
SELECT name,
       CONCAT(mobile1, '-') AS part1,                    -- 휴대폰 국번과 '-' 연결
       CONCAT(CONCAT(mobile1, '-'), mobile2) AS mobile,  -- 국번-전화번호 형식으로 연결
       mobile1 || '-' || mobile2 AS phone_number        -- 연결 연산자 사용
FROM userTbl;


-- buyTbl 테이블의 가격 데이터 활용
-- 반올림, 절삭
SELECT prodName, price,
       ROUND(price/1000, 2) AS round_thousands,    -- 천 단위로 나누고 소수점 2자리 반올림
       TRUNC(price/1000, 1) AS trunc_thousands     -- 천 단위로 나누고 소수점 1자리 절삭
FROM buyTbl;

-- 올림, 내림
SELECT prodName, price,
       CEIL(price/100) AS ceil_hundreds,           -- 백 단위로 나누고 올림
       FLOOR(price/100) AS floor_hundreds          -- 백 단위로 나누고 내림
FROM buyTbl;

-- 나머지, 절대값
SELECT prodName, price, amount,
       MOD(price, 100) AS remainder_100,           -- 가격을 100으로 나눈 나머지
       ABS(price - 500) AS abs_diff_500            -- 가격과 500의 차이의 절대값
FROM buyTbl;

-- 부호, 제곱, 제곱근
SELECT prodName, price,
       SIGN(price - 100) AS sign_price,            -- 가격이 100보다 크면 1, 같으면 0, 작으면 -1
       POWER(amount, 2) AS amount_squared,         -- 수량의 제곱
       SQRT(price) AS sqrt_price                   -- 가격의 제곱근
FROM buyTbl;


SELECT *
FROM usertbl u
    JOIN buytbl b
    ON u.userid = b.userid;
    
SELECT u.userid, name, birthyear, addr, prodname, groupname, price
FROM usertbl u
    JOIN buytbl b
    ON u.userid = b.userid;
    
    
SELECT u.userid, u.name, SUM(b.price * b.amount) AS "총 구매금액"
FROM usertbl u
    JOIN buytbl b
    ON u.userid = b.userid
GROUP BY u.userid, u.name;

SELECT u.name, SUM(b.amount) AS 총수량
FROM usertbl u
    JOIN buytbl b
    ON u.userid = b.userid
GROUP BY u.name
ORDER BY 총수량 DESC;

SELECT rownum AS RN, name, 총수량 FROM (
SELECT u.name, SUM(b.amount) AS 총수량
FROM usertbl u
    JOIN buytbl b
    ON u.userid = b.userid
GROUP BY u.name
ORDER BY 총수량 DESC)
WHERE rownum = 1;

SELECT DISTINCT u.name
FROM usertbl u
    JOIN buytbl b
    ON u.userid = b.userid
WHERE b.prodname = '책';

SELECT * FROM usertbl;
SELECT * FROM buytbl;
SELECT *
FROM usertbl u
    left JOIN buytbl b
    ON u.userid = b.userid;
-- buytbl에 값이 없는 것들도 가져온다
 
SELECT *
FROM usertbl u
    LEFT JOIN buytbl b
    ON u.userid = b.userid
WHERE b.userid IS NULL;
-- buyTbl에 구매 이력이 없는 사용자

SELECT *
FROM usertbl u
    INNER JOIN buytbl b
    ON b.userid = u.userid;
    
SELECT * FROM studenttbl;
SELECT * FROM examtbl;
SELECT *
FROM studenttbl s
    RIGHT OUTER JOIN examtbl e
    ON s.studentid = e.studentid;
    
