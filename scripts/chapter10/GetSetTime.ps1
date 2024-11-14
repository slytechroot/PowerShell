#################################################################################
# GetSetTime.ps1
# ed wilson, msft, 8/9/2007
#
# Uses get-wmiobject and the win32_operatingsystem wmi class
# uses the funline function
# Uses [Management.ManagementDatetimeConverter] to convert from UTC time 
# DTMF time to a more readable time. 
# uses the static method: todatetime
# calls the setdatetime method
# uses the get-date cmdlet
#
#################################################################################
param($computer="localhost", $a, $help)
function funline ($strIN)
{
 $num = $strIN.length
 for($i=1 ; $i -le $num ; $i++)
  { $funline += "=" }
    Write-Host -ForegroundColor yellow `n$strIN 
    Write-Host -ForegroundColor darkYellow $funline
}

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: GetSetTime.ps1 
Prints or sets the current time on a local or remote machine.

PARAMETERS: 
-computer Specifies the name of the computer upon which to run the script
-a(ction)     determines whether sets or gets the current time
-help         prints help file

SYNTAX:
GetSetTime.ps1 -computer MunichServer

Lists current time on a computer named MunichServer

GetSetTime.ps1 

Lists current time on local computer

GetSetTime.ps1 -a q

Lists current time on local computer

GetSetTime.ps1 -a q –computer MunichServer

Lists current time on a computer named MunichServer

GetSetTime.ps1 -a s -computer MunichServer

Sets current time on a computer named MunichServer

GetSetTime.ps1 -help ?

Displays the help topic for the script

"@
$helpText
exit
}

if($help){funline("Obtaining help ...") ; funhelp }

$date = [Management.ManagementDatetimeConverter]::`
  ToDmtfDateTime($(get-date))

$objWMI = Get-WmiObject -ComputerName $computer `
  -Class win32_operatingsystem
$localUTC=$objwmi.localDateTime

switch($a)
{ 
 "q"    {
          funline("The time on $($objWMI.csname) is")
          [Management.ManagementDatetimeConverter]::`
          ToDateTime($localUTC)
	     }
 "s"     {
          funline("Setting current time on $computer ...")
          $objWMI.SetDateTime($date)
	     }
 DEFAULT { 
          funline("The time on $($objWMI.csname) is")
          [Management.ManagementDatetimeConverter]::`
          ToDateTime($localUTC)
		 }
}
