-- Creating the Student table 
    CREATE TABLE Student(
        Student_ID INT PRIMARY KEY,
        First_Name VARCHAR(225) NOT NULL,
        Last_Name VARCHAR(225) NOT NULL,
        Email VARCHAR(225) NOT NULL UNIQUE,
        Program VARCHAR(225) NOT NULL,
        Adress VARCHAR(225) NOT NULL
    );
    -- Populating Student table with random data
    -- INSERT INTO Student VALUES(1,'Paula','Hanna','something1@hotmail.com', 'Computer science', 'somewher 1');
    -- INSERT INTO Student VALUES(2,'Raef','Bechara','somethineg2@gmail.com', 'Computer science', 'somewhere 2');
    -- INSERT INTO Student VALUES(3,'Sebastian','Ramic','something3@gmail.com','IT','somewhere 3');
    -- INSERT INTO Student VALUES(4,'Damiano','Velkijovic','something4@gmail.com','Medical Engineerng','somewhere 4');
    -- INSERT INTO Student VALUES(5,'Toni','Hanna','something5@gmail.com','Economy','somewhere 1');
    -- INSERT INTO Student VALUES(6,'Marcelo','Lepi','something6@gmail.com','CS','somewhere 7');
    -- INSERT INTO Student VALUES(7,'Emily','Stanly','something7@gmail.com','CS', 'somewhere 99');
    -- INSERT INTO Student VALUES(8,'Hugo','Francis','something8@gmail.com', 'CS', 'somewhere 9');
    -- INSERT INTO Student VALUES(9,'Matilda','Erikson','something9@gmail.com','CS', 'somewhere 10');
    -- INSERT INTO Student VALUES(10,'Rose','Johnson','something10@gmail.com','CS', 'somewhere 96');

    -- Creating Admins table
    --(AdminID: integer, FirstName: string, LastName: string, Email: string, Adress: string,
    --Department: string, PhoneNumber: string)  (Admin)
    CREATE TABLE Admin(
        Admin_ID INT PRIMARY KEY,
        First_Name VARCHAR(225) NOT NULL,
        Last_Name VARCHAR(225) NOT NULL,
        Email VARCHAR(225) NOT NULL UNIQUE,
        Adress VARCHAR(225) NOT NULL,
        Department VARCHAR(225) NOT NULL,
        Phone_Number VARCHAR(225) NOT NULL
    );
    -- -- ADD 5 admins
    -- INSERT INTO Admin VALUES(001,'Dena','Hussien','denahussien@hotmail.com', 'landsvägen 1', 'computer science' , '0712345678');
    -- INSERT INTO Admin VALUES(002,'Petter','bränden','petterbränden@hotmail.com', 'sveavägen 15', ' mathematics' , '0707070707');
    -- INSERT INTO Admin VALUES(003,'Anna','Jerbrant','annajerbrabt@gmail.com', 'saimagatan 12', ' economics' , '0778945625');
    -- INSERT INTO Admin VALUES(004,'David','Broman','davidbroman@yahoo.com', 'finlandsgatan 137A', ' electrical engeenering ' , '0701020304');
    -- INSERT INTO Admin VALUES(005,'Tommy','Ekola','tommyekola@outlook.se', 'malmvägen 2', 'mathematics' , '0714253689');

    -- (Pk(Title, edition), publisher, Date_Of_Publish)
    CREATE TABLE Published_Book(
        Title VARCHAR(225),
        Edition VARCHAR(225),
        Publisher VARCHAR(225) NOT NULL,
        Date_Of_Publish DATE NOT NULL,
        PRIMARY KEY(Title,Edition)
    );

    -- INSERT INTO Published_Book('Harry Potter and the philosopher stone', 'First edition', 'Blomsburry publishing' , '1997-06-26');
    -- INSERT INTO Published_Book('Lord of the rings', 'First edition', 'Allen & Unwin', '1954-07-29')
    -- INSERT INTO Published_Book()
    -- INSERT INTO Published_Book()
    -- INSERT INTO Published_Book()
    -- INSERT INTO Published_Book()
    -- INSERT INTO Published_Book()
    -- INSERT INTO Published_Book()
    -- INSERT INTO Published_Book()
    -- INSERT INTO Published_Book()



    -- (PhysicalBook_ID: Integer, Title: String, Edition: String, ISBN: String,
    --language: String, publisher: String, DateOfPublish: String)  (Book_Information)
    CREATE TABLE Book(
        PhysicalBook_ID INT PRIMARY KEY,
        Title VARCHAR(225) NOT NULL,
        Edition VARCHAR(225) NOT NULL,
        ISBN VARCHAR(225),
        Language VARCHAR(225) NOT NULL,
        FOREIGN KEY (Title,Edition) REFERENCES Published_Book(Title,Edition)
        ON DELETE CASCADE ON UPDATE CASCADE
        -- Publisher VARCHAR(225) NOT NULL,
        -- Date_Of_Publish DATE NOT NULL
    );
    -- ADD 10 books
    -- INSERT INTO Book VALUES(0001, 'Harry Potter and the philosopher stone', 'First edition' , '9780439362139' , 'English' , 'Blomsburry publishing' , '1997-06-26');
    -- INSERT INTO Book VALUES(0002, 'Lord of the rings', 'First edition' , '9780544003415' , 'English' , 'Allen & Unwin' , '1954-07-29');
    -- INSERT INTO Book VALUES(0003, 'Naruto Shippuden V15', 'First edition' , 'not given' , 'English' , 'Shūkan Shōnen Jump ' , '2008-08-15');
    -- INSERT INTO Book VALUES(0004, 'Death note V3', 'First edition' , 'not given' , 'English' , 'Shūkan Shōnen Jump' , '2004-05-17');
    -- INSERT INTO Book VALUES(0005, 'Holes', 'First edition' , '9780030664137' , 'English' , ' Farrar, Straus and Giroux' , '1998-08-20');
    -- INSERT INTO Book VALUES(0006, 'Bröderna lejonhjärta', 'First edition' , '9789129688313' , 'Svenska' , ' Rabén & Sjögren' , '2013-09-26');
    -- INSERT INTO Book VALUES(0007, 'The kite runner', 'second edition' , '9781526604736' , 'English' , ' Riverhead Books' , '2003-05-29');
    -- INSERT INTO Book VALUES(0008, 'Calculus: A Complete Course', '10th edition' , '9780135732588' , 'English' , 'Pearson Education' , '2021-05-21');
    -- INSERT INTO Book VALUES(0009, 'Dagboken - Jag sökte dig och fann mitt hjärta', 'First edition' , '9780751556896' , 'svenska' , ' Warner Books' , '1996-10-1');
    -- INSERT INTO Book VALUES(0010, 'Attack on titan v35', 'First edition' , '9781612620268' , 'English' , ' Kōdansha' , '2018-07-01');


    --(PhysicalBook_ID: integer, Damage: string) (DamagedBook)
    CREATE TABLE Damaged_Book(
        PhysicalBook_ID INT NOT NULL,
        FOREIGN KEY(PhysicalBook_ID) REFERENCES Book(PhysicalBook_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
        Damage VARCHAR(225) NOT NULL, 
        PRIMARY KEY(PhysicalBook_ID, Damage)
    );
    -- Damage status of the books
    --  INSERT INTO Damaged_Book VALUES(0002 ,'the book cover is in bad shape');
    --  INSERT INTO Damaged_Book VALUES(0002 ,'some pages are missing');
    --  INSERT INTO Damaged_Book VALUES(0005 ,'some pages are in bad shape and the content is intelligable');
    --  INSERT INTO Damaged_Book VALUES(0006 ,'pen marks on some pages');
    --  INSERT INTO Damaged_Book VALUES(0006 ,'some pages are missing');
    --  INSERT INTO Damaged_Book VALUES(0008 ,'the table of content pages are missing');

    --(PhysicalBook_ID: Integer,
    --Title : String ,  prequel : String , sequel: String) (prequels and sequels)
    CREATE TABLE Prequel_And_Sequel(
        PhysicalBook_ID INT NOT NULL,
        Title VARCHAR(225),
        PRIMARY KEY(PhysicalBook_ID, Title),
        FOREIGN KEY (PhysicalBook_ID) REFERENCES Book(PhysicalBook_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
        Prequel VARCHAR(225),
        Sequel VARCHAR(225)
    );
    -- -- prequels and sequels of the  books 
    -- INSERT INTO Prequel_And_Sequel (PhysicalBook_ID,Title,Sequel) VALUES(0001,'Harry Potter and the philosopher stone' , 'Harry Potter and the philosopher stone');
    -- INSERT INTO Prequel_And_Sequel (PhysicalBook_ID,Title,prequel) VALUES(0003, 'Naruto Shippuden V15' , 'Naruto');

    --(PhysicalBook_ID: integer, Author: string) (BookAuthor)
    CREATE TABLE Book_Author(
        PhysicalBook_ID INT NOT NULL,
        FOREIGN KEY(PhysicalBook_ID) REFERENCES Book(PhysicalBook_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
        Author VARCHAR(225) NOT NULL,
        PRIMARY KEY(PhysicalBook_ID, Author)
    );
    --  -- the authors of the 10 books 
    -- INSERT INTO Book_Author VALUES(0001 , 'JK Rowling');
    -- INSERT INTO Book_Author VALUES(0002 , 'J.R.R. Tolkien');
    -- INSERT INTO Book_Author VALUES(0003 , 'Masashi Kishimoto');
    -- INSERT INTO Book_Author VALUES(0004 , 'Tsugumi Ohba');
    -- INSERT INTO Book_Author VALUES(0004 , 'Takeshi Obata');
    -- INSERT INTO Book_Author VALUES(0005 , 'Louis Sachar');
    -- INSERT INTO Book_Author VALUES(0006 , 'Astrid Lindgren');
    -- INSERT INTO Book_Author VALUES(0007 , 'Khaled Hosseini');
    -- INSERT INTO Book_Author VALUES(0008 , 'Robert A. Adams');
    -- INSERT INTO Book_Author VALUES(0008 , 'Christopher Essex');
    -- INSERT INTO Book_Author VALUES(0009 , 'Nicholas Sparks');
    -- INSERT INTO Book_Author VALUES(0010 , 'Hajime Isayama');



    --(PhysicalBook_ID: integer, Genre: string) (BookGenre)
    CREATE TABLE Book_Genre(
        PhysicalBook_ID INT NOT NULL,
        FOREIGN KEY(PhysicalBook_ID) REFERENCES Book(PhysicalBook_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
        Genre VARCHAR(225) NOT NULL,
        PRIMARY KEY(PhysicalBook_ID, Genre)
    );
    --  -- the genres of the 10 books 
    -- INSERT INTO Book_Genre VALUES(0001 , 'fantasy');
    -- INSERT INTO Book_Genre VALUES(0001 , 'childreen book');
    -- INSERT INTO Book_Genre VALUES(0002 , 'fantasy');
    -- INSERT INTO Book_Genre VALUES(0003 , 'fantasy');
    -- INSERT INTO Book_Genre VALUES(0003 , 'anime');
    -- INSERT INTO Book_Genre VALUES(0004 , 'fantasy');
    -- INSERT INTO Book_Genre VALUES(0004 , 'crime-thriller');
    -- INSERT INTO Book_Genre VALUES(0004 , 'anime');
    -- INSERT INTO Book_Genre VALUES(0005 , 'adventure');
    -- INSERT INTO Book_Genre VALUES(0005 , 'novel');
    -- INSERT INTO Book_Genre VALUES(0006 , 'childreen book');
    -- INSERT INTO Book_Genre VALUES(0007 , 'novel');
    -- INSERT INTO Book_Genre VALUES(0007 , 'drama');
    -- INSERT INTO Book_Genre VALUES(0008 , 'education');
    -- INSERT INTO Book_Genre VALUES(0008 , 'math'); 
    -- INSERT INTO Book_Genre VALUES(0009 , 'novel');
    -- INSERT INTO Book_Genre VALUES(0009 , 'romance');
    -- INSERT INTO Book_Genre VALUES(0009 , 'adult');
    -- INSERT INTO Book_Genre VALUES(0010 , 'fantasy');
    -- INSERT INTO Book_Genre VALUES(0010 , 'anime');
    -- INSERT INTO Book_Genre VALUES(0010 , 'horror');


    --Borrowed_Book(Borrowing_ID: Integer, DateOfBorrowing: Date, ExpiringDate: Date, ReturnDate: Date, PysicalBook_ID: integer, Student_ID: integer) 
    CREATE TABLE Borrowed_Book(
        Borrowing_ID INT PRIMARY KEY,
        Date_Of_Borrowing DATE NOT NULL,
        Expiring_Date DATE NOT NULL,
        Return_Date DATE ,
        PhysicalBook_ID INT NOT NULL,
        Student_ID INT NOT NULL,
        FOREIGN KEY(PhysicalBook_ID) REFERENCES Book(PhysicalBook_ID)
        ON DELETE CASCADE ON UPDATE CASCADE, 
        FOREIGN KEY(Student_ID) REFERENCES Student(Student_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
    );
    -- -- Borrowed books that have not been returned
    -- INSERT INTO Borrowed_Book(Borrowing_ID,Date_Of_Borrowing,Expiring_Date,PhysicalBook_ID,Student_ID) VALUES(1111 ,'2021-09-15', '2021-09-22', 0001, 2 );
    -- INSERT INTO Borrowed_Book(Borrowing_ID,Date_Of_Borrowing,Expiring_Date,PhysicalBook_ID,Student_ID) VALUES(2222 ,'2021-08-15', '2021-08-22', 0010, 3);
    -- INSERT INTO Borrowed_Book(Borrowing_ID,Date_Of_Borrowing,Expiring_Date,PhysicalBook_ID,Student_ID) VALUES(3333 ,'2021-08-01', '2021-08-08', 0004, 10);
    -- INSERT INTO Borrowed_Book(Borrowing_ID,Date_Of_Borrowing,Expiring_Date,PhysicalBook_ID,Student_ID) VALUES(4444 ,'2021-07-01', '2021-07-08', 0005, 4);
    -- INSERT INTO Borrowed_Book(Borrowing_ID,Date_Of_Borrowing,Expiring_Date,PhysicalBook_ID,Student_ID) VALUES(5555 ,'2021-06-01', '2021-06-08', 0002, 6);
    -- Borrowed books that have been returned
    -- INSERT INTO Borrowed_Book VALUES(6666 , '2021-08-15', '2021-08-22' , '2021-08-20' , 0003, 1 );
    -- INSERT INTO Borrowed_Book VALUES(7777 , '2021-07-15', '2021-07-22' , '2021-07-20' , 0009, 5);
    -- INSERT INTO Borrowed_Book VALUES(8888 , '2021-06-15', '2021-06-22' , '2021-06-20' , 0006, 7);
    -- INSERT INTO Borrowed_Book VALUES(9999 , '2021-05-15', '2021-06-22' , '2021-06-20' , 0007, 8);
    -- INSERT INTO Borrowed_Book VALUES(12121 , '2021-05-15','2021-06-22' , '2021-06-20' , 0008, 9);

    --Fines(Borrowing_ID: integer, FineAmount: double) 
    CREATE TABLE Fine(
        Borrowing_ID INT NOT NULL,
        Fine_Amount DECIMAL NOT NULL, 
        FOREIGN KEY(Borrowing_ID) REFERENCES Borrowed_Book(Borrowing_ID)
        ON DELETE NO ACTION ON UPDATE CASCADE,
        PRIMARY KEY(Borrowing_ID, Fine_Amount)
    );
    -- --Fines
    -- INSERT INTO Fine VALUES(1111 , 50.00);
    -- INSERT INTO Fine VALUES(2222 , 150.00);
    -- INSERT INTO Fine VALUES(3333 , 250.00);
    -- INSERT INTO Fine VALUES(4444 , 350.00);
    -- INSERT INTO Fine VALUES(5555 , 450.00);

    --Transaction_Information(Transaction_ID: integer, DateOFPayment: Date, PaymentMethod: string, Borrowing_ID)  
    CREATE TABLE Transaction_Information(
        Transaction_ID INT PRIMARY KEY,
        Date_Of_Payment DATE ,
        Payment_Method  VARCHAR(225) NOT NULL,
        Borrowing_ID INT NOT NULL,
        FOREIGN KEY (Borrowing_ID) REFERENCES Borrowed_Book(Borrowing_ID) 
        ON DELETE NO ACTION on UPDATE CASCADE
    );
