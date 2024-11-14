############################################################# 
# ReadTxtFileRegEx.ps1
# ed wilson, msft, 9/10/2007
# uses trick to read txt file. does this by using
# dollar sign and code blocks to store contents of file
# into a variable.
# then uses switch to do a regular expression match for 
# process name. uses current property of automatic
# variable $switch to read line
#
############################################################

$a = ${c:\fso\192.168.1.1_Processes.txt}

switch -regex($a) 
 { 
   "csrss.exe" { Write-Host $switch.current }
  
 }