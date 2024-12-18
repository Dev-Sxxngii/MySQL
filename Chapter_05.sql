인덱스: 데이터의 빠른 조회를 도와주는 개체(책: 카테고리, 단원)

뷰(SELECT문): 사용자가 SELECT문(뷰)을 사용해 접근하면 뷰(SELECT문)가 테이블을 연결시켜 사용자에게 보여준다.
- 사용자는 테이블에 접근하는 것이 아닌 뷰에 접근하는 것이다!

스토어드 프로시저: 프로그래밍 지원 도구(기본적으로 MySQL은 지원하지 않음)

use shop_db;

# member 테이블 조회
select * from member where member_name = '아이유'; /*전체 테이블 조회(비효율적)*/

# member 테이블 인덱스 조회
show index from member;

# member_name 인덱스 생성
create index id1 on member(member_name);

# member_name 인덱스 변경 (삭제 후 생성)
alter table member drop index id1;
alter table member add index idx_member_name(member_name);

# member table 조회
select * from member where member_name = '아이유';

# member_view 생성
create view member_view
as 
	SELECT * FROM member;
    
# member_view 뷰 조회
select * from member_view;

# 스토어드 프로시저 생성
DELIMITER //
CREATE PROCEDURE myProc()
BEGIN
	select * from member where member_name = '아이유';
    SELECT * FROM product WHERE product_name = '삼각김밥';
END //
DELIMITER ; /* 뷰랑 충돌 오류 발생 */

# 프로시저 호출
CALL myProc();

# 프로시저 삭제
drop procedure myProc;

# member_view 뷰 삭제
drop view member_view;

