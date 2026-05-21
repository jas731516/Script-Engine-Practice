-- Example 4 - LOOP in PL/SQL
-- LOOP is used to repeat a block of code multiple times

SET SERVEROUTPUT ON;
DECLARE
   v_count  NUMBER := 1;
BEGIN
   -- Simple LOOP
   LOOP
      DBMS_OUTPUT.PUT_LINE('Count is : ' || v_count);
      v_count := v_count + 1;
      EXIT WHEN v_count > 5;
   END LOOP;
END;
/

-- --- OUTPUT ---
-- Count is : 1
-- Count is : 2
-- Count is : 3
-- Count is : 4
-- Count is : 5
