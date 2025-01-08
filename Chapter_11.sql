# DB 선택
use market_db;



-- ifProc1 --
# PROCDURE 예외 처리
DROP PROCEDURE IF EXISTS ifProc1;

# PROCDURE 생성
DELIMITER $$
CREATE PROCEDURE ifProc1()
BEGIN
	IF 100 = 100 THEN
		SELECT '100은 100과 같습니다.';
	END IF;
END $$
DELIMITER ;

# PROCEDURE 조회
SHOW PROCEDURE STATUS;
-- 또는 --
SHOW PROCEDURE STATUS
	WHERE DB = 'market_db'; /* DB: SHOW PROCEDURE STATUS 쿼리문의 예약어 */
    
# PROCDURE 호출
CALL ifProc1();



-- ifProc2 --
# PROCEDURE 예외 처리
DROP PROCEDURE IF EXISTS ifProc2;

# PROCEDURE 생성
DELIMITER $$
CREATE PROCEDURE ifProc2()
BEGIN
    DECLARE myNum INT; /* DECLARE: 지역 변수 선언 */
    SET myNum = 200;
    IF myNum = 100 THEN
		SELECT '100입니다.';
	ELSE
		SELECT '100이 아닙니다.';
	END IF;
END $$
DELIMITER ;
    
# PROCEDURE 조회
SHOW PROCEDURE STATUS;

# PROCEDURE 호출
CALL ifProc2();



-- ifProc3 --
# PROCEDURE 예외 처리
DROP PROCEDURE IF EXISTS ifProc3;

# PROCEDURE 생성
DELIMITER $$
CREATE PROCEDURE ifProc3()
BEGIN
	DECLARE debutDate DATE;
    DECLARE curDate DATE;
    DECLARE days INT;
    
    SELECT debut_date INTO debutDate /* SELECT INTO문은 프로시저내에서 변수에 조회된 데이터를 할당하거나 파일로 저장하기 위해 사용한다 */
		FROM market_db.member
        WHERE user_id = 'APN';
	
    SET curDate = CURRENT_DATE(); /* CURRENT_DATE: YYYY-MM-DD */
    SET days = DATEDIFF(curDate, debutDate); /* DATEDFF: YYYY-MM-DD - YYYY-MM-DD, 기본값은 days(일) */
    
    IF (days/365) >= 5 THEN
		SELECT CONCAT('데뷔한지 ', days, '일이나 지났습니다. 에이핑크 파이팅!');
	ELSE
		SELECT '데뷔한지' + days + '일밖에 안되었네요. 에이핑크 파이팅!';
    END IF;
END $$
DELIMITER ;
        
# PROCEDURE 조회
SHOW PROCEDURE STATUS;

# PROCEDURE 호출
CALL ifProc3();	



/* caseProc; */
# PROCEDURE 예외 처리
DROP PROCEDURE IF EXISTS caseProc;

# PROCEDURE 생성
DELIMITER $$
CREATE PROCEDURE caseProc()
BEGIN
	DECLARE point INT;
    DECLARE credit CHAR(1);
    SET point = 100;
    
    CASE
		WHEN point >= 90 THEN
			SET credit = 'A';
		WHEN point >= 80 THEN
			SET credit = 'B';
		WHEN point >= 70 THEN
			SET credit = 'C';
		WHEN point >= 60 THEN
			SET credit = 'D';            
		ELSE
			SET credit = 'F';            
		END CASE;
        SELECT CONCAT('취득점수: ', point), CONCAT('학점: ', credit);
END $$
DELIMITER ;

# PROCEDURE 조회
SHOW PROCEDURE STATUS;

# PROCEDURE 호출
CALL caseProc();



/* caseProc */
SELECT mem_id, SUM(price*amount) '총구매액'
	FROM buy
    GROUP BY mem_id;
    
SELECT mem_id, SUM(price*amount) '총구매액'
	FROM buy
    GROUP BY mem_id
    ORDER BY SUM(price*amount) DESC;
    
SELECT B.mem_id, M.mem_name, SUM(price*amount) '총구매액'
	FROM buy B
		INNER JOIN member M
        ON B.mem_id = M.mem_id
	GROUP BY B.mem_id
    ORDER BY SUM(price*amount) DESC;