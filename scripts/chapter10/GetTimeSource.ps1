#################################################################################
# GetTimeSource.ps1
# ed wilson, msft, 8/10/2007
#
# Uses get-wmiobject and the stdregprov wmi class
# uses the funline2 function which passes by reference to return a modified value
# uses the write-host cmdlet
# uses the [wmiclass] type accelertor
# uses the \\comptuername\root\default to go to different namespace on
# a remote machine [wmiclass]"\\$computer\root\default:stdregprov" and
# connect to the specific class to use its wmi methods
# with .net framework, the stdregprov methods are diffent in they do not use
# an output variable in the 4th position of the method call. also need to 
# specify the hklm value in decimal NOT hex format.
#
#################################################################################

param($computer="localhost", $help)

function funline ([ref]$strIN)
{ 
 $num = $strIN.value.length
 for($i=1 ; $i -le $num ; $i++)
  { $funline += "=" }
    $strIN.value = "$($strIN.value)`n" + $funline
}

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: GetTimeSource.ps1 
Prints the current time source on a local or remote machine.

PARAMETERS: 
-computer Specifies the name of the computer upon which to run the script
-help         prints help file

SYNTAX:
GetTimeSource.ps1 -computer MunichServer

Lists current time source on a computer named MunichServer

GetTimeSource.ps1 

Lists current time source on local computer

GetTimeSource.ps1 -help ?

Displays the help topic for the script

"@
$helpText
exit
}

if($help){ "Obtaining help ..." ; funhelp }


$hklm = 2147483650  # numeric representation of HKLM from WMI SDK
$strKey = "SYSTEM\CurrentControlSet\Services\W32Time\Parameters"
$strValue = "NtpServer"
$stdReg =  [wmiclass]"\\$computer\root\default:stdregprov"

$strTime = $stdReg.GetStringValue($hklm,$strKey,$strValue)

if($strTime.returnvalue -eq 0)
 { 
  $strOUT="$($strTime.sValue)" 
  funline([ref]$strOut)
 }
 ELSE
 { 
  $strOut="An error $($strTime.returnvalue) occurred"
  funline([ref]$strOut)
 }

Write-Host -foregroundcolor green "Time source on $computer"
Write-Host -ForegroundColor cyan $strout