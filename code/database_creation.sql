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

CREATE TABLE date_sequence (
    seq_date   DATE NOT NULL
);

CREATE TABLE representation (
    theater_id_theater INTEGER NOT NULL,
    id_show            INTEGER NOT NULL,
    cost               FLOAT(2) NOT NULL,
    travel_cost        FLOAT(2) NOT NULL,
    rep_date             DATE NOT NULL,
    CONSTRAINT check_travel_cost CHECK (travel_cost >= 0)
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
    sub_date        DATE NOT NULL,
    sender        INTEGER NOT NULL,
    credited      CHAR(1) NOT NULL
);

-- Oracle SQL has no boolean type, so we use CHAR(1) instead and we check the value
ALTER TABLE subventions ADD CONSTRAINT subventions_ck1 CHECK ( credited IN ('T', 'F') );

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
