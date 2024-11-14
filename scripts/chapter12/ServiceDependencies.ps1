#################################################################################
# ServiceDependencies.ps1
# ed wilson, msft, 8/27/2007
#
# uses get-wmiobject cmdlet to query services and their dependencies
# uses an association class to return two end points, and then uses the [wmi] 
# management.object wmi class accelerator to provide access to the wmi paths
# uses the swbemobjectpath to query the associated classes
# uses [switch] to turn $help into a switch instead of just a parameter
# uses "=" * ((([wmi]$_.dependent).pathname).length + $c_padline) to multiply the
# string character. you can multiply a string value and get a string of characters
# of a specific length. as the pathname is the longest property value, we use it
#
#################################################################################

$erroractionpreference = "SilentlyContinue" # hides any cryptic error messages due to security
Param($computer = "localhost", [switch]$help)

function funline ($strIN)
{
 $num = $strIN.length
 for($i=1 ; $i -le $num ; $i++)
  { $funline = $funline + "=" }
    Write-Host -ForegroundColor yellow $strIN 
    Write-Host -ForegroundColor darkYellow $funline
}

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: ServiceDependencies.ps1 
Displays a listing of services and their dependencies

PARAMETERS: 
-computer    The name of the computer
-help        prints help file

SYNTAX:
ServiceDependencies.ps1 -computer munich

Displays a listing of services and their dependencies
on a computer named munich

ServiceDependencies.ps1 

Displays a listing of services and their dependencies
on the local machine

ServiceDependencies.ps1 -help ?

Displays the help topic for the script

"@
$helpText
exit
}

if($help){ "Obtaining help ..." ; funhelp }
$dependentProperty = "name", "displayname", "pathname", 
                      "state", "startmode", "processID"
$antecedentProperty = "name", "displayname", 
                       "state", "processID"

if($computer = "localhost") { $computer = $env:computername }
funline("Service Dependencies on $($computer)")

New-Variable -Name c_padline -value 14 -option constant # allows for length of displayname

Get-WmiObject -Class Win32_DependentService -computername $computer |
Foreach-object `
 {
  "=" * ((([wmi]$_.dependent).pathname).length + $c_padline)
  Write-Host -ForegroundColor blue "This service:"
    [wmi]$_.Dependent |
      format-list -Property $dependentProperty
  Write-Host -ForegroundColor cyan "Depends on this service:"
    [wmi]$_.Antecedent | 
      format-list -Property $antecedentProperty
        "=" * ((([wmi]$_.dependent).pathname).length + $c_padline) + "`n"
 }