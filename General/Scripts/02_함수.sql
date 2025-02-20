/* 함수 : 컬럼값 | 지정된 값을 읽어 연산한 결과를 반환하는 것
 * 
 * 1. 단일행 함수 (N -> N)
 * - N개의 행의 컬럼 값을 전달하여 N개의 결과를 반환
 * 
 * 2. 그룹 함수 (N -> 1)
 * - N개의 행의 컬럼 값을 전달하여 1개의 결과를 반환
 * 
 * * 함수는
 *  SELECT절, WHERE절, ORDER BY절, GROUP BY절, HAVING절에 사용 가능(FROM빼고 다 가능)
 * */

/* ***** 단일 행 함수 ***** */

/* <문자 관련 함수> */

/* LENGTH(컬럼명|문자열) : 문자열의 길이 반환 */
SELECT 'HELLOW WORD', LENGTH('HELLOW WORD')
FROM DUAL; -- 임시 테이블

-- EMPLOYEE 테이블에서
-- 사원명, 이메일, 이메일 길이 조회
-- 단, 이메일 길이가 12 이하인 사원만 조회
-- 이메일 길이 오름차순으로 정렬
SELECT EMP_NAME, EMAIL, LENGTH(EMAIL) AS "이메일 길이" 
FROM EMPLOYEE 
WHERE LENGTH(EMAIL) <= 12
ORDER BY LENGTH(EMAIL) ASC;

-------------------------------------------------

/* INSTR(문자열 | 컬럼명, '찾을 문자열' [, 시작위치 [, 순번]])
 * - 시작 위치부터 지정된 순번 까지 
 * 문자열 | 컬럼 값에서 '찾을 문자열'의 위치를 반환
 */

-- 처음 B를 찾은 위치 조회
SELECT 'AABBCCABC', INSTR('AABBCCABC', 'B')
FROM DUAL; --3

-- 5번째 문자 검색 시작, 처음 B를 찾은 위치 조회
SELECT 'AABBCCABC', INSTR('AABBCCABC', 'B',5)
FROM DUAL; --8

-- 5번째 문자 검색 시작, 3번째로 찾은 C를 찾은 위치 조회
SELECT 'AABBCCABC', INSTR('AABBCCABC', 'C',5,3)
FROM DUAL; --9

/* SUBSTR(문자열, 시작위치 [, 길이])
 * 
 * - 문자열을 시작 위치부터 지정된 길이만큼 잘라서 반환
 * - 길이 미작성 시 시작위치 ~ 끝 까지 잘라서 반환
 * */

-- EMPLOYEE 테이블에서
-- 사원들의 이메일 아이디 조회하기 (뒤에 주소 필요 없음)
SELECT  SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1)
FROM EMPLOYEE;

/* TRIM(옵션 문자열 FROM 문자열)
 * - 대상 문자열에 앞|뒤|양쪽에 존재하는 지정된 문자열 제거
 * 
 * - 옵션 : LEADING(앞), TRAILING(뒤), BOTH(양쪽, 기본값)
 * */

SELECT '###기###준###',
TRIM(LEADING '#' FROM '###기###준###'),
TRIM(TRAILING '#' FROM '###기###준###'),
TRIM(BOTH'#' FROM '###기###준###')
FROM DUAL;

------------------------------------
/* REPLACE(문자열, 찾을 문자열, 대체 문자열)
 * - 문자열에서 원하는 부분을 바꾸는 함수
 * */

SELECT NATIONAL_NAME , REPLACE(NATIONAL_NAME,'한국', '대한민국') 변경
FROM "NATIONAL";

-- 모든 사원의 이메일 주소를
-- or.kr -> gmail.com변경
SELECT EMAIL || ' -> ' || REPLACE (EMAIL,'or.kr','gmail.com') "이메일 변경"
FROM EMPLOYEE;

-- # 모두 제거하기
SELECT '###기###준###', REPLACE('###기###준###', '#', '') 변경
FROM D

------------------------------------------------------------
/* <숫자 관련 함수>
 * 
 * - MOD(숫자, 나눌 값) : 결과로 나머지 반환
 * - ABS(숫자) : 절대 값
 * - CEIL(실수)   : 올림 -> 정수 형태로 반환
 * - FLOOER(실수) : 내림 -> 정수 형태로 반환
 * 
 * - ROUND(실수[, 소수점 위치]) : 반올림
 *   1) 소수점 위치 X : 소수점 첫째 자리에서 반올림 -> 정수
 * 	 2) 소수점 위치 O : 지정된 위치에서 반올림
 * 	
 * - TRUNC(실수 [, 소수점 위치]) : 버림(잘라내기)
 * */

-- MOD()
SELECT MOD(7, 4) FROM DUAL; -- 3

-- ABS()
SELECT ABS(-333) FROM DUAL; -- 333

