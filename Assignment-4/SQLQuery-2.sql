USE readinglist;

--1)With respect to the number of pages in each book, what is the mean and standard deviation among all of the books that Dr. Soper has read?

	SELECT AVG(pages) meanPages, ROUND(STDEV(pages),3) std
	FROM Book;

--2)What is the title of the only book in Dr. Soper’s reading list that is exactly 583 pages long?

	SELECT title FROM Book
	WHERE pages = 583;

--3)What is the most common length (number of pages) of all of the books that Dr. Soper has read?

	SELECT TOP 1 pages, Count(*) as numberOfBooks FROM Book
	GROUP BY pages
	ORDER BY COUNT(pages) DESC;

--4)Several authors have same name that only contain only five characters. What are the names fo these authors?

	SELECT authorName FROM Author
	WHERE LEN(authorName) = 5;

--5)What is the name of the subcategory whose ID is 107?

	SELECT subCategoryName FROM Subcategory
	WHERE subcategoryId = 107;
	
--6)What is the title of the very first book that DR. Soper added to his reading list?

	SELECT TOP 1 title FROM Book b
	JOIN BookRead br ON b.bookId = br.bookId
	ORDER BY br.readingOrder ASC;

--7)In 2015, Dr. Soper read just one book that was written by multiple authors. What is the title of that book?

	SELECT TOP 1 b.title,COUNT(ba.authorId) AS NumberofAuthors FROM Book b
	JOIN BookAuthor ba ON b.bookId=ba.bookId
	JOIN BookRead br ON b.bookId=br.bookId
	WHERE br.yearRead = 2015
	GROUP BY b.title
	ORDER BY COUNT(ba.authorID) DESC;

--8)In what year did Dr. Soper read the fewest total pages, and how many pages did he read during that year?
	
	SELECT TOP 1 br.yearRead, SUM(b.pages) AS PagesRead FROM Book b
	JOIN BookRead br ON b.bookId = br.bookId
	GROUP BY br.yearRead
	ORDER BY SUM(b.pages) ASC;

--9)How many total pages has Dr. Soper read in books written by Richard Feynman?

	SELECT SUM(b.pages) as NumberOfPages FROM Book b
	JOIN BookRead br ON b.bookId = br.bookId
	JOIN BookAuthor ba ON b.bookId = ba.bookId
	JOIN Author a ON ba.authorId = a.authorId
	WHERE a.authorName = 'Richard Feynman';

--10)What are the titles of all the books in the Economics subcategory that Dr. Soper read in 2011?

	SELECT b.title FROM Book b
	JOIN Subcategory sc ON b.subcategoryId=sc.subcategoryId
	JOIN BookRead br ON b.bookId=br.bookId
	WHERE sc.subcategoryName = 'Economics' AND br.yearRead = 2011;
	
--11)How many fiction books did Dr. Soper read each year between 2010 and 2012?

	SELECT br.yearRead, COUNT(c.categoryId) as numberofCategories FROM Category c
	JOIN Subcategory sc ON c.categoryId = sc.categoryId
	JOIN Book b on b.subcategoryId = sc.subcategoryId
	JOIN BookRead br ON b.bookId = br.bookId
	WHERE c.categoryName='Fiction' AND br.yearRead BETWEEN 2010 AND 2012
	GROUP BY br.yearRead;

--12)What is the title of the first book that Dr. Soper read that was written by Orson Scott Card?

	SELECT TOP 1 b.title, br.yearRead FROM Book b
	JOIN BookAuthor ba ON b.bookId = ba.bookId
	JOIN Author a ON a.authorId = ba.authorId
	JOIN BookRead br ON b.bookId = br.bookId
	WHERE a.authorName = 'Orson Scott Card'
	ORDER BY br.readingOrder ASC;

--13)How many books has Dr. Soper read more than once? Your results should be just a single number.

	SELECT COUNT(*) FROM 
	(
	SELECT COUNT(*) as timesRead FROM BookRead
	GROUP BY bookId
	HAVING COUNT(*) > 1 
	) AS bookReadMultipleTimes;

--14)What are the three most popular subcategories of nonfiction books that Dr. Soper has read?

	SELECT TOP 3 sc.subcategoryName, COUNT(br.bookId) as countOfBooks FROM Subcategory sc
	JOIN Category c ON sc.categoryId = c.categoryId
	JOIN Book b ON sc.subcategoryId = b.subcategoryId
	JOIN BookRead br ON b.bookId = br.bookId
	WHERE c.categoryName = 'Nonfiction'
	GROUP BY sc.subcategoryName
	ORDER BY countOfBooks DESC;

