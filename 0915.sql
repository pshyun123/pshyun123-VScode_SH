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
SELECT SYSDATE FROM DUAL;
--EMP 테이블에서 사번, 사원명, 급여조회(X)(단, 급여는 100단위까지 값만 출력, 급여기준 내림차순 정렬)
SELECT EMPNO, ENAME, ROUND(SAL,-2) --100자리에서 반올림처리
FROM EMP
ORDER BY SAL DESC;
--EMP 테이블에서 사원번호가 홀수인 사원들 조회(X)- MOD 함수 사용
--SELECT EMPNO
--FROM EMP
--WHERE NOT EMPNO/2=0
SELECT*
FROM EMP
WHERE MOD(EMPNO, 2) = 1;

--EMP 테이블에서 사원명, 입사일 조회(입사일은 연도,월 분리 추출해서 출력)(X)
--SELECT ENAME, HIREDATE
--FROM EMP
--WHERE EXTRACT(YEAR FROM HIREDATE, MONTH FROM HIREDATE)
SELECT ENAME, EXTRACT(YEAR FROM HIREDATE), EXTRACT(MONTH FROM HIREDATE)
FROM EMP

--EMP 테이블에서 9월에 입사한 직원의 정보조회(OK)
SELECT *
FROM EMP
WHERE EXTRACT(MONTH FROM HIREDATE) = 9;

--EMP 테이블에서 81년도에 입사한 직원 조회(OK)
SELECT *
FROM EMP
WHERE EXTRACT(YEAR FROM HIREDATE) = 1981

--EMP 테이블에서 이름이 E로 끝나는 직원조회(OK)
SELECT *
FROM EMP
WHERE ENAME LIKE '%E';

--EMP 테이블에서 이름의 세번째글자가 'R'인 직원 정보 조회(OK)
SELECT *
FROM EMP
WHERE ENAME LIKE '__R%';

-- EMP 테이블에서 사번, 사원명 입사일, 입사일 +40년 되는 날짜 조회(X)
-- SELECT 
-- ADD_MONTHS(HIREDATE,480)
-- FROM DUAL;
SELECT EMPNO, ENAME, HIREDATE, ADD_MONTHS(HIREDATE,480)
FROM EMP;

--EMP 테이블에서 입사일로부터 38년 이상 근무한 직원 정보 조회(X)
-- SELECT *
-- FROM EMP
-- WHERE HIREDATE 

SELECT *
FROM EMP
WHERE MONTHS_BETWEEN(SYSDATE, HIREDATE) / 12 >= 38 --달 수를 12로 나누고 년도구함

--EMP 테이블에서 년도만 추출(X)
-- SELECT EXTRACT(YEAR FROM DATE)
-- FROM EMP;
SELECT EXTRACT(YEAR FROM SYSDATE)
FROM EMP;

--자료형을 변환하는 형 변환 함수
--자동형변환 : NUMBER + 문자타입 +=> NUMBER타입으로 자동변환
SELECT EMPNO, ENAME, EMPNO + '500'
FROM EMP
WHERE ENAME = 'FORD';

SELECT EMPNO, ENAME, EMPNO + 'ABCD'
FROM EMP
WHERE ENAME = 'ABCD'; --오류


-- 날짜, 숫가를 문자로 변환하는 TO_CHAR 함수
-- 주로 날짜 데이터를 문자 데이터로 변환하는데 사용
-- 자바의 SimpleDateFormat이랑 비슷
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI') AS 현재날짜시간
    FROM DUAL;


SELECT SYSDATE,
    TO_CHAR(SYSDATE, 'CC') AS 세기,
    TO_CHAR(SYSDATE, 'YY') AS 연도,
    TO_CHAR(SYSDATE, 'YYYY/MM/DD PM HH:MI:SS ') AS "년/월/일 시:분:초",
    TO_CHAR(SYSDATE, 'Q') AS 쿼터,
    TO_CHAR(SYSDATE, 'DD') AS 일,
    TO_CHAR(SYSDATE, 'DDD') AS 경과일,
    TO_CHAR(SYSDATE, 'HH') AS "12시간제",
    TO_CHAR(SYSDATE, 'HH12') AS "12시간제",
    TO_CHAR(SYSDATE, 'HH24') AS "24시간제",
    TO_CHAR(SYSDATE, 'W') AS 몇주차
FROM DUAL;

