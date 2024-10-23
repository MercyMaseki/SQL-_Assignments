Use June_class;
SELECT * FROM Newyork;
SELECT * FROM Chicago;
SELECT * FROM LosAngeles;
SELECT * FROM Washington;

-- Create a table called Washington--
CREATE TABLE Washington ( 
ID INT Primary Key,
Name VARCHAR(10),
Age INT,
INDUSTRY VARCHAR(100));
SELECT * FROM Washington;
INSERT INTO Washington (ID,Name,Age,Industry)
VALUES
(1,'Kamau',40,'Mechanic'),
(2,'Joshua',50,'Engineer');

DROP TABLE Washington;
SELECT * FROM Washington;
-- ALTER  the table  this is for adding a new column-- 
ALTER TABLE Washington
ADD Adress VARCHAR(255);

UPDATE Washington
set adress = 'Hemisphere , Ave RD , 1d45'
where ID = 2;

-- Since the Washington table was dropped we are not able to add it back-- so we need to create it again
CREATE TABLE Washington ( 
ID INT Primary Key,
Name VARCHAR(10),
Age INT,
INDUSTRY VARCHAR(100));
SELECT * FROM Washington;
INSERT INTO Washington (ID,Name,Age,Industry)
VALUES
(1,'Kamau',40,'Mechanic'),
(2,'Joshua',50,'Engineer');

INSERT INTO Washington (ID,Name,Age,Industry)
VALUES
(1,'Kamau',40,'Mechanic'),
(2,'Joshua',50,'Engineer');
UPDATE Washington
set adress = 'Hemisphere , Ave RD , 1d45'
where ID = 2;
-- ALTER  the table  this is for adding a new column-- 

SELECT * FROM Washington;
ALTER TABLE Washington
ADD Adress VARCHAR(255);
UPDATE Washington
set adress = 'Hemisphere , Ave RD , 1d45'
where ID = 2;

-- Modify - changing the size of the characters within a column-- 
ALTER TABLE washington
MODIFY Name VARCHAR(100);

ALTER TABLE washington
MODIFY  Industry  VARCHAR(250);

update Washington
set Industry  = 'XXXXxXXXXXXXXXXXXXXXXXXXXXXXXX'
where ID = 3;

update Washington
set Name = 'Joshua Kimanzi'
where ID = 2;

select *from washington;

UPDATE Washington
SET Industry = CASE 
    WHEN ID = 1 THEN 'Automotive'
    WHEN ID = 2 THEN 'Construction'
    WHEN ID = 3 THEN 'Healthcare'
    -- Add more ID cases here if needed
END
WHERE ID IN (1, 2, 3);  -- Specify the list of IDs you want to update
