-- Example 9 - PACKAGE in PL/SQL
-- PACKAGE is used to group related procedures and functions
-- In Finacle all scripts are written inside packages

SET SERVEROUTPUT ON;

-- ============================================
-- PART 1: PACKAGE SPECIFICATION (Header)
-- This is like a menu - shows what is available
-- ============================================
CREATE OR REPLACE PACKAGE pkg_finacle_bank
IS
   -- Declare function
   FUNCTION get_balance(
      p_account_no  IN  NUMBER
   ) RETURN NUMBER;

   -- Declare procedure
   PROCEDURE process_debit(
      p_account_no  IN  NUMBER,
      p_amount      IN  NUMBER
   );

   PROCEDURE process_credit(
      p_account_no  IN  NUMBER,
      p_amount      IN  NUMBER
   );

END pkg_finacle_bank;
/

-- ============================================
-- PART 2: PACKAGE BODY (Actual code)
-- This is the actual implementation
-- ============================================
CREATE OR REPLACE PACKAGE BODY pkg_finacle_bank
IS

   -- FUNCTION: Get Account Balance
   FUNCTION get_balance(
      p_account_no  IN  NUMBER
   ) RETURN NUMBER
   IS
      v_balance  NUMBER := 0;
   BEGIN
      IF p_account_no = 1001 THEN
         v_balance := 50000;
      ELSIF p_account_no = 1002 THEN
         v_balance := 15000;
      ELSE
         v_balance := 0;
      END IF;
      RETURN v_balance;
   EXCEPTION
      WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE('ERROR in get_balance: ' || SQLERRM);
         RETURN 0;
   END get_balance;

   -- PROCEDURE: Process Debit
   PROCEDURE process_debit(
      p_account_no  IN  NUMBER,
      p_amount      IN  NUMBER
   )
   IS
      v_balance     NUMBER;
      v_new_balance NUMBER;
   BEGIN
      v_balance := get_balance(p_account_no);

      DBMS_OUTPUT.PUT_LINE('--- DEBIT TRANSACTION ---');
      DBMS_OUTPUT.PUT_LINE('Account No     : ' || p_account_no);
      DBMS_OUTPUT.PUT_LINE('Current Balance: ' || v_balance);
      DBMS_OUTPUT.PUT_LINE('Debit Amount   : ' || p_amount);

      IF v_balance >= p_amount THEN
         v_new_balance := v_balance - p_amount;
         DBMS_OUTPUT.PUT_LINE('Status         : SUCCESS');
         DBMS_OUTPUT.PUT_LINE('New Balance    : ' || v_new_balance);
      ELSE
         DBMS_OUTPUT.PUT_LINE('Status         : FAILED');
         DBMS_OUTPUT.PUT_LINE('Reason         : Insufficient Balance');
      END IF;
   EXCEPTION
      WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE('ERROR in process_debit: ' || SQLERRM);
   END process_debit;

   -- PROCEDURE: Process Credit
   PROCEDURE process_credit(
      p_account_no  IN  NUMBER,
      p_amount      IN  NUMBER
   )
   IS
      v_balance     NUMBER;
      v_new_balance NUMBER;
   BEGIN
      v_balance := get_balance(p_account_no);

      DBMS_OUTPUT.PUT_LINE('--- CREDIT TRANSACTION ---');
      DBMS_OUTPUT.PUT_LINE('Account No     : ' || p_account_no);
      DBMS_OUTPUT.PUT_LINE('Current Balance: ' || v_balance);
      DBMS_OUTPUT.PUT_LINE('Credit Amount  : ' || p_amount);

      v_new_balance := v_balance + p_amount;
      DBMS_OUTPUT.PUT_LINE('Status         : SUCCESS');
      DBMS_OUTPUT.PUT_LINE('New Balance    : ' || v_new_balance);
   EXCEPTION
      WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE('ERROR in process_credit: ' || SQLERRM);
   END process_credit;

END pkg_finacle_bank;
/

-- ============================================
-- PART 3: TEST THE PACKAGE
-- ============================================
BEGIN
   DBMS_OUTPUT.PUT_LINE('==============================');
   DBMS_OUTPUT.PUT_LINE('   FINACLE PACKAGE TEST       ');
   DBMS_OUTPUT.PUT_LINE('==============================');

   -- Test Debit
   pkg_finacle_bank.process_debit(1001, 20000);

   DBMS_OUTPUT.PUT_LINE(' ');

   -- Test Credit
   pkg_finacle_bank.process_credit(1002, 5000);

   DBMS_OUTPUT.PUT_LINE(' ');

   -- Test Failed Debit
   pkg_finacle_bank.process_debit(1002, 50000);

END;
/

-- --- OUTPUT ---
-- ==============================
--    FINACLE PACKAGE TEST
-- ==============================
-- --- DEBIT TRANSACTION ---
-- Account No     : 1001
-- Current Balance: 50000
-- Debit Amount   : 20000
-- Status         : SUCCESS
-- New Balance    : 30000
--
-- --- CREDIT TRANSACTION ---
-- Account No     : 1002
-- Current Balance: 15000
-- Credit Amount  : 5000
-- Status         : SUCCESS
-- New Balance    : 20000
--
-- --- DEBIT TRANSACTION ---
-- Account No     : 1002
-- Current Balance: 15000
-- Debit Amount   : 50000
-- Status         : FAILED
-- Reason         : Insufficient Balance