-- CEIL()
SELECT CEIL(1.1), FLOOR(1.9)  -- 2/ 1
FROM DUAL;

-- ROUND()
SELECT 
ROUND(123.456),  -- 123
ROUND(123.456, 1),  -- 123.5
ROUND(123.456, 2),  -- 123.46
ROUND(123.456, 0)   -- 123
ROUND(123.456, -1)  -- 120
FROM DUAL;

--- TRUNC() : 버림
SELECT 
TRUNC(123.456),   -- 123 (소수점 버림)
TRUNC(123.456, 1),  -- 123.4 
TRUNC(123.456, 2)   -- 123.45 
FROM DUAL;

-- TRUNC()와 FLOOR()의 차이
-- 버림        내림
SELECT TRUNC(-123.5), FLOOR(-123.5) 
FROM DUAL;

---------------------------------------------------------
/* 날짜 관련 함수 */
/* MONTH_BETWEEN(날짜, 날짜) 
 * - 두 날짜 사이의 개월 수 반환
 * */
SELECT CEIL(MONTHS_BETWEEN(TO_DATE('2025-07-17', 'YYYY.MM.DD'), CURRENT_DATE)) 
FROM DUAL; -- 5 개월

/* 나이 구하기 */
-- 2001.03.20 생의 나이, 만 나이 구하기
SELECT CEIL((SYSDATE - TO_DATE('2001.03.20', 'YYYY.MM.DD')) / 365 + 1) "한국식 나이",
FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE('2001.03.20', 'YYYY.MM.DD')) / 12) "만 나이"
FROM DUAL;

/***********************************/
-- 정확한 날짜 계산에는 MONTH_BETWEEN이 좋다
--> 내부적으로 윤달 계산이 포함되어 있어서
/***********************************/

-------------------------------------------

/* ADD_MONTH(날짜, 숫자) :
 * - 날짜에 숫자 만큼의 개월 수 추가
 * - 달마다 일 수가 다르기 때문에 계산이 쉽지 않음 -> 쉽게 계산할 수 있는 함수 제공
 * */
SELECT SYSDATE + 28, ADD_MONTHS(SYSDATE, 1), -- 둘다 3/20
 SYSDATE + 28 + 31, ADD_MONTHS(SYSDATE, 2) 
FROM DUAL;

--------------------------------------------------
/* LAST_DAY(날짜)
 * - 해당 월의 마지막 날짜를 반환
 * - 월말, 월 초 구하는 용도로 많이 사용
 * */
SELECT LAST_DAY(SYSDATE), LAST_DAY(SYSDATE) + 1 "다음달 1일",
 ADD_MONTHS( LAST_DAY(SYSDATE) + 1,-1) "이번달 1일"
FROM DUAL;

--------------------------------------------
/* EXTRACT(YEAR | MONTH | DAY 날짜)
 * - EXTRACT 뜻 : 뽑아내다, 추출하다
 * - 지정된 년|월|일을 추출하여 '정수' 형태로 반환
 * */

-- EMPLOYEE 테이블에서 2010년대에 입사한 사원의
-- 사번, 이름, 입사일을 입사일 내림 차순으로 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE 
FROM EMPLOYEE 
WHERE EXTRACT(YEAR FROM HIRE_DATE) BETWEEN 2010 AND 2019 
ORDER BY HIRE_DATE  DESC;

----------------------------------------------------------

/* <형변환(Paring) 함수> */
-- 문자열(CHAR, VARCHAR2) <-> 숫자(NUMBER)
-- 문자열(CHAR, VARCHAR2) <-> 날짜(DATE)
-- 숫자(NUMBER) --> 날짜(DATE)

/* TO_DATE(문자열 | 숫자 [,포맷])
 * - 문자열 또는 숫자를 날짜로 변환
 * 
 * [포멧 종류]
 * YY   : 연도(짧게)
 * YYYY : 연도(길게)
 * 
 * RR   : 연도(짧게)
 * RRRR : 연도(길게)
 * 
 * MM : 월
 * DD : 일
 * 
 * AM/PM : 오전/오후(둘 중 아무거나 작성 가능)
 * 
 * HH : 시간(12시간 표기)
 * HH 24 : 시간 (24시간 표기)
 * MI : 분
 * SS : 초
 * 
 * DAY : 요일(전체) - 월요일, MONDAY
 * DY  : 요일(약어) - 월, MON
 * */
-- . - / : 등의 기호와 기본적인 날짜 작성 순서는 포맷 지정을 안해도 해석 가능
SELECT '2025-02-20' 문자열, TO_DATE('2025-02-20') 날짜 
FROM DUAL;

-- 일반적인 날짜 패턴이 아니거나 영어 외 문자 포함 시 포맷 지정 필수
SELECT '2025-02-21 17:50:00 (금)' 문자열, 
TO_DATE('2025-02-21 17:50:00 (금)', 'YYYY-MM-DD HH24:MI:SS(DY)') 날짜 
FROM DUAL;

