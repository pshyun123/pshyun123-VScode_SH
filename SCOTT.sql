DESC EMP;
DESC DEPT;
DESC BONUS;
DESC SALGRADE;
---------------------------------------------------------------------------------
--기본 SELECT * FROM EMP;
SELECT * FROM EMP;
--EMP 테이블에서 사원번호, 사원이름, 사원이 속한 부서 번호만 조회
SELECT EMPNO,ENAME,DEPTNO
FROM EMP;

-- SQL문 작성 유의사항
-- 1. 대소문자 구분 하지 않음
-- 2. 한줄 또는 여러줄에 입력될 수 있음
-- 3. 일반적으로 키워드는 대문자로 입력
-- 4. 일반적으로 이름, 열이름등은 소문자로 입력
-- 5. 마지막 절은 ; 으로 끝남

-- Q. 사원번호와 부서번호만 나오도록 EMP 테이블 조회하기
SELECT EMPNO, DEPTNO FROM EMP; 
-- 별칭 설정하기 : AS, 열 이름 또는 칼럼을 별칭으로 표시 가능
SELECT ENAME AS 이름, SAL AS 급여, SAL*12+COMM AS 연봉, COMM AS 성과급
FROM EMP;

-- 중복제거하기 : DISTINCT, 데이터를 조회할 때 값이 중복되는 행이 여러 개 조회되는 경우가 있는데, 값이 중복된 행을 한개씩만 선택하고자 할 때 사용
SELECT DISTINCT JOB, DEPTNO FROM EMP;

-- 컬럼값 계산하는 산술연산자 : 
SELECT ENAME, SAL, SAL*12
FROM EMP;

--# WHERE 구문 : 데이터 조회시 사용자가 원하는 조건에 맞는 데이터만을 조회하고 싶을 때 사용(행을 제한)
-- 여러 연산자와 함께 사용함
SELECT * FROM EMP
WHERE DEPTNO = 10;--데이터 베이스에서는  = 같다라는 의미로 사용

SELECT * FROM EMP
WHERE EMPNO = 7369;


--Q. 급여가 2500 초과인 사원번호, 이름, 직무(JOB), 급여 출력해보기
SELECT EMPNO, ENAME, JOB, SAL FROM EMP
WHERE SAL > 2500;

SELECT *
FROM EMP
WHERE SAL * 12 = 36000;

-- 성과급이 500 초과인 사원 출력
SELECT * FROM EMP
WHERE COMM>500;

-- 입사일 81.01.01 이전인 데이터 조회
SELECT * FROM EMP
WHERE HIREDATE < '81/01/01';


-- 같지 않음을 표현하는 여러가지 방법 <>, !=, ^=, NOT
SELECT * FROM EMP
WHERE deptno <> 30;


-- 급여가 3000 이상이고, 부서가 20번인 사원 조회(두가지 조건 모두 만족)
SELECT *
FROM EMP
WHERE SAL >= 3000 AND DEPTNO = 20


-- 급여가 3000 이상이고, 부서가 20번, 입사일 82.01.01 이전인 사원 조회
SELECT * 
FROM emp
WHERE sal >= 3000 AND deptno = 20 AND hiredate <'82/0101';

-- 급여가 3000 이상이고, 부서가 20번이거나 입사일 82.01.01 이전인 사원 조회
SELECT 
* FROM emp
WHERE sal >= 3000 AND (deptno = 20 OR hiredate <'82/0101');

--급여가 2500 이상이고 직업이 MANAGER인 사원 정보만 출력
SELECT 
* FROM EMP
WHERE SAL >= 2500 AND JOB = 'MANAGER';



SELECT *
FROM EMP
WHERE JOB = 'MANAGER'
    OR JOB = 'SALESMAN'
    OR JOB = 'CLERK';
    
--IN 연산자(포함여부확인)    
SELECT *
FROM EMP
WHERE JOB IN('MANAGER', 'SALESMAN', 'CLERK');

--DEPTNO가  20, 30 아닌 사원들의 정보를 조회
SELECT *
    FROM EMP
WHERE DEPTNO NOT IN(20, 30);

--BETWEEN A AND B 연산자
SELECT *
FROM EMP
WHERE SAL >= 2000 AND SAL <= 3000;

SELECT *
FROM EMP
WHERE SAL BETWEEN 2000 AND 3000;

--사원번호 7698에서 7902 까지의 사원 조회
SELECT *
FROM EMP
WHERE empno BETWEEN 7689 AND 9702;

--1980년이 아닌 해에 입사한 사원을 조회
SELECT *
FROM EMP
WHERE NOT HIREDATE BETWEEN '1980/01/01' AND '1980/12/31';

--LIKE, NOT LIKE 연산자: 일부 문자열의 포함 여부를 확인하는 연산자, 데이터를 **조회(검색)할 때 사용**
-- % : 길이와 상관없이 모든 문자 데이터를 의미
-- _ : 문자 1개를 의미

SELECT EMPNO, ENAME
FROM EMP
WHERE ENAME LIKE '%K%'--앞의 문자열이 0~무한대까지 몇개오는지 상관없음.



SELECT *
FROM EMP 
WHERE ENAME LIKE '_L%' --아무 문자가 오든 상관 없지만 한개의 문자만 올 수 있음

-- 사원 이름에 AM이 포함되어 있는 사원 데이터만 출력하기 
SELECT *
FROM EMP
WHERE ENAME LIKE '%AM%';

    
-- 사원 이름에 AM이 포함되어 있지 않은 사원 데이터 출력하기
SELECT *
FROM EMP
WHERE ENAME NOT LIKE '%AM%';

-- NULL :  미확정 또는 알 수 없는 값을 의미 (0이 아니고 빈 공간을 의미하지 않음. 연산, 할당, 비교가 불가능하며 ‘=’, ‘IN’ 연산자를 이용하면 조회 불가능) 
SELECT ENAME, SAL * 12 + COMM AS 연봉, COMM
FROM EMP;

SELECT *
FROM emp
WHERE comm = null; -- 연산불가

SELECT * 
FROM emp
WHERE comm IS NULL; -- NULL 여부를 확인할때 사용하는 연산자

SELECT *
FROM EMP
WHERE MGR IS NOT NULL;