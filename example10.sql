-- Example 10 - TRIGGER in PL/SQL
-- TRIGGER automatically runs when a table event occurs
-- Events: INSERT, UPDATE, DELETE
-- In Finacle triggers are used for audit logging and validations

SET SERVEROUTPUT ON;

-- ============================================
-- STEP 1: Create a sample transaction table
-- ============================================
CREATE TABLE finacle_transactions (
   trans_id      NUMBER,
   account_no    NUMBER,
   trans_type    VARCHAR2(10),  -- DEBIT or CREDIT
   amount        NUMBER,
   trans_date    DATE
);

-- ============================================
-- STEP 2: Create audit log table
-- ============================================
CREATE TABLE finacle_audit_log (
   log_id        NUMBER,
   account_no    NUMBER,
   action        VARCHAR2(10),
   amount        NUMBER,
   log_date      DATE,
   log_message   VARCHAR2(200)
);

-- ============================================
-- STEP 3: Create TRIGGER
-- Fires automatically after every INSERT
-- on finacle_transactions table
-- ============================================
CREATE OR REPLACE TRIGGER trg_transaction_audit
AFTER INSERT ON finacle_transactions
FOR EACH ROW
BEGIN
   -- Automatically log every new transaction
   INSERT INTO finacle_audit_log (
      log_id,
      account_no,
      action,
      amount,
      log_date,
      log_message
   ) VALUES (
      :NEW.trans_id,
      :NEW.account_no,
      :NEW.trans_type,
      :NEW.amount,
      SYSDATE,
      'Transaction recorded for account: ' || :NEW.account_no
   );

   DBMS_OUTPUT.PUT_LINE('TRIGGER FIRED!');
   DBMS_OUTPUT.PUT_LINE('Auto logged transaction for account: ' || :NEW.account_no);

EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('ERROR in trigger: ' || SQLERRM);
END trg_transaction_audit;
/

-- ============================================
-- STEP 4: Test the trigger
-- Insert a transaction and see trigger fire
-- ============================================
BEGIN
   DBMS_OUTPUT.PUT_LINE('==============================');
   DBMS_OUTPUT.PUT_LINE('   TRIGGER TEST               ');
   DBMS_OUTPUT.PUT_LINE('==============================');

   -- Insert transaction 1
   INSERT INTO finacle_transactions
   VALUES (1, 1001, 'DEBIT', 20000, SYSDATE);

   DBMS_OUTPUT.PUT_LINE(' ');

   -- Insert transaction 2
   INSERT INTO finacle_transactions
   VALUES (2, 1002, 'CREDIT', 5000, SYSDATE);

   COMMIT;
   DBMS_OUTPUT.PUT_LINE(' ');
   DBMS_OUTPUT.PUT_LINE('All transactions committed!');
END;
/

-- ============================================
-- STEP 5: Check audit log
-- ============================================
SELECT * FROM finacle_audit_log;

-- --- OUTPUT ---
-- ==============================
--    TRIGGER TEST
-- ==============================
-- TRIGGER FIRED!
-- Auto logged transaction for account: 1001
--
-- TRIGGER FIRED!
-- Auto logged transaction for account: 1002
--
-- All transactions committed!
--
-- FINACLE_AUDIT_LOG:
-- 1 | 1001 | DEBIT  | 20000 | 21-MAY-26 | Transaction recorded for account: 1001
-- 2 | 1002 | CREDIT | 5000  | 21-MAY-26 | Transaction recorded for account: 1002
