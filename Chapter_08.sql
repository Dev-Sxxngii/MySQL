# market_db 호출
use market_db;

# hongong1 테이블 생성
create table hongong1 (
	toy_id int,
    toy_name char(4),
    age int
);

# insert
insert into hongong1
	values (1, '우디', 25);
    
insert into hongong1(toy_id, toy_name) 
	values(2, '버즈');
    
insert into hongong1(toy_name, age, toy_id) /* 대입 순서 지정 가능 */
	values('제시', 20, 3);

# hongong2 테이블 생성
create table hongong2 (
	toy_id int auto_increment primary key, /* auto_increment & primary key 세트 */
    toy_name char(4),
    age int
);

# insert | auto_increment
insert into hongong2 values (null, '보핍', 25); /* auto_increment로 인해 null이어도 자동 값 할당 */
insert into hongong2 values (null, '슬링키', 22); /* auto_increment로 인해 null이어도 자동 값 할당 */
insert into hongong2 values (null, '렉스', 21); /* auto_increment로 인해 null이어도 자동 값 할당 */

# hongong2 테이블 조회
select * from hongong2; 

# auto_increment 현재 값
select last_insert_id();

# alter: auto_increment 기본 값 변경
alter table hongong2 auto_increment = 100;
insert into hongong2 values (null, '재남', 35);
select * from hongong2;

# hongong3 테이블 생성 
create table hongong3(
	toy_id int auto_increment primary key,
    toy_name char(4),
    age int
);
alter table hongong3 auto_increment = 1000; /* auto_increment값 변경 */
set @@auto_increment_increment = 3; /* auto_increment 간격 조절 */

insert into hongong3 values (null, '토마스', 20);
insert into hongong3 values (null, '제임스', 23);
insert into hongong3 values (null, '고든', 25);
select * from hongong3;

select * from world.city;

desc world.city; /* desc: 테이블 구조 출력 */

select * from world.city limit 5;

create table city_popul(
	city_name char(35),
    population int
);

desc city_popul;

# insert into ~ select: 읽어 온 데이터를 저장
insert into city_popul
	select name, population from world.city;
    
select * from city_popul;

# safe mode 끄기 (safe mode가 실행되면 update문 사용 불가)
SET SQL_SAFE_UPDATES = 0;

# update
update city_popul
	set city_name = '서울'
    where city_name = 'Seoul';
select * from city_popul where city_name = '서울';

update city_popul
	set city_name = '뉴욕', population = 0
    where city_name = 'New York';
select * from city_popul where city_name = '뉴욕';

/* 
아래와 같은 경우를 제외하고 거의 where 절과 함께 사용한다.
where 절을 함께 사용하지 않으면 모든 데이터 값이 변해버리기 때문
 */
update city_popul
	set population = population/10000; -- 만명 단위로 변경

# delete
select * from city_popul where city_name like "New%";

delete from city_popul
	where city_name like 'New%';

# 삭제 제한
delete from city_popul
	where city_name like 'New%'
    limit 5;
    