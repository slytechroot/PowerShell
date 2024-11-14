##################################################
#
# ListFileMetaProperties.ps1
# ed wilson, msft, 5/14/2007
#
# uses shell.application com object to extract
# file meta properties
#
###################################################
$i = 0
$a = 30 
$strFolder = "c:\mytest"

$objShell = New-Object -ComObject Shell.Application
$objFolder = $objShell.namespace($strFolder)
for ( $i ; $i -le 266 ; $i++ ) 
    { 
	 Write-output $i $objFolder.getDetailsOf($objFolder.items, $i) >>$strFolder\test.txt
	}