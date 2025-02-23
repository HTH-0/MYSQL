#한줄 주석(#뒤에 붙여도 가능)
-- 한줄 주석(-- 하고 띄어쓰기 해야함)
/*
여러줄
*/

USE world;
# world라는 이름의 데이터베이스를 사용한다.

SELECT * FROM city;
SELECT * FROM country;
SELECT * FROM sakila.city; # sakila 데이터베이스가 존재하는 city를 조회해라
USE world;

# Query 작성 시, 명령어는 대문자 / 속성명, 테이블, db명은 소문자로 적는게 일반적이다.
# 조회 시, 속성명을 변경하고 싶다면 속성명 뒤에 새로운 속성이름을 작성하면 된다 (AS가 생략된 것)
SELECT Population 인구수, name '도시의 이름', district AS '구역^-^' FROM city;
SELECT 1, 2, 3 * 10 AS '결과';
# FROM을 추가하면 어떤 테이블에 있는 데이터도 동시에 조회할 수 있다.
SELECT name, name, name, population * 10, 1000 FROM city;
########### 조건 조회
SELECT * FROM city WHERE population > 1000000; # 인구수가 100만 이상인 데이터만
SELECT * FROM city WHERE countrycode = 'kor' AND population > 1000000;
## MYSQL은 TRUE / FALSE가 없고, 1과 0으로 판단
SELECT TRUE, FALSE, 1, 0;
SELECT 1 < 10;# TRUE기 때문에 1이 조회된다.
SELECT 1 > 10;# FALSE라 0이 조회됨.
SELECT 1 = 1; # 같은가 ? = 하나만, == 안됨!
SELECT 1 != 1; # 다른가 ? '!'는 반대를 의미한다.
SELECT 1 = 1 AND 2 = 2; #AND랑 &&랑 같음. 말 그대로 사용하는것이 일반적
SELECT 1 != 1 OR 2 = 2; # || 보다는 OR
SELECT NOT TRUE; # ! 보다는 NOT
### Countrycode가 kor 이면서 인구수가 100만 이상인 데이터 조회
SELECT * FROM city WHERE CountryCode = 'KOR' AND population > 1000000;
### Countrycode가 kor 이면서, 구역이 경기도 or 경상남도인 데이터 조회

SELECT * FROM city
WHERE countryCode = 'kor' AND ( District = 'kyonggi' OR district = 'kyongsangnam' );
##################
SELECT DISTINCT district FROM city WHERE CountryCode = 'kor';
# 인구수를 기준으로 정렬
# ASC : 오름차순 (기본)
# DESC : 내림차순
# LIMIT 2,3 : 조회된 결과에서 2번 줄 이후에 3줄만 
SELECT * FROM city ORDER BY population DESC LIMIT 2, 3;

SELECT * FROM city
WHERE CountryCode = 'kor'
ORDER BY District, Population; # district로 정렬 후에, population으로 재정렬ALTER

###
SELECT * FROM city
WHERE CountryCode = 'kor' AND (pupulation > 1000000 AND Population < 2000000);
# 1000000도 나오고 2000000도 포함, 백만 이상 이백만 이하
SELECT * FROM city
WHERE CountryCode = 'kor' AND (pupulation BETWEEN 1000000 AND 2000000);
## IN : OR 대신에 사용가능
## district가 경기 혹은 경남이라면 ok
SELECT * FROM city
WHERE CountryCode = 'kor' AND District IN ('kyonggi', 'kyongsangnam');
SELECT * FROM country WHERE IndepYear IS NOT NULL; 
SELECT * FROM country WHERE IndepYear = NULL; # NULL은 = 비교 안된다
SELECT * FROM country WHERE IndepYear <=> NULL; # <=> 는 NULL 비교도 OK
####### LIKE
SELECT * FROM country WHERE name LIKE '%g';# g로 끝나는 국가를 검색(앞에 아무거나 있어도 상관없다)
SELECT * FROM country WHERE name LIKE 'g%';# g로 시작하는 국가
SELECT * FROM country WHERE name LIKE '%g%';# g가 이름안에 들어가있는 국가
SELECT * FROM country WHERE name LIKE 'ja___';# ja로 시작하고 ja + 글자가 3개인 국가
SELECT * FROM country WHERE name LIKE '____';# 4글자로 된 국가
SELECT * FROM country WHERE name LIKE '_u__';# 4글자이고 2번째 글자가 u인 국가
SELECT * FROM country WHERE name LIKE '_r%';# 2글자 이상, 2번째 글자가 r인 국가
# %글자를 찾고싶다면 ESCAPE 글자 사용( \% 로 검색 )

########
SELECT SUM(Population) FROM city WHERE CountryCode = 'kor' ;
SELECT MAX(Population), 1, 2 FROM city WHERE CountryCode = 'kor' ;
SELECT COUNT(*), MIN(Population) FROM city
WHERE CountryCode = 'kor';
SELECT SUM(Population) / COUNT(population) , AVG(Population) FROM city
WHERE CountryCode = 'kor';
SELECT CONCAT(COUNT(DISTINCT District), '개') FROM city
WHERE CountryCode = 'kor';
SELECT CONCAT('하이', 'ㅋㅋㅋ', 1, TRUE, FALSE);
############# 대한민국의 District별로 인구수 합계를 구하고 싶어
SELECT SUM(population) FROM city WHERE CountryCode = 'kor' ;
SELECT District, SUM(population) '인구 총 합' FROM city
WHERE CountryCode = 'kor'
GROUP BY District;
SELECT District, SUM(population) '인구 총 합' FROM city
WHERE CountryCode = 'kor'
GROUP BY District
HAVING SUM(population) > 2000000;
SELECT name, district, sum(population) FROM city
WHERE CountryCode = 'kor'
GROUP BY District, name WITH ROLLUP; 