########################################################################
# CheckStoppedServices.ps1
# ed wilson, msft, 6/3/2007
# 
# uses get-contect to retrieve content from file
# uses foreach to walkthrough the stream from the file
# uses trimend() to remove blank spaces from end of each line in file
# uses get-wmiobject to retrieve properties of win32_service class
# uses foreach to allow to evaluate state of service. uses if and else
# for evaluation
# uses write-host -foregroundcolor to print out in red.
#
#######################################################################
$strFile = "c:\fso\StoppedServices.txt"
Get-Content  $strFile |
foreach-object { $strService = $_.trimend()
$strQuery = "Select * from win32_service where name ='$strService'"
get-wmiobject -query $strQuery | 
foreach-object `
{
 if ($_.state -eq "stopped" )
  { Write-Host $_.name "is still stopped" }
 ELSE
  { Write-Host -foregroundcolor RED $_.name `
    " is no longer stopped. It is $($_.state)" }
}
}