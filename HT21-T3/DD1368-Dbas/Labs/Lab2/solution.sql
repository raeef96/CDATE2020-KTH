-- 1)
SELECT author, title FROM Book_Author
NATURAL JOIN
Book
WHERE PhysicalBook_ID = 11;

-- 2)
SELECT Title, Date_Of_Publish AS Published FROM published_book
WHERE Date_Of_Publish > '2000-01-01'
ORDER BY Date_Of_Publish;

--3)
select count(physicalbook_ID) from (select physicalBook_ID
from borrowed_book
except
select physicalBook_ID from borrowed_book
where return_date <= current_date) AS Currently_borrowed;

-- 4)
select sum(fine_amount) from (select* from transaction_information
natural join borrowed_book
natural join fine) AS paid_fines;

-- 5) 
select title, author, genre, language from Book_author
natural join
Book_genre
natural join book
order by genre;


-- 6)
select title, fine_amount, first_name, last_name, borrowing_ID from (select* from book
natural join (select* from student
natural join (select* from borrowed_book
natural join (select* from fine
natural join (select borrowing_ID from fine
except
select borrowing_ID from transaction_information
natural join borrowed_book natural join fine) As somthing) As somthing2) As something3) As somthing4) As Final_product;
