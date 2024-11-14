###################################################
# CompareServicesTxt.ps1
# ed wilson, msft, 6/1/2007
# 
# compares two files for changes in service status
# uses the compare-object cmdlet and get-content
# 
####################################################

$strReference =  "c:\fso\dcm.txt"
$strDifference = "c:\fso\dcm1.txt"

Compare-Object `
-referenceobject $(get-content $strReference) `
-differenceobject $(get-content $strDifference)