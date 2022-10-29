-- Basic security triggers

-- trigger that checks if bank account A and B are different
CREATE OR REPLACE TRIGGER transaction_bank_check
    BEFORE INSERT OR UPDATE ON transaction
    FOR EACH ROW
BEGIN
    IF :NEW.id_bank_a = :NEW.id_bank_b THEN
        RAISE_APPLICATION_ERROR(-20000, 'Bank A and B must be different');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Correctly added with different bank accounts');
    END IF;
END;

-- add a trigger that checks if the travel cost is 0 when the theater is the same as the company's theater
CREATE OR REPLACE TRIGGER representation_travel_cost_trigger
BEFORE INSERT OR UPDATE ON representation
FOR EACH ROW
DECLARE 
    theater_checked INTEGER;
BEGIN
    SELECT id_theater INTO theater_checked
    FROM company c, show s 
    WHERE s.id_show = :NEW.id_show 
    AND c.id_company = s.id_company;

    IF :NEW.theater_id_theater = theater_checked THEN
        IF :NEW.travel_cost <> 0 THEN
            RAISE_APPLICATION_ERROR(-20000, 'Travel cost must be 0 when the theater is the same as the company''s theater');
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Correctly added with travel cost 0');
    END IF;
END;

-- A trigger that adds and removes money from bank accounts as soon as a transaction is created
CREATE OR REPLACE TRIGGER transaction_check
    AFTER INSERT ON transaction
    FOR EACH ROW
BEGIN
    UPDATE bank SET balance = balance - :NEW.amount WHERE id_bank = :NEW.id_bank_a;
    UPDATE bank SET balance = balance + :NEW.amount WHERE id_bank = :NEW.id_bank_b;
    DBMS_OUTPUT.PUT_LINE('Correctly added the transaction in the bank accoutns');
END;
/


-- Trigger Budget et Couts de Production
CREATE OR REPLACE TRIGGER pay_fees
AFTER UPDATE OR INSERT ON date_sequence
REFERENCING NEW AS NEW
FOR EACH ROW
DECLARE
    total_fees FLOAT(2);
    theater_bank INTEGER;
    company_bank INTEGER;
    last_transaction INTEGER;
BEGIN
    SELECT s.fix_fees + s.nb_repr * (r.cost + r.travel_cost), t.id_bank, c.id_bank INTO total_fees, theater_bank, company_bank
    FROM show s, representation r, theater t, company c
    WHERE s.id_show = r.id_show
    AND s.first_repr = :NEW.seq_date
    AND t.id_theater = r.theater_id_theater
    AND c.id_company = s.id_company;

    INSERT INTO transaction (id_transaction, id_bank_a, id_bank_b, amount)
    VALUES ((SELECT MAX(id_transaction) FROM transaction) + 1, theater_bank, company_bank, total_fees);
    DBMS_OUTPUT.PUT_LINE('Correctly added the transaction in the bank accoutns');
END;

-- This triggers changes the price of the ticket when the date of the representation is in more than 15 days
CREATE OR REPLACE TRIGGER ticket_price_date_trigger
    AFTER INSERT OR UPDATE ON date_sequence
    FOR EACH ROW
DECLARE
    price FLOAT(2);
    rep_date DATE;
    show INTEGER;
BEGIN
    SELECT ti.ref_price, r.date_rep, ti.id_show INTO price, rep_date, show
    FROM tickets ti, representation r
    WHERE ti.id_show = r.id_show;
    
    IF rep_date - :NEW.seq_date < 15 THEN
        UPDATE tickets SET ref_price = price * 0.8 WHERE id_show = show;
        DBMS_OUTPUT.PUT_LINE('Correctly updated the price of the tickets regarding to the date');
    END IF;
END;

--Un trigger qui modifie le prix d'un ticket en fonctiondu % de remplissage de la room
CREATE OR REPLACE TRIGGER ticket_price_filling_room_trigger
BEFORE INSERT OR UPDATE ON tickets
FOR EACH ROW
DECLARE
    nb_places INTEGER;
    nb_places_taken INTEGER;
    price FLOAT(2);
BEGIN
    SELECT t.capacity, (SELECT COUNT(*) FROM tickets WHERE id_show = :NEW.id_show), ti.ref_price INTO nb_places, nb_places_taken, price
    FROM tickets ti, theater t, representation r
    WHERE ti.id_show = :NEW.id_show
    AND r.id_show = ti.id_show
    AND t.id_theater = r.Theater_id_theater;

    IF nb_places_taken / nb_places < 0.3 THEN
        UPDATE tickets SET ref_price = price * 0.5 WHERE id_show = :NEW.id_show;
        DBMS_OUTPUT.PUT_LINE('Correctly updated the price of the tickets regarding to the filling of the room');
    END IF;
