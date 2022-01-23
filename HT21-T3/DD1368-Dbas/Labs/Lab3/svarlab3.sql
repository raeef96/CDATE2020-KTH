--1--
select count(transactionid) As septemperfines from (select* from fines
natural join
transactions) As allfines where paymentmethod = 'Card' and DoP >= '2021-09-01' and Dop < '2021-10-1';
--2--
select* from (select name, sum(pages) from (students natural join borrowing
natural join resources
natural join books
natural join Users)
where DoR IS NOT NULL
group by name) As Something
order by sum desc fetch first row only;
--3--
select title from ( select physicalid, title from resources natural join books
except
select physicalid, title from books
natural join resources
natural join borrowing
where dor is null) As something
where title LIKE 'S%s' or title  LIKE 'H%s';
--4--
select title , genre , rank from ( select title , genre , 
 rank() over(partition by genre order by dob) rank from books
natural join resources
natural join borrowing
natural join genre) AS something
where rank <= 3;
--5--
with A AS(select program , sum from (select program, SUM(amount) AS sum
from fines natural join borrowing
natural join students
group by program
order by sum desc) AS something)
select * ,  ((sum * 100) / SUM(sum) OVER ()) AS percent from A ;
--6--
select title,genre, rank from
(select * , rank() over(partition by genre order by dob) rank 
from books
natural join resources
natural join borrowing
natural join genre) AS something
where genre = 'RomCom'
fetch first 3 row only;
--7--

select (select sum(late) from ( select title , count(dob) AS late
from
books natural join resources
natural join borrowing
where dor > doe and (title ='Discovery of India' or title =' New Markets & Other Essays' or title ='Phantom of Manhattan' or
 title ='Pattern Classification' or title ='India from Midnight to Milennium'
  or title = 'Deceiver' or title = 'Trial')
group by title
order by late desc ) AS something2)
/
(select sum(mostpop) from (select title AS topten , count(dob) AS mostpop  from
books natural join resources
natural join borrowing
group by title
order by mostpop desc
fetch first 7 row only) AS something) AS likelihood;

--8--
WITH bookstatuses AS (
    SELECT COUNT(DoB) AS borrowed, 
        date_part('week', DoB::date) AS week
        FROM Borrowing
        WHERE (DoB > '2020-12-31' AND DoB < '2021-07-07')
        GROUP BY (week)
        ORDER BY week ASC
),
    bookreturned AS (
        SELECT COUNT(DoR) AS returned,
        date_part('week', DoB::date) AS week
        FROM Borrowing
        WHERE (DoR > '2020-12-31' AND DoR < '2021-07-01' AND DoR is NOT NULL)
        GROUP BY (week)
        ORDER BY week ASC
    ),

    latebook AS (
        SELECT COUNT(DoR) AS late,
        date_part('week', DoB::date) AS week
        FROM Borrowing
        WHERE (DoR > DoE AND DoB > '2020-12-31' AND DoB < '2021-07-01')
        GROUP BY (week)
        ORDER BY week ASC
    ),

    joins AS (
        SELECT bookstatuses.week, bookstatuses.borrowed, bookreturned.returned
        FROM bookstatuses
        INNER JOIN bookreturned USING (week)
    ),

    joins2 AS (
        SELECT joins.week, joins.borrowed, joins.returned, latebook.late
        FROM joins
        INNER JOIN latebook USING (week)
    )
SELECT * FROM joins2;

--9-- 
with recursive rec AS (
    SELECT pre.preTitle, bok.bookTitle
    FROM Prequels
    INNER JOIN (
        SELECT title AS PreTitle, bookid
        FROM Books) pre ON (Prequels.prequelID = pre.BookID)
    INNER JOIN (
        SELECT title AS BookTitle, bookid
        FROM Books) bok ON (Prequels.BookID = bok.BookID)
),
   rec2 AS (
      SELECT b.preTitle, b.bookTitle, b.preTitle || ' -> ' || b.bookTitle AS path
       FROM rec b
       WHERE NOT EXISTS (SELECT 1 FROM rec b2 WHERE b2.bookTitle = b.preTitle)
       UNION ALL
       SELECT rec2.preTitle, b.bookTitle, path || ' -> ' || b.bookTitle
       FROM rec2 INNER JOIN
            rec b
            ON rec2.bookTitle = b.preTitle
      
      )
SELECT distinct ON (preTitle) path AS series
FROM rec2;

