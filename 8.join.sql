-- inner join : 두 테이블 사이에 지정된 조건에 맞는 레코드만을 반환. on 조건을 통해 교집합 찾기
-- 즉 post테이블에 글쓴적이 있는 author와 글쓴이가 author에 있는 post데이터를 결합하여 출력
select * from author inner join post on author.id=post.id;
select * from author a inner join post p on a.id=p.id;

-- 출력순서만 달라질뿐 위 쿼리와 아래쿼리는 동일
select * from post p inner join author a on a.id=p.author_id;
-- 만약 같게 하고 싶다면
select a.*, p.* from post p inner join author a on a.id=p.author_id;

-- 글쓴이가 있는 글 전체 정보와 글쓴이의 이메일만 출력하시오
select p.*, a.email from post p inner join author a on a.id=p.author.id;
-- 글쓴이가 있는 글의 제목, 내용, 그리고 글쓴이의 이름만 출력하시오
select p.title, p.content, p.name from post inner join author a on a.id=p.author_id;

-- A left join B : A테이블의 데이터는 모두 조회하고, 관련있는(on 조건) B데이터도 출력.
-- 글쓴이는 모두 출력하되, 글을 쓴적이 있다면 관련글도 같이 출력
select * from author a left join post p on a.id=p.author_id;

-- 모든 글목록을 출력하고, 만약 저자가 있다면 이메일 정보를 출력.
select p.*, a.email from post p left join author a on a.id=p.author_id;

-- 모든 글목록을 출력하고 관련된 저자 정보 출력 (author_id가 not null이라면)
-- 아래의 두 쿼리는 동일 not null이라는 전제 때문
select * from post p left join author p on a.id-p.author_id;
select * from post p inner join author p on a.id-p.author_id;\

-- 실습) 글쓴이가 있는 글 중에서 글의 title과 저자의 email을 출력하되,
-- 저자의 나이가 30세 이상인 글만 출력
select p.title, a.email from post p inner join author a on a.id=p.author_id where a.age >= 30;

-- 전체 글목록을 조회하되 글의 저자의 이름이 비워져있지 않은 목록만을 출력하시오
select p.* from post p inner join author a on a.id=p.author_id where a.name is not null; 
select p.* from post p left join author a on a.id=p.author_id where a.name is not null;

-- 조건에 맞는 도서와 저자 리스트 출력
SELECT 
b.BOOK_ID, 
a.AUTHOR_NAME, 
DATE_FORMAT(b.PUBLISHED_DATE, '%Y-%m-%d') AS PUBLISHED_DATE 
from BOOK b inner join AUTHOR a on b.AUTHOR_ID=a.AUTHOR_ID 
where b.CATEGORY like '경제'
order by PUBLISHED_DATE;

-- 없어진 기록 찾기 (left join + is null)
SELECT o.ANIMAL_ID, o.NAME 
from ANIMAL_OUTS o left join ANIMAL_INS i 
on o.ANIMAL_ID=i.ANIMAL_ID where i.ANIMAL_ID is null
order by o.ANIMAL_ID;
-- 없어진 기록 찾기 (not in)
select ANIMAL_ID, NAME from ANIMAL_OUTS 
where ANIMAL_ID not in(select ANIMAL_ID from ANIMAL_INS)
order by ANIMAL_ID;