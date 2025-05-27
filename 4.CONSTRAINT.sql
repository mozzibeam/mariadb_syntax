-- not null 제약조건 추가
alter table author modify column name varchar(255) not null;
alter table post modify column title varchar(255) not null;

-- not null 제약조건 제거 (덮어쓰기)
alter table author modify column name varchar(255);
alter table post modify column title varchar(255);

-- not null, unique 제약조건 동시추가
alter table author modify column email varchar(255) not null unique;

-- 테이블차원의 제약조건 추가/제거 pk, fk(primary key, foreign key)
select * from information_schema.key_column_usage where table_name='posts'; --조회

-- 제약조건 제거(fk) -- fk는 한 테이블에 여러개 있을 수 있음 그래서 뒤에 제약조건명이 붙음
-- 제약조건명은 위의 information 들어간 명령어로 조회 가능
alter table post drop foreign key 제약조건명;
alter table post drop constraint 제약조건명; 

-- 제약조건 제거(pk)
alter table post drop primary key;

-- 제약조건 추가(pk)
alter table post add constraint 제약조건명 primary key(id);

-- 제약조건 추가(fk)
alter table post add constraint 제약조건명 foreign key(author_id) references author(id);

-- on delete/update 제약조건 테스트
-- 부모 테이블 데이터 delete할 시 자식 fk컬럼 set null, update할 시 자식 fk컬럼 cascade
alter table post add constraint post_fk_new foreign key(author_id) references author(id)
on delete set null on update cascade; -- 만약 author_id가 not null로 설정되어 있으면 on delete set null과 충돌남

-- default옵션
-- enum타입 및 현재시간(current_timestamp)에서 많이 사용
alter table author modify column name varchar(255) default 'anonymous';

-- auto_increment : 입력을 안했을 때 마지막에 입력된 가장 큰 값에서 +1만큼 자동으로 증가된 숫자값을 적용
alter table author modify column id bigint auto_increment;
alter table post modify column id bigint auto_increment;

-- uuid타입
alter table post add column user_id char(36) default (uuid());
