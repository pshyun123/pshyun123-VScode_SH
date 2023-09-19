-- FROM 절에 사용하는 서브쿼리 : 인라인뷰
-- FROM 절에 직접 테이블 명시하여 사용하기에 테이블 내 데이터 규모가 너무 큰 경우 사용
-- 보안이나 특정 목적으로 정보를 제공하는 경우
-- 10번 부서에 해당하는 테이블만 가지고 옴

SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
FROM (SELECT * FROM EMP 
        WHERE DEPTNO = 10) E10 JOIN (SELECT * FROM DEPT) D
ON E10.DEPTNO = D.DEPTNO;



-- 먼저 정렬하고 해당 개수만 가져오기
-- ROWNUM : 오라클에서 행 번호를 자동으로 매겨주는 문법
-- 정렬된 결과에서 상위 3개를 뽑으려면 테이블 가져올 때 정렬된 형태로 가져와야함.
-- 왜냐하면 일반적인 셀렉트 문에서는 오더바이 절이 맨 마지막에 수행
SELECT ROWNUM, ENAME, SAL
FROM (SELECT * FROM EMP
        ORDER BY SAL DESC)
WHERE ROWNUM <= 3; --연봉 제일 높은 사람 3명 출력

-- 스칼라 서브쿼리: SELECT문에서 쓰이는 단일 행 서브쿼리.(반드시 하나의 결과만 나와야 함)
SELECT EMPNO, ENAME, JOB, SAL, (SELECT GRADE
                              FROM SALGRADE
                              WHERE E.SAL BETWEEN LOSAL AND HISAL) AS 급여등급,
                              DEPTNO,
                              (SELECT DNAME
                              FROM DEPTH
                              WHERE E.DEPTNO = DEPT.DEPNO) AS DNAME
FROM EMP E;

--매 행마다 부서번호가 각 행의 부서번호와 동일한 사원들의 SAL 평균을 구해서 반환
SELECT ENAME, DEPTNO, SAL,
    (SELECT TRUNC(AVG(SAL))
    FROM EMP
    WHERE DEPTNO = E.DEPTNO) AS 부서별평균급여
FROM EMP E;

SELECT ENAME, DEPTNO, SAL,
    (SELECT TRUNC(AVG(SAL)) -- 소속 분서의 급여 평균값 1개
        FROM EMP
        WHERE DEPTNO = E.DEPTNO) AS AVGDEPTSAL -- 해당 부서를 결정하는 것은 현재 입력되는 행의 부서
FROM EMP E;

-- 부서위치가 NEW YORK인 경우에 본사로, 그 외 부서는 분점으로 반환
SELECT EMPNO, ENAME,
        CASE WHEN DEPTNO = (SELECT DEPTNO
                            FROM DEPT
                            WHERE LOC = 'NEW YORK')
            THEN '본사'
            ELSE '분점'
        END AS 소속
FROM EMP
ORDER BY 소속 DESC;

-- 1. ALLEN과 같은 직책(JOB)인 사원들의 사원 정보(사원번호, 사원이름), 부서 정보를 출력
-- 1) 알렌의 직책 알아내고, 조인과 서브쿼리 필요
SELECT E.EMPNO, E.ENAME, E.JOB, D.DEPTNO, D.DNAME
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE E.JOB = (SELECT JOB
FROM EMP
WHERE ENAME = 'ALLEN')
-- 2. 전체 사원의 평균 급여(SAL)보다 높은 급여 받는 사원들의 사원 정보, 부서 정보, 급여 등급 출력
-- (급여가 많은 순으로 정렬/급여가 같을 경우, 사원 번호를 기준 오름차순 정렬).
-- 테이블 3개 조인(EMP, DEPT, SALGRADE)
SELECT E.EMPNO, E.ENAME,  D.DEPTNO, D.DNAME, D.LOC, E.SAL, S.GRADE
FROM EMP E 
JOIN DEPT D ON E.DEPTNO = D.DEPTNO
JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL 
WHERE E.SAL > (SELECT AVG(SAL)
                FROM EMP)
ORDER BY E.SAL DESC, E.EMPNO;


-- 3. 10번 부서 사원 중 30번 부서에 존재하지 않는 직책을 가진 사원들의 사원 정보, 부서 정보 출력
SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME, D.LOC
FROM EMP E JOIN DEPT D
ON D.DEPTNO= D.DEPTNO
WHERE E.DEPTNO = 10 AND E.JOB NOT IN (SELECT DISTINCT JOB
                                        FROM EMP
                                        WHERE DEPTNO = 30);

