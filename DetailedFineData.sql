SELECT 
  CONCAT ('p', patron_view.record_num, 'a') AS "Record Number", --adds p prefix to the patron record number and the "a" as a placeholder for the check digit, so the number can be easily copied and pasted into Sierra
  CONCAT (patron_record_fullname.first_name, ' ', patron_record_fullname.middle_name, ' ', patron_record_fullname.last_name) AS "Name", --Combines parts of patron name into First-Middle-Last format
  TO_CHAR(fine.assessed_gmt, 'MM/DD/YYYY') AS "Date Assessed",--Formats the date field
  fine.charge_location_code AS "Location Code", 
  ROUND ((fine.item_charge_amt + fine.billing_fee_amt),2) AS "Amount Owed",--Combines fees, rounds to 2 decimal places
  CONCAT (fine.title, fine.description) AS "Title" --Combines bib record title, or manual fee note into one column
   
FROM
  sierra_view.fine
INNER JOIN sierra_view.patron_view
ON  patron_view.id = fine.patron_record_id
INNER JOIN sierra_view.patron_record_fullname
ON patron_record_fullname.patron_record_id = patron_view.id

WHERE
--Replace "abc" below with library's three letter code
  fine.charge_location_code LIKE 'lag%' AND 
--Replace "01/01/2018" with beginning date 
  fine.assessed_gmt BETWEEN '01/01/2018' AND CURRENT_DATE-- CURRENT_DATE can be replaced with a numeric date if desired

ORDER BY patron_view.record_num, Title;--Sorts by patron record number, then title - patrons with multiple fines will have them listed in alphabetical order



