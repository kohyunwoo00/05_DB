-- 1번 
-- 학생이름과 주소지를 조회하시오 
-- 단, 출력 헤더는 "학생 이름", "주소지"로 하고, 정렬은 이름으로 오름차순 정렬 
SELECT STUDENT_NAME "학생 이름", STUDENT_ADDRESS "주소지"
FROM TB_STUDENT 
ORDER BY STUDENT_NAME ASC;

-- 2번 
-- 휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서 조회하시오.
SELECT STUDENT_NAME, STUDENT_SSN 
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y' 
ORDER BY STUDENT_SSN DESC;

-- 3번 
-- 주소지가 강원도나 경기도인 학생들 중 1900년대 학번을 가진 학생들의  
-- 이름과 학번, 주소를 이름 오름차순으로 조회하시오. 
-- 단, 출력헤더에는 "학생이름", "학번", "거주지 주소"가 출력되도록 한다.
SELECT STUDENT_NAME 학생이름, STUDENT_NO 학번, STUDENT_ADDRESS "거주지 주소"
FROM TB_STUDENT 
WHERE STUDENT_NO LIKE '9%' AND (STUDENT_ADDRESS LIKE '강원도%' OR STUDENT_ADDRESS LIKE '경기도%')
ORDER BY STUDENT_NAME ASC;

-- 4번 
-- 현재 법학과 교수의 이름, 주민등록 번호를 나이가 많은 순서부터 조회하시오.
SELECT P.PROFESSOR_NAME, P.PROFESSOR_SSN 
FROM TB_PROFESSOR P
JOIN TB_DEPARTMENT D ON(D.DEPARTMENT_NO = P.DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '법학과'
ORDER BY P.PROFESSOR_SSN ASC;

-- 5번 
-- 2004년 2학기에 'C3118100' 과목을 수강한 학생들의 학점을 조회하려고 한다. 
 -- 학점이 높은 학생부터 표시하고, 학점이 같으면 학번이 낮은 학생부터 조회하시오. 
-- (참고) 소수점 아래 2자리까지 0으로 표현 : TO_CHAR(NUMBER, 'FM9.00') 
-- (FM : 조회 결과 양쪽 공백 제거) 

-- 6번 
-- 학생 번호, 학생 이름, 학과 이름을 학생 이름 오름차순으로 조회하시오.
SELECT S.STUDENT_NO, S.STUDENT_NAME, D.DEPARTMENT_NAME 
FROM TB_STUDENT S
JOIN TB_DEPARTMENT D ON (D.DEPARTMENT_NO = S.DEPARTMENT_NO)
ORDER BY S.STUDENT_NAME ASC;

-- 7번 
-- 춘 기술대학교의 과목 이름, 해당 과목을 수업하는 학과 이름을 조회하시오.
SELECT C.CLASS_NAME, D.DEPARTMENT_NAME 
FROM TB_CLASS C
JOIN TB_DEPARTMENT D ON(D.DEPARTMENT_NO = C.DEPARTMENT_NO);

-- 8번 
-- 과목, 해당 과목 교수 이름을 조회하시오.
SELECT DISTINCT (C.CLASS_NAME), P.PROFESSOR_NAME 
FROM TB_CLASS C
JOIN TB_PROFESSOR P ON(C.DEPARTMENT_NO = P.DEPARTMENT_NO)
JOIN TB_CLASS_PROFESSOR CP ON(P.PROFESSOR_NO = CP.PROFESSOR_NO);








