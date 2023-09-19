--GROUP BY : 여러 데이터에서 의미있는 하나의 결과를 특정 열 값별로 묶어서 출력할때 사용
SELECT ROUND(AVG(SAL), 2) AS 사원전체 평균
FROM EMP;----------------------ERROR----------------------

-- 부서별 사원 평균
SELECT DEPTNO, ROUND(AVG(SAL),2) AS DE
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

--GROUP BY 절 없이 구현한다면?
SELECT AVG(SAL)FROM EMP WHERE DEPTNO = 10;
SELECT AVG(SAL)FROM EMP WHERE DEPTNO = 20;
SELECT AVG(SAL)FROM EMP WHERE DEPTNO = 30;

--집합연산자를 사용하여 구현하기
SELECT AVG(SAL)FROM EMP WHERE DEPTNO = 10
UNION ALL
SELECT AVG(SAL)FROM EMP WHERE DEPTNO = 20
UNION ALL
SELECT AVG(SAL)FROM EMP WHERE DEPTNO = 30;
--부서코드 급여합계 부서평균 부서코드 순 정렬
SELECT DEPTNO 부서코드,
    SUM(SAL) 합계,
    ROUND(AVG(SAL), 2) 평균,
    COUNT(*) -- 각 그룹에 해당하는 인원이 몇명인지 확인
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

-- HAVING 절 : GROUP BY 절이 존재하는 경우에만 사용가능
-- GROUP BY 절을 통해 그룹화된 결과 값의 범의를 제한할 때 사용(실행순서때문에)
-- 먼저 부서별, 직책별로 그룹화하여 평균을 구함
-- 그 다음 각 그룹별 급여 평균이 2000이 넘는 그룹을 출력
SELECT DEPTNO, JOB, ROUND(AVG(SAL),2)
FROM EMP
GROUP BY DEPTNO, JOB --범위가 좁아지는게 아니라 넓어짐 두개의 교집합이 아님
HAVING AVG(SAL) >= 2000--급여가 2000이상인 사람만 출력// 집계함수가 아님
ORDER BY DEPTNO, JOB;
-- 그루핑한 결과가 더 많이 출력됨. 


-- WHERE 절 사용하는 경우
-- 먼저 급여가 2000인 사원들을 골라내고 평균을 구함
-- 조건에 맞는 사원 중에서 부서별, 직책별 급여의 평균을 구해서 출력
SELECT DEPTNO, JOB, ROUND(AVG(SAL),2)
FROM EMP
WHERE SAL >= 2000--급여가 2000이상인 사람만 출력// 오류 뜬다
GROUP BY DEPTNO, JOB --범위가 좁아지는게 아니라 넓어짐 두개의 교집합이 아님
ORDER BY DEPTNO, JOB;
-- 두개의 결과는 같음.

-- 1. 부서별 직책의 평균 급여가 500 이상인 사원들의 부서번호, 직책, 부서별 직책의 평균급여 출력
SELECT DEPTNO, JOB, ROUND(AVG(SAL),2)
FROM EMP
GROUP BY DEPTNO, JOB
HAVING AVG(SAL) >= 500
ORDER BY DEPTNO, JOB;

-- 2. EMP 테이블을 이용하여 부서번호, 평균급여, 최고급여, 최저급여, 사원수를 출력,  단, 평균 급여를 출력 할 때는 
--    소수점 제외하고 부서 번호별로 출력
SELECT DEPTNO "부서 번호", 
    TRUNC(AVG(SAL)) "평균 급여",
    MAX(SAL) "최고 급여",
    COUNT(*) "사원 수"
FROM EMP
GROUP BY DEPTNO;


-- 3. 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원을 출력
SELECT JOB 직책, COUNT(*) "사원 수"
FROM EMP
GROUP BY JOB
HAVING COUNT(*) >= 3;

-- 4. 사원들의 입사 연도를 기준으로 부서별로 몇 명이 입사했는지 출력
-- SELECT EXTRACT(YEAR FROM HIREDATE) "입사일"
SELECT TO_CHAR(HIREDATE, 'YYYY') 입사일,
    DEPTNO,
    COUNT(*) 사원수
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO
ORDER BY TO_CHAR(HIREDATE, 'YYYY');

