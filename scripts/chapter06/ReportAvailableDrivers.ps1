#######################################################################
# ReportAvailableDrivers.ps1
# ed wilson, msft, 7/7/2007
# initializes a bunch of variables
# uses get-childitem and envirioment drive to find inf files
# uses where object to find prn in the file names
# uses foreach-object to iterate through the collection 
# uses the -file and -regex switches for the switch statement
# switch reads the file, and then the regex matches the list
# of printer types
# we then add up the number of each make of printer
#
#################################################################
$hp=$ibm=$lexmark=$star=$text=$ps=$generic=0
Get-ChildItem ((Get-Item Env:\systemroot).value+"\inf") -Exclude *.pnf | 
Where-Object { $_.name -match "prn" } |
foreach-object($_){
  switch -regex -file $_.fullname 
   { 
         'hp'      { $hp++ }
	 'ibm'     { $ibm++ }
	 'lexmark' { $lexmark++ }
	 'star'    { $star++ }
	 'text'    { $text++ }
	 'ps'      { $ps++ }
	 'generic' { $generic++ }
	}
   
}
"
The following details the printer drivers currently available on the system:
 HP drivers:      $hp
 IBM drivers:     $ibm
 Lexmark drivers: $lexmark
 Star drivers:    $Star
 Text drivers:    $text
 PS drivers:      $ps
 Generic drivers: $generic
"


