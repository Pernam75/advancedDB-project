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

