

CREATE PROCEDURE querylibrarydb
AS
BEGIN


	SELECT
		a1.copies_noofcopies AS 'No of Copies',
		a2.book_title AS 'Book Title', a3.branch_name AS 'Branch Name'
		FROM tbl_copies a1
		INNER JOIN tbl_book a2 ON a2.book_id = a1.copies_bookid
		INNER JOIN tbl_branch a3 ON a3.branch_id = a1.copies_branchid
		WHERE book_title = 'The Lost Tribe' AND branch_name = 'Sharpstown'
	;	
		/*#1 --------------------------------------------------------
			# of copies of The Lost Tribe owned by Sharpstown
		------------------------------------------------------------*/


	SELECT
		a1.copies_noofcopies AS 'No of Copies',
		a2.book_title AS 'Book Title', a3.branch_name AS 'Branch Name'
		FROM tbl_copies a1
		INNER JOIN tbl_book a2 ON a2.book_id = a1.copies_bookid
		INNER JOIN tbl_branch a3 ON a3.branch_id = a1.copies_branchid
		WHERE book_title = 'The Lost Tribe'
	;
		/*#2 -------------------------------------------------------
			# of copies of the Lost Tribe owned by each branch
		----------------------------------------------------------*/


	SELECT borrower_name
		FROM tbl_borrower
		INNER JOIN tbl_loans ON loans_cardno = borrower_cardno
		WHERE NOT EXISTS (select* from tbl_loans where borrower_cardno = loans_cardno)
	;
		/*#3 -------------------------------------------------------
			names of all borrowers with 0 books checked out
		-----------------------------------------------------------*/

	SELECT 
		a1.loans_duedate AS 'Loan Due Date',
		a2.book_title AS 'Book Title', a3.branch_name AS 'Branch Name', 
		a4.borrower_name AS 'Borrower Name', a4.borrower_address AS 'Borrower Address'
		FROM tbl_loans a1
		INNER JOIN tbl_book a2 ON a2.book_id = a1.loans_bookid
		INNER JOIN tbl_branch a3 ON a3.branch_id = a1.loans_branchid
		INNER JOIN tbl_borrower a4 ON a4.borrower_cardno = a1.loans_cardno
		WHERE loans_duedate = '1/25/18' AND branch_name = 'Sharpstown'
	;
		/* #4 ---------------------------------------------------
			Books loaned from Sharpstown due back today
		---------------------------------------------------------*/


	
	SELECT branch_name AS 'Branch Name', COUNT(*) AS 'No of Books Loaned Out'
		FROM tbl_loans, tbl_branch
		WHERE loans_branchid = branch_id
		GROUP BY branch_name
	;
		/*#5 -----------------------------------------------------------
			for each branch retrieve branch name, and #of books loaned out
		----------------------------------------------------------------*/

	SELECT 
		borrower_cardno AS 'Library Card No', borrower_name AS 'Borrower Name', 
		borrower_address AS 'Borrower Address', COUNT(*) AS 'No of Books Checked Out'
		FROM tbl_borrower, tbl_loans
		WHERE borrower_cardno = loans_cardno
		GROUP BY borrower_cardno, borrower_name, borrower_address
		HAVING COUNT(*) > 5
		;
		/*#6 ----------------------------------------------------------------
		   Retrieve name/addresses/#of books checked out for borrows with >5
		--------------------------------------------------------------------*/

	SELECT
		a1.copies_noofcopies AS 'No of Copies',
		a2.book_id AS 'Book ID', a2.book_title AS 'Book Title', 
		a4.branch_name AS 'Branch Name'
		FROM tbl_copies a1
		INNER JOIN tbl_book a2 ON book_id = a1.copies_bookid
		INNER JOIN tbl_authors a3 ON authors_book = a1.copies_bookid
		INNER JOIN tbl_branch a4 ON branch_id = a1.copies_branchid
		WHERE branch_name = 'Central' AND authors_name = 'Stephen King'
		;
		/* #7 ------------------------------------------------------
				Retrieve #of copies of S King owned by Central
		-----------------------------------------------------------*/
END;