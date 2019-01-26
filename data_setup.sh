# WWTD data is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License
# License details at - https://creativecommons.org/licenses/by-nc-sa/3.0/
# Details of the Who Were The Nuns project at - https://wwtn.history.qmul.ac.uk/
#
# download database setup script from the WWTN website
# this will be saved locally to make it easier to compare & debug in the event of new releases
# it's not clear whether this url is version-specific - so it should be checked against the links published on the WWTN website
curl -o dbsetup.sql https://wwtn.history.qmul.ac.uk/database-static/101746.txt

echo About to prepare database.
echo Enter password for MySQL user:
mysql -u  root -p < db_prep.sql

echo About to set up WWTN base data.
echo Enter password for MySQL user:
mysql -u root -p wwtn < dbsetup.sql

echo About to create mart.
echo Enter password for MySQL user:
mysql -u root -p wwtn < create_mart.sql
