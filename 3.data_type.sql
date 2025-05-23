-- tinyint : -128~127까지 표현 가능
-- author테이블에 age 컬럼 변경
alter table author modify column age tinyint unsigned;
insert into author(id, email, age) values(6, 'abc@naver.com', 300);

-- int : 4바이트(대략, 40억 숫자범위)

-- bigint : 8바이트

-- author, post 테이블의 id값 bigint 변경
alter table author modify column id bigint primary key;
alter table post modify column id bigint;

-- decimal(총자리수, 소수부자리수)
alter table post add column price decimal(10,3);
-- decimal 소수자리수 초과시 짤림현상 발생함
insert into post(id, tiltle, price, author_id) values(8, 'hello python', 10.33412, 12);

-- 문자타입 : 고정길이(char), 가변길이(varchar, text)
alter table author add column gender char(10);
alter table author modify column gender char(1);

alter table author add column self_introduction text;

-- blob(바이너리데이터) 타입 실습
-- 일반적으로 blob으로 저장하기 보다, varchar로 설계하고 이미지경로만을 저장함
alter table author add column profile_image longblob; -- bigint 같은 느낌
insert into author(id, email, profile_image) values(13, 'aaa@naver.com', LOAD_FILE('C:\Users\Playdata\spongebob.jpg'));

-- enum : 삽입될 수 있는 데이터의 종류를 한정하는 데이터 타입
-- role컬럼 추가 
-- not null 조건을 걸지 않으면 nullable함, 보통은 디폴트 옵션으로 null이 입력되지 않게함
alter table author add column role enum('admin', 'user') not null default 'user';
-- enum에 지정된 값이 아닌 경우
insert into author(id, email, role) values(17, 'oghtrhi@naver.com', 'admin2');
-- role을 지정 안한 경우 (디폴트를 주었기 때문에 이전 null값들도 -> user로 바뀜)
insert into author(id, email) values(18, 'gegeogi@naver.com');
-- enum에 지정된 값인 경우우
insert into author(id, email, role) values(19, 'oagahgi@naver.com', 'admin');
-- select 검색시 컬럼 검색처럼 조건으로 사용 가능
select * from author where role='admin';

-- date와 datetime
-- 날짜타입의 입력, 수정, 조회시에 문자열 형식을 사용
alter table author add column birthday date;
alter table post add column created_time datetime;
insert into post(id, title, author_id, created_time) values(19, 'hell', 3, '2025-05-23 14:36:30');
alter table post modify column created_time datetime default current_timestamp();
insert into post(id, title, author_id) values(20, 'hell', 3);

-- 비교연산자
select * from author where id >= 2 and id < 4;
select * from author where id between 2 and 4; --위 구문과 같음
select * from author where id in(2,3,4); -- not in은 2,3,4가 아닌 것들 조회

-- like : 특정 문자를 포함하는 데이터를 조회하기 위한 키워드
select * from post where title like '%fa%';
select * from post where title like '%python';

-- REGEXP 정규표현식을 활용한 조회
select * from post where title regexp '[a-z]'; -- 하나라도 알파벳 소문자가 들어있으면
select * from post where title regexp '[가-힣]'; -- 한글

-- 숫자 -> 날짜
select cast(20250523 as date) from author; -- 2025-05-23;
-- 문자 -> 날짜
select cast('20240523' as date);
-- 문자 -> 숫자
select cast('12' as unsigned); -- unsigned 나 signed (int아님)

-- 날짜조회 방법 : 2025-05-23 14:30;24
-- like패턴, 부등호
select * from post where created_time like '2025-05%'; -- 문자열처럼 조회
-- 날짜만 입력시 시간부분에 자동으로 00:00:00이 붙어서 2025-05-20의 date 값은 나오지 않음음
select * from post where created_time >= '2025-05-01' and created_time <= '2025-05-20'; -- 날짜 구간 조회
select date_format(created_time, '%Y-%m-%d') from post; -- 소문자 y는 2자리
select date_format(created_time, '%H-%i-%s') from post; -- 소문자 h는 12시간 방식
select * from post where date_format(created_time, '%m') = '05';
-- cast를 활용하여 문자값을 숫자로 변환해서 찾을 수 있음음
select * from post where cast(date_format(created_time, '%m') as unsigned) = 5;
-- 아래것도 찾아지긴 하는데 문법적으로 올바르진 않음음
select * from post where date_format(created_time, '%m') = 5;

-- 현재시간 출력
select now(); -- (UTC-9 시간으로 적용됨 - 보통 미국 프로그램 사용으로 인해)