SELECT SYSDATE,
     TO_CHAR(SYSDATE, 'MM') AS MM,
     TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = KOREAN' ) AS MON_KOR,
     TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = JAPANESE') AS MON_JPN,
     TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = ENGLISH' ) AS MON_ENG,
     TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = KOREAN' ) AS MONTH_KOR,
     TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = JAPANESE') AS MONTH_JPN,
     TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = ENGLISH' ) AS MONTH_ENG
FROM DUAL;

SELECT SYSDATE,
     TO_CHAR(SYSDATE, 'MM') AS MM,
     TO_CHAR(SYSDATE, 'DD') AS DD,
     TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE = KOREAN' ) AS DY_KOR,
     TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE = JAPANESE') AS DY_JPN,
     TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE = ENGLISH' ) AS DY_ENG,
     TO_CHAR(SYSDATE, 'DAY', 'NLS_DATE_LANGUAGE = KOREAN' ) AS DAY_KOR,
     TO_CHAR(SYSDATE, 'DAY', 'NLS_DATE_LANGUAGE = JAPANESE') AS DAY_JPN,
     TO_CHAR(SYSDATE, 'DAY', 'NLS_DATE_LANGUAGE = ENGLISH' ) AS DAY_ENG
FROM DUAL;

SELECT SYSDATE,
     TO_CHAR(SYSDATE, 'HH24:MI:SS') AS HH24MISS,
     TO_CHAR(SYSDATE, 'HH12:MI:SS AM') AS HHMISS_AM,
     TO_CHAR(SYSDATE, 'HH:MI:SS P.M.') AS HHMISS_PM
FROM DUAL;


SELECT SAL, --RAW 데이터가 바뀌는게 아님, 보여주는 데이터
    TO_CHAR(SAL, '$999,999')AS SAL_$,
    TO_CHAR(SAL, 'L999,999')AS SAL_L,
    TO_CHAR(SAL, '999,999.00')AS SAL_1,--소수점 두자리쪽
    TO_CHAR(SAL, '000,999,999.00')AS SAL_2,
    TO_CHAR(SAL, '000999999.99') AS SAL_3,
    TO_CHAR(SAL, '999,999,00') AS SAL_4
FROM EMP;

-- To_NUMBER() : NUMBER 타입으로 형 변환
SELECT TO_NUMBER('1300') - '1500'
FROM DUAL;

-- TO_DATE : 문자열로 명시된 날짜로 변환하는 함수
SELECT TO_DATE('2022/08/20', 'YY/MM/DD')
FROM DUAL;


-- 1981년 6월 1일에 입사한 사원정보 출력
SELECT *
FROM EMP
WHERE HIREDATE > TO_DATE('1981/06/01','YYYY/MM/DD')

SELECT *
FROM EMP
WHERE HIREDATE > '01-JUN-1981'

SELECT *
FROM EMP
WHERE HIREDATE > '01-JUN-81'

--NULL 처리 함수 : NULL은 값이 없음. 즉, 할당되지 않음을 의미
--NULL은 0이나 공백과는 다른 의미, 연산불가
--NVL(NULL인지 검사할 열, 앞열 데이터가 NULL인 경우 반환할 데이터)
--성과금 없는 경우에도 급여에 반영될수 있도록
SELECT EMPNO,ENAME, SAL, COMM, SAL+COMM,
    NVL(COMM,0), SAL+NVL(COMM, 0)
FROM EMP;

SELECT EMPNO,ENAME, SAL, COMM, SAL+COMM,
    NVL(COMM,0), SAL+NVL(COMM, 100)--성과금이 없는 사람에게는 일괄적으로 100추가
FROM EMP;


--NVL2() : NULL이든 아니든 모두에 대해서 값을 지정해줌
SELECT EMPNO, ENAME, COMM, SAL,
    NVL2(COMM, '0', 'X')AS 성과금유무, --성과금 있는 경우 O,아닌경우X
    NVL2(COMM, SAL*12+COMM, SAL*12)AS 연봉 --NULL이 아닌경우(COMM, SAL*12+COMM)
FROM EMP;

--NULLIF() : 두 값이 동일하면 NULL 반환, 아니면 첫번째 값 반환
SELECT NULLIF(10,10), NULLIF('A','B')
FROM DUAL;

--DECODE: 주어진 데이터 값이 조건 값과 일치하는 값을 출력, 일치하는 값X 기본값 출력
SELECT EMPNO,ENAME,JOB,SAL,
    DECODE(JOB,
    'MANAGER',SAL*1.1, --직업이 메니져면 급여 10프로 인상
    'SALESMAN', SAL * 1.05, -- 5프로 인상
    'ANALYST', SAL,
    SAL*1.03)AS 연봉인상
