_

DROP SCHEMA IF EXISTS CAP CASCADE;

CREATE SCHEMA CAP;
SET SEARCH_PATH TO CAP;
DO $GO$
BEGIN
    DROP TABLE IF EXISTS tbl_Orders; 
    DROP TABLE IF EXISTS tbl_ProductSupplier;
    DROP TABLE IF EXISTS tbl_Suppliers;
    DROP TABLE IF EXISTS tbl_Products;
    DROP TABLE IF EXISTS tbl_Agents;
    DROP TABLE IF EXISTS tbl_Customers;


    CREATE TABLE tbl_Customers
    (
        cid CHAR(4),
        cname VARCHAR(13),
        city VARCHAR(20),
        cdiscnt NUMERIC(4,2),
        CONSTRAINT cpk PRIMARY KEY(cid),
        CONSTRAINT cReasonableDiscount CHECK(cdiscnt>=0 AND cdiscnt<100)
    );


    CREATE TABLE tbl_Agents
    (
        aid CHAR(3),
        aname VARCHAR(13),
        acity VARCHAR(20),
        apercent SMALLINT,
        CONSTRAINT apk PRIMARY KEY (aid)
    );

    CREATE TABLE tbl_Products
    (
        pid CHAR(3),
        pname VARCHAR(13),
        city VARCHAR(20),
        quantity INTEGER,
        price MONEY,
        CONSTRAINT ppk PRIMARY KEY(pid)
    );


    CREATE TABLE tbl_Suppliers
    (
        sid CHAR(3),
        sname VARCHAR(24),
        CONSTRAINT spk PRIMARY KEY(sid),
        CONSTRAINT null_sname CHECK( sname IS NOT NULL )
    );

    CREATE TABLE tbl_ProductSupplier
    (
        -- might have its own PK
        pid CHAR(3),
        sid CHAR(3),
        CONSTRAINT ps_PK PRIMARY KEY(pid, sid), -- neither may be NULL, UNIQUE as a pair
        CONSTRAINT pid_FK FOREIGN KEY(pid) REFERENCES tbl_Products(pid),
        CONSTRAINT sid_FK FOREIGN KEY(sid) REFERENCES tbl_Suppliers(sid)
    );


    CREATE TABLE tbl_Orders
    (
        ordno INTEGER,
        o_month CHAR(3),
        cid CHAR(4),
        aid CHAR(3),
        pid CHAR(3),
        o_qty INTEGER,
        o_dollars MONEY,
        CONSTRAINT opk PRIMARY KEY(ordno),
        CONSTRAINT cfk FOREIGN KEY(cid) REFERENCES tbl_Customers(cid),
        CONSTRAINT afk FOREIGN KEY(aid) REFERENCES tbl_Agents(aid),
        CONSTRAINT pfk FOREIGN KEY(pid) REFERENCES tbl_Products(pid)
    );


    INSERT INTO tbl_Customers(cid, cname, city, cdiscnt)
    VALUES  ( 'c001','Tiptop','Duluth',10.00),
            ('c002','Basics','Dallas',12.00),
            ('c003','Allied','Dallas',8.00),
            ('c004','ACME','Duluth',8.00),
            ('c005','Ace','Denton', 10.00),
            ('c006','ACME','Kyoto',0.00);


    INSERT INTO tbl_Agents(aid, aname,  acity,  apercent)
    VALUES  (   'a01','Smith','New York',6  ),
            (   'a02','Jones','Newark',6    ),
            (   'a03','Brown','Tokyo',7     ),
            (   'a04','Gray','New York',6   ),
            (   'a05','Otasi','Duluth',5    ),
            (   'a06','Smith','Dallas',5    );


    INSERT INTO tbl_Products(pid,   pname,  city,   quantity,   price)
    VALUES  (   'p01','comb','Dallas',111400,0.50   ),
            (   'p02','brush','Newark',203000,0.50  ),
            (   'p03','razor','Duluth',150600,1.00  ),
            (   'p04','pen','Duluth',125300,1.00    ),
            (   'p05','pencil','Dallas',221400,1.00 ),
            (   'p06','folder','Dallas',123100,2.00 ),
            (   'p07','case','Newark',100500,1.00   ),
            (   'p08','floppy','Tulsa',150995, 1.00 );

    
    INSERT INTO tbl_Suppliers( sid, sname )
    VALUES  (   's01', 'Alpha Supply' ),
            (   's02', 'Beta Supply' ),
            (   's03', 'Gamma Supply' ),
            (   's04', 'Delta Supply' ),
            (   's05', 'Epsilon Supply' ),
            (   's06', 'Lambda Supply' ),
            (   's07', 'Zeta Supply' );
            
            
    ALTER TABLE tbl_ProductSupplier DISABLE TRIGGER ALL;
    INSERT INTO tbl_ProductSupplier( pid, sid )
    VALUES  (   'p02', 's05' ),
            (   'p02', 's03' ),
            (   'p01', 's07' ),
            (   'p03', 's01' ),
            (   'p06', 's02' ),
            (   'p08', 's03' ),
            (   'p04', 's06' ),
            (   'p02', 's06' ),
            (   'p07', 's03' ),
            (   'p09', 's08' );
    ALTER TABLE tbl_ProductSupplier ENABLE TRIGGER ALL;
    

    ALTER TABLE tbl_Orders DISABLE TRIGGER ALL;

    INSERT INTO tbl_Orders( ordno,  o_month,    cid,    aid,    pid,    o_qty,  o_dollars )
    VALUES  (   1011,'jan','c001','a01','p01',1000,450.00   ),
            (   1012,'jan','c001','a01','p01',1000,450.00   ),
            (   1019,'feb','c001','a02','p02',400,180.00    ),
            (   1017,'feb','c001','a06','p03',600,540.00    ),
            (   1018,'feb','c001','a03','p04',600,540.00   ),
            (   1023,'mar','c001','a04','p05',500,450.00   ),
            (   1022,'mar','c001','a05','p06',400,720.00   ),
            (   1025,'apr','c001','a05','p07',800,720.00   ),
            (   1013,'jan','c002','a03','p03',1000,880.00   ),
            (   1026,'may','c002','a05','p03',800,704.00   ),
            (   1015,'jan','c003','a03','p05',1200,1104.00   ),
            (   1014,'jan','c003','a03','p05',1200,1104.00   ),
            (   1021,'feb','c004','a06','p01',1000,460.00   ),
            (   1016,'jan','c006','a01','p01',1000,500.00   ),
            (   1020,'feb','c006','a03','p07',600,600.00   ),
            (   1024,'mar','c006','a06','p01',800,400.00   ),
            (   1027,'feb','c004','a02','p99',800,720.00    );

    ALTER TABLE tbl_Orders ENABLE TRIGGER ALL;
    

    RAISE NOTICE E'\n\t\tCAP Creation Successful.';
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE E'\n\t\tErrors Detected:  %,  %', SQLERRM, SQLSTATE;
END $GO$ LANGUAGE plpgsql;

RESET SEARCH_PATH;
