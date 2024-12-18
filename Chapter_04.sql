데이터 베이스 구축 절차
- 데이터 베이스 생성 → 테이블 생성 → 데이터 입력/수정/삭제 → 데이터 조회/활용

CREATE DATABASE shop_db;

use shop_db;

# member 테이블 생성
create table member(
	member_id CHAR(8) NOT Null,
    member_name CHAR(5) NOT NULL,
    member_addr CHAR(20)
);

# PK 지정
ALTER TABLE member MODIFY COLUMN member_id CHAR PRIMARY KEY;

# member_id 속성(크기) 변경
ALTER TABLE member MODIFY member_id CHAR(8);

# member 테이블 구조 확인
desc shop_db.member;

# product 테이블 생성
create table product(
	product_name CHAR(4) NOT NULL PRIMARY KEY,
    cost INT NOT NULL,
    make_date DATE,
    company CHAR(5),
    amount INT NOT NULL
);

# product table 구조 확인
desc product;

# member 테이블 데이터 입력
INSERT INTO member(member_id, member_name, member_addr) values('tess', '나훈아', '경기 부천시 중동');
INSERT INTO member values('hero', '임영웅', '서울 은평구 증산동');
INSERT INTO member values('iyou', '아이유', '인천 남구 주안동');
INSERT INTO member values('jyp', '박진영', '경기 고양시 장향동');

# member 테이블 조회
select * from member;
select member_id, member_name from member;
select * from member where member_id = 'iyou';

# product 테이블 데이터 입력
INSERT INTO product values('바나나', 1500, '2021-07-01', '델몬트', 17);
INSERT INTO product values('카스', 2500, '2022-03-01', 'OB', 3);
INSERT INTO product values('삼각김밥', 800, '2023-09-01', 'CJ', 22);

# product 테이블 조회
select * from product;
select product_name, company, amount from product;
select * from product where product_name = '삼각김밥';