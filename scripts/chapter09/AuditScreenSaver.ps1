#################################################################################
# AuditScreenSaver.ps1 
# ed wilson, msft, 8/3/2007
#
# Uses get-wmiobject and the win32_desktop wmi class
# uses the funline function
# Uses get-wmiobject and win32_computersystem to get logged on user name. This
# allows to only get information of current user
# uses where-object
# uses -eq to perform exact match of the username
#
#################################################################################
param($computer="localhost", $help)
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
NAME: AuditScreenSaver.ps1 
Prints screensaver config on a local or remote machine.

PARAMETERS: 
-computerName Specifies the name of the computer upon which to run the script
-help         prints help file

SYNTAX:
AuditScreenSaver.ps1 -computer MunichServer

Lists screensaver configuration on a computer named MunichServer

AuditScreenSaver.ps1 

Lists screensaver configuration on local computer

AuditScreenSaver.ps1 -help ?

Displays the help topic for the script

"@
$helpText
exit
}

if($help){funline("Obtaining help ...") ; funhelp }

$username = (get-wmiobject -class win32_computersystem `
  -computername $computer).username
$index=$username.indexof("\")

$username=$username.substring($index+1)
$screensaver = Get-WmiObject -Class win32_desktop `
  -computername $computer -filter "name like `"%$($username)`"" |
Select-Object -Property screen*, name 

funline("Screen saver configuration for $($screensaver.name)")
if($screensaver.ScreenSaverActive -eq "true")
 {
  Write-Host "The screensaver is: $($screensaver.screensaverExecutable)"
  Write-Host "Secure Screensaver: $($screensaver.ScreenSaverSecure)"
  Write-Host "Screensaver timeout: $($screensaver.ScreenSaverTimeout)"
 }
ELSE
 { Write-Host "$($screensaver.name) does not have a screen saver"}
