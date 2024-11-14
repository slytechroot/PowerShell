########################################################################
# AuditUnauthorizedShares.ps1
# ed wilson, msft, 6/29/2007
# 
# compares existing shares to a text file to ensure compliance 
# 
# uses get-content to retrieve content from file
# 
# uses substring() to remove $ from end of each share name
# uses get-wmiobject to retrieve properties of win32_share class
# uses foreach to allow to evaluate shares. uses if and else
# for evaluation
# uses write-host -foregroundcolor to print out in red.
#
#######################################################################
Clear-Host
$strFile = Get-Content "c:\fso\shares.txt"

$strQuery = "Select * from win32_share"
$shares = get-wmiobject -query $strQuery  

foreach ( $share in $shares)
 { 
   $shareName = $($share.name).tostring()
   $shareName = $shareName.substring(0,$shareName.length-1)

  Write-Host "Searching for share $($share.Name) ..." -ForegroundColor yellow

  if ( $strFile -match $shareName ) 
   { Write-Host "`t$($share.name) found" -foregroundcolor Green}
  ELSE
   { Write-Host "`t$($share.Name) not found" -foregroundcolor red}
 }