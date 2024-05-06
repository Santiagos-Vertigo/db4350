/*
    Final Test       CSCE 4350,  University of North Texas


    Enter your name here:




    Instructions:

    Do not type your code in a comment; the file should be able to
    run without error as a script in PSQL.

    Complete the tasks in this file, save it, test it, then upload.
    Please don't "ZIP" the file.
*/

/*
    Create a new schema named pft1 and set your searchpath..

    #1  25 points

        The objective of this section is to focus on the one-to-many
        and the many-to-many relationships.  You will need to add
        fields; however, take a mimimalist approach.  I.e.: don't
        add fields or tables unless they're required to represent
        the relationship.  Try to keep the tables as simple as possible.

        We will create a schema (or "group of logically-connected
        tables") realizing the following entities:


        Owners

        Pets  (assumably dogs)

        Tricks  (demonstrated by pets)





        Owners: An owner may be associated with zero or more pets.  (Hint: it's
        a one to many relationship.)

        The required properties of an owner are:

        fld_o_id INTEGER, PRIMARY KEY
        fld_o_name   VARCHAR(16),
        
        [Other fields may or may not be needed; if so, then add them.
         The owner name field cannot be NULL or zero length.]


        Pets: A pet has exactly one owner.  (Note: *exactly* one owner
        means no orphan records allowed.  )

        The required properties of a pet are:
        
        fld_p_id INTEGER, PRIMARY KEY
        fld_p_name   VARCHAR(16)
        
        [Other fields may or may not be needed; if so, then add them.  You do
        not need to include fields like "breed" and "color".  It is recommended
        only to add a field or fields as needed to represent the relationship.
        
        The pet name field cannot be NULL or zero length.]

        A pet may perform zero or more tricks; a trick may be performed by
        zero or more pets.  (Hint: this is a many to many relationship.)




        The required properties of a trick are:
        
        fld_t_id INTEGER, PRIMARY KEY
        fld_t_name   VARCHAR(16)
        
        -- ***
        fld_t_proficiency INTEGER DEFAULT 0
        
        [Other fields may or may not be needed; if so, then add them.
         The trick name field cannot be NULL or zero length.]

        [Other *tables* may or may not be needed; if so, then add them.]


        Grading Points
        
        All constraints must be named:
            -- Examples of named constraints:
            CREATE TABLE foo
            (
                fee VARCHAR(16),
                fie CHAR(1),
                foe INTEGER,
                fum BOOLEAN,
                --
                CONSTRAINT foo_PK PRIMARY KEY(fee),
                CONSTRAINT no_null_fie CHECK(fie IS NOT NULL),
                CONSTRAINT valid_foe CHECK(foe >= 0),
                CONSTRAINT fum_FK FOREIGN KEY(fum) REFERENCES baz(fum)
            );
            
            -- Examples of In-Line constraints that lose points:
            CREATE TABLE quux
            (
                fee VARCHAR(16) PRIMARY KEY,
                fie CHAR(1) NOT NULL,
                foe INTEGER CHECK >=0,
                fum BOOLEAN REFERENCES baz(fum)
            );
            
            Demonstrate attention to format, naming conventions and coding conventions
            used by the class this semester.
*/

    CREATE SCHEMA IF NOT EXISTS pft1;
    
    SET SEARCH_PATH TO pft1;
    
    
    DROP TABLE IF EXISTS tbl_pets_tricks;
    DROP TABLE IF EXISTS tbl_tricks;
    DROP TABLE IF EXISTS tbl_pets;
    DROP TABLE IF EXISTS tbl_owners;

    CREATE TABLE tbl_owners
    (
        fld_o_id    INTEGER,
        fld_o_name  VARCHAR(16),
        --
        CONSTRAINT owner_PK PRIMARY KEY(fld_o_id),
        CONSTRAINT null_oname CHECK(fld_o_name IS NOT NULL),
        CONSTRAINT empty_oname CHECK(LENGTH(fld_o_name)>0)
        -- See other option below.
    );
    
    
    CREATE TABLE tbl_pets
    (
        fld_p_id    INTEGER,
        fld_p_name  VARCHAR(16),
        fld_o_id    INTEGER,
        --
        CONSTRAINT pet_PK PRIMARY KEY(fld_p_id),
        CONSTRAINT valid_pname CHECK( 
                                        (fld_p_name IS NOT NULL) 
                                                AND 
                                        (LENGTH(fld_p_name)>0)
                                     ),
        -- can be done thus, but the parenthese are tricky
        --
        CONSTRAINT pet_FK1 FOREIGN KEY(fld_o_id) REFERENCES tbl_owners(fld_o_id)
    );
    
    
    CREATE TABLE tbl_tricks
    (
        fld_t_id    INTEGER,
        fld_t_name  VARCHAR(16),
        --
        CONSTRAINT tricks_PK  PRIMARY KEY(fld_t_id),
        CONSTRAINT null_tname CHECK(fld_t_name IS NOT NULL),
        CONSTRAINT empty_tname CHECK(LENGTH(fld_t_name)>0)
    );
    
    
    CREATE TABLE tbl_pets_tricks
    (
        fld_p_id    INTEGER,
        fld_t_id    INTEGER,
        fld_t_proficiency INTEGER DEFAULT 0,
        --
        CONSTRAINT pets_tricks_PK PRIMARY KEY(fld_p_id, fld_t_id),
        -- A multi-field PK is not desirable, but possible depending
        -- on your specific needs.  Another option is to create a new
        -- PK field and:
        -- CONSTRAINT unique_Pair UNIQUE(fld_p_id, fld_t_id), and both
        -- not null, etc.
        --
        -- If we use a two-field PK, neither can possibly be null.
        --
        CONSTRAINT pt_FK1 FOREIGN KEY(fld_p_id) REFERENCES tbl_pets(fld_p_id),
        CONSTRAINT pt_FK2 FOREIGN KEY(fld_t_id) REFERENCES tbl_tricks(fld_t_id)
    );