-- 5. 추가 수당을 받는 사원 수와 받지 않는 사원수를 출력 (O, X로 표기 필요)
SELECT NVL2(COMM, 'O', 'X') "추가 수당",
    COUNT(*) 사원수
FROM EMP
GROUP BY NVL2(COMM,'O', 'X');

-- 6. 각 부서의 입사 연도별 사원 수, 최고 급여, 급여 합, 평균 급여를 출력
SELECT DEPTNO, 
    TO_CHAR(HIREDATE, 'YYYY') 입사년도,
    COUNT(*) 사원수,
    MAX(SAL) 최고급여,
    SUM(SAL) 합계,
    TRUNC(AVG(SAL)) 평균급여
FROM EMP
GROUP BY DEPTNO, TO_CHAR(HIREDATE, 'YYYY')
ORDER BY DEPTNO, TO_CHAR(HIREDATE, 'YYYY')

-- # 그룹화와 관련된 여러함수 : ROLLUP, CUBE..
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)--------ERROR---------
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB);

-- ROLLUP: 명시한 열을 소그룹부터 대그룹의 순서로 각 그룹별 결과를 출력하고
-- 마지막에 총 데이터 결과를 출력 / 각 부서별 중간결과를 보여줌
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB);

-- Join : 두 개 이상의 테이블에서 데이터를 가져와서 연결하는 데 사용되는 SQL의 기능
-- RDMS에서는 테이블 설계시 무결성 원칙으로 인해 동일한 정보가 여러군데 존재하면 안됨.
-- 필연적으로 테이블을 관리목적에 맞게 설계함.
SELECT * FROM DEPT; --DEPTNO는 DEPT를 참조한 키임


-- 열 이름을 비교하는 조건식으로 조인하기
SELECT *
FROM EMP, DEPT 
WHERE EMP.DEPTNO = DEPT.DEPTNO--기준열 지정
ORDER BY EMPNO;
--DEPT기준으로 소트. 연결키는 부서번호 프라이머리 키는 아님. 
--사원입장에서는 사원번호가 더 중요


-- 테이블 별칭 사용하기
SELECT *
FROM EMP E, DEPT D --EMP는 E DEPT는 D로, FROM절이 먼저 와서 가능. 웨어절에서 바뀐이름 사용가능
WHERE E.DEPTNO = D.DEPTNO
ORDER BY EMPNO;

-- 조인 종류 : 두 개 이상의 테이블을 하나의 테이블처럼 가로로 늘어뜨려 출력하기 위해 사용.
-- 대상 데이터를 어떻게 연결하느냐에 따라 → 등가 조인, 비등가 조인, 자체 조인, 외부 조인 등으로 구분
-- 등가조인 : 테이블을 연결한 후에 출력 행을 각 테이블의 특정 열에 일치한 데이터를 기준으로 선정하는 방식.
-- 오라클조인
SELECT EMPNO, ENAME, D.DEPTNO, DNAME, LOC
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO -- 등가조인이자 오라클 조인. 
    AND SAL >=3000 --차이점 웨어절이 복잡할때 무엇을 위한 웨어인지 식별 어렵다
    ORDER BY D.DEPTNO;
-- 안시조인
SELECT EMPNO, ENAME, D.DEPTNO, DNAME, LOC
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE SAL >= 3000
    ORDER BY D.DEPTNO; -- 조금 더 직관적임

--Q1.EMP 테이블 별칭을 E로, DEPT 테이블 별칭은 D로 하여 
--등가 조인을 했을 때 급여가 2500 이하,사원 번호가 9999 이하인 사원의 정보 출력
--1) 오라클 조인
SELECT EMPNO, ENAME, SAL, D.DEPTNO, DNAME, LOC
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO -- 동등조인, 이너조인, 두테이블이 일치하는 데이터만 선택
    AND SAL <= 2500 
    AND EMPNO <= 9999 
    ORDER BY EMPNO;

--2) 안시 조인----------------------------------------------------------
SELECT EMPNO, ENAME, SAL, D.DEPTNO, DNAME, LOC
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE SAL <= 2500 AND EMPNO <= 9999
    ORDER BY EMPNO;

-- 비등가조인 : 동일 컬럼(열, 레코드) 없이 다른 조건을 사용하여 조인 할 때 사용(일반적이지 않음)
SELECT * FROM EMP;
SELECT * FROM SALGRADE; -- 급여의 등급 보는 테이블

