# market_db 예외 처리
drop database if exists market_db; -- market_db 데이터 베이스 존재 시 삭제

# market_db 생성
create database market_db;

# market_db 데이터 베이스 호출
use market_db;

# member 테이블 생성
create table member(
	user_id char(8) not null primary key,
    user_name varchar(10) not null,
    group_size int not null,
    user_address char(2) not null,
    area_code char(3),
    local_number char(8),
    user_height smallint,
    debut_date date
);

# member 테이블 구조
desc member;

# buy 테이블 생성
create table buy(
	purchase_id int auto_increment not null primary key,
    user_id char(8) not null,
    product_name char(6) not null,
    category char(4),
    unit_price int not null,
    product_stock smallint not null,
    foreign key(user_id) references member(user_id)
);

# buy 테이블 구조
desc buy;

# member 테이블 데이터 추가
insert into member values('TWC', '트와이스', 9, '서울', '02', '11111111', 167, '2015.10.19');
insert into member values('BLK', '블랙핑크', 4, '경남', '055', '22222222', 163, '2016.08.08');
insert into member values('WMN', '여자친구', 6, '경기', '031', '33333333', 166, '2015.01.15');
insert into member values('OMY', '오마이걸', 7, '서울', NULL, NULL, 160, '2015.04.21');
insert into member values('GRL', '소녀시대', 8, '서울', '02', '44444444', 168, '2007.08.02');
insert into member values('ITZ', '잇지', 5, '경남', NULL, NULL, 167, '2019.02.12');
insert into member values('RED', '레드벨벳', 4, '경북', '054', '55555555', 161, '2014.08.01');
insert into member values('APN', '에이핑크', 6, '경기', '031', '77777777', 164, '2011.02.10');
insert into member values('SPC', '우주소녀', 13, '서울', '02', '88888888', 162, '2016.02.25');
insert into member values('MMU', '마마무', 4, '전남', '061', '99999999', 165, '2014.06.19');

# buy 테이블 데이터 추가
insert into buy values(NULL, 'BLK', '지갑', NULL, 30, 2);
insert into buy values(NULL, 'BLK', '맥북프로', '디지털', 1000, 1);
insert into buy values(NULL, 'APN', '아이폰', '디지털', 200, 1);
insert into buy values(NULL, 'MMU', '아이폰', '디지털', 200, 5);
insert into buy values(NULL, 'BLK', '청바지', '패션', 50, 3);
insert into buy values(NULL, 'MMU', '에어팟', '디지털', 80, 10);
insert into buy values(NULL, 'GRL', '혼공SQL', '서적', 15, 5);
insert into buy values(NULL, 'APN', '혼공SQL', '서적', 15, 2);
insert into buy values(NULL, 'APN', '청바지', '패션', 50, 1);
insert into buy values(NULL, 'MMU', '지갑', NULL, 30, 1);
insert into buy values(NULL, 'APN', '혼공SQL', '서적', 15, 1);
insert into buy values(NULL, 'MMU', '지갑', NULL, 30, 4);

# 일반(전체) 조회
select * from member;

# 조건(where) & 열(row) 조회
select * from member where user_id = 'BLK';

# 조건(where) & 부등호(> 또는 <)
select user_id, user_name from member where user_height <= 162;

# 조건(where) & and
select user_id, user_name from member where user_height <= 162 and group_size <= 5;

# 조건(where) & or
select user_id, user_name from member where user_height <= 162 or group_size <= 5;

# 조건(where) & between
select user_id, user_name from member where user_height between 163 and 165; /* 두 개의 조건만 가능 */

# 조건(where) & in
select user_id, user_address from member where user_address in('경기', '전남', '경남');

# 조건(where) & like %
select user_id, user_name from member where user_name like '블%';
select user_id, user_name from member where user_name like '%랙%';
select user_id, user_name from member where user_name like '%크';

# 조건(where) & like __
select user_id, user_name from member where user_name like '블___';
select user_id, user_name from member where user_name like '_랙__';
select user_id, user_name from member where user_name like '___크';

# 속성(열) 조회 
select user_id, user_name, debut_date from member;
select debut_date, user_name, user_id from member; /* 열 순서 변경 가능 */

# 별칭 조회
select user_id 코드, user_name 이름, debut_date 데뷔일 from member;
select user_name 이름, birth_year 출생연도, user_address '집 주소' from member; /* 별칭 설정 시 공백이 포함될 경우 따옴표("") 처리*/

# 데이터베이스 접근 조회
select * from shop_db.member; /* 미사용중인 데이터베이스의 테이블 접근 가능 */