########################################################################
# CompareShares.ps1
# ed wilson, msft, 6/29/2007
# 
# compares existing shares to a text file to ensure compliance 
# 
# uses get-content to retrieve content from file
# uses foreach to walkthrough the stream from the file
# uses trimend() to remove blank spaces from end of each line in file
# uses get-wmiobject to retrieve properties of win32_share class
# uses foreach to allow to evaluate shares. uses if and else
# for evaluation
# uses write-host -foregroundcolor to print out in red.
#
#######################################################################
$strFile = "c:\fso\shares.txt"
Get-Content  $strFile |
foreach-object { $strShare = $_.trimend()
$strQuery = "Select * from win32_share where name ='$strShare'"
get-wmiobject -query $strQuery | 
foreach-object `
{
 if ($_.name )
  { Write-Host $_.name "is still present" }
 ELSE
  { Write-Host -foregroundcolor RED $_.name `
    " is no longer present" }
}
}