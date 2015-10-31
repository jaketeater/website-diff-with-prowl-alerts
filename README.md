# Website Diff with iOS Push Notifications Via Prowl
This bash script monitors a webpage for changes.  When changes are found, it sends a push notification via Prowl and archives the new version of the web page.  This is a simple script that downloads the url, peforms a diff and reports on any changes.

# Installation
1. Clone or download this repo.   
1. Install prowl's dependencies, and prowl:
  1. `sudo apt-get install libwww-perl -y`
  1. `sudo perl -MCPAN -e 'install Bundle::LWP'` (accept the defaults)
  1. `wget http://www.prowlapp.com/static/prowl.pl`
  1. `chmod +x prowl.pl`
  1. Move prowl.pl to the `website_diff/` directory
1. Edit the website_diff.sh file and configure, by adding your prowl API key and the path to the script (including the website_diff directory).
1. Add the urls you wish to monitor to website_diff.sh
1. Create a cronjob to execute website_diff.sh at the desired fequency.

# Usage
The first time a url is scraped, it will send an alert.  After that, alerts will only be sent if changes are detected.  When a change is detected, the new version of the url is archived in the archive folder.

The prowl push message includes a url arguement, so all you have to do is swipe when you receive the message and you will be redirected to the webpage.

# Credits
Thanks to this post for the inspiration: http://bhfsteve.blogspot.com/2013/03/monitoring-web-page-for-changes-using.html
