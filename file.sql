CREATE TABLE Books (
    ISBN VARCHAR(13) PRIMARY KEY,
    Title VARCHAR(255),
    Author VARCHAR(255),
    Genre VARCHAR(50),
    Available INT DEFAULT 1
);

CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255),
    MembershipType VARCHAR(50)
);

CREATE TABLE Loans (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT,
    ISBN VARCHAR(13),
    LoanDate DATE,
    Returned BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (ISBN) REFERENCES Books(ISBN)
);
INSERT INTO Books (ISBN, Title, Author, Genre) 
VALUES ('978-3-16-148410-0', 'The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction');

INSERT INTO Members (Name, Email, MembershipType) 
VALUES ('John Doe', 'john@example.com', 'Premium');


SELECT * FROM Books WHERE Author = 'F. Scott Fitzgerald';
SELECT Name, Email FROM Members WHERE MembershipType = 'Premium';


UPDATE Books SET Available = 0 WHERE ISBN = '978-3-16-148410-0';

DELETE FROM Members WHERE MemberID = 1;


CREATE PROCEDURE CheckOutBook(IN memberID INT, IN isbn VARCHAR(13))
BEGIN
    INSERT INTO Loans (MemberID, ISBN, LoanDate) VALUES (memberID, isbn, CURDATE());
END;


CREATE TRIGGER UpdateBookAvailability AFTER INSERT ON Loans
FOR EACH ROW
BEGIN
    UPDATE Books SET Available = Available - 1 WHERE ISBN = NEW.ISBN;
END;


CREATE INDEX idx_books_isbn ON Books(ISBN);
CREATE INDEX idx_members_name ON Members(Name);