SELECT E.ENAME, E.SAL, S.GRADE
FROM EMP E, SALGRADE S -- 두개의 테이블을 연결함
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL; -- 비등가 조인(급여와 범위구간을 정해서 등급을 찍게끔 함)

-- ANSI 조인으로 변경
SELECT ENAME, SAL, GRADE
FROM EMP E JOIN SALGRADE S
ON SAL BETWEEN LOSAL AND HISAL;


-- 자체 조인 : SELF 조인이라고도 함. 같은 테이블을 두번 사용하여 자체 조인
-- EMP 테이블에서 직속상관의 사원번호는 MGR에 있음
-- MGR을 이용해서 상관의 이름을 알아내기 위해서 사용할 수 있음
SELECT E1.EMPNO, E1.ENAME, E1.MGR,-- E1.MGR: 상관 사원번호
    E2.EMPNO AS 상관사원번호,
    E2.ENAME AS 상관이름--상관 사원번호를 통해 상관 이름을 구할 수 있음
    FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO;

-- 외부조인: 동등 조인의 경우 한쪽 컬럼에 값이 없다면 해당 행은 조회되지 않음
-- 내부조인과 다르게 값이 동등하지 않아도 출력됨
-- 동등조인 조건을 만족하지 못해 누락되는 행 출력하기 위해 사용
INSERT INTO EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    VALUES(9000, '짱구', 'SALESMAN', 7698, SYSDATE, 2000, 1000, NULL) --부서 값 안넣음

-- 왼쪽 외부조인 사용
SELECT E.ENAME, E.DEPTNO, DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO(+) --왼쪽 기준으로 오른쪽 채움
ORDER BY E.DEPTNO;

SELECT * FROM DEPT;

-- 오른쪽 외부조인 사용
SELECT E.ENAME, E.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO --오른쪽 기준으로 왼쪽 채움
ORDER BY E.DEPTNO;

-- SQL-99 표준 문법으로 배우는 조인 (ANSI)-----------------------세가지는 같은 문법--------------
-- NATURAL JOIN :자동. 등가 조인을 대신해 사용. 자동으로 같은 열 찾아서 조인
SELECT EMPNO, ENAME, DNAME
FROM EMP NATURAL JOIN DEPT;

-- JOIN ~ USING
-- 등가 조인 대신. USING 키워드에 조인 기준으로 사용할 열을 명시하여 사용
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, DEPTNO --E.DEPTNO쓰면 안됨..두개의 
FROM EMP E JOIN DEPT D USING(DEPTNO)
ORDER BY DEPTNO;

-- JOIN ~ ON : ANSI 등가조인
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, E.DEPTNO
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;


-- ANSI LEFT OTHER JOIN
SELECT E.ENAME, E.DEPTNO, DNAME
FROM EMP E LEFT OTHER JOIN DEPT D ---------------------ERROR---------------------
ON E.DEPTNO = D.DEPTNO 
ORDER BY E.DEPTNO;

-- ANSI RIGHT OTHER JOIN
SELECT E.ENAME, D.DEPTNO, D.DNAME
FROM EMP E RIGHT OTHER JOIN DEPT D --------------------ERROR---------------------
ON E.DEPTNO = D.DEPTNO
ORDER BY E.DEPTNO;

-- 1. 급여가 2000 초과인 사원들의 부서정보, 사원정보 출력(오라클, ANSI)
-- 오라클
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.SAL
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND E.SAL > 2000;

-- ANSI
SELECT DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.SAL
FROM EMP E NATURAL JOIN DEPT D
ON E.DEPTNO = D.DEPTNO --------------------ERROR---------------------
AND SAL > 2000;

-- 2. 각 부서별 평균 급여, 최대급여 최소급여 사원수 출력(집계함수 사용)
SELECT DEPTNO, ROUND(AVG(SAL), 2) AS AVG_SAL, MAX(SAL), MIN(SAL), COUNT(*) AS CNT
FROM EMP E JOIN DEPT D USING (DEPTNO)
GROUP BY DEPTNO, D.DNAME;

