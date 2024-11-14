#####################################################
#
# FileProperties.ps1
# ed wilson, msft, 5/14/2007
#
# uses shell.application to work with file properties
# attributes 30 - 32 are camera definition
# have to use $($strFileName.name) to get name need $
# `t is a tab
# items() is a method that lists files in the folder
# getDetailsOf wants a file AND an attribute number
# we hold the attribute numbers in $a. 
######################################################

$a = 30 
$strFolder = "C:\Pictures\Canberra"

$objShell = New-Object -ComObject Shell.Application
$objFolder = $objShell.namespace($strFolder)

foreach ($strFileName in $objFolder.items())
   { Write-Host "$($strFileName.name)"
     for ($a ; $a  -le 32; $a++)
    { 
	 Write-Host "`t attribute $a" $objFolder.getDetailsOf($strFileName, $a) 
	}
	$a=30
   }
    
