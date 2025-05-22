-- insert : 테이블 데이터 삽입
insert into 테이블명(컬럼1,컬럼2,컬럼3...) values(데이터1,데이터2,데이터3,...);
insert into author(id, name, email) values(3, 'hong3', 'hong3@naver.com'); -- 문자열 작은 따옴표 관례

-- update : 테이블 데이터 변경
update author set name='홍길동', email='hong100@naver.com' where id=3;

-- select : 조회회
select 컬럼1, 컬럼2 from 테이블명
select name, email, from author;
select * from author;

-- delete : 삭제
delete from 테이블명 where 조건절
delete from author where id=3;

-- select 조건절 활용 조회
select * from author where id>1 and name='legacy3';

-- 중복제거 조회 : distinct
select name from author;
select distinct name from author;

-- 정렬 : order by + 컬럼명
-- asc : 오름차순(별다른 옵션 안 주면 default값), desc : 내림차순
-- 아무런 정렬조건 없이 조회할 경우에는 PK기준으로 오름차순
select * from author order by name;
select * from author order by name desc;

-- 멀티컬럼 order by : 여러컬럼으로 정렬시에, 먼저 쓴 컬럼 우선정렬, 중복시, 그라음 정렬옵션적용
select * from author 
order by name desc, email asc; -- name 우선 정렬 후 중복 시에 email로 오름차순 정렬 asc 생략가능

-- 결과값 개수 제한
select * from author 
order by id desc
limit 1;

-- 별칭(alias)를 이용한 select
select name as '이름', email as '이메일' from author;
select name, email from author as a; -- 테이블 별칭도 가능
select a.name, a.email from author a;

-- null을 조회조건으로 활용, 무조건 알아야됨 기본적인거
select * from author where password is null -- = null 로 쓰는거 아님
select * from author where password is not null

SELECT ANIMAL_ID, NAME, INTAKE_CONDITION from ANIMAL_INS
order by NAME, INTAKE_CONDITION desc;