/*
    #2  23 Points

    Insert records into the tables using field lists in the INSERT statements:

    tbl_owners:

    id     name   
    1       Al
    2       Betty
    3       Chas
    
    tbl_pets"
    
    id      name
    1       Spot       owned by Betty
    2       Phydeaux   owned by Betty
    3       Fifi       owned by Al
   
    tbl_tricks:
    
    id      name
    1       Roll Over
    2       Speak
    3       Fetch
    
    Insert the following relationships:
    
    Speak applies to Phydeaux, proficiency = 2
    Fetch applies to Spot, proficiency = 3
    Roll Over applies to Phydeaux, proficiency = 1
    Speak applies to Fifi, proficiency = 2
 

    Write your code after the close of the comment:
*/

    INSERT INTO tbl_owners(fld_o_id, fld_o_name)
    VALUES  (1, 'Al'),
            (2, 'Betty'),
            (3, 'Chas'); 
    -- Individual statements OK, see next:
    
    -- ----------------------------------------
    
    INSERT INTO tbl_pets(fld_p_id, fld_p_name, fld_o_id)
    VALUES  (1, 'Spot', 2);
    
    INSERT INTO tbl_pets(fld_p_id, fld_p_name, fld_o_id)
    VALUES  (2, 'Phydeaux', 2);
    
    INSERT INTO tbl_pets(fld_p_id, fld_p_name, fld_o_id)
    VALUES  (3, 'Fifi', 1);
    
    -- --------------------------------------------
    
    INSERT INTO tbl_tricks(fld_t_id, fld_t_name)
    VALUES  (1, 'Roll Over'),
            (2, 'Speak'),
            (3, 'Fetch');
            
    -- -------------------------------------------
    
    INSERT INTO tbl_pets_tricks(fld_p_id, fld_t_id, fld_t_proficiency)
    VALUES  (2, 2, 2),
            (3, 1, 3),
            (1, 2, 1),
            (2, 3, 2);


/*
    #3  24 points (8 points each)
    
    Write a query that will return all fields of any record in tbl_owners
    that do not own a pet.  (Childless parent query.)
*/
    SELECT o.*
    FROM tbl_owners AS o LEFT OUTER JOIN tbl_pets AS p
        ON o.fld_o_id = p.fld_o_id
    WHERE p.fld_o_id IS NULL;
/*
    
    Write a query that will return all fields of any record in tbl_pets
    where the parent record is not in tbl_owners.  (Invalid parent query.)
*/
    ALTER TABLE tbl_pets DISABLE TRIGGER ALL; -- turn off the checks.
    
    INSERT INTO tbl_pets(fld_p_id, fld_p_name, fld_o_id)
    VALUES  (4, 'Bogus', -13);
    
    ALTER TABLE tbl_pets ENABLE TRIGGER ALL; -- turn off the checks.
    -- Now, we have an invalid FK.  (Not a good idea in practice!)
    -- The validity of your code is independent of the data in the table!!!
    -- I.e.: you don't have to insert bad data
    
    SELECT p.*
    FROM tbl_owners AS o RIGHT OUTER JOIN tbl_pets AS p
        ON o.fld_o_id = p.fld_o_id
    WHERE o.fld_o_id IS NULL;
