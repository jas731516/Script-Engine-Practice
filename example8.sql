-- Example 8 - EXCEPTION Handling in PL/SQL
-- EXCEPTION is used to handle errors gracefully
-- In Finacle every script must have proper exception handling

SET SERVEROUTPUT ON;

DECLARE
   v_account_no  NUMBER := 9999;
   v_balance     NUMBER;

BEGIN
   DBMS_OUTPUT.PUT_LINE('==============================');
   DBMS_OUTPUT.PUT_LINE('  EXCEPTION HANDLING DEMO     ');
   DBMS_OUTPUT.PUT_LINE('==============================');

   -- This will cause NO_DATA_FOUND error
   -- because account 9999 does not exist
   SELECT sal
   INTO   v_balance
   FROM   emp
   WHERE  empno = v_account_no;

   DBMS_OUTPUT.PUT_LINE('Balance : ' || v_balance);

EXCEPTION
   -- Handle specific error: no row found
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('ERROR : Account not found!');
      DBMS_OUTPUT.PUT_LINE('Account No : ' || v_account_no);

   -- Handle specific error: more than one row returned
   WHEN TOO_MANY_ROWS THEN
      DBMS_OUTPUT.PUT_LINE('ERROR : Multiple accounts found!');

   -- Handle specific error: wrong value type
   WHEN VALUE_ERROR THEN
      DBMS_OUTPUT.PUT_LINE('ERROR : Invalid value or data type!');

   -- Handle all other unexpected errors
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('ERROR : Unexpected error!');
      DBMS_OUTPUT.PUT_LINE('Detail: ' || SQLERRM);

END;
/

-- --- OUTPUT ---
-- ==============================
--   EXCEPTION HANDLING DEMO
-- ==============================
-- ERROR : Account not found!
-- Account No : 9999
