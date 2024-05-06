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



/*
    #3  24 points (8 points each)
    
    Write a query that will return all fields of any record in tbl_owners
    that do not own a pet.  (Childless parent query.)
*/

/*
    
    Write a query that will return all fields of any record in tbl_pets
    where the parent record is not in tbl_owners.  (Invalid parent query.)
*/

/*
    
    Based on the data in the cap schema, create a VIEW named view_customer_agent that 
    will show all customer/agent *name* pairs (only cname and aname).
    --
    Test your view.  (I have 17 rows in mine.  Yours may vary if we have 
    different data sets.
*/
 




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


    
    
    
/*    
    In each state, which counties (Geo_QNAME) have a number of people with 
    a 7th grade education, ACS18_5yr_B15003011, greater that the average for 
    that state.  Show state, county, & number.
    
    (This is the classic signature of a correlated subquery.  Remember: when
    comparing a number to a table, use > [or <] ALL.)
*/

 
 
/*
    Thus, the final will look like this.
    
    Here is the practice test.  I will release the answer key
    on Monday in class.  I will also discuss the test at length.
    
    Create tables with 1 --> many relationship
    Create tables with many --> many relationship
    
    Insert Data
    
    Inner join
    
    Outer Join  Childless Parent
                Bogus Parent
           
    Create View
    
    Derived Table
    
    Correlated Subquery
