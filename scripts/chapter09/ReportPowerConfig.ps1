############################################################
# ReportPowerConfig.ps1
# ed wilson, msft, 7/21/2007
#
# uses powercfg to report a variety of information
# accepts several command line parameters
# 
############################################################
param($a="a", $help)
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
NAME: ReportPowerConfig.ps1 
Prints power config on a local machine.

PARAMETERS: 
-a(ction) action to perform <a(ctive scheme), l(ist), 
          q(uery), d(evice), dv(evice verbose),
		  dwa(evice wake armed), dwp(evice wake programable)>   
-help     prints help file

SYNTAX:
ReportPowerConfig.ps1 

Lists power configuration on local computer

ReportPowerConfig.ps1 -a a

Lists active power configuration on local computer

ReportPowerConfig.ps1 -a l

Lists all power configuration on local computer

ReportPowerConfig.ps1 -a q

Lists all available sleep states on local computer

ReportPowerConfig.ps1 -a w

Lists last wake event on local computer

ReportPowerConfig.ps1 -a d

Lists all devices on local computer

ReportPowerConfig.ps1 -a dv

Lists all devices on local computer - verbose

ReportPowerConfig.ps1 -a dwa

Lists devices configured to wake the local computer

ReportPowerConfig.ps1 -a dwp

Lists devices that are user confiurable to wake the
computer from sleep on local computer

ReportPowerConfig.ps1 -help ?

Displays the help topic for the script

"@
$helpText
exit
}

if($help){funline("Obtaining help ...") ; funhelp }
$computer = (New-Object -ComObject WScript.Network).computername

funline("Power configuration on: $($computer)")

switch($a)
{
 "a"   { POWERCFG -GETACTIVESCHEME ; "`r"}
 "l"   { powercfg -LIST }
 "q"   { powercfg -AVAILABLESLEEPSTATES }
 "w"   { powercfg -lastwake }
 "d"   { powercfg -devicequery all_devices }
 "dv"  { powercfg -devicequery all_devices_verbose }
 "dwa" { powercfg -devicequery wake_armed }
 "dwp" { powercfg -devicequery wake_programmable }
 }
