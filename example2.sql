-- Example 2 - Variables in PL/SQL
-- Variables are used to store values temporarily

SET SERVEROUTPUT ON;

DECLARE
   v_name    VARCHAR2(50) := 'Finacle';
   v_age     NUMBER       := 22;
   v_salary  NUMBER       := 25000;
BEGIN
   DBMS_OUTPUT.PUT_LINE('Name   : ' || v_name);
   DBMS_OUTPUT.PUT_LINE('Age    : ' || v_age);
   DBMS_OUTPUT.PUT_LINE('Salary : ' || v_salary);
END;
/

-- --- OUTPUT ---
-- Name   : Finacle
-- Age    : 22
-- Salary : 25000
