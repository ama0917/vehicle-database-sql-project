
CREATE SCHEMA IF NOT EXISTS mt2;
SET SEARCH_PATH TO mt2;

DROP TABLE IF EXISTS tbl_owners;

CREATE TABLE tbl_owners
(
   SSN CHAR(9),
   f_name VARCHAR(50),
   m_initial VARCHAR(1),
   l_name VARCHAR(50),
   address VARCHAR(100),
   city VARCHAR(50),
   state VARCHAR(2),
   phone VARCHAR(20),
   dob DATE,
   --
   CONSTRAINT tbl_owners_pk PRIMARY KEY(SSN),
   CONSTRAINT tbl_owners_first_null CHECK(f_name IS NOT NULL),
   CONSTRAINT tbl_owners_last_null CHECK(l_name IS NOT NULL),
   CONSTRAINT tbl_owners_address_null CHECK(address IS NOT NULL),
   CONSTRAINT tbl_owners_city_null CHECK(city IS NOT NULL),
   CONSTRAINT tbl_owners_state_null CHECK(state IS NOT NULL),
   CONSTRAINT tbl_owners_phone_null CHECK(phone IS NOT NULL),
   CONSTRAINT tbl_owners_dob_null CHECK(dob IS NOT NULL)
);

DROP TABLE IF EXISTS tbl_autos;

CREATE TABLE tbl_autos
(
   VIN CHAR(256),
   make VARCHAR(30),
   model VARCHAR(30),
   color VARCHAR(3),
   owner_SSN CHAR(9),
   --
   CONSTRAINT tbl_autos_pk PRIMARY KEY(VIN),
   CONSTRAINT tbl_autos_fk FOREIGN KEY(owner_SSN)
      REFERENCES tbl_owners(SSN),
   CONSTRAINT tbl_autos_color_check CHECK (Color IN ('BLU', 'MAR', 'YEL', 'SIL', 'PLE', 
                                          'ONG', 'GRN','GRY', 'PNK', 'TAN', 'BRO', 'BLK',
                                          'RED', 'GLD', 'BGE', 'WHI')),
   CONSTRAINT tbl_autos_owner_null CHECK(owner_SSN IS NOT NULL),
   CONSTRAINT tbl_autos_model_null CHECK(model IS NOT NULL),
   CONSTRAINT tbl_autos_make_null CHECK(make IS NOT NULL)
);

INSERT INTO tbl_owners(SSN, f_name, m_initial, l_name, address, city, state, phone, dob)
VALUES ( '7722','Al','B','Jones','123 4th','Denton','TX','3951243','1993-11-21'),
       ( '9805','Bob','A','Roberts','234 5th','Denton','TX','8173452','2001-09-11'),
       ( '3426','Connie','G','Smith','345 6th','Plano','TX','8173566','1999-03-16'),
       ( '9871','Dale','O','Evans','456 7th','Dallas','TX','8172217','1989-01-27');


INSERT INTO tbl_autos(VIN, make, model, color, owner_SSN)
VALUES ( '7635','Ford','Ranger','RED','9805'),
       ( '76A3','Toyota','Corolla','TAN','9805'),
       ( '2B9X','Ford','Mustang','BLK','9871'),
       ( '5301','VW','Golf','GRN','3426');


RESET SEARCH_PATH;
SET SEARCH_PATH TO cap;

SELECT c.cname, o.cid, o.pid
FROM tblorders AS o INNER JOIN tblcustomers AS c
ON o.cid = c.cid
WHERE o.pid='p02';

SELECT c.cname, o.cid, p.pname
FROM tblorders AS o INNER JOIN tblcustomers AS c
ON o.cid = c.cid
INNER JOIN tblproducts AS p
ON o.pid=p.pid
WHERE p.pname='brush';


SELECT o.pid, COUNT(*) AS order_count
FROM tblorders AS o
WHERE o.pid = 'p05'
GROUP BY o.pid;

SELECT p.pname, COUNT(*) AS pencil_count
FROM tblorders AS o INNER JOIN tblproducts AS p
ON o.pid = p.pid
WHERE p.pname = 'pencil'
GROUP BY p.pname;

SELECT o.o_month, COUNT(*) AS pencil_count
FROM tblorders AS o INNER JOIN tblproducts AS p
ON o.pid = p.pid
WHERE p.pname = 'pencil'
GROUP BY o.o_month;

SELECT pid, pname, quantity
FROM tblproducts
WHERE quantity = (
   SELECT MAX(quantity)
   FROM tblproducts
);

RESET SEARCH_PATH;
SET SEARCH_PATH TO mt2;

SELECT o.SSN, o.f_name, o.m_initial, o.l_name
FROM tbl_owners AS o LEFT OUTER JOIN tbl_autos AS a
   ON o.SSN = a.owner_SSN
WHERE a.owner_SSN IS NULL; 