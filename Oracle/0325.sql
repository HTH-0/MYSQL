SELECT * FROM usertbl;
SELECT * FROM buytbl;

SELECT * FROM usertbl WHERE NAME = '���ȣ';

SELECT * FROM usertbl WHERE birthyear >= 1970 AND height >= 182;
SELECT * FROM usertbl WHERE birthyear >= 1970 OR height >= 182;

SELECT * FROM usertbl WHERE birthyear BETWEEN 1970 AND 1980;

SELECT * FROM usertbl WHERE addr IN('�泲', '����', '���');

SELECT * FROM usertbl WHERE mobile1 IN('010', '011');
SELECT * FROM usertbl;
SELECT name, height FROM usertbl WHERE name LIKE '��%';
SELECT name, height FROM usertbl WHERE name LIKE '_���';

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
SELECT * FROM buytbl WHERE groupname IN ('����', '����');
--6
SELECT * FROM buytbl WHERE prodname = 'å' OR userid LIKE '%W';
SELECT * FROM buyTbl WHERE TRIM(UPPER(userid)) LIKE '%W';

SELECT * FROM buytbl;
SELECT * FROM usertbl;

SELECT userid, SUM(price * amount) AS �ѱ���
FROM buytbl
GROUP BY userid;

SELECT userid, COUNT(*)
FROM buytbl
GROUP BY userid;

SELECT addr, COUNT(*) AS ����ڼ�
FROM usertbl
GROUP BY addr;

SELECT groupName, SUM(price * amount) AS �Ǹž�
FROM buytbl
WHERE groupName IS NOT NULL
GROUP BY groupName;

SELECT birthYear, COUNT(*) "�ο���"
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
SELECT NVL (groupname, '�̺з�') AS groupname, SUM(amount) FROM buytbl GROUP BY groupname;
SELECT 
    CASE
        WHEN groupName IS NULL
        THEN '�̺з�'
        ELSE groupName
    END AS ī�װ�, SUM(amount)AS ���հ�
FROM buytbl
GROUP BY groupName;

--4
SELECT birthYear, AVG(height) FROM usertbl GROUP BY birthyear;
--5
SELECT prodname, COUNT(*) "���� Ƚ��", SUM(price * amount)"�� ���ž�" FROM buytbl GROUP BY prodname ORDER BY "���� Ƚ��" DESC;
--6
SELECT NVL(mobile1, '�̺з�') AS mobile1, COUNT(*) FROM usertbl GROUP BY mobile1;
--7
SELECT * FROM usertbl;
SELECT U.addr, SUM(price * amount) "�� ���ž�" FROM buytbl B
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

SELECT addr, AVG(height) AS "���Ű"
FROM usertbl
GROUP BY addr
HAVING AVG(height) > 175;

SELECT userid, COUNT(*) AS ����Ƚ��, SUM(price * amount) �ѱ��ž�
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

SELECT NVL(groupname, '����') AS �׷��,
SUM(price * amount)
FROM buytbl
GROUP BY ROLLUP(groupname);

SELECT 
    CASE 
        WHEN GROUPING(groupname) = 1 THEN '����'
        WHEN groupname IS NULL THEN '�̺з�'
        ELSE groupname
    END AS �׷��,
    SUM(price * amount) AS �ѱݾ�
FROM buytbl
GROUP BY ROLLUP(groupname);



--����
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

-- ��ҹ��� ��ȯ
SELECT userID,
       LOWER(userID) AS lower_id,         -- �ҹ��� ��ȯ
       UPPER(name) AS upper_name,         -- �빮�� ��ȯ
       INITCAP(LOWER(name)) AS init_cap   -- ù ���ڸ� �빮�ڷ� ��ȯ
FROM userTbl;

-- ���ڿ� ����
SELECT name, 
       LENGTH(name) AS name_length,       -- �̸��� ���� ����
       LENGTH(addr) AS addr_length        -- �ּ��� ���� ����
FROM userTbl;

-- ���ڿ� ����
SELECT name,
       SUBSTR(name, 1, 1) AS first_char,  -- �̸��� ù ����
       SUBSTR(userID, 2) AS userid_part   -- userID�� �� ��° ���ں��� ������
FROM userTbl;

-- ���� ��ġ ã��
SELECT name, 
       INSTR(name, '��') AS position_kim   -- '��'�� �ִ� ��ġ (������ 0)