FROM EMP;

--CASE문 
SELECT EMPNO, ENAME, JOB, SAL,
    CASE JOB
        WHEN 'MANAGER' THEN SAL*1.1
        WHEN 'SALESMAN' THEN SAL*1.05
        WHEN 'ANALYST' THEN SAL
        ELSE SAL * 1.03
    END AS UPSAL--연봉인상
FROM EMP;

-- 열 값에 따라서 출력 값이 달라지는 CASE 문
SELECT EMPNO, ENAME,
    CASE
        WHEN COMM IS NULL THEN '해당사항 없음'
        WHEN COMM = 0 THEN '수당 없음'
        WHEN COMM > 0 THEN '수당: ' || COMM
    END AS "성과급기준"
FROM EMP; 


--1번.
SELECT EMPNO,
    RPAD(SUBSTR(EMPNO,1,2),4,'*')AS MASKING_EMPNO, --사원번호 앞 두자리만 자름/문자열,시작점, 개수)총 4자리, 나머지 2자리를 *로
    ENAME,
    RPAD(SUBSTR(ENAME, 1, 1), LENGTH(ENAME),'*')AS MASKING_ENAME --이름길이는 불규칙적이라 LENGTH, 나머지는 *
FROM EMP
WHERE LENGTH(ENAME)=5;

--2번. 하루 8시간 일했을때일급,시급
SELECT EMPNO, ENAME, SAL,
    TRUNC(SAL/21.5) AS 일급,
    ROUND(SAL/21.5/8,1) AS 시급
FROM EMP;

--3번. 정직원 되는날짜 
-- NEXT_DAY(기준일자, 찾을 요일) : 기준일자 다음에 오는 날짜 구하는 함수
SELECT EMPNO, ENAME, HIREDATE,
    TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE,3), 'MON'), 'YYYY/MM/DD') AS 정직원진급,
    NVL(TO_CHAR(COMM), 'N/A') AS COMM -- 같은 열에대한 값이 문자, 숫자로 모두 나올 수 있기 때문에 하나로 통일
FROM EMP;

-- 4번. 
SELECT EMPNO, ENAME, MGR, 
    CASE
        WHEN MGR IS NULL THEN '0000'
        WHEN SUBSTR(MGR, 1, 2) = '78' THEN '8888' 
        WHEN SUBSTR(MGR, 1, 2) = '77' THEN '7777' 
        WHEN SUBSTR(MGR, 1, 2) = '76' THEN '6666'  
        WHEN SUBSTR(MGR, 1, 2) = '75' THEN '5555'  
        ELSE TO_CHAR(MGR)
    END AS CHG_MGR
FROM EMP;

SELECT EMPNO, ENAME, MGR, 
    CASE
        WHEN MGR IS NULL THEN 0000
        WHEN SUBSTR(MGR, 1, 2) = '78' THEN 8888 
        WHEN SUBSTR(MGR, 1, 2) = '77' THEN 7777
        WHEN SUBSTR(MGR, 1, 2) = '76' THEN 6666 
        WHEN SUBSTR(MGR, 1, 2) = '75' THEN 5555  
        ELSE MGR
    END AS CHG_MGR
FROM EMP;


-- 다중행 함수 : 여러 행에 대해 함수가 적용되어 하나의 결과를 나타내는 함수 (집계 함수)
-- 여러 행이 입력되어 결과가 하나의 행으로 출력.
SELECT SUM(SAL)
    FROM EMP; --문제 없음

SELECT SUM(SAL), EMPNO
    FROM EMP; --사원번호는 단일행, 급여는 다중행이라 오류


-- GROUP BY : 그룹으로 묶을 때  

SELECT SUM(SAL), ENAME
    FROM EMP
GROUP BY ENAME; --SUM을 하든 안하든 똑같음...

-- SELECT ENAME, SUM(SAL)
-- FROM EMP; -- 이름은 단일, 급여는 총합임.


SELECT DEPTNO, SUM(SAL) --부서별 총 급여니까 오류 안뜸
FROM EMP
GROUP BY DEPTNO;

--부서별로 집계함수에 대해서 몇명인지 카운트 해줘
SELECT DEPTNO, SUM(SAL), COUNT(*), ROUND(AVG(SAL),2), MAX(SAL), MIN(SAL)
FROM EMP
GROUP BY DEPTNO;