END;

-- Trigger qui modifie le prix d'un ticket en fonction du nombre de places restantes et de la date de la représentation
CREATE OR REPLACE TRIGGER ticket_price_filling_room_date_trigger
    AFTER INSERT OR UPDATE ON date_sequence
    FOR EACH ROW
DECLARE
    price FLOAT(2);
    rep_date DATE;
    show INTEGER;
    nb_places INTEGER;
    nb_places_taken INTEGER;
BEGIN
    SELECT ti.ref_price, r.date_rep, ti.id_show, t.capacity, COUNT(*) INTO price, rep_date, show, nb_places, nb_places_taken
    FROM tickets ti, representation r, theater t
    WHERE ti.id_show = r.id_show
    AND ti.id_show = show
    AND r.id_show = ti.id_show
    AND t.id_theater = r.Theater_id_theater;
    
    IF rep_date = :NEW.seq_date AND nb_places_taken / nb_places < 0.5 THEN
        UPDATE tickets SET ref_price = price * 0.7 WHERE id_show = show;
        DBMS_OUTPUT.PUT_LINE('Correctly updated the price of the tickets regarding to the date and the filling of the room');
    END IF;
END;

-- This triggers changes the price of the ticket when the date of the representation is in more than 15 days
CREATE OR REPLACE TRIGGER subvention_date_trigger
    AFTER INSERT OR UPDATE ON date_sequence
    FOR EACH ROW
DECLARE
    paying_date DATE;
    theater INTEGER;
    bank INTEGER;
    amount FLOAT(2);
BEGIN
    SELECT su.sub_date, t.id_theater, t.id_bank, su.amount INTO paying_date, theater, bank, amount
    FROM subvention s, theater t
    WHERE su.id_theater = t.id_theater;

    IF paying_date = :NEW.seq_date THEN
        UPDATE bank SET balance = balance + amount WHERE id_bank = bank;
        DBMS_OUTPUT.PUT_LINE('Correctly added the subvention in the bank accoutns');
    END IF;
END;

-- Give the theater balance at the end of each month
CREATE OR REPLACE TRIGGER monthly_balance_trigger
    AFTER INSERT OR UPDATE ON date_sequence
    FOR EACH ROW
DECLARE
    theater INTEGER;
    theater_balance FLOAT(2);
    theater_name VARCHAR(25);
    theater_bank INTEGER;
BEGIN
    -- if the date is the last day of the month -> call the procedure
    IF TRUNC(:NEW.seq_date + 1, 'MM') <> TRUNC(:NEW.seq_date, 'MM') THEN
        FOR theaters IN (SELECT id_theater FROM theater) LOOP
            SELECT t.name, t.id_bank, b.balance INTO theater_name, theater_bank, theater_balance
            FROM theater t, bank b WHERE id_theater = theaters.id_theater;
            DBMS_OUTPUT.PUT_LINE('id ' || theaters.id_theater || '|name '|| theater_name || '| balance ' || theater_balance);
        END LOOP;
    END IF;
END;

-- Check that the theater does not produce two shows on the same day
CREATE OR REPLACE TRIGGER theater_show_date_trigger
    BEFORE INSERT OR UPDATE ON representation
    FOR EACH ROW
DECLARE
    theater INTEGER;
    date_rep DATE;
BEGIN
    SELECT r.date_rep, r.Theater_id_theater INTO date_rep, theater
    FROM representation r
    WHERE r.id_show = :NEW.id_show;

    IF date_rep = :NEW.date_rep AND theater = :NEW.Theater_id_theater THEN
        RAISE_APPLICATION_ERROR(-20001, 'The theater already has a show on this date');
    END IF;
END;

-- Check that the companies does not produce two shows on the same day
CREATE OR REPLACE TRIGGER company_show_date_trigger
    BEFORE INSERT OR UPDATE ON representation
    FOR EACH ROW
DECLARE
    company INTEGER;
    date_rep DATE;
BEGIN
    SELECT r.date_rep, r.Company_id_company INTO date_rep, company
    FROM representation r
    WHERE r.id_show = :NEW.id_show;

    IF date_rep = :NEW.date_rep AND company = :NEW.Company_id_company THEN
        RAISE_APPLICATION_ERROR(-20002, 'The company already has a show on this date');
    END IF;
END;