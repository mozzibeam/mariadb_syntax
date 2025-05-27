-- 흐름제어 : case when, if, ifnull
-- if(a,b,c) : a조건이 참이면 b반환, 그렇지 않으면 c를 반환
select id, if(name is null, '익명사용자', name) from author;

-- ifnull(a,b) : a가 null이면 b를 반환, null 아니면 a를 그대로 반환
select id, ifnull(name, '익명사용자') from author;

select id, 
case 
    when name is null then '익명사용자'
    when name='legacy4' then '홍길동'
    else name
end as name
from author; 

-- 경기도에 위치한 식품창고 목록 출력하기
SELECT WAREHOUSE_ID, 
WAREHOUSE_NAME, 
ADDRESS, 
IFNULL(FREEZER_YN, 'N') as FREEZER_YN
from FOOD_WAREHOUSE
where ADDRESS like '경기도%' 
order by WAREHOUSE_ID;

-- 조건에 부합하는 중고거래 상태 조회하기
SELECT BOARD_ID,
WRITER_ID,
TITLE,
PRICE,
case
when STATUS = 'SALE' then '판매중'
when STATUS = 'RESERVED' then '예약중'
when STATUS = 'DONE' then '거래완료'
else STATUS end as STATUS
from USED_GOODS_BOARD
where CREATED_DATE = '2022-10-05'
order by BOARD_ID desc;

-- 12세 이하인 여자 환자 목록 출력하기
SELECT
PT_NAME,
PT_NO,
GEND_CD,
AGE,
ifnull(TLNO, 'NONE') as TLNO
from PATIENT
where AGE <= 12 and GEND_CD = 'W'
order by AGE desc, PT_NAME asc;