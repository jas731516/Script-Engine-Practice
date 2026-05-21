-- Example 6 - SELECT INTO in PL/SQL
-- SELECT INTO is used to fetch data from a table
-- and store it into a variable

SET SERVEROUTPUT ON;

DECLARE
   v_name      VARCHAR2(50);
   v_salary    NUMBER;
BEGIN
   SELECT ename, sal
   INTO   v_name, v_salary
   FROM   emp
   WHERE  empno = 7369;

   DBMS_OUTPUT.PUT_LINE('Employee Name   : ' || v_name);
   DBMS_OUTPUT.PUT_LINE('Employee Salary : ' || v_salary);
END;
/

-- --- OUTPUT ---
-- Employee Name   : SMITH
-- Employee Salary : 800
