-- select the tickets prices for today
SELECT ti.ref_price, s.name, r.date_rep
FROM tickets ti, representation r, date_sequence d, show s
WHERE ti.id_show = r.id_show
AND r.id_show = s.id_show
AND r.date_rep = d.seq_date

-- create a procedure that display the cities the company will visit this month
CREATE OR REPLACE PROCEDURE cities_to_visit (id_company IN INTEGER, start_date IN DATE, end_date IN DATE)
AS
BEGIN
    FOR cities IN (SELECT DISTINCT t.city FROM theater t, representation r, show s, company c
                 WHERE t.id_theater = r.id_theater
                 AND r.id_show = s.id_show
                 AND s.id_company = c.id_company
                 AND c.id_company = s.id_company
                 AND date_rep BETWEEN start_date AND end_date)
    LOOP
        DBMS_OUTPUT.PUT_LINE(cities.city);
    END LOOP;
END;

BEGIN
    cities_to_visit(&id_company);
END;

-- Test dates :
UPDATE date_sequence SET seq_date = '07-11-2022' WHERE date_sequence = '01-11-2022'; -- > This date is the first representation of the first show
SELECT * FROM transactions -- will show the fees paid by the theater 1 for the show 1

UPDATE date_sequence SET seq_date = '10-11-22' WHERE date_sequence = '07-11-22'; -- > This date is the first representation of the second show

UPDATE date_sequence SET seq_date = '15-11-2022' WHERE date_sequence = '10-11-2022'; -- > This date is the first subvention date
SELECT * FROM representation WHERE date_rep = '18-11-2022'; -- will show the diiscount price for the show 3 in theater 2
SELECT * FROM subvention -- will show the subvention credited for the theaters
SELECT * FROM bank WHERE id_bank IN (SELECT id_bank FROM theater); -- will show the bank account credited of the theaters

UPDATE date_sequence SET seq_date = '17-11-2022' WHERE date_sequence = '15-11-2022';
UPDATE date_sequence SET seq_date = '18-11-2022' WHERE date_sequence = '17-11-2022';
UPDATE date_sequence SET seq_date = '20-11-2022' WHERE date_sequence = '18-11-2022';
UPDATE date_sequence SET seq_date = '22-11-2022' WHERE date_sequence = '20-11-2022';
UPDATE date_sequence SET seq_date = '24-11-2022' WHERE date_sequence = '22-11-2022';
UPDATE date_sequence SET seq_date = '25-11-2022' WHERE date_sequence = '24-11-2022';
UPDATE date_sequence SET seq_date = '01-12-2022' WHERE date_sequence = '25-11-2022';
UPDATE date_sequence SET seq_date = '07-12-2022' WHERE date_sequence = '01-12-2022';
UPDATE date_sequence SET seq_date = '08-12-2022' WHERE date_sequence = '07-12-2022';
UPDATE date_sequence SET seq_date = '10-12-2022' WHERE date_sequence = '08-12-2022';
UPDATE date_sequence SET seq_date = '15-12-2022' WHERE date_sequence = '10-12-2022';
UPDATE date_sequence SET seq_date = '18-12-2022' WHERE date_sequence = '15-12-2022';
UPDATE date_sequence SET seq_date = '22-12-2022' WHERE date_sequence = '18-12-2022';
UPDATE date_sequence SET seq_date = '31-12-2022' WHERE date_sequence = '22-12-2022';
UPDATE date_sequence SET seq_date = '01-01-2023' WHERE date_sequence = '31-12-2022'; -- > day pf the state every 5 year subvention
SELECT * FROM subvention -- will show the subvention credited for the theaters
SELECT * FROM bank WHERE id_bank IN (SELECT id_bank FROM theater); -- will show the bank account credited of the theaters

UPDATE date_sequence SET seq_date = '01-02-2023' WHERE date_sequence = '01-01-2023';