SELECT 
'16:20:43 목요일 02-20/2025' 문자열, TO_DATE('16:20:43 목요일 02-20/2025', 'HH24:MI:SS DAY MM-DD/YYYY') 날짜 
FROM DUAL;

-- 한글(년,월,일)은 DBMS 시스템에 등록된 날짜 포맷이 아니라 인식이 불가
-- -> 포맷이 아니라 모양 그대로 인식할 수 있게 "" 추가
SELECT 
'2025년 02월 20일' 문자열, TO_DATE('2025년 02월 20일', 'YYYY"년" MM"월" DD"일"') 날짜 
FROM DUAL;

-- 숫자 -> 날짜 변환 가능
SELECT 20250220 숫자, TO_DATE(20250220)
FROM DUAL;

-----------------------------------------------
/* TO_CHAR(숫자 | 날짜 [,포맷])
 * - 숫자, 날짜를 문자열로 변환
 * */

/* 숫자 -> 문자열
 * 
 * 1) 9 : 숫자 1칸을 의미, 오른쪽 정렬
 * 2) 0 : 숫자 1칸을 의미, 오른쪽 정렬, 빈칸을 0으로 채움
 * 3) L : 현재 시스템 또는 DB 설정 국가의 화폐 기호
 * 4) , : 숫자 자릿수 구분
 * */

-- 숫자 -> 문자열
SELECT 1234, TO_CHAR(1234) FROM DUAL; 

-- 문자열 9칸 지정, 오른쪽 정렬
SELECT 1234, TO_CHAR(1234, '9999999') 
FROM DUAL;

-- 문자열 9칸 지정, 오른쪽 정렬, 빈칸 0으로 채우기
SELECT 1234, TO_CHAR(1234, '0000000') 
FROM DUAL;

-- 변경할 숫자보다 칸 수가 적을 때 -> 모든 문자가 #으로 변환되서 출력(오류)
SELECT 1234, TO_CHAR(1234, '000') 
FROM DUAL;

-- ,를 이용한 자릿수 구분 + 화폐기호
-- TRIM() : 양쪽 공백 제거
SELECT 100000000, TRIM(TO_CHAR(100000000, 'L999,999,999'));

-- 모든 사원의 연봉 조회
-- 단, 연봉은 '\999,999,999'형태로 출력
-- 연봉 내림차순으로 조회
SELECT EMP_NAME , TRIM(TO_CHAR(SALARY * 12, 'L999,999,999')) 연봉 
FROM EMPLOYEE 
ORDER BY SALARY * 12 DESC;

/* (참고)
 * - 문자열 정렬 기준은 글자 수, 글자 순서 등에 영향이 있기 때문에
 * 	 정렬 시 생각을 잘 해봐야 함
 * 
 * - 숫자는 정렬 기준으로 사용하기 좋다
 * (크고, 작다의 기준이 단순하고 명확해서)
 * */

-----------------------------------------------------------------
/* 날짜 -> 문자열 */
-- 오늘 날짜를 'YYYY/MM/DD DAY'로 변경
SELECT CURRENT_DATE, TO_CHAR(CURRENT_DATE, 'YYYY/MM/DD DAY') "오늘 날짜"
FROM DUAL;

-- 오늘 날짜를 '2025.02.20 (목) 오후 04:27:20' 변환
SELECT TO_CHAR(SYSDATE, 'YYYY.MM.DD (DY) PM HH:MI:SS') "오늘 날짜"
FROM DUAL;

-- 오늘 날짜를 '2025년 02월 20일 (목) 오후 04시30분20초' 변환
SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일" (DY) PM HH"시"MI"분"SS"초"') "오늘 날짜" 
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'RRRR"년" MM"월" DD"일" (DY) PM HH"시"MI"분"SS"초"') "오늘 날짜" 
FROM DUAL;

/* R, Y 차이점
 * YY : 연도 상관 없이 현재 세기로 표기(현재 세기 == 21C == 2000년대)
 * 
 * RR : 50을 기준으로 50 미만이면 현재 세기(2000년대)
 *			            50 이상이면 이전 세기(1900년대)	 
 *  */
SELECT
TO_DATE('25/02/20', 'YY/MM/DD') YY, -- 2025 
TO_DATE('25/02/20', 'RR/MM/DD') RR  -- 2025
FROM DUAL;

SELECT
TO_DATE('50/02/20', 'YY/MM/DD') YY, -- 2050 
TO_DATE('50/02/20', 'RR/MM/DD') RR  -- 1950
FROM DUAL;

----------------------------------
/* TO_NUMBER(문자열 [.패턴] : 문자열 -> 숫자*/
SELECT '123456789', TO_NUMBER('123456789') FROM DUAL;

SELECT '$1,500', TO_NUMBER('$1,500','$9,999') 숫자
FROM DUAL;












