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

CREATE TABLE bank (
    id_bank INTEGER NOT NULL,
    balance FLOAT(2) NOT NULL
);

ALTER TABLE bank ADD CONSTRAINT bank_pk PRIMARY KEY ( id_bank );

CREATE TABLE company (
    id_company INTEGER NOT NULL,
    id_bank    INTEGER NOT NULL,
    name       VARCHAR2(25) NOT NULL,
    id_theater INTEGER NOT NULL
);

ALTER TABLE company ADD CONSTRAINT company_pk PRIMARY KEY ( id_company );

CREATE TABLE "Date" (
    scenario INTEGER NOT NULL,
    "date"   DATE NOT NULL
);

ALTER TABLE "Date" ADD CONSTRAINT date_pk PRIMARY KEY ( scenario );

CREATE TABLE representation (
    theater_id_theater INTEGER NOT NULL,
    id_show            INTEGER NOT NULL,
    cost               FLOAT(2) NOT NULL,
    travel_cost        FLOAT(2) NOT NULL,
    "date"             DATE NOT NULL
);

ALTER TABLE representation ADD CONSTRAINT representation_pk PRIMARY KEY ( theater_id_theater,
                                                                          id_show );

CREATE TABLE show (
    id_show    INTEGER NOT NULL,
    id_company INTEGER NOT NULL,
    name       VARCHAR2(25) NOT NULL,
    fix_fees   FLOAT(2) NOT NULL
);

ALTER TABLE show ADD CONSTRAINT show_pk PRIMARY KEY ( id_show );

CREATE TABLE subventions (
    id_subvention INTEGER NOT NULL,
    id_theater    INTEGER NOT NULL,
    "date"        DATE NOT NULL,
    sender        INTEGER NOT NULL
);

ALTER TABLE subventions ADD CONSTRAINT subventions_pk PRIMARY KEY ( id_subvention );

CREATE TABLE theater (
    id_theater INTEGER NOT NULL,
    id_bank    INTEGER NOT NULL,
    name       VARCHAR2(25) NOT NULL,
    adress     VARCHAR2(50) NOT NULL,
    capacity   INTEGER NOT NULL
);

ALTER TABLE theater ADD CONSTRAINT theater_pk PRIMARY KEY ( id_theater );

CREATE TABLE tickets (
    id_ticket  INTEGER NOT NULL,
    ref_price  FLOAT(2) NOT NULL,
    id_theater INTEGER NOT NULL,
    id_show    INTEGER NOT NULL
);

ALTER TABLE tickets ADD CONSTRAINT tickets_pk PRIMARY KEY ( id_ticket );

CREATE TABLE transaction (
    id_transaction INTEGER NOT NULL,
    id_bank_a      INTEGER NOT NULL,
    id_bank_b      INTEGER NOT NULL,
    amount         FLOAT(2) NOT NULL
);

ALTER TABLE transaction ADD CONSTRAINT transaction_pk PRIMARY KEY ( id_transaction );

ALTER TABLE company
    ADD CONSTRAINT company_bank_fk FOREIGN KEY ( id_bank )
        REFERENCES bank ( id_bank );

ALTER TABLE company
    ADD CONSTRAINT company_theater_fk FOREIGN KEY ( id_theater )
        REFERENCES theater ( id_theater );

ALTER TABLE representation
    ADD CONSTRAINT representation_show_fk FOREIGN KEY ( id_show )
        REFERENCES show ( id_show );

ALTER TABLE representation
    ADD CONSTRAINT representation_theater_fk FOREIGN KEY ( theater_id_theater )
        REFERENCES theater ( id_theater );

ALTER TABLE show
    ADD CONSTRAINT show_company_fk FOREIGN KEY ( id_company )
        REFERENCES company ( id_company );

ALTER TABLE subventions
    ADD CONSTRAINT subventions_theater_fk FOREIGN KEY ( id_theater )
        REFERENCES theater ( id_theater );

ALTER TABLE theater
    ADD CONSTRAINT theater_bank_fk FOREIGN KEY ( id_bank )
        REFERENCES bank ( id_bank );

ALTER TABLE tickets
    ADD CONSTRAINT tickets_representation_fk FOREIGN KEY ( id_theater,
                                                           id_show )
        REFERENCES representation ( theater_id_theater,
                                    id_show );

