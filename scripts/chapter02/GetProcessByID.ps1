###############################################
# GetProcessByID.ps1
# ed wilson, msft, 5/14/2007
#
# Uses get-process cmdlet
# pipelines results to foreach cmdlet
# Uses if statement to decide on name of process
# returns the process ID
#
#################################################

$strProcess = "system"
Get-Process | 
foreach ( $_.name ) { 
  if ( $_.name -eq $strProcess ) 
   { 
    Write-Host "system process is ID : " $_.ID 
   } 
}