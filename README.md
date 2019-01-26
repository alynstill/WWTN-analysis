# WWTN-analysis
https://wwtn.history.qmul.ac.uk/about/

## Set up MySQL
------------

If you don't already have it - install MySQL Using homebrew enter: 
* brew install mysql
* mysql_secure_installation
* enter a new password for root
* Enter 'Y' to remove anonymous users, remove test database & disable remote
access for root
* Enter 'Y' to reload privilege tables now

Make sure you have a user with sufficient permissions - remember/note the
username & password.

## Set terminal encoding to latin1
-------------------------------

I did this through preferences - but there may be a better way

## Prepare the Data
----------------
From terminal enter: ./data_setup.sh

These files are set up using the root user to create the database - when
prompted for a password enter the root password This isn't best practice so feel
free to change to another user with sufficient permissions. 

This gets the database structure and content from the QMUL website, sets up a
blank database to use (dropping the existing wwtn database if there is one) and
then runs the downloaded database script.