ALTER TABLE transaction
    ADD CONSTRAINT transaction_bank_buyer_fk FOREIGN KEY ( id_bank_a )
        REFERENCES bank ( id_bank );

ALTER TABLE transaction
    ADD CONSTRAINT transaction_bank_seller_fk FOREIGN KEY ( id_bank_b )
        REFERENCES bank ( id_bank );

-- Language: pl/sql

-- A trigger that checks that the travel cost is 0 when the theater is that of the company 
CREATE OR REPLACE TRIGGER travel_cost_check
    BEFORE INSERT OR UPDATE ON representation
    FOR EACH ROW
BEGIN
    IF :NEW.theater_id_theater = (SELECT id_theater FROM company WHERE id_company = (SELECT id_company FROM show WHERE id_show = :NEW.id_show)) THEN
        IF :NEW.travel_cost <> 0 THEN
            RAISE_APPLICATION_ERROR(-20000, 'Travel cost must be 0 when the theater is that of the company');
        END IF;
    END IF;
END;
/


-- A trigger that adds and removes money from bank accounts as soon as a transaction is created
CREATE OR REPLACE TRIGGER transaction_check
    BEFORE INSERT OR UPDATE ON transaction
    FOR EACH ROW
BEGIN
    IF :NEW.id_bank_a <> :NEW.id_bank_b THEN
        UPDATE bank SET balance = balance - :NEW.amount WHERE id_bank = :NEW.id_bank_a;
        UPDATE bank SET balance = balance + :NEW.amount WHERE id_bank = :NEW.id_bank_b;
    END IF;
END;
/

--Un trigger qui paye l'intégralité des frais (travel cost + b repr * cout d'une repr + fix fees)
CREATE OR REPLACE TRIGGER pay_fees
    BEFORE INSERT OR UPDATE ON representation
    FOR EACH ROW
BEGIN
    UPDATE bank SET balance = balance - (:NEW.cost * (SELECT capacity FROM theater WHERE id_theater = :NEW.theater_id_theater) + :NEW.travel_cost + (SELECT fix_fees FROM show WHERE id_show = :NEW.id_show)) WHERE id_bank = (SELECT id_bank FROM company WHERE id_company = (SELECT id_company FROM show WHERE id_show = :NEW.id_show));
END;
/

--Un trigger qui modifie le prix d'un ticket en fonctiondu % de remplissage de la room
CREATE OR REPLACE TRIGGER ticket_price
    BEFORE INSERT OR UPDATE ON tickets
    FOR EACH ROW
BEGIN
    UPDATE tickets SET ref_price = (SELECT cost FROM representation WHERE id_show = :NEW.id_show AND theater_id_theater = :NEW.id_theater) * (SELECT capacity FROM theater WHERE id_theater = :NEW.id_theater) / (SELECT COUNT(*) FROM tickets WHERE id_show = :NEW.id_show AND id_theater = :NEW.id_theater) WHERE id_ticket = :NEW.id_ticket;
END;
/


--Un trigger qui donne transforme une subvention en transaction a la date donnée (remplir aussi le champs credited) (edited)
CREATE OR REPLACE TRIGGER subvention_to_transaction
    BEFORE INSERT OR UPDATE ON subventions
    FOR EACH ROW
BEGIN
    INSERT INTO transaction (id_bank_a, id_bank_b, amount) VALUES (:NEW.sender, :NEW.id_theater, :NEW.amount);
    UPDATE subventions SET credited = :NEW.date WHERE id_subvention = :NEW.id_subvention;
END;
/

--Plusieurs triggers qui gèrent la partie "accounting and payment schedule"
--Un trigger qui met à jour le champs "paid" de la table "representation" quand le montant de la transaction est égal au montant de la représentation
CREATE OR REPLACE TRIGGER paid_check
    BEFORE INSERT OR UPDATE ON transaction
    FOR EACH ROW
BEGIN
    UPDATE representation SET paid = 1 WHERE id_show = (SELECT id_show FROM tickets WHERE id_ticket = (SELECT id_ticket FROM transaction WHERE id_transaction = :NEW.id_transaction)) AND theater_id_theater = (SELECT id_theater FROM tickets WHERE id_ticket = (SELECT id_ticket FROM transaction WHERE id_transaction = :NEW.id_transaction)) AND cost = :NEW.amount;
END;
/