-- 3. 모든 부서정보와 사원정보 -> 부서번호, 사원이름 순으로 정렬
SELECT E.DEPTNO, DNAME, EMPNO, ENAME, JOB, SAL
  FROM EMP E RIGHT OUTER JOIN DEPT D 
  ON E.DEPTNO = D.DEPTNO
ORDER BY E.DEPTNO, ENAME;


-- 서브쿼리: 어떤 상황이나 조건에 따라 변할 수 있는 데이터 값을 비교하기 위해
--         SQL문 안에 작성하는 작은 SELECT문
-- 킹이라는 이름의 사원의 부서이름 찾기 위한 커리
SELECT DNAME FROM DEPT
WHERE DEPTNO = (SELECT DEPTNO FROM EMP 
                WHERE ENAME = 'KING');
-- 사원 'JONES'의 급여보다 높은 급여를 받는 사원 정보 출력하기(조건2개)
SELECT *
FROM EMP
WHERE SAL > (SELECT SAL FROM EMP 
                WHERE ENAME = 'JONES');

--Q. EMP 테이블의 사원 정보 중에서 사원 이름이 ALLEN인 사원의 추가 수당보다 많이 받는 사원 정보를 구하도록 코드 작성
SELECT *
    FROM EMP
WHERE COMM > (SELECT COMM FROM EMP 
                WHERE ENAME = 'ALLEN');
--Q. 'JAMES'보다 이전에 입사한 사원출력
SELECT * 
FROM EMP
WHERE HIREDATE < (SELECT HIREDATE FROM EMP
                    WHERE ENAME = 'JAMES');

--20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 
--높은 급여를 받는 사원 정보와 소속 부서 정보를 조회하는 경우에 대한 쿼리를 작성 
SELECT EMPNO, ENAME, JOB, SAL, D.DEPTNO, DNAME, LOC
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE E.DEPTNO = 20 
AND SAL > (SELECT AVG(SAL)FROM EMP);

-- <다중행 서브쿼리> : 실행 결과 행이 여러 개로 나오는 서브쿼리
-- IN 연산자 : 메인쿼리의 데이터가 서브쿼리의 결과중 하나라도 일치하면 참임.
-- 각 부서별 최고 급여와 동일한 급여를 받는 사원 정보 출력
SELECT *
FROM EMP
WHERE SAL IN (SELECT MAX(SAL)
                FROM EMP
                GROUP BY DEPTNO);


-- ANY 연산자 : 메인 쿼리의 비교 조건이 서브 쿼리의 여러 검색 결과 중 하나 이상 만족되면 반환(조건성립되면)
--'SALESMAN’ 들의 급여 중 최소값보다 많은 급여를 받는 사원들
SELECT empno, ename, sal 
FROM emp
WHERE sal > ANY (SELECT sal 
                FROM emp
                WHERE JOB = 'SALESMAN'); --any in거의 비슷하게 사용가능
-- ALL 연산자: 모든 값이 일치하면 반환
-- 30번 부서 사원들의 급여보다 적은 급여를 받는 사원 정보 출력
SELECT *
	FROM EMP
	WHERE SAL < ALL(SELECT SAL 
					FROM EMP
					WHERE DEPTNO = 30);

SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > ALL(SELECT SAL
                FROM EMP
                WHERE JOB = 'MANAGER');

--EXISTS 연산자 : 서브쿼리에 결과 값이 하나 이상 존재하면 조건식이 모두 true, 존재하지 않으면 모두 false
SELECT *
    FROM EMP
    WHERE EXISTS (SELECT DNAME
                    FROM DEPT
                    WHERE DEPTNO = 50);--서브쿼리에 값이 존재하지 않는 경우 

-- 다중 열 서브 쿼리 : 서브 쿼리의 결과가 두 개 이상의 컬럼으로 반환되어 메인 쿼리에 전달됨
-- 30번 부서에 포함되어 부서번호, 급여 두가지 정보 있으면 다 찍어줌
SELECT EMPNO, ENAME, SAL, DEPTNO
    FROM EMP
    WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, SAL
                            FROM EMP
                            WHERE DEPTNO = 30);
-- GROUP BY 절이 포함된 다중열 서브쿼리
-- 부서번호, 최대급여 받아서 포함되면 다 찍어줌
SELECT *
    FROM EMP
    WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL)
                            FROM EMP
                            GROUP BY DEPTNO);





