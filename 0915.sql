-- 문자 함수 : 문자 데이터를 가공하는 것
SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)--첫글자만 대문자로 바꾸는 것
FROM EMP;

-- 대문자로 비교
SELECT * 
FROM EMP
WHERE UPPER(ENAME) = UPPER('JAMES');

-- LENGTH 함수 : 문자열 길이를 반환
-- LENGTHB 함수 : 문자열 바이트 수를 반환

SELECT LENGTH('한글'), LENGTHB('한글')
FROM DUAL;--테이블 없이 가상더미 테이블에서 실행

-- SUBSTR / SUBSTRB 
-- 데이터베이스 시작 위치가 0이 아님(1임). 
-- 2번째 매개변수는 길이, 3번째 매개변수 생략하면 끝까지
SELECT JOB, SUBSTR(JOB,1,2), SUBSTR(JOB, 3,2), SUBSTR(JOB, 5)
FROM EMP;


SELECT JOB,
    SUBSTR(JOB, -LENGTH(JOB)),--음수는 뒤에서부터 계산, 길이에 대한 음수값으로 역순 접근
    SUBSTR(JOB, -LENGTH(JOB), 2),--SALESMAN, -8이면 S위치에서 길이가 2만큼 출력
    SUBSTR(JOB, -3)
FROM EMP;

-- INSTR : 문자열 데이터 안에 특정 문자나 문자열이 어디에 포함되어 있는지 알고자 할때 사용
SELECT INSTR('HELLO,ORACLE!','L' ) as INSTR_1,
    INSTR('HELLO,ORACLE!','L',5) as INSTR_2, --3번째 인자로 찾을 시작위치 지정
    INSTR('HELLO,ORACLE!','L',2,2) as INSTR_2 --3번째 인자는 시작위치, 4번째는 몇번째인지 지정
FROM DUAL;

-- 특정문자가 포함된 행 찾기
SELECT *FROM EMP
WHERE INSTR(ENAME, 'S') > 0;

SELECT *
FROM EMP
WHERE ENAME LIKE'%S%';

-- REPLACE : 특정 문자열 데이터에 포함된 문자를 다른 문자로 대체
-- 대체할 문자를 입력하지 않으면 삭제

SELECT '010-1234-5678' AS REPLACE_BEFORE,
    REPLACE ('010-1234-5678', '-', ' ') AS REPLACE_1, -- 공백으로 대체
    REPLACE ('010-1234-5678', '-') AS REPLACE_2 -- 해당문자 삭제
FROM DUAL;

--LPAD/RPAD : 기준 공간 칸수를 지정하고 빈칸 만큼 특정 문자로 채우는 함수
SELECT LPAD('ORACLE', 10, '+')
FROM DUAL;
SELECT RPAD('ORACLE', 10, '+')
FROM DUAL;

SELECT 'ORACLE',
    LPAD('ORACLE', 10, '#') AS LPAD_1,
    RPAD('ORACLE', 10, '*') AS RPAD_1,
    LPAD('ORACLE', 10) AS LPAD_2,
    RPAD('ORACLE', 10) AS RPAD_2
FROM DUAL;

-- 개인정보 뒷자리 * 표시로 출력
SELECT
    RPAD('971226-', 14, '*') AS RPAD_JMNO,
    RPAD('010-1234-', 13, '*') AS RPAD_PHONE
FROM DUAL;

-- 두 문자열을 합치는 CONCAT 함수
SELECT CONCAT(EMPNO, ENAME), -- + 연산자랑 비슷
    CONCAT(EMPNO, CONCAT(' : ', ENAME)) --이중 CONCAT (자바에선 + 만하면 되는데 그게 안됨)
FROM EMP
WHERE ENAME = 'JAMES';

-- TRIM/LTRIM/RTRIM :문자열 데이터 내에서 특정 문자를 지우기 위해 사용
-- 삭제할 문자 지정하지 않으면 공백제거(공백제거용으로 좋다)
SELECT '[' || TRIM(' _Oracle_ ') || ']' AS TRIM,        --공백은 양쪽 다 지움
 '[' || LTRIM('     _Oracle_     ') || ']' AS LTRIM,    --왼쪽 공백 지움
 '[' || LTRIM('<_Oracle_>', '<_') || ']' AS LTRIM_2,    --특정문자 지움(REPLACE쓰자)
 '[' || RTRIM('     _Oracle_     ') || ']' AS RTRIM,    --오른쪽 공백 지움
 '[' || RTRIM('<_Oracle_>', '_>') || ']' AS RTRIM_2     --특정문자 지움(REPLACE쓰자)
 FROM DUAL;


 SELECT RTRIM('DKJFLKDJFD       ', 'D')
 FROM DUAL;

 -- 날짜 데이터를 다루는 날짜함수
 -- SYSDATE : 운영체제의 현재 날짜와 시간 정보 가져옴

 SELECT SYSDATE FROM DUAL;

