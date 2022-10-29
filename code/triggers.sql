-- Basic security triggers

-- trigger that checks if bank account A and B are different
CREATE OR REPLACE TRIGGER transaction_bank_check
    BEFORE INSERT OR UPDATE ON transaction
    FOR EACH ROW
BEGIN
    IF :NEW.id_bank_a = :NEW.id_bank_b THEN
        RAISE_APPLICATION_ERROR(-20000, 'Bank A and B must be different');
    END IF;
END;

