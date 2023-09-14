-- 함수
-- 오라클에서 함수는 내장 함수와 사용자 정의 함수로 나뉨
-- 내장 함수는 단일행 함수, 다중행(집계) 함수로 나뉨
-- DUAL 테이블 : 오라클의 SYS 계쩡에서 제공하는 테이블, 
-- 함수나 계산식에서 테이블 참조없이 실행해보기 위해 제공됨(DUMMY테이블)

-- ABS : 절대값을 구하는 함수
SELECT -10, ABS(-10) FROM DUAL;

-- ROUND : 반올림한 결과를 반환하는 함수 : ROUND(숫자, 반올림 위치), 위치는 음수값도 줄 수 있음
SELECT ROUND(1234.5678) AS ROUND, 
    ROUND(1234.5678, 0) AS ROUND_0,
    ROUND(1234.5678, 1) AS ROUND_1,
    ROUND(1234.5678, 2) AS ROUND_2,
    ROUND(1234.5678, -1) AS ROUND_MINUS1,
    ROUND(1234.5678, -2) AS ROUND_MINUS2
FROM DUAL;
-- TRUNC : 버림을 한 결과를 반환하는 함수
SELECT TRUNC(1234.5678) AS TRUNC, 
    TRUNC(1234.5678, 0) AS TRUNC_0,
    TRUNC(1234.5678, 1) AS TRUNC_1,
    TRUNC(1234.5678, 2) AS TRUNC_2,
    TRUNC(1234.5678, -1) AS TRUNC_MINUS1,
    TRUNC(1234.5678, -2) AS TRUNC_MINUS2
FROM DUAL;

--MOD :나누기한 후 나머지를 출력하는 함수
SELECT MOD(21, 5) FROM DUAL;

--CEIL : 소수점 이하를 무조건 올림
SELECT CEIL(12.000001) FROM DUAL;

--FLOOR : 소수점 이하를 무조건 내림
SELECT FLOOR(12.999999) FROM DUAL;

--POWER : 정수A를 정수B만큼 제곱하는 함수 (3,4)-> 3*3*3*3
SELECT POWER(3,4) FROM DUAL;
