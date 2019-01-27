create database if not exists wwtn_mart;
GRANT SELECT ON wwtn_mart.* TO 'wwtn';
USE `wwtn_mart`;
DROP function IF EXISTS `WWTNDatePart`;

DELIMITER $$
USE `wwtn_mart`$$
CREATE FUNCTION `WWTNDatePart` (datestr varchar(50),datepart varchar(1))
RETURNS INTEGER
BEGIN

	if datepart='y'
		then
		set @datepartvalue =
					case when left(datestr,4) rlike '[1][0-9][0-9][0-9]'
					then cast(left(datestr,4) as unsigned)
					end
	;
	elseif datepart ='m'
	then set @datepartvalue=CASE
        WHEN datestr LIKE '%Jan' THEN 1
        WHEN datestr LIKE '%Feb' THEN 2
        WHEN datestr LIKE '%Mar' THEN 3
        WHEN datestr LIKE '%Apr' THEN 4
        WHEN datestr LIKE '%May' THEN 5
        WHEN datestr LIKE '%Jun' THEN 6
        WHEN datestr LIKE '%Jul' THEN 7
        WHEN datestr LIKE '%Aug' THEN 8
        WHEN datestr LIKE '%Sep' THEN 9
        WHEN datestr LIKE '%Oct' THEN 10
        WHEN datestr LIKE '%Nov' THEN 11
        WHEN datestr LIKE '%Dec' THEN 12
    END;
	elseif datepart = 'd' then
		set @datepartvalue=
		CASE 	WHEN MID(datestr, 6, 2) rlike '[0-9][0-9]'
					THEN MID(datestr, 6, 2)
				WHEN MID(datestr, 6, 1) rlike '[0-9]'
					THEN MID(datestr, 6, 1)
		END;
	ELSE SET @datepartvalue = null ;
	END IF;

	return @datepartvalue;

END $$

DELIMITER ;

drop function if exists WWTNAge;

DELIMITER $$
CREATE FUNCTION `WWTNAge` (agestr varchar(50))
RETURNS INTEGER
BEGIN
set @age = case when left(agestr,2) rlike '[0-9][0-9]' then cast(left(agestr,2) as unsigned) end;
return @age;
END $$

DELIMITER ;

drop function if exists WWTNDateEst;
DELIMITER $$
USE `wwtn_mart`$$
CREATE FUNCTION `WWTNDateEst` (year_part int,month_part int, day_part int, estimatetype varchar(3))
RETURNS Date
BEGIN

set @WWTNDateEst = makedate(year_part
							,1
							);

if month_part is not null 
	then set @WWTNDateEst = date_add( @WWTNDateEst, INTERVAL month_part-1 MONTH);
elseif estimatetype = 'min' 
	then set @WWTNDateEst = date_add( @WWTNDateEst, INTERVAL 0 MONTH);
elseif estimatetype = 'max'
	then set @WWTNDateEst = date_add( @WWTNDateEst, INTERVAL 11 MONTH);
end if;


if day_part is not null 
	then set @WWTNDateEst = date_add(@WWTNDateEst, INTERVAL day_part - 1 DAY);
elseif estimatetype ='min' 
	then set @WWTNRateEst = @WWTNDateEst ;-- date will already be the first of the month - so no need to change anything;
elseif estimatetype = 'max'
	then set @WWTNDateEst = date_sub(	date_add(@WWTNDateEst
												, INTERVAL 1 MONTH
                                                )
									, INTERVAL 1 DAY
                                    ); -- For max estimate - we want the end of the month, so add one month (to give 1st of next month) then take away one day
end if;

return @WWTNDateEst;

END $$

DELIMITER ;

drop table if exists associated_people;
CREATE TABLE associated_people (
    uid CHAR(5) DEFAULT NULL,
    relationship TINYINT(4) DEFAULT NULL,
    pid INT(11) DEFAULT NULL
)  ENGINE=MYISAM DEFAULT CHARSET=LATIN1;

INSERT
    INTO associated_people
   (uid,relationship,pid)
   SELECT uid,relationship,pid
   from WWTN.associated_people;


drop table if exists convent;

