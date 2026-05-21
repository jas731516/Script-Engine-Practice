-- Example 5 - FOR LOOP in PL/SQL
-- FOR LOOP is simpler than simple LOOP
-- No need to declare counter variable or EXIT WHEN

SET SERVEROUTPUT ON;

BEGIN
   FOR i IN 1..5 LOOP
      DBMS_OUTPUT.PUT_LINE('Number : ' || i);
   END LOOP;
END;
/

-- --- OUTPUT ---
-- Number : 1
-- Number : 2
-- Number : 3
-- Number : 4
-- Number : 5
