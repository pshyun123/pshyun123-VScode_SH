DESC EMP;
DESC DEPT;
DESC BONUS;
DESC SALGRADE;
---------------------------------------------------------------------------------
--�⺻ SELECT * FROM EMP;
SELECT * FROM EMP;
--EMP ���̺��� �����ȣ, ����̸�, ����� ���� �μ� ��ȣ�� ��ȸ
SELECT EMPNO,ENAME,DEPTNO
FROM EMP;

-- SQL�� �ۼ� ���ǻ���
-- 1. ��ҹ��� ���� ���� ����
-- 2. ���� �Ǵ� �����ٿ� �Էµ� �� ����
-- 3. �Ϲ������� Ű����� �빮�ڷ� �Է�
-- 4. �Ϲ������� �̸�, ���̸����� �ҹ��ڷ� �Է�
-- 5. ������ ���� ; ���� ����

-- Q. �����ȣ�� �μ���ȣ�� �������� EMP ���̺� ��ȸ�ϱ�
SELECT EMPNO, DEPTNO FROM EMP; 
-- ��Ī �����ϱ� : AS, �� �̸� �Ǵ� Į���� ��Ī���� ǥ�� ����
SELECT ENAME AS �̸�, SAL AS �޿�, SAL*12+COMM AS ����, COMM AS ������
FROM EMP;

-- �ߺ������ϱ� : DISTINCT, �����͸� ��ȸ�� �� ���� �ߺ��Ǵ� ���� ���� �� ��ȸ�Ǵ� ��찡 �ִµ�, ���� �ߺ��� ���� �Ѱ����� �����ϰ��� �� �� ���
SELECT DISTINCT JOB, DEPTNO FROM EMP;

-- �÷��� ����ϴ� ��������� : 
SELECT ENAME, SAL, SAL*12
FROM EMP;

--# WHERE ���� : ������ ��ȸ�� ����ڰ� ���ϴ� ���ǿ� �´� �����͸��� ��ȸ�ϰ� ���� �� ���(���� ����)
-- ���� �����ڿ� �Բ� �����
SELECT * FROM EMP
WHERE DEPTNO = 10;--������ ���̽�������  = ���ٶ�� �ǹ̷� ���

SELECT * FROM EMP
WHERE EMPNO = 7369;


--Q. �޿��� 2500 �ʰ��� �����ȣ, �̸�, ����(JOB), �޿� ����غ���
SELECT EMPNO, ENAME, JOB, SAL FROM EMP
WHERE SAL > 2500;

SELECT *
FROM EMP
WHERE SAL * 12 = 36000;

-- �������� 500 �ʰ��� ��� ���
SELECT * FROM EMP
WHERE COMM>500;

-- �Ի��� 81.01.01 ������ ������ ��ȸ
SELECT * FROM EMP
WHERE HIREDATE < '81/01/01';


-- ���� ������ ǥ���ϴ� �������� ��� <>, !=, ^=, NOT
SELECT * FROM EMP
WHERE deptno <> 30;


-- �޿��� 3000 �̻��̰�, �μ��� 20���� ��� ��ȸ(�ΰ��� ���� ��� ����)
SELECT *
FROM EMP
WHERE SAL >= 3000 AND DEPTNO = 20


-- �޿��� 3000 �̻��̰�, �μ��� 20��, �Ի��� 82.01.01 ������ ��� ��ȸ
SELECT * 
FROM emp
WHERE sal >= 3000 AND deptno = 20 AND hiredate <'82/0101';

-- �޿��� 3000 �̻��̰�, �μ��� 20���̰ų� �Ի��� 82.01.01 ������ ��� ��ȸ
SELECT 
* FROM emp
WHERE sal >= 3000 AND (deptno = 20 OR hiredate <'82/0101');

--�޿��� 2500 �̻��̰� ������ MANAGER�� ��� ������ ���
SELECT 
* FROM EMP
WHERE SAL >= 2500 AND JOB = 'MANAGER';



SELECT *
FROM EMP
WHERE JOB = 'MANAGER'
    OR JOB = 'SALESMAN'
    OR JOB = 'CLERK';
    
--IN ������(���Կ���Ȯ��)    
SELECT *
FROM EMP
WHERE JOB IN('MANAGER', 'SALESMAN', 'CLERK');

--DEPTNO��  20, 30 �ƴ� ������� ������ ��ȸ
SELECT *
    FROM EMP
WHERE DEPTNO NOT IN(20, 30);

--BETWEEN A AND B ������
SELECT *
FROM EMP
WHERE SAL >= 2000 AND SAL <= 3000;

SELECT *
FROM EMP
WHERE SAL BETWEEN 2000 AND 3000;

--�����ȣ 7698���� 7902 ������ ��� ��ȸ
SELECT *
FROM EMP
WHERE empno BETWEEN 7689 AND 9702;

--1980���� �ƴ� �ؿ� �Ի��� ����� ��ȸ
SELECT *
FROM EMP
WHERE NOT HIREDATE BETWEEN '1980/01/01' AND '1980/12/31';

--LIKE, NOT LIKE ������: �Ϻ� ���ڿ��� ���� ���θ� Ȯ���ϴ� ������, �����͸� **��ȸ(�˻�)�� �� ���**
-- % : ���̿� ������� ��� ���� �����͸� �ǹ�
-- _ : ���� 1���� �ǹ�

SELECT EMPNO, ENAME
FROM EMP
WHERE ENAME LIKE '%K%'--���� ���ڿ��� 0~���Ѵ���� ������� �������.



SELECT *
FROM EMP 
WHERE ENAME LIKE '_L%' --�ƹ� ���ڰ� ���� ��� ������ �Ѱ��� ���ڸ� �� �� ����

-- ��� �̸��� AM�� ���ԵǾ� �ִ� ��� �����͸� ����ϱ� 
SELECT *
FROM EMP
WHERE ENAME LIKE '%AM%';

    
-- ��� �̸��� AM�� ���ԵǾ� ���� ���� ��� ������ ����ϱ�
SELECT *
FROM EMP
WHERE ENAME NOT LIKE '%AM%';

-- NULL :  ��Ȯ�� �Ǵ� �� �� ���� ���� �ǹ� (0�� �ƴϰ� �� ������ �ǹ����� ����. ����, �Ҵ�, �񱳰� �Ұ����ϸ� ��=��, ��IN�� �����ڸ� �̿��ϸ� ��ȸ �Ұ���) 
SELECT ENAME, SAL * 12 + COMM AS ����, COMM
FROM EMP;

SELECT *
FROM emp
WHERE comm = null; -- ����Ұ�

SELECT * 
FROM emp
WHERE comm IS NULL; -- NULL ���θ� Ȯ���Ҷ� ����ϴ� ������

SELECT *
FROM EMP
WHERE MGR IS NOT NULL;