select 'uid','relationship','pid'
union all
SELECT * FROM associated_people 
INTO OUTFILE '/tmp/wwtn_exports/test.csv' 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '
'
;
