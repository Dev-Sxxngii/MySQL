# select문 문법
/*
select 열 이름 
	from 테이블 이름
    where 조건식
    group by 열 이름 # where절 내에서 기능 사용 불가
    having 조건식 group by의 조건은 having에서 사용한다.
    order by 정렬 [asc, desc]
    limit 숫자(제한)
*/

# market_db 데이터 베이스 호출
use market_db;

# member 테이블 구조
desc member;

# order by(정렬)
select * 
	from member 
    order by debut_date; /* asc: 오름차순(생략 가능) */

select * 
	from member 
    order by debut_date desc; /* desc: 내림차순 */

# 개별 order by(정렬)
select * 
	from member 
    where user_height >= 165 
    order by user_height desc, debut_date asc; /* 다수의 조건 가능 user_height에 동일한 값이 존재하면 debut_date 실행 */
    
# limit(제한)
select *
	from member
    order by group_size desc
    limit 3; /* 출력 결과 수 제한 */
    
select *
	from member
    order by group_size desc
    limit 3,2; /* 기준, 출력 결과 수 | 3번 이후(4번부터) 2개 출력 */
    
# distinct(중복 결합[merge])
select distinct user_address
	from member;
    
# group by & sum
select user_id, sum(product_stock)
	from buy
    group by user_id;
    
select user_id, sum(product_stock * unit_price) '총 구매금액'
	from buy
    group by user_id
    order by sum(product_stock * unit_price) desc;
    
# group by & avg
select user_id, avg(product_stock)
	from buy
    group by user_id;
    
select user_id, avg(product_stock * unit_price) '총 구매금액'
	from buy
    group by user_id    
    order by avg(product_stock * unit_price) desc;
    
# group by & count(*)
select user_id, count(area_code)
	from member
    group by user_id;
    
# group by & having
select user_id, sum(product_stock * unit_price)
	from buy
    group by user_id
    having sum(product_stock * unit_price) > 1000
    order by sum(product_stock * unit_price) desc;