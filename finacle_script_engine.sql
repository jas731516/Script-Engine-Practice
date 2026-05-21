-- Finacle Script Engine - Banking Transaction Practice
-- Topics used: FUNCTION, PROCEDURE, EXCEPTION, IF ELSE, LOOP
-- This simulates a basic banking transaction script

SET SERVEROUTPUT ON;

-- ============================================
-- FUNCTION: Check Account Balance
-- ============================================
CREATE OR REPLACE FUNCTION get_balance(
   p_account_no  IN  NUMBER
) RETURN NUMBER
IS
   v_balance  NUMBER := 0;
BEGIN
   -- Simulating balance fetch
   -- In real Finacle this fetches from GCTD/ACTD tables
   IF p_account_no = 1001 THEN
      v_balance := 50000;
   ELSIF p_account_no = 1002 THEN
      v_balance := 15000;
   ELSE
      v_balance := 0;
   END IF;

   RETURN v_balance;
END get_balance;
/

-- ============================================
-- PROCEDURE: Process Debit Transaction
-- ============================================
CREATE OR REPLACE PROCEDURE process_debit(
   p_account_no  IN  NUMBER,
   p_amount      IN  NUMBER
)
IS
   v_balance     NUMBER;
   v_new_balance NUMBER;
BEGIN
   -- Step 1: Get current balance
   v_balance := get_balance(p_account_no);

   DBMS_OUTPUT.PUT_LINE('Account No     : ' || p_account_no);
   DBMS_OUTPUT.PUT_LINE('Current Balance: ' || v_balance);
   DBMS_OUTPUT.PUT_LINE('Debit Amount   : ' || p_amount);

   -- Step 2: Check sufficient balance
   IF v_balance >= p_amount THEN
      v_new_balance := v_balance - p_amount;
      DBMS_OUTPUT.PUT_LINE('Transaction    : SUCCESS');
      DBMS_OUTPUT.PUT_LINE('New Balance    : ' || v_new_balance);
   ELSE
      DBMS_OUTPUT.PUT_LINE('Transaction    : FAILED');
      DBMS_OUTPUT.PUT_LINE('Reason         : Insufficient Balance');
   END IF;

EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('ERROR : ' || SQLERRM);
END process_debit;
/

-- ============================================
-- MAIN BLOCK: Test the Script Engine
-- ============================================
BEGIN
   DBMS_OUTPUT.PUT_LINE('=============================');
   DBMS_OUTPUT.PUT_LINE('  FINACLE SCRIPT ENGINE TEST ');
   DBMS_OUTPUT.PUT_LINE('=============================');

   DBMS_OUTPUT.PUT_LINE('--- Transaction 1 ---');
   process_debit(1001, 20000);  -- Should SUCCESS

   DBMS_OUTPUT.PUT_LINE(' ');
   DBMS_OUTPUT.PUT_LINE('--- Transaction 2 ---');
   process_debit(1002, 50000);  -- Should FAIL

   DBMS_OUTPUT.PUT_LINE(' ');
   DBMS_OUTPUT.PUT_LINE('--- Transaction 3 ---');
   process_debit(9999, 1000);   -- Unknown account
END;
/

-- --- OUTPUT ---
-- =============================
--   FINACLE SCRIPT ENGINE TEST
-- =============================
-- --- Transaction 1 ---
-- Account No     : 1001
-- Current Balance: 50000
-- Debit Amount   : 20000
-- Transaction    : SUCCESS
-- New Balance    : 30000
--
-- --- Transaction 2 ---
-- Account No     : 1002
-- Current Balance: 15000
-- Debit Amount   : 50000
-- Transaction    : FAILED
-- Reason         : Insufficient Balance
--
-- --- Transaction 3 ---
-- Account No     : 9999
-- Current Balance: 0
-- Debit Amount   : 1000
-- Transaction    : FAILED
-- Reason         : Insufficient Balance
