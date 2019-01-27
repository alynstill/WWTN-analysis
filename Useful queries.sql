
SELECT
   professions.uid,
   nuns.forename,
   nuns.name_religion,
   date_profession,
   convent.date_from,
   convent.from_year
FROM
   professions
       INNER JOIN
   convent ON professions.uid = convent.uid
       INNER JOIN
   nuns ON convent.uid = nuns.uid
WHERE
   convent.from_year IS NULL
           AND (nuns.uid LIKE 'BA%'
       OR nuns.uid LIKE 'LA%')
ORDER BY uid
;
