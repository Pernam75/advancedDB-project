
-- theater bank accounts
INSERT INTO bank (id_bank, balance) VALUES (1, 100000.00);
INSERT INTO bank (id_bank, balance) VALUES (2, 90000.00);
INSERT INTO bank (id_bank, balance) VALUES (3, 80000.00);
INSERT INTO bank (id_bank, balance) VALUES (4, 70000.00);
INSERT INTO bank (id_bank, balance) VALUES (5, 60000.00);
INSERT INTO bank (id_bank, balance) VALUES (6, 50000.00);
INSERT INTO bank (id_bank, balance) VALUES (7, 40000.00);
INSERT INTO bank (id_bank, balance) VALUES (8, 30000.00);
INSERT INTO bank (id_bank, balance) VALUES (9, 20000.00);
INSERT INTO bank (id_bank, balance) VALUES (10, 10000.00);
-- company banks account
INSERT INTO bank (id_bank, balance) VALUES (11, 1000.00);
INSERT INTO bank (id_bank, balance) VALUES (12, 1000.00);
INSERT INTO bank (id_bank, balance) VALUES (13, 1000.00);
INSERT INTO bank (id_bank, balance) VALUES (14, 1000.00);
INSERT INTO bank (id_bank, balance) VALUES (15, 1000.00);
INSERT INTO bank (id_bank, balance) VALUES (16, 1000.00);
INSERT INTO bank (id_bank, balance) VALUES (17, 1000.00);
INSERT INTO bank (id_bank, balance) VALUES (18, 1000.00);
INSERT INTO bank (id_bank, balance) VALUES (19, 1000.00);
INSERT INTO bank (id_bank, balance) VALUES (20, 1000.00);


-- theater table
INSERT INTO theater(id_theater, id_bank, name, adress, city, capacity) VALUES (1, 1, 'Theatre de Paris', '15 rue Blanche', 'Paris', 100);
INSERT INTO theater(id_theater, id_bank, name, adress, city, capacity) VALUES (2, 2, 'Theatre de Lyon', '15 rue Blanche', 'Lyon', 220);
INSERT INTO theater(id_theater, id_bank, name, adress, city, capacity) VALUES (3, 3, 'Theatre de Marseille', '15 rue Blanche', 'Marseille', 124);
INSERT INTO theater(id_theater, id_bank, name, adress, city, capacity) VALUES (4, 4, 'Theatre de Toulouse', '15 rue Blanche', 'Toulouse', 239);
INSERT INTO theater(id_theater, id_bank, name, adress, city, capacity) VALUES (5, 5, 'Theatre de Nice', '15 rue Blanche', 'Nice', 10);
INSERT INTO theater(id_theater, id_bank, name, adress, city, capacity) VALUES (6, 6, 'Theatre de Nantes', '15 rue Blanche', 'Nantes', 64);
INSERT INTO theater(id_theater, id_bank, name, adress, city, capacity) VALUES (7, 7, 'Theatre de Strasbourg', '15 rue Blanche', 'Strasbourg', 34);
INSERT INTO theater(id_theater, id_bank, name, adress, city, capacity) VALUES (8, 8, 'Theatre de Montpellier', '15 rue Blanche', 'Montpellier', 58);
INSERT INTO theater(id_theater, id_bank, name, adress, city, capacity) VALUES (9, 9, 'Theatre de Bordeaux', '15 rue Blanche', 'Bordeaux', 79);
INSERT INTO theater(id_theater, id_bank, name, adress, city, capacity) VALUES (10, 10, 'Theatre de Lille', '15 rue Blanche', 'Lille', 223);

-- company table
INSERT INTO company VALUES (1, 11, 'Company 1', 1);
INSERT INTO company VALUES (2, 12, 'Company 2', 2);
INSERT INTO company VALUES (3, 13, 'Company 3', 3);
INSERT INTO company VALUES (4, 14, 'Company 4', 2);
INSERT INTO company VALUES (5, 15, 'Company 5', 1);
INSERT INTO company VALUES (6, 16, 'Company 6', 3);
INSERT INTO company VALUES (7, 17, 'Company 7', 1);
INSERT INTO company VALUES (8, 18, 'Company 8', 2);
INSERT INTO company VALUES (9, 19, 'Company 9', 3);
INSERT INTO company VALUES (10, 20, 'Company 10', 2);

-- show table
INSERT INTO show(id_show, id_company, name, fix_fees, nb_repr, first_rep) VALUES (1, 1, 'Show 1', 1000, 10, '07-11-2022');
INSERT INTO show(id_show, id_company, name, fix_fees, nb_repr, first_rep) VALUES (2, 2, 'Show 2', 1000, 10, '10-11-2022');
INSERT INTO show(id_show, id_company, name, fix_fees, nb_repr, first_rep) VALUES (3, 3, 'Show 3', 1000, 10, '18-11-2022');
INSERT INTO show(id_show, id_company, name, fix_fees, nb_repr, first_rep) VALUES (4, 4, 'Show 4', 1000, 10, '20-11-2022');
INSERT INTO show(id_show, id_company, name, fix_fees, nb_repr, first_rep) VALUES (5, 5, 'Show 5', 1000, 10, '25-11-2022');
INSERT INTO show(id_show, id_company, name, fix_fees, nb_repr, first_rep) VALUES (6, 1, 'Show 6', 1000, 10, '30-11-2022');
INSERT INTO show(id_show, id_company, name, fix_fees, nb_repr, first_rep) VALUES (7, 2, 'Show 7', 1000, 10, '01-12-2022');
INSERT INTO show(id_show, id_company, name, fix_fees, nb_repr, first_rep) VALUES (8, 3, 'Show 8', 1000, 10, '05-12-2022');
INSERT INTO show(id_show, id_company, name, fix_fees, nb_repr, first_rep) VALUES (9, 4, 'Show 9', 1000, 10, '10-12-2022');
INSERT INTO show(id_show, id_company, name, fix_fees, nb_repr, first_rep) VALUES (10, 5, 'Show 10', 1000, 10, '15-12-2022');


