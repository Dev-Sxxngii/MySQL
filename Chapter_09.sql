정수형(소수점이 없는 숫자)
TINYINT	| 1 바이트 | -128 ~ 127
SMALLINT | 2 바이트 | -32,768 ~ 32,767
INT | 4 바이트 | 약 -21억 ~ 약 21억
BIGINT | 8 바이트 | 약 -900경 ~ 약 900경
unsigned를 통해 음수의 범위를 양수에 합쳐 사용 가능하다.
연산의 의미가 있거나 크다/작다 또는 순서에 의미가 있는 경우에 사용하는게 효율적이다.
전화번호는 연산, 비교, 순서와 관련이 없어 문자형으로 잡는게 더 효율적이다. 

문자형 
char: 고정형 문자형(255자)
varchar: 가변형 문자형(16,383자)
char(10)과 varchar(10)의 차이점: char는 남은 공간도 그대로 잡아버려 낭비가 발생할 수 있다. varchar는 공간이 남으면 입력된 공간 만큼만 크기를 잡는다.
char는 속도가 빠르다.
varchar는 공간 효율성이 향상한다.
글자 크기가 고정된 것은 char가 ex) 전화번호
글자 크기가 가변적인 것은 varchar가 유리하다. ex) 이름
전화번호와 같은 앞에 0이 포함되는 것을 숫자형으로 잡으면 0이 떨어져 나간다. 그래서 문자로 잡는게 더 효율적이다.

create table big_table (
	data1 char(255),
	data2 varchar(16383)
); // 한 번에 실행시키는 것은 불가능하다.

longtext: 긴 글자
longblob: 바이너리 데이터(이진 데이터)

실수형 
float | 4 바이트 | 소수점 이하 7자리 표현
double | 8 바이트 | 소수점 이하 15자리 표현

날짜형
date | 3 바이트 | 날짜만 저장, yyyy-mm-dd
time | 3 바이트 | 시간만 저장, HH:MM:SS
datetime | 8 바이트 | 날짜 및 시간 저장 yyyyy-mm-ff hh:mm:ss

변수(@이가 중요함)
set @변수이름 = 변수의 값;
select @변수이름;
변수는 임시 저장되는 개념이다. 새로운 query에서도 값은 남아있지 않고 mysql을 재부팅하면 값은 사라진다.
limit의 경우에는 변수를 통해 할 수 없다.(영상 좀 더 듣고 할걸..ㅠㅠ)

변수의 값을 통한 기능이 되지 않은 경우는 prepare, execute를 통해 사용이 가능하다.

데이터 형 변환
명시적 변환: 프로그램 변환
암시적 변환: 자동 변환

cst ( 값 as 데이터_형식 [ (길이) ])
convert (값, 데이터 형식 [ (길이) ] )

# market_db 호출
use market_db;

# hongong4 테이블 생성
create table hongong4 (
	tinyint_col tinyint,
    smallint_col smallint,
    int_col int,
    bigint_col bigint
);

# hongong4 구조
desc hongong4;

# hongong4 데이터 추가
insert into hongong4(tinyint_col, smallint_col, int_col, bigint_col) values (127, 32767, 2147383647, 9000000000000000000);

# hongong4 테이블 조회
select * from hongong4;

# hongong4 데이터 추가
insert into hongong4(tinyint_col, smallint_col, int_col, bigint_col) values (128, 32768, 2147383648, 90000000000000000000); /* out of range: 표현 가능한 값을 범위를 벗어남 */

# big_table 테이블 생성
create table big_table(
	data1 char(255)
);

# big_table2 테이블 생성
create table big_table2(
	data2 varchar(16383)
);

# netflix_db 데이터 베이스 생성
create database netflix_db;

# movie 테이블 생성
create table netflix_db.movie (
	movie_id int,
    movie_title varchar(30),
    movie_director varchar(20),
    movie_star varchar(20),
    movie_script longtext, 
    movie_film longblob 
);

# 숫자형 변수
set @myVar1 = 5;
set @myVar2 = 4.25;

select @myVar1;
select @myVar2;

# 숫자형 변수 연산
select @myVar1 + @myVar2;

# 문자형 변수
set @txt = '가수 이름 ==> ';
set @height = 166;
select @txt, user_name from member where user_height > @height;

set @count = 3;

select user_name, user_height 
	from member 
    order by user_height desc 
    -- limit @count; /* 불가능 */
    limit 3;
    
set @count = 3;
prepare mySQL from 'select user_name, user_height from member order by user_height limit ?';
execute mySQL using @count;

select avg(unit_price) from buy;

select cast(avg(unit_price) as signed) '평균 가격' from buy;
-- 또는
select convert(avg(unit_price), signed) '평균 가격' from buy;

select cast('2022$12$12' as date);
select cast('2022/12/12' as date);
select cast('2022%12%12' as date);
select cast('2022@12@12' as date);

desc buy;

select purchase_id, concat(cast(unit_price as char), 'x', cast(product_stock as char) ,'=') '가격x수량', unit_price*product_stock '구매액' 
	from buy;