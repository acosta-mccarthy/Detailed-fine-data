


SELECT
field_name,
TO_CHAR (date_field_gmt, 'MM/DD/YYYY') AS "Date",
CONCAT (field_one, field_two)
--Add comments to your code

FROM
  sierra_view.table_one
JOIN sierra_view.table_two
 ON table_one.field = table_two.field

WHERE
date_created BETWEEN '10/01/2018' AND CURRENT_DATE
field = 'value'
other_field LIKE "%text%"

ORDER BY
patron_record_number, date, title




