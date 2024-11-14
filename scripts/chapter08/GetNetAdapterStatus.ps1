#################################################################################
# GetNetAdapterStatus.ps1
# ed wilson, msft, 7/23/2007
#
# uses param for command line arguments
# uses funhelp function to display help
# uses funstatus function to get status of the network adapter
# uses get-wmiobject cmdlet, and the win32_networkadapter wmi class
# uses here string in the function. NOTE: DO NOT have a space when using here 
# string: $helpText=@" (works) $helpText = @" (does not work)
#
#################################################################################
param($computer="localhost",$help)
function funStatus($status)
{
 switch($status)
  {
   0 { " Disconnected" }
   1 { " Connecting" } 
   2 { " Connected" }  
   3 { " Disconnecting" } 
   4 { " Hardware not present" } 
   5 { " Hardware disabled" } 
   6 { " Hardware malfunction" } 
   7 { " Media disconnected" } 
   8 { " Authenticating" } 
   9 { " Authentication succeeded" } 
   10 { " Authentication failed" } 
  }

}

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: GetNetAdapterStatus.ps1
Produces a listing of network adapters and status on a local or remote machine.

PARAMETERS: 
-computerName Specifies the name of the computer upon which to run the script
-help         prints help file

SYNTAX:
GetNetAdapterStatus.ps1 -computer MunichServer

Lists all the network adapters and status on a computer named MunichServer

GetNetAdapterStatus.ps1 

Lists all the network adapters and status on local computer

GetNetAdapterStatus.ps1 -help ?

Displays the help topic for the script

"@
$helpText
exit
}

function funline ($strIN)
{
 $num = $strIN.length
 for($i=1 ; $i -le $num ; $i++)
  { $funline = $funline + "=" }
    Write-Host -ForegroundColor yellow $strIN 
    Write-Host -ForegroundColor darkYellow $funline
}

if($help) { "Printing help now..." ; funHelp }

$objWMI=Get-WmiObject -Class win32_networkadapter -computer $computer

funline("Network adapters and status on $computer")
foreach($net in $objWMI)
{
 Write-Host "$($net.name)"
  funstatus($net.netconnectionstatus)
}