/*
    
    Based on the data in the cap schema, create a VIEW named view_customer_agent that 
    will show all customer/agent *name* pairs (only cname and aname).
    --
    Test your view.  (I have 17 rows in mine.  Yours may vary if we have 
    different data sets.
*/
    SET SEARCH_PATH TO cap;
    
    DROP VIEW IF EXISTS view_customer_agent;
    
    CREATE VIEW view_customer_agent AS
    (
        SELECT cname, aname
        FROM tbl_customers AS c INNER JOIN tbl_orders AS o
            ON c.cid = o.cid INNER JOIN tbl_agents AS a
                ON o.aid = a.aid
    );




/*
    #4  28 points (14 points each)
 -- Connect to the edu database.

    Which state (Geo_STUSAB) has the greatest number of people with 
    a 7th grade education? (ACS18_5yr_B15003011)  Show state and number.
    
    (Hint: to get the number of 7th grade education calls for a 
    SUM(ACS18_5yr_B15003011) To find the greatest of these requires 
    a MAX function.  Thus, you're finding MAX( SUM(ACS18_5yr_B15003011) ),
    but we can't nest aggregate functions.  This hint should point you in
    the right direction.
*/

    -- First, I will answer: List all states & the number of 7th grade:
    SET SEARCH_PATH TO edu;

    SELECT Geo_STUSAB, SUM(ACS18_5yr_B15003011) AS s
    FROM B15003
    GROUP BY Geo_STUSAB;
    
    /*
        Now, treat that as a table and find the maximum of S
        Like:
        
            SELECT name, score
            FROM t
            WHERE score IN
            (
                SELECT MAX(score)
                FROM t
            );
    */
    
    SELECT Geo_STUSAB, s
    FROM
    (
        SELECT Geo_STUSAB, SUM(ACS18_5yr_B15003011) AS s
        FROM B15003
        GROUP BY Geo_STUSAB
    ) AS d
    WHERE s IN
    (
        SELECT MAX(s)
        FROM
        (
            SELECT Geo_STUSAB, SUM(ACS18_5yr_B15003011) AS s
            FROM B15003
            GROUP BY Geo_STUSAB
        ) AS d
    );
    
    
    
/*    
    In each state, which counties (Geo_QNAME) have a number of people with 
    a 7th grade education, ACS18_5yr_B15003011, greater that the average for 
    that state.  Show state, county, & number.
    
    (This is the classic signature of a correlated subquery.  Remember: when
    comparing a number to a table, use > [or <] ALL.)
*/

    SELECT Geo_STUSAB, Geo_QNAME, ACS18_5yr_B15003011
    FROM B15003 AS outside
    WHERE ACS18_5yr_B15003011 > ALL
    (
        SELECT AVG(ACS18_5yr_B15003011)
        FROM B15003
        WHERE Geo_STUSAB = outside.Geo_STUSAB
    )
    ORDER BY Geo_STUSAB, Geo_QNAME;
/*
    To test it, pick a state (Vermont, for example) with
    few counties in the query output... VT has eight.  Print the avg:
*/
    SELECT AVG(ACS18_5yr_B15003011)
    FROM B15003
    WHERE Geo_STUSAB = 'vt';

    -- Now, add the 'vt' criterion to the correlated subquery:
    SELECT Geo_STUSAB, Geo_QNAME, ACS18_5yr_B15003011
    FROM B15003 AS outside
    WHERE ACS18_5yr_B15003011 > ALL
    (
        SELECT AVG(ACS18_5yr_B15003011)
        FROM B15003
        WHERE Geo_STUSAB = outside.Geo_STUSAB
    )
    AND Geo_STUSAB = 'vt' -- like this!
    ORDER BY Geo_STUSAB, Geo_QNAME;
    
    
    
    -- Some texts will teach this as:
    SELECT Geo_STUSAB, Geo_QNAME, ACS18_5yr_B15003011
    FROM B15003 AS outside
    WHERE ACS18_5yr_B15003011 > ALL
    (
        SELECT AVG(ACS18_5yr_B15003011)
        FROM B15003 AS inside
        WHERE inside.Geo_STUSAB = outside.Geo_STUSAB
    )
    ORDER BY Geo_STUSAB, Geo_QNAME;
    -- But renaming the table in the inner query is optional.
    -- The reference to Geo_STUSAB in the inner query defaults
    -- to the local table, so it doesn't have to be renamed.
    --
    -- The "> ALL" is required because the left side of the
    -- inequality is a number and the right side is a table.
    -- If you don't use "ALL", SQL will coerce the variables;
    -- however, this is sloppy programming practice.
 
/*
    Create tables with 1 --> many relationship
    Create tables with many --> many relationship
    
    Insert Data
    
    Inner join
    
    Outer Join  Childless Parent
                Bogus Parent
           
    Create View
    
    Derived Table
    
    Correlated Subquery
