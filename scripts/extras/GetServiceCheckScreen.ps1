$null = @"
GetServiceCheckScreen.ps1
ed wilson, msft, 6/5/2007

This script performs a basic wmi query for win32_service.
It then check the background color of the console, to ensure
the color choice will be appropriate. 
The script also uses a here string for a comment block
"@

$strComputer = "."
$objService = Get-WmiObject -Class win32_service -ComputerName "." 
foreach($strService in $objService)
{
 if ( $host.UI.RawUI.BackgroundColor -ne "green")
 {
  Write-Host $strService.name -ForegroundColor green
 }
  ELSE 
  {
   Write-Host $strService.name -ForegroundColor yellow
  }
}