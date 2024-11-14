####################################################
# ParseAppTextLog.ps1
# ed wilson, msft, 5/25/2007
#
# Parses the text file that was 
# created by using the WriteAppLogToText.ps1 script
# uses switch to open the text file. Uses wildcard
# match for : information, warning and error
# initializes variables to 0
# uses $i++ to increment the value of counter
# each switch statement that matches will increment
# appropriate counter
#
####################################################
$strLog = "c:\fso\applog.txt" 
$e=$i=$w=0

switch -wildcard -file $strLog { 
"*error*" { $e++ }
"*info*"  { $i++ }
"*warn*"  { $w++ }
}
Write-Output "
$strLog contains the following:
      errors      $e
      warnings    $w
      information $i
"