FROM userTbl;

-- ���ڿ� ä���
SELECT userID,
       LPAD(userID, 10, '*') AS lpad_id,  -- userID ������ *�� ä�� 10�ڸ���
       RPAD(name, 10, '-') AS rpad_name   -- name �������� -�� ä�� 10�ڸ���
FROM userTbl;

-- ���� ����
SELECT TRIM(' SQL ') AS trim_result,      -- ���� ���� ����: 'SQL'
       LTRIM(' SQL ') AS ltrim_result,    -- ���� ���� ����: 'SQL '
       RTRIM(' SQL ') AS rtrim_result     -- ������ ���� ����: ' SQL'
FROM dual;

-- ���ڿ� ġȯ
SELECT name,
       REPLACE(mobile1, NULL, '����') AS replace_null,   -- NULL�� '����'���� ��ü
       REPLACE(addr, '����', 'SEOUL') AS replace_addr   -- '����'�� 'SEOUL'�� ��ü
FROM userTbl;

-- ���ڿ� ����
SELECT name,
       CONCAT(mobile1, '-') AS part1,                    -- �޴��� ������ '-' ����
       CONCAT(CONCAT(mobile1, '-'), mobile2) AS mobile,  -- ����-��ȭ��ȣ �������� ����
       mobile1 || '-' || mobile2 AS phone_number        -- ���� ������ ���
FROM userTbl;


-- buyTbl ���̺��� ���� ������ Ȱ��
-- �ݿø�, ����
SELECT prodName, price,
       ROUND(price/1000, 2) AS round_thousands,    -- õ ������ ������ �Ҽ��� 2�ڸ� �ݿø�
       TRUNC(price/1000, 1) AS trunc_thousands     -- õ ������ ������ �Ҽ��� 1�ڸ� ����
FROM buyTbl;

-- �ø�, ����
SELECT prodName, price,
       CEIL(price/100) AS ceil_hundreds,           -- �� ������ ������ �ø�
       FLOOR(price/100) AS floor_hundreds          -- �� ������ ������ ����
FROM buyTbl;

-- ������, ���밪
SELECT prodName, price, amount,
       MOD(price, 100) AS remainder_100,           -- ������ 100���� ���� ������
       ABS(price - 500) AS abs_diff_500            -- ���ݰ� 500�� ������ ���밪
FROM buyTbl;

-- ��ȣ, ����, ������
SELECT prodName, price,
       SIGN(price - 100) AS sign_price,            -- ������ 100���� ũ�� 1, ������ 0, ������ -1
       POWER(amount, 2) AS amount_squared,         -- ������ ����
       SQRT(price) AS sqrt_price                   -- ������ ������
FROM buyTbl;


SELECT *
FROM usertbl u
    JOIN buytbl b
    ON u.userid = b.userid;
    
SELECT u.userid, name, birthyear, addr, prodname, groupname, price
FROM usertbl u
    JOIN buytbl b
    ON u.userid = b.userid;
    
    
SELECT u.userid, u.name, SUM(b.price * b.amount) AS "�� ���űݾ�"
FROM usertbl u
    JOIN buytbl b
    ON u.userid = b.userid
GROUP BY u.userid, u.name;

SELECT u.name, SUM(b.amount) AS �Ѽ���
FROM usertbl u
    JOIN buytbl b
    ON u.userid = b.userid
GROUP BY u.name
ORDER BY �Ѽ��� DESC;

SELECT rownum AS RN, name, �Ѽ��� FROM (
SELECT u.name, SUM(b.amount) AS �Ѽ���
FROM usertbl u
    JOIN buytbl b
    ON u.userid = b.userid
GROUP BY u.name
ORDER BY �Ѽ��� DESC)
WHERE rownum = 1;

SELECT DISTINCT u.name
FROM usertbl u
    JOIN buytbl b
    ON u.userid = b.userid
WHERE b.prodname = 'å';

SELECT * FROM usertbl;
SELECT * FROM buytbl;
SELECT *
FROM usertbl u
    left JOIN buytbl b
    ON u.userid = b.userid;
-- buytbl�� ���� ���� �͵鵵 �����´�
 
SELECT *
FROM usertbl u
    LEFT JOIN buytbl b
    ON u.userid = b.userid
WHERE b.userid IS NULL;
-- buyTbl�� ���� �̷��� ���� �����

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
    