CREATE TABLE convent (
  uid char(5) default NULL,
  cid tinyint(4) default NULL,
  date_from varchar(30) default NULL,
  from_year int,
  from_month int,
  from_day int,
  from_min date default null,
  from_max date default null,
  age_entry varchar(30) default NULL,
  age_entry_clean int,
  `type` enum('choir','lay','unknown','white') default NULL,
  mstatus enum('married','unmarried','widowed') default NULL,
  date_left varchar(30) default NULL,
  left_year int,
  left_month int,
  left_day int,
  left_min date default null,
  left_max date default null,
  reason_left tinytext,
  note tinytext,
  from_type enum('entry','clothing','founder','return','transfer','other') default NULL,
  conventcode char(2) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

INSERT INTO convent
(`uid`,
`cid`,
`date_from`,
`age_entry`,
`type`,
`mstatus`,
`date_left`,
`reason_left`,
`note`,
`from_type`

)
SELECT `convent`.`uid`,
    `convent`.`cid`,
    `convent`.`date_from`,
    `convent`.`age_entry`,
    `convent`.`type`,
    `convent`.`mstatus`,
    `convent`.`date_left`,
    `convent`.`reason_left`,
    `convent`.`note`,
    `convent`.`from_type`

FROM `WWTN`.`convent`;

drop table if exists nuns;

CREATE TABLE nuns (
  uid char(5) NOT NULL,
  forename varchar(50) default NULL,
  surname varchar(50) default NULL,
  name_religion varchar(65) default NULL,
  date_birth varchar(30) default NULL,
  birth_year int,
  birth_month int,
  birth_day int,
  birth_min date default null,
  birth_max date default null,
  date_death varchar(30) default NULL,
  death_year int,
  death_month int,
  death_day int,
  death_min date default null,
  death_max date default null,
  age_death varchar(10) default NULL,
  age_death_clean int,
  national_identity varchar(20) default NULL,
  conv varchar(1) default 'N',
  note varchar(100) default NULL,
  namequal enum('bapt?','no bapt','no relig') default NULL,
  pbirth int(11) default NULL,
  pdeath int(11) default NULL,
  PRIMARY KEY  (uid),
  conventcode varchar(2) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

INSERT INTO `WWTN_Mart`.`nuns`
(`uid`,
`forename`,
`surname`,
`name_religion`,
`date_birth`,
`date_death`,
`age_death`,
`national_identity`,
`conv`,
`note`,
`namequal`,
`pbirth`,
`pdeath`)

SELECT `nuns`.`uid`,
    `nuns`.`forename`,
    `nuns`.`surname`,
    `nuns`.`name_religion`,
    `nuns`.`date_birth`,
    `nuns`.`date_death`,
    `nuns`.`age_death`,
    `nuns`.`national_identity`,
    `nuns`.`conv`,
    `nuns`.`note`,
    `nuns`.`namequal`,
    `nuns`.`pbirth`,
    `nuns`.`pdeath`
FROM `WWTN`.`nuns`;


 drop table if exists office;

 CREATE TABLE office (
  uid char(5) default NULL,
  cid tinyint(4) default NULL,
  officeid tinyint(4) default NULL,
  date_from varchar(30) default NULL,
  from_year int,
  from_month int,
  from_day int,
  from_min date default null,
  from_max date default null,
  date_until varchar(30) default NULL,
  until_year int,
  until_month int,
  until_day int,
  until_min date default null,
  until_max date default null,
  note varchar(20) default NULL,
  conventcode varchar(2),  
  successor_uid char(5) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

 insert into office (uid,cid,officeid,date_from,date_until,note)
 select uid,cid,officeid,date_from,date_until,note
 from wwtn.office;


drop table if exists convents;
CREATE TABLE convents (
  cid tinyint(4) NOT NULL auto_increment,
  religorder tinyint(4) default NULL,
  PRIMARY KEY  (cid)
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=latin1;
insert into convents
select * from WWTN.convents;

 drop table if exists professions;
 CREATE TABLE professions (
  uid char(5) default NULL,
  ordid tinyint(4) default NULL,
  date_profession varchar(30) default NULL,
  profession_year int,
  profession_month int,
  profession_day int,
  profession_min date default null,
  profession_max date default null,
  age_profession varchar(10) default NULL,
  age_profession_clean int,
  dowry varchar(70) default NULL,
  dowry_amt int,
  dowry_currency varchar(70),
  note tinytext,
  conventcode nvarchar(2)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

insert into professions(uid,ordid,date_profession,age_profession,dowry,note,conventcode)
select uid,ordid,date_profession,age_profession,dowry,note,left(uid,2) from WWTN.professions;


UPDATE convent
SET
    from_year = WWTNDatePart(date_from,'y'),
    from_month = WWTNDatePart(date_from,'m'),
    from_day = WWTNDatePart(date_from,'d')
WHERE
    date_from IS NOT NULL;


 UPDATE convent
SET
    left_year = WWTNDatePart(date_left,'y') ,
    left_month = WWTNDatePart(date_left,'m'),
    left_day = WWTNDatePart(date_left,'d')
WHERE
    date_left IS NOT NULL;


update convent
set age_entry_clean = cast(left(age_entry,2) as unsigned)
 where age_entry is not null;

update convent
set from_min = WWTNDateEst(from_year,
							from_month,
							from_day,
							'min') 
, from_max = WWTNDateEst(from_year,
							from_month,
							from_day,
							'max') 
, left_min = WWTNDateEst(left_year,
							left_month,
							left_day,
							'min') 
, left_max = WWTNDateEst(left_year,
							left_month,
							left_day,
							'max') ;


UPDATE nuns
SET
    birth_year = WWTNDatePart(date_birth,'y'),
    birth_month = WWTNDatePart(date_birth,'m'),
    birth_day = WWTNDatePart(date_birth,'d')
WHERE
    date_birth IS NOT NULL;

 UPDATE nuns
SET
    death_year = WWTNDatePart(date_death,'y'),
    death_month = WWTNDatePart(date_death,'m')
WHERE
    date_death IS NOT NULL;

update nuns
set death_day = WWTNDatePart(date_death,'d')
where date_death is not null;


 update nuns
 set age_death_clean = WWTNAge(age_death)
 where age_death is not null;


;


 update office
 set from_year = WWTNDatePart(date_from,'y')
 , from_month = WWTNDatePart(date_from,'m')
 , from_day = WWTNDatePart(date_from,'d')
 ,until_year = WWTNDatePart(date_until,'y')
 , until_month = WWTNDatePart(date_until,'m')
 , until_day = WWTNDatePart(date_until,'d');

 update professions
 set profession_year = WWTNDatePart(date_profession,'y')
 , profession_month = WWTNDatePart(date_profession,'m')
 , profession_day = WWTNDatePart(date_profession,'d')
 , age_profession_clean = WWTNAge(age_profession) ;

 update professions
 set dowry = REPLACE(dowry, '~', '')
 where dowry is not null;


drop table if exists conventcodes;
create table conventcodes (cid tinyint,ConventCode nvarchar(2));

insert into conventcodes(cid,ConventCode)
SELECT 
    c.cid
    , case when c.cid = 40 then 'PT'
			when c.cid=21 then 'MW'
            when c.cid=9 then 'OB'
            else CONCAT(LEFT(l.place, 1), LEFT(r.name, 1))
    end as ConventCode    
FROM
    wwtn_mart.convents AS c
        LEFT JOIN
    wwtn.locations AS l ON c.cid = l.cid
        LEFT JOIN
    wwtn.religorders AS r ON c.religorder = r.ordid
;

UPDATE wwtn_mart.office , wwtn_mart.conventcodes
set wwtn_mart.office.conventcode = wwtn_mart.conventcodes.conventcode
where wwtn_mart.office.cid = wwtn_mart.conventcodes.cid
;

-- where the date of leaving office is not known, use the date of death
update wwtn_mart.office, wwtn_mart.nuns
set wwtn_mart.office.until_year = wwtn_mart.nuns.death_year
where wwtn_mart.office.uid = wwtn_mart.nuns.uid 
and wwtn_mart.office.date_until is null 
and wwtn_mart.nuns.death_year is not null
;
 
 drop view if exists prioress_professions; 
 
 create view prioress_professions as
 (
	SELECT 
		pri.uid AS prioress_uid,
		pri.cid,
		pri.date_from,
		pri.from_year,
		pri.from_month,
		pri.date_until,
		pri.until_year,
		pri.until_month,
		pri.conventcode,
		pri.name_religion,
		pri.surname,
		pri.forename,
		prof.uid AS professee_uid,
		prof.date_profession,
		prof.profession_year,
		prof.profession_month,
		concat_ws(', ', ifnull(n.name_religion,'NK'), ifnull(n.surname,'NK') ) AS professee
	FROM
		(SELECT 
			o.uid,
				o.cid,
				o.officeid,
				o.date_from,
				o.from_year,
				o.from_month,
				o.from_day,
				o.date_until,
				o.until_year,
				o.until_month,
				o.until_day,
				o.note,
				o.conventcode,
				nun.name_religion,
				nun.surname,
				nun.forename
		FROM
			wwtn_mart.office AS o
		INNER JOIN wwtn.offices AS os ON o.officeid = os.idx
			AND os.office = 'Prioress'
		INNER JOIN wwtn_mart.nuns AS nun ON o.uid = nun.uid
        ) AS pri
			LEFT JOIN wwtn_mart.professions AS prof 
        ON pri.conventcode = prof.conventcode
			AND prof.profession_year >= ifnull(pri.from_year,0)
			AND IFNULL(prof.profession_month, 13) >= IFNULL(pri.from_month, 0)
			AND prof.profession_year <= ifnull(pri.until_year,2000)
			AND IFNULL(prof.profession_month, 0) <= IFNULL(pri.until_month, 13)
			LEFT JOIN
		wwtn_mart.nuns AS n ON prof.uid = n.uid
	ORDER BY pri.from_year , pri.pri.until_year , prof.profession_year , prof.profession_month 
 )
 


 -- select * from professions;
 -- select * from convent;
-- select * from nuns;
-- select * from office;
