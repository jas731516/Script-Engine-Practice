-- Example 3 - IF ELSE Condition in PL/SQL
-- IF ELSE is used to make decisions based on a condition

SET SERVEROUTPUT ON;

DECLARE
   v_salary  NUMBER := 25000;
BEGIN
   IF v_salary >= 20000 THEN
      DBMS_OUTPUT.PUT_LINE('Salary is Good');
   ELSIF v_salary >= 10000 THEN
      DBMS_OUTPUT.PUT_LINE('Salary is Average');
   ELSE
      DBMS_OUTPUT.PUT_LINE('Salary is Low');
   END IF;
END;
/

-- --- OUTPUT ---
-- Salary is Good
