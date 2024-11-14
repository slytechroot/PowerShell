#################################################################################
# DeleteShare.ps1
# ed wilson, msft, 6/24/2007
# Deletes a share using win32_share. Uses permissions of logged on user
# It can be remote machine if you specify the $computername parameter and
# the currently logged on user has rights on the remote machine
#
##################################################################################
Param($shareName, $computerName="localhost")

function funHelp()
{
$helpText=@"

NAME: DeleteShare.ps1
Deletes a share on a local or remotemachine using credentials 
of logged on user

PARAMETERS:
-shareName   Specifies the name of the share
-computerName  [optional] the name of computer containing share

SYNTAX:
DeleteShare.ps1 -shareName "fso"

Deletes a share named fso on local computer

DeleteShare.ps1 -shareName "fso" -computerName "london"

Deletes a share named fso on a remote computer named london

"@
$helpText
exit
}

if(!($ShareName)) { "you must supply a shareName" ; funHelp }
$wmiClass = "Win32_Share"
$objWMI= Get-WmiObject -Class $wmiClass -computername $computerName -filter "Name = '$shareName'" 
$objWMI.delete()


