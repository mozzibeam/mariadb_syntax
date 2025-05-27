-- 트랜잭션 : 논리적인 작업처리 단위(1개 이상의 SQL문의 집합)
-- 쿼리 자체를 트랜잭션이라고 부르기도 함
-- 0)임시저장 1)commit 2)rollback

-- 트랜잭션 테스트
alter table author add column post_count int default 0;

-- post에 글쓴후에, author테이블의 post_count컬럼에 +1을 시키는 트랜잭션 테스트
start transaction;
update author set post_count=post_count+1 where id=3;
insert into post(title, content, author_id) values("hello", "hello ...", 3);
commit; --또는 rollback;

-- 위 트랜잭션은 실패시 자동으로 rollback이 어려움
-- stored procedure(프로시저)를 활용하여 성공시 commit, 실패시 rollback 등 다이나믹한 프로그래밍
DELIMITER //
create procedure transaction_test()
begin
    declare exit handler for SQLEXCEPTION
    begin
        rollback;
    end;
    start transaction;
    update author set post_count=post_count+1 where id=3;
    insert into post(title, content, author_id) values("hello", "hello ...", 3);
    commit;
end //
DELIMITER ;

-- 프로시저 호출
call transaction_test();

-- 사용자에게 입력받는 프로시저 생성
DELIMITER //
create procedure transaction_test2(in titleInput varchar(255), in contentInput varchar(255), in idInput bigint)
begin
    declare exit handler for SQLEXCEPTION
    begin
        rollback;
    end;
    start transaction;
    update author set post_count=post_count+1 where id=idInput;
    insert into post(title, content, author_id) values(titleInput, contentInput, idInput);
    commit;
end //
DELIMITER ;

-- 프로시저 호출
call transaction_test();