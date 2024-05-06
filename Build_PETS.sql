DROP SCHEMA IF EXISTS pets CASCADE;
CREATE SCHEMA IF NOT EXISTS pets;

SET SEARCH_PATH TO pets;

DROP TABLE IF EXISTS tbl_pets_tricks;
DROP TABLE IF EXISTS tbl_tricks;
DROP TABLE IF EXISTS tbl_pets;
DROP TABLE IF EXISTS tbl_owners;

DO $$
BEGIN
    CREATE TABLE tbl_owners
    (
        fld_o_id    INTEGER,
        fld_o_name  VARCHAR(16),
        CONSTRAINT owner_PK PRIMARY KEY(fld_o_id),
        CONSTRAINT null_oname CHECK(fld_o_name IS NOT NULL),
        CONSTRAINT empty_oname CHECK(LENGTH(fld_o_name)>0)
    );

    CREATE TABLE tbl_pets
    (
        fld_p_id    INTEGER,
        fld_p_name  VARCHAR(16),
        fld_o_id    INTEGER,
        CONSTRAINT pet_PK PRIMARY KEY(fld_p_id),
        CONSTRAINT valid_pname CHECK( 
            (fld_p_name IS NOT NULL) 
            AND 
            (LENGTH(fld_p_name)>0)
        ),
        CONSTRAINT pet_FK1 FOREIGN KEY(fld_o_id) REFERENCES tbl_owners(fld_o_id)
    );

    CREATE TABLE tbl_tricks
    (
        fld_t_id    INTEGER,
        fld_t_name  VARCHAR(16),
        CONSTRAINT tricks_PK  PRIMARY KEY(fld_t_id),
        CONSTRAINT null_tname CHECK(fld_t_name IS NOT NULL),
        CONSTRAINT empty_tname CHECK(LENGTH(fld_t_name)>0)
    );

    CREATE TABLE tbl_pets_tricks
    (
        fld_p_id    INTEGER,
        fld_t_id    INTEGER,
        fld_t_proficiency INTEGER DEFAULT 0,
        CONSTRAINT pets_tricks_PK PRIMARY KEY(fld_p_id, fld_t_id),
        CONSTRAINT pt_FK1 FOREIGN KEY(fld_p_id) REFERENCES tbl_pets(fld_p_id),
        CONSTRAINT pt_FK2 FOREIGN KEY(fld_t_id) REFERENCES tbl_tricks(fld_t_id)
    );

    INSERT INTO tbl_owners(fld_o_id, fld_o_name)
    VALUES  (1, 'Al'),
            (2, 'Betty'),
            (3, 'Chas'); 

    INSERT INTO tbl_pets(fld_p_id, fld_p_name, fld_o_id)
    VALUES  (1, 'Spot', 2),
            (2, 'Phydeaux', 2),
            (3, 'Fifi', 1);

    INSERT INTO tbl_tricks(fld_t_id, fld_t_name)
    VALUES  (1, 'Roll Over'),
            (2, 'Speak'),
            (3, 'Fetch');

    INSERT INTO tbl_pets_tricks(fld_p_id, fld_t_id, fld_t_proficiency)
    VALUES  (2, 2, 2),
            (3, 1, 3),
            (1, 2, 1),
            (2, 3, 2);

    RAISE NOTICE E'\n\t\tPETS Creation Successful.';
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE E'\n\t\tErrors Detected:  %,  %', SQLERRM, SQLSTATE;
END $$ LANGUAGE plpgsql;

RESET SEARCH_PATH;

            

    SELECT o.*
    FROM tbl_owners AS o LEFT OUTER JOIN tbl_pets AS p
        ON o.fld_o_id = p.fld_o_id
    WHERE p.fld_o_id IS NULL;

    ALTER TABLE tbl_pets DISABLE TRIGGER ALL; -- turn off the checks.
    
    INSERT INTO tbl_pets(fld_p_id, fld_p_name, fld_o_id)
    VALUES  (4, 'Bogus', -13);
    
    ALTER TABLE tbl_pets ENABLE TRIGGER ALL; -- turn off the checks.
    
    SELECT p.*
    FROM tbl_owners AS o RIGHT OUTER JOIN tbl_pets AS p
        ON o.fld_o_id = p.fld_o_id
    WHERE o.fld_o_id IS NULL;



