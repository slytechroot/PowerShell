#################################################################################
# ReportDesktopSettings.ps1
# ed wilson, msft, 7/24/2007
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
  { $funline = $funline + "=" }
    Write-Host -ForegroundColor yellow `n$strIN 
    Write-Host -ForegroundColor darkYellow $funline
}

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: ReportDesktopSettings.ps1
Prints desktop config on a local or remote machine.

PARAMETERS: 
-computerName Specifies the name of the computer upon which to run the script
-help         prints help file

SYNTAX:
ReportDesktopSettings.ps1-computer MunichServer

Lists desktop configuration on a computer named MunichServer

ReportDesktopSettings.ps1

Lists desktop configuration on local computer

ReportDesktopSettings.ps1-help ?

Displays the help topic for the script

"@
$helpText
exit
}
 
if($help){ funline("obtaining help ...") ; funhelp }

$currentUser = (Get-WmiObject -class win32_computersystem `
 -computername $computer).username

Get-WmiObject -Class win32_desktop -computername $computer |
Where-Object { $_.name -Eq $currentUser } |
foreach-object `
    {  funline("Desktop settings for $($currentUser)")
      $_.psobject.properties | 
	   foreach-object `
        { 
         If($_.value)
	      { 
	        if ($_.name -match "__"){}
		    ELSE
	       { 
		    Write-Host "$($_.name)`t`t $($_.value)" 
		   } 
	     }
       } 
     }
