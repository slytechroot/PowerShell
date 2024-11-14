###############################################################
# exploreSort.ps1
# The first command works and sorts ascending by name
# The second does not error, but does not sort properly ...
# whats the deal?
#
###############################################################

"WORKS"

gwmi win32_process -Property name |
sort  -property name 

Start-Sleep -Seconds 2

"DOES NOT WORK"

$wmi = gwmi win32_process -Property name
sort  -property name -inputobject $wmi