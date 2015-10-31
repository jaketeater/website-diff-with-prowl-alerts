#!/bin/bash
###############################
##########   CONFIG  ##########
PROWL_API_KEY=""
PATH_TO_FILES=""

#Enter urls here, each URL in quotes on a new line
URLS=(
	"http://www.example.com"
	"http://www.anotherexample.com"
	)
########## END CONFIG ##########
################################

#Move to the files' path.  This is to facilitate running this script in cron.
cd $PATH_TO_FILES

for URL in "${URLS[@]}"
do
	#Make url into a valid filename (replaces chars in brackets with a dash)
	NEW_FILE="${URL//[:\/.?]/-}.new.html"
	OLD_FILE="${URL//[:\/.?]/-}.old.html"
	#Move the existing file, in preparation of a new file
	mv temp/$NEW_FILE  temp/$OLD_FILE
	#Download the url
	curl "$URL" -L --compressed -s > temp/$NEW_FILE
	#Compare the two files looking for any differences
	if ! diff temp/$NEW_FILE temp/$OLD_FILE; then
		#If differences are found, send an alert via prowl.
		./prowl.pl -apikey="$PROWL_API_KEY" -application="Application" -event="Website Changed" -notification="$URL Changed." -url="$URL"
		#Copy the new version of the webpage to the archive.
		cp temp/$NEW_FILE archive/$(date +%F-%T)-$NEW_FILE
	fi
done
