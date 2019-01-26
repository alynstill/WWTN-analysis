select 'uid','relationship','pid'
union all
SELECT * FROM associated_people 
INTO OUTFILE '/usr/local/WWTN/associated_people.csv' 
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '
'
;
select 'uid','cid','date_from','age_entry','type','mstatus','date_left','reason_left','note','from_type'
union all
SELECT * FROM convent 
INTO OUTFILE '/usr/local/WWTN/convent.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '
'
;
select 'cid','religorder'
 union all
SELECT 
    *
FROM
    convents INTO OUTFILE '/usr/local/WWTN/convents.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '
';

select 'uid','idx','role','description'
union all
SELECT 
    *
FROM
    creative_works INTO OUTFILE '/usr/local/WWTN/creative_works.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '
';
select 'idx','role1','role2'
union all
SELECT 
    *
FROM
    link_types INTO OUTFILE '/usr/local/WWTN/link_types.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '
';
select 'uid1','idx','uid2'
union all
SELECT 
    *
FROM
    linkages INTO OUTFILE '/usr/local/WWTN/linkages.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '
';
select 'cid','idx','place','date_from','date_to'
union all
SELECT 
    *
FROM
    locations INTO OUTFILE '/usr/local/WWTN/locations.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '
';
select 'uid','idx','note'
union all
SELECT 
    *
FROM
    notes INTO OUTFILE '/usr/local/WWTN/notes.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '
';
select 'uid','forename','surname','name_religion','date_birth','date_death','age_death','national_identity','conv','note','namequal','pbirth','pdeath'
union all
SELECT 
    *
FROM
    nuns INTO OUTFILE '/usr/local/WWTN/nuns.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '
';
select 'uid','cid','officeid','date_from','date_until','note'
union all
SELECT 
    *
FROM
    office INTO OUTFILE '/usr/local/WWTN/office.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '
';
select 'idx','office','ranking'
union all
SELECT 
    *
FROM
    offices INTO OUTFILE '/usr/local/WWTN/offices.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '
';
select 'idx','name'
union all
SELECT 
    *
FROM
    pdfs INTO OUTFILE '/usr/local/WWTN/pdfs.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '
';
select 'idx','uid'
union all
SELECT 
    *
FROM
    pdfxuids INTO OUTFILE '/usr/local/WWTN/pdfxuids.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '
';
select 'pid','title','forename','surname','suffix','note','distinguish'

union all
SELECT 
    *
FROM
    people INTO OUTFILE '/usr/local/WWTN/people.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '
';
select 'pid','plid'
union all
SELECT 
    *
FROM
    people_places INTO OUTFILE '/usr/local/WWTN/people_places.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '
';
select 'plid','place','loc','o_p'
union all
SELECT 
    *
FROM
    places INTO OUTFILE '/usr/local/WWTN/places.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '
';
select 'uid','ordid','date_profession','age_profession','dowry','note'
union all
SELECT 
    *
FROM
    professions INTO OUTFILE '/usr/local/WWTN/professions.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '
';
select 'uid'
union all
SELECT 
    *
FROM
    quotes INTO OUTFILE '/usr/local/WWTN/quotes.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '
';
select 'idx','relationship'
union all
SELECT 
    *
FROM
    relationships INTO OUTFILE '/usr/local/WWTN/relationships.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '
';
select 'ordid','name'
union all
SELECT 
    *
FROM
    religorders INTO OUTFILE '/usr/local/WWTN/religorders.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '
';
select 'srcid','srcname'
union all
SELECT 
    *
FROM
    srcdocs INTO OUTFILE '/usr/local/WWTN/srcdocs.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '
';
select 'refid','srcid','itemref'
union all
SELECT 
    *
FROM
    srcrefs INTO OUTFILE '/usr/local/WWTN/srcrefs.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '
';
select 'srcid','cid'
union all
SELECT 
    *
FROM
    srcxcids INTO OUTFILE '/usr/local/WWTN/srcxcids.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '
';
select 'refid','uid'
union all
SELECT 
    *
FROM
    srcxuids INTO OUTFILE '/usr/local/WWTN/srcxuids.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '
';
select 'idx','variant'
union all
SELECT 
    *
FROM
    variants INTO OUTFILE '/usr/local/WWTN/variants.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '
';