-- representation table
INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (1, 1, 100, 0, '07-11-2022', 100);
INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (2, 1, 100, 300, '10-11-2022', 100);
INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (3, 1, 100, 200, '30-11-2022', 100);

INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (1, 2, 100, 0, '10-11-2022', 100);
INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (3, 2, 100, 200, '17-11-2022', 100);
INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (2, 2, 100, 300, '30-11-2022', 100);


INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (2, 3, 100, 300, '18-11-2022', 100);
INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (1, 3, 100, 0, '22-11-2022', 100);
INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (3, 3, 100, 200, '27-11-2022', 100);

INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (1, 4, 100, 0, '20-11-2022', 100);
INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (3, 4, 100, 200, '24-11-2022', 100);
INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (2, 4, 100, 300, '29-11-2022', 100);

INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (2, 5, 100, 300, '25-11-2022', 100);
INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (3, 5, 100, 200, '01-12-2022', 100);
INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (1, 5, 100, 0, '07-12-2022', 100);

INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (2, 6, 100, 300, '30-11-2022', 100);
INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (1, 6, 100, 0, '10-12-2022', 100);
INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (3, 6, 100, 200, '15-12-2022', 100);

INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (2, 7, 100, 300, '01-12-2022', 100);
INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (3, 7, 100, 200, '01-01-2023', 100);
INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (1, 7, 100, 0, '01-02-2023', 100);

INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (3, 8, 100, 200, '05-12-2022', 100);
INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (2, 8, 100, 300, '07-12-2022', 100);
INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (1, 8, 100, 0, '08-12-2022', 100);

INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (3, 9, 100, 200, '10-12-2022', 100);
INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (2, 9, 100, 300, '30-12-2022', 100);
INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (1, 9, 100, 0, '31-12-2022', 100);

INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (3, 10, 100, 200, '15-12-2022', 100);
INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (2, 10, 100, 300, '18-12-2022', 100);
INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (1, 10, 100, 0, '22-12-2022', 100);

INSERT INTO representation(id_theater, id_show, cost, travel_cost, date_rep, ref_price) VALUES (5, 1, 100, 200, '20-12-2022', 100);

-- You will get some trigger errors related to the travel cost which are not 0

-- ticket table
INSERT INTO tickets(id_ticket, sold_price, id_theater, id_show) VALUES (1, 100, 1, 1);
INSERT INTO tickets(id_ticket, sold_price, id_theater, id_show) VALUES (2, 100, 1, 1);
INSERT INTO tickets(id_ticket, sold_price, id_theater, id_show) VALUES (3, 100, 1, 1);
INSERT INTO tickets(id_ticket, sold_price, id_theater, id_show) VALUES (4, 100, 1, 1);
INSERT INTO tickets(id_ticket, sold_price, id_theater, id_show) VALUES (5, 100, 1, 1);
INSERT INTO tickets(id_ticket, sold_price, id_theater, id_show) VALUES (6, 100, 1, 1);
INSERT INTO tickets(id_ticket, sold_price, id_theater, id_show) VALUES (7, 100, 1, 1);
INSERT INTO tickets(id_ticket, sold_price, id_theater, id_show) VALUES (8, 100, 1, 1);
INSERT INTO tickets(id_ticket, sold_price, id_theater, id_show) VALUES (9, 100, 1, 1);
INSERT INTO tickets(id_ticket, sold_price, id_theater, id_show) VALUES (10, 100, 1, 1);
INSERT INTO tickets(id_ticket, sold_price, id_theater, id_show) VALUES (11, 100, 2, 2);

-- subvention table
INSERT INTO subventions(id_subvention, id_theater, sub_date, sender, credited, amount) VALUES (1, 1, '15-11-2022', 'town', 'F', 1000.00);
INSERT INTO subventions(id_subvention, id_theater, sub_date, sender, credited, amount) VALUES (2, 1, '01-01-2022', 'state', 'F', 80000.00);
INSERT INTO subventions(id_subvention, id_theater, sub_date, sender, credited, amount) VALUES (3, 1, '01-01-2022', 'other', 'F', 10000.00);
INSERT INTO subventions(id_subvention, id_theater, sub_date, sender, credited, amount) VALUES (4, 2, '15-11-2022', 'town', 'F', 1000.00);
INSERT INTO subventions(id_subvention, id_theater, sub_date, sender, credited, amount) VALUES (5, 2, '01-01-2022', 'state', 'F', 80000.00);
INSERT INTO subventions(id_subvention, id_theater, sub_date, sender, credited, amount) VALUES (6, 3, '15-11-2022', 'town', 'F', 1000.00);
INSERT INTO subventions(id_subvention, id_theater, sub_date, sender, credited, amount) VALUES (7, 3, '01-01-2022', 'state', 'F', 80000.00);