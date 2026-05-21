-- Example 7 - CURSOR in PL/SQL
-- CURSOR is used to fetch and loop through multiple rows
-- from a table one by one

SET SERVEROUTPUT ON;

DECLARE
   -- Step 1: Declare the cursor with a SELECT query
   CURSOR c_emp IS
      SELECT empno, ename, sal
      FROM   emp
      WHERE  sal > 1000;

   -- Step 2: Declare variables to hold each row
   v_empno  NUMBER;
   v_ename  VARCHAR2(50);
   v_sal    NUMBER;

BEGIN
   DBMS_OUTPUT.PUT_LINE('==============================');
   DBMS_OUTPUT.PUT_LINE('  EMPLOYEE LIST (SAL > 1000)  ');
   DBMS_OUTPUT.PUT_LINE('==============================');

   -- Step 3: Open the cursor
   OPEN c_emp;

   -- Step 4: Loop through each row
   LOOP
      FETCH c_emp INTO v_empno, v_ename, v_sal;
      EXIT WHEN c_emp%NOTFOUND;

      DBMS_OUTPUT.PUT_LINE(
         'EmpNo: ' || v_empno ||
         ' Name: '  || v_ename ||
         ' Sal: '   || v_sal
      );
   END LOOP;

   -- Step 5: Close the cursor
   CLOSE c_emp;

END;
/

-- --- OUTPUT ---
-- ==============================
--   EMPLOYEE LIST (SAL > 1000)
-- ==============================
-- EmpNo: 7499 Name: ALLEN  Sal: 1600
-- EmpNo: 7521 Name: WARD   Sal: 1250
-- EmpNo: 7566 Name: JONES  Sal: 2975
-- EmpNo: 7654 Name: MARTIN Sal: 1250
-- EmpNo: 7698 Name: BLAKE  Sal: 2850
-- EmpNo: 7782 Name: CLARK  Sal: 2450
-- EmpNo: 7788 Name: SCOTT  Sal: 3000
-- EmpNo: 7839 Name: KING   Sal: 5000
-- EmpNo: 7844 Name: TURNER Sal: 1500
-- EmpNo: 7902 Name: FORD   Sal: 3000
-- EmpNo: 7934 Name: MILLER Sal: 1300
