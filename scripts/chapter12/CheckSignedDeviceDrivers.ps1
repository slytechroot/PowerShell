#################################################################################
# CheckSignedDeviceDrivers.ps1
# ed wilson, msft, 8/24/2007
#
# Uses get-wmiobject cmdlet to query service status and startmode
# evaluates null output and handles this and multiple service 
# uses foreach to walk through collection of services
# uses [switch] to turn $help into a switch instead of just a parameter
#
#################################################################################

param(
      $computer="localhost", 
	  [switch]$unsigned, 
	  [switch]$full,
	  [switch]$help
	 )

function funline ($strIN)
{
 $num = $strIN.length
 for($i=1 ; $i -le $num ; $i++)
  { $funline += "=" }
    Write-Host -ForegroundColor green $strIN 
    Write-Host -ForegroundColor darkgreen $funline
}

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: CheckSignedDeviceDrivers.ps1 
Displays a listing of device drivers that are 
and whether they are signed or not

PARAMETERS: 
-computer    the name of the computer
-unsigned    lists unsigned drivers
-full        lists Description, driverProviderName,
             Driverversion,DriverDate, and infName
-help        prints help file

SYNTAX:
CheckSignedDeviceDrivers.ps1 -computer munich -unsigned

Displays a listing of all unsigned drivers
on a computer named munich

CheckSignedDeviceDrivers.ps1 -unsigned -full

Displays a listing of all unsigned drivers on local
computer. Lists Description, driverProviderName,
Driverversion,DriverDate, and infName of the driver

CheckSignedDeviceDrivers.ps1 -computer munich -full

Displays a listing of all signed drivers
a computer named munich. Lists Description, driverProviderName,
Driverversion,DriverDate, and infName of the driver

CheckSignedDeviceDrivers.ps1 -help ?

Displays the help topic for the script

"@
$helpText
exit
}

if($help){ "Obtaining help ..." ; funhelp }

if($unsigned)
  { $filter = "isSigned = 'false'" ; $mode = "unsigned" }
ELSE
  { $filter = "isSigned = 'true'" ; $mode = "signed" }

$property = "Description", "driverProviderName", `
            "Driverversion","DriverDate","infName"

$wmi = Get-WmiObject -Class Win32_PnPSignedDriver `
     -computername $computer -property $property -filter $filter

funline("There are $($wmi.count) $mode drivers isted below:")

if($full)
 {
  format-list -InputObject $wmi -property `
      $property  
 }
ELSE
 {
  format-table -inputobject $wmi -Property description
 }