--날짜 데이터는 정수값, +-가능
SELECT SYSDATE AS NOW,
    SYSDATE-1 AS YESTERDAY,
    SYSDATE+1 AS TOMORROW
FROM DUAL;

--몇개월 이후 날짜 구하는 ADD_MONTHS 함수
--특정 날짜에 지정한 개월 수 이후 날짜 데이터를 반환하는 함수
SELECT SYSDATE,
    ADD_MONTHS(SYSDATE, 3) -- 두번째 인자는 개월 수 의미
FROM DUAL;


--입사 10주년이 되는 사원들 데이터 출력(날짜)
SELECT EMPNO, ENAME, HIREDATE,
    ADD_MONTHS(HIREDATE, 120) AS WORK10YEAR
FROM EMP;

--# 복습문제
-- SYSDATE와 ADD_MONTHS 함수를 사용하여 현재 날짜와 6개월 후 날짜 출력
SELECT SYSDATE AS NOW,
ADD_MONTHS(SYSDATE,6)
FROM DUAL;

-- 두 날짜 간의 개월 수 차이를 구하는 MONTHS_BETWEEN 함수
SELECT EMPNO, ENAME, HIREDATE, SYSDATE,
    MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTHS1,--과거에서 현재 빼기
    MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTHS2,--현재에서 입사일 배기
    TRUNC(MONTHS_BETWEEN(SYSDATE,HIREDATE)) AS MONTHS3,
    ROUND(MONTHS_BETWEEN(SYSDATE,HIREDATE)) AS MONTHS4
FROM EMP;

-- 날짜 정보 추출 함수
-- EXTRACT 함수는 날짜 유형의 데이터로부터 날짜 정보를 분리하여 새로운 컬럼의 형태로 추출

SELECT EXTRACT(YEAR FROM DATE '2023-09-15')
FROM DUAL;


SELECT *
FROM EMP   
WHERE EXTRACT(MONTH FROM HIREDATE) = 12;


--오늘 날짜에 대한 정보조회(OK)
SELECT SYSDATE FORM EMP;
--EMP 테이블에서 사번, 사원명, 급여조회(OK)(단, 급여는 100단위까지 값만 출력, 급여기준 내림차순 정렬)
SELECT EMPNO, ENAME, SAL
FROM EMP
ORDER BY SAL DESC;

--EMP 테이블에서 사원번호가 홀수인 사원들 조회
SELECT EMPNO
FROM EMP
WHERE NOT EMPNO/2=0

--EMP 테이블에서 사원명, 입사일 조회(입사일은 연도,월 분리 추출해서 출력)
SELECT *
FROM EMP
WHERE EXTRACT(YEAR FROM HIREDATE, MONTH FROM HIREDATE)

--EMP 테이블에서 9월에 입사한 직원의 정보조회(OK)
SELECT *
FROM EMP
WHERE EXTRACT(MONTH FROM HIREDATE) = 9

--EMP 테이블에서 81년도에 입사한 직원 조회(OK)
SELECT *
FROM EMP
WHERE EXTRACT(YEAR FROM HIREDATE) = 1981

--EMP 테이블에서 이름이 E로 끝나는 직원조회(OK)
SELECT *
FROM EMP
WHERE UPPER(ENAME) LIKE UPPER('%E')

--EMP 테이블에서 이름의 세번째글자가 'R'인 직원 정보 조회(OK)
SELECT *
FROM EMP
WHERE UPPER(ENAME) LIKE UPPER('__R%')
--EMP 테이블에서 사번, 사원명 입사일, 입사일 +40년 되는 날짜 조회(세모)
SELECT ADD_MONTHS(HIREDATE,480)
FROM EMP

FROM DUAL;
--EMP 테이블에서 입사일로부터 38년 이상 근무한 직원 정보 조회


--EMP 테이블에서 년도만 추출


