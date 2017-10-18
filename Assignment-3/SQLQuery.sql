--Q1)What are the two categories of books?

	SELECT categoryName FROM Category;

--Q2)What are the two categories of books?

	SELECT COUNT(*) FROM BookRead
	WHERE yearRead BETWEEN 2006 AND 2016;

--Q3)Which subcategory names begin with “20th Century”? Your answer should be ordered alphabetically.

	SELECT subCategoryName FROM Subcategory
	WHERE subcategoryName LIKE '20th Century%'
	ORDER BY subcategoryName;

--Q4)How many unique authors are there?

	SELECT COUNT(DISTINCT authorID) FROM Author;

--Q5)What is the title and number of pages of the shortest book that Dr. Soper has read?

	SELECT TOP 1 title, pages FROM Book
	ORDER BY pages ASC;

--Q6)What is the average length of the authors’ names? Hint: read about the “LEN” function.

	SELECT CAST(AVG(LEN(authorName)) AS float)  
	FROM Author;

--Q7)How many unique books written by William Shakespeare has Dr. Soper read?

	SELECT DISTINCT COUNT(*) 
	FROM BookAuthor ba
	FULL JOIN Author a ON ba.authorId=a.authorId
	WHERE a.authorName = 'William Shakespeare';

--Q8)How many total pages did Dr. Soper read in 2011?

	SELECT SUM(pages) as TotalPages
	FROM Book b
	FULL JOIN BookRead br ON b.bookId=br.bookId
	WHERE br.yearRead = 2011;

--Q9)What are the titles of the books that Dr. Soper is currently reading?

	SELECT title
	FROM Book b
	FULL JOIN BookRead br ON b.bookId = br.bookId
	WHERE currentlyReading = 1;

--Q10)How many subcategories of “Nonfiction” books are there?

	SELECT COUNT(*) 
	FROM Subcategory s
	FULL JOIN Category c ON s.categoryId = c.categoryId
	WHERE c.categoryName = 'Nonfiction';

--Q11)In which years did Dr. Soper read “Harry Potter and the Deathly Hallows”?

	SELECT yearRead
	FROM BookRead br
	JOIN Book b ON br.bookId = b.bookId
	WHERE b.title = 'Harry Potter and the Deathly Hallows'
	ORDER BY br.yearRead;

--Q12)Which authors wrote the book entitled “What I Learned Losing a Million Dollars”? Your answer should be sorted by the author order attribute.

	SELECT authorName
	FROM Author a
	JOIN BookAuthor ba ON a.authorId = ba.authorId
	JOIN Book b ON ba.bookId = b.bookId
	WHERE b.title = 'What I Learned Losing a Million Dollars'
	ORDER BY ba.authorOrder;

--Q13)What is the average number of pages of the “Fiction” books that Dr. Soper read in 2016?

	SELECT AVG(pages*1.0) as AveragePages 
	FROM Book b
	JOIN Subcategory sc ON b.subcategoryId = sc.subcategoryId
	JOIN Category c ON c.categoryId = sc.categoryId
	JOIN BookRead br ON b.bookId = br.bookId
	WHERE br.yearRead = 2016 AND c.categoryName = 'Fiction';

--Q14)What is the minimum number of pages, maximum number of pages, and average number of pages for all of the unique books written by George R. R. Martin that Dr. Soper has read?

	SELECT MIN(pages) AS MinPages, MAX(pages) AS MaxPages, AVG(pages * 1.0) as AveragePages
	FROM Book b
	JOIN BookAuthor ba ON b.bookId = ba.bookId
	JOIN Author a ON ba.authorId = a.authorId
	WHERE a.authorName = 'George R. R. Martin';

--Q15)What is the most common first letter of the authors’ first names? Hint: read about the “LEFT” function.

	SELECT TOP 1 LEFT(authorName,1) as Letter, COUNT(*) as Count
	FROM Author
	GROUP BY LEFT(authorName,1)
	ORDER BY COUNT(*) DESC;