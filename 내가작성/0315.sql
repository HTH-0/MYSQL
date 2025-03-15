# INNER JOIN : 두 테이블의 데이터가 일단 전부 나오고, 추가로 ON 구문에 맞는 데이터만 나온다
# OUTER JOIN (LEFT)
# LEFT 테이블ㅇㄴ 전부, RIGHT 테이블은 ON 구문에 맞는 데이터만 나온다 (LEFT, RIGHT)
#( ON 구문이 무조건 필요)
#NATURAL JOIN : INNER JOIN의 ON 구문을 자동으로 구성해줌
#CROSS JOIN : 두 테이블의 행 데이터를 서로 한 행씩 결합한 결과가 나온다 ( 의미없는 데이터)

SELECT * FROM emptbl;
SELECT * FROM emptbl WHERE emp =(
SELECT manager FROM emptbl WHERE emp = '우대리');
## JOIN 구문
SELECT * FROM emptbl EMP
	INNER JOIN emptbl MANAGER
    ON EMP.manager = MANAGER.emp;
SELECT * FROM emptbl MANAGER   
    LEFT OUTER JOIN emptbl MANAGER2
    ON MANAGER.maneger = MANAGER2.emp
    WHERE EMP.emp = '우대리';


#####
CREATE TABLE `customer` (
    `no` INT AUTO_INCREMENT PRIMARY KEY,
    `name` CHAR(10),
    `recommend` INT,
    FOREIGN KEY (`recommend`) REFERENCES `emptbl`(`other_column`)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
SELECT * FROM customer;

#'박병우'가 추천한 사람의 이름들을 조회
SELECT * FROM customer WHERE `recommend` IN(
SELECT `no` FROM customer WHERE `name` = '박병우');
SELECT * FROM customer `CUS`
	LEFT OUTER JOIN customer `REC`
	ON `CUS`.`no` = `REC`.`recommend`
    WHERE `CUS`.`name` = '박병우';
    
    
## 자신이 추천한 사람이 2명 이상인 사람의 정보를 조회

SELECT * FROM customer WHERE `no` IN
(SELECT `recommend`
FROM customer
GROUP BY `recommend`
HAVING COUNT(*) >= 2);

## SELF JOIN
SELECT CUS.`no`, CUS.`name`, CUS.`recommend`
FROM customer CUS 
	INNER JOIN customer REC
    ON CUS.`no` = REC.`recommend`
GROUP BY CUS.`no`, CUS.`name`, CUS.`recommend`
HAVING COUNT(*) >= 2;
    
    
SET @num = 20; # num 이라는 변수에 10을 저장
SELECT @num;	# num 변수의 값(10)을 조회
SELECT 10 * @num;
SET @nowdate = new();
SELECT @nowdate, now();

SET @limit_count = 3;
PREPARE var_query
FROM 'SELECT * FROM usertbl LIMIT ?';

EXECUTE var_query USING @limit_count;

###
SET @attr_name = 'name'; # 나는 usertbl에서 name 열을 조회하고 싶다.
SET @my_query = CONCAT('SELECT', @attr_name, ' FROM usertbl');

###
SELECT NOW();
SELECT CAST(NOW() AS DATE);
SELECT CONVERT( NOW() , DATE);
###
SELECT '100' + '200'; ## 문자를 숫자로 변환했다.
SELECT '100' + 200;
SELECT CONCAT(100, 200);
SELECT 10 > 'A0';
SELECT CAST('-10.111' AS UNSIGNED INT);

SHOW charset;
##############
SELECT IF(1 = 1, '맞다', '틀렸다');
SELECT *, IF( birthYear >= 1980,'dd' , 'dd') FROM usertbl;
USE world;
SELECT IFNULL(indepyear, 1000) FROM country;
SELECT ifnull(10, 20), ifnull(NULL, 20);


### SQLD >> IF, IFNULL, NULLIF >> 결과가 뭐냐
SELECT
	CASE 1
		WHEN 1 THEN '일'
        WHEN 10 THEN '십'
	END;
    
SELECT
	CASE
		WHEN 100 != 100 THEN '맞음'
        WHEN 100 != 100 THEN '아님'
        ELSE ' 해당안됨'
        END AS '결과';
        
SELECT countryCode,
	CASE
		WHEN COUNT(*) > 20 THEN '대규모'
		ELSE '소규모'
        END '규모'
FROM city GROUP BY countryCode;


SELECT ASCII('A'), CAST(CHAR(65) AS CHAR);
SELECT LENGTH('A1!'), char_length('A1!');

SELECT FORMAT(123456.789, 1);

SELECT REPLACE ( 'MY TEST PROGRAM', 'TEST', 'MYSQL');

SELECT CURDATE(), CURTIME(), NOW(), SYSDATE(), current_timestamp(), unix_timestamp();

SELECT '현재 시간은 ?년 ?월 ?일 입니다';
SELECT YEAR(NOW()), MONTH(NOW()), DAY(CURDATE());
SELECT CONCAT('현재 시간은', YEAR(NOW()), '년', MONTH(NOW()), '월', DAY(CURDATE()), '일 입니다');
SELECT '20-04-08';
SELECT DATE_FORMAT('20-04-08', '%Y-%m-%d');
SELECT str_to_date('TODAY20_1_1', 'TODAY%Y_%m_%d');
SELECt time(str_to_date('',''));

####
SELECT DATE_ADD(NOW(), INTERVAL 1 MONTH);
SELECT ADDDATE('2000-01-01', 31);
SELECT NOW(), SLEEP(1), NOW();## now()를 사용해야한다. 시간이 달라지지 않는다
SELECT SYSDATE(), SLEEP(1), SYSDATE(); ## SYSDATE 사용하면 흘러가는 시간을 출력함