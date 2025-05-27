-- read uncommited : 커밋되지 않은 데이터 read 가능 -> dirty read 문제 발생
-- 실습절차
-- 워크벤치에서 오토커밋 해제, 업데이트 후 커밋하지 않음. (transaction1)
-- 터미널을 열어 select했을 때 위 변경사항이 읽히는지 확인. (transaction2)
-- 결론 : mariadb는 기본이 reapeatable read이므로 dirty read 발생하지 않음.

-- read commited : 커밋한 데이터만 read 가능 -> phantom read 발생(또는 non-repeatable read)
-- 워크벤치에서 실행
start transaction;
select count(*) from author;
do sleep(15);
select count(*) from author;
commit;
-- 터미널에서 실행
insert into author(email) values("xxxxx2d2xx21@naver.com");

-- repeatable read : 읽기의 일관성 보장 -> lost update 문제 발생 -> 배타적 잠금으로 해결
-- lost update 문제 발생
DELIMITER //
create procedure concurrent_test1()
begin
    declare count int;
    start transaction;
    insert into post(title, author_id) values('hello world', 1);
    select post_count into count from author where id=1 for update;
    do sleep(15);
    update author set post_count=count+1 where id=1;
    commit;
end //
DELIMITER ;

-- 터미널에서는 아래코드 실행행
select post_count from author where id=1;
-- lost update 문제 해결 : select for update시에 트랜잭션이 종료 후에 특정 행에 대한 lock풀림


-- serializable : 모든 트랜잭션 순차적 실행 -> 동시성문제 없으나(성능저하)