-- 4. 직책이 SALESMAN인 사람들의 최고 급여보다 높은 급여를 받는 사원들의 사원 정보, 급여 등급 출력
-- (다중행 함수를 사용하는 방법, 사용하지 않는 방법 둘다.사원 번호를 기준으로 오름차순 정렬)
-- 다중행 사용하지 않는 방법
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
AND SAL > (SELECT MAX(SAL)
            FROM EMP
            WHERE JOB = 'SALESMAN')
ORDER BY E.EMPNO;

-- 다중행 사용하는 방법
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
FROM EMP E JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE E.SAL > ALL(SELECT SAL
                  FROM EMP
                  WHERE JOB = 'SALESMAN')
ORDER BY E.EMPNO;

-- DML(Data Manipulation Language):데이터를 조회(SELECT), 삭제(DELETE), 입력(INSERT), 변경(UPDATE) 
-- 테이블이 아니고 데이터를 조작하는 것

-- DML을 하기 위해서 임시테이블 생성
-- 기존의 DEPT 테이블 복사해서 DEPT_TEMP 테이블 생성


CREATE TABLE DEPT_TEMP
AS SELECT * FROM DEPT;

SELECT * FROM DEPT_TEMP;

DROP TABLE DEPT_TEMP; -- 테이블 삭제할 때 사용

-- 테이블에 데이터 추가 (1)
INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC) VALUES(50, 'DATABASE', 'SEOUL');
INSERT INTO DEPT_TEMP(DEPTNO, LOC, DNAME) VALUES(50, '부산', 'DEVELOPMENT');
INSERT INTO DEPT_TEMP(DEPTNO, LOC, DNAME) VALUES(70, '인천', NULL);
-- UPDATE DEPT_TEMP
--     SET DEPTNO = 60
--     WHERE LOC = '부산';


-- 테이블에 데이터 추가 (2)
INSERT INTO DEPT_TEMP VALUES(80, '프론트',NULL);
-- INSERT INTO DEPT_TEMP VALUES(90, '백엔드'); --개수가 안 맞아서 안들어간다
INSERT INTO DEPT_TEMP(DEPTNO, DNAME) VALUES(90, '백엔드'); --열이름 

CREATE TABLE EMP_TEMP
AS SELECT * FROM EMP 
WHERE 1 != 1; 

-----ERROR----

SELECT * FROM EMP_TEMP;
-- 테이블에 날짜 데이터 입력
INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
        VALUES (9001, '안유진', 'MANAGER', 9000, TO_DATE('2023/09/23','YYYY/MM/DD'), 2000, 1000, 10);

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
        VALUES (9001, '가을', 'MANAGER', 9000, SYSDATE, 2000, 1000, 10);


-- 서브쿼리를 이용한 INSERT
INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO
    FROM EMP E JOIN SALGRADE S
    ON E.SAL BETWEEN S.LOSAL AND S.HISAL
    WHERE S.GRADE =1;

-- UPDATE : 행의 정보를 변경할 때 사용
-- UPDATE '테이블 이름' SET '변경할 열의 이름과 데이터' WHERE '조건식'
SELECT * FROM DEPT_TEMP2;

CREATE TABLE DEPT_TEMP2
AS SELECT * FROM DEPT_TEMP;

-- UPDATE DEPT_TEMP2
--     SET DNAME = '프론트'

-- UPDATE DEPT_TEMP2
--     SET DNAME = '데이터'
--     WHERE DEPTNO = 20;

UPDATE DEPT_TEMP2
    SET DNAME = '백엔드',
        LOC = '광주'
    WHERE DEPTNO = 30;

ROLLBACK;


--테이블 데이터 삭제
CREATE TABLE EMP_TEMP2
    AS SELECT * FROM EMP;
    
SELECT * FROM EMP_TEMP2;

--조건절 없이 사용하면 모든 데이터 삭제
DELETE FROM EMP_TEMP2

---
WHERE JOB = 'SALESMAN';



-- 오토커밋 꺼주고 커밋 맨 마지막에 해주면 락 걸려있던 데이터가 풀린다. 
CREATE TABLE DEPT_TCL
AS SELECT *
FROM DEPT;

SELECT * FROM DEPT_TCL;

INSERT INTO DEPT_TCL VALUES(50, 'DATABASE', 'SEOUL')

COMMIT;
--커밋이 일어나줘야한다. 필요에따라 오토커밋 해도 되는데 트랜젝션. 반영됨.
UPDATE DEPT_TCL
SET LOC = 'SEOUL'
WHERE DEPTNO = 30;
