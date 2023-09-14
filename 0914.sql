-- 정렬을 위한 ORDER BY절

SELECT * FROM EMP
ORDER BY SAL ASC; --ASC는 오름차순

-- 사원번호 기준으로 오름차순 정렬
SELECT * FROM EMP
ORDER BY SAL ASC; 

-- 여러 , 기준으로 정렬하기
-- 정렬 조건이 없으면 기본적으로 오름차순
-- 급여순으로 정렬, 급여 같은 경우 이름순 정렬
SELECT * FROM EMP
ORDER BY SAL, ENAME DESC; --정렬조건은 맨 뒤에, 오름차순 정렬이후 이름 기준 내림차순


-- 연결 연산자 : SELECT문 조회 시 세미콜른 사이에 특정한 문자를 넣고 싶을 때 사용하는 연산자
SELECT NAME || 'S JOB IS ' || JOB AS EMPLOYEE --AS로 별칭 만들기
FROM EMP;

-- 실습문제 1
-- 1. 사원 이름 S로 끝나는 사원
SELECT * FROM EMP
WHERE ENAME LIKE '%S'; --

-- 2. 30번 부서에서 근무, 직책 SALESMAN 인 사원번호, 이름, 직책, 급여, 부서번호 출력
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 30 AND JOB = 'SALESMAN';

-- 3. 20,30번 부서에 근무하는 사원 중 급여 2000 초과인 사원의
--    사원번호 이름, 급여, 부서번호 출력

SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO IN (20, 30) AND SAL > 2000;

-- 4. BETWEEN 연산자 사용하지 않고 급여가 2000이상 3000이하 데이터 출력
SELECT * FROM EMP
WHERE SAL >= 2000 AND SAL <= 3000;

-- 5. 사원 이름에 이름에 E가 포함, 30번 부서, 급여 1000~2000사이가 아닌 
--    사원이름, 사원번호, 급여, 부서번호 출력
SELECT ENAME, EMPNO, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 30 
AND ENAME LIKE '%E%' 
AND SAL NOT BETWEEN 1000 AND 2000;

-- 6. 추가수당이 존재하지 않고 상급자가 있고 직책이 MANAGER, CLERK인 사원중에서 
--    사원이름의 두번째 글자가 L아닌 사원의 정보출력
SELECT * FROM EMP
WHERE COMM IS NULL -- 추가수당 존재X
AND MGR IS NOT NULL -- 상급자가 존재
AND JOB IN ('MANAGER', 'CLERK')
AND ENAME NOT LIKE '_L%'


-- 1. EMP테이블에서 COMM의 값이 NULL이 아닌 정보 조회
SELECT * 
FROM EMP
WHERE COMM IS NOT NULL;
-- 2. EMP테이블에서 커미션을 받지 못하는 직원 조회
SELECT * 
FROM EMP
WHERE COMM IS NULL OR COMM = 0;
-- 3. EMP테이블에서 관리자(상급자)가 없는 직원 정보 조회
SELECT * 
FROM EMP
WHERE MGR IS NULL;
-- 4. EMP테이블에서 급여를 많이 받는 직원 순으로 조회(내림차순)
SELECT * 
FROM EMP
ORDER BY SAL DESC;
-- 5. EMP테이블에서 급여가 같을 경우 커미션을 내림차순 정렬 조회
SELECT * 
FROM EMP
ORDER BY SAL DESC, COMM DESC;
-- 6. EMP테이블에서 사원번호, 사원명, 직책, 입사일 조회(입사일 오름차순 정렬)
SELECT EMPNO, ENAME, JOB, HIREDATE
FROM EMP
ORDER BY HIREDATE;
-- 7. EMP테이블에서 사원번호, 사원명 조회(사원번호 기준 내림차순)
SELECT EMPNO, ENAME
FROM EMP
ORDER BY EMPNO DESC;
-- 8. EMP테이블에서 사번, 입사일, 사원명, 급여, 부서번호 조회
--    (부서번호가 빠른순으로, 같은 경우 최근 입사일 순으로)
SELECT EMPNO, HIREDATE, ENAME, SAL, DEPTNO
FROM EMP
ORDER BY DEPTNO, HIREDATE DESC; --내림차순