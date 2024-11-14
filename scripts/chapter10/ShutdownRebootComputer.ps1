#################################################################################
# ShutdownRebootComputer.ps1
# ed wilson, msft, 8/9/2007
#
# Uses get-wmiobject and win32_operatingsystem wmi class
# This script must run with ADMIN rights to reboot or shutdown a remote machine
# add rights to the call $objWMI.psbase.Scope.Options.EnablePrivileges = $true
# this enables the shutdown priviliege for the script. Not a documented syntax
#
#################################################################################

param(
      $computer="localhost", 
      $user = "administrator", 
      $password,
      $a,  
      $help
	 )

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: ShutdownRebootComputer.ps1
Shutdown or reboot a local or remote machine.

PARAMETERS: 
-computer Specifies the name of the computer upon which to run the script
-user     user credentials 
-password password of the user
-a(ction) action to perform < s(hutdown), r(eboot) >
-help     prints help file

SYNTAX:
ShutdownRebootComputer.ps1-computer MunichServer -a s

Shutdown a remote computer named MunichServer 

ShutdownRebootComputer.ps1-computer MunichServer -a r
-user munich\admin -password MyPassword

Reboots a computer named MunichServer. Uses the credentials 
of the munich admin, with password of MyPassword

ShutdownRebootComputer.ps1

Displays message pointing to help

ShutdownRebootComputer.ps1 -help ?

Displays the help topic for the script

"@
$helpText
exit
}

if($help){ "Obtaining help ..." ; funhelp }

switch($a)
{
 "s" {
      if($computer -ne "localhost")
      {
       $objWMI = Get-WmiObject -Class Win32_operatingsystem `
       -computername $computer -credential $user
       $objWMI.psbase.Scope.Options.EnablePrivileges = $true
       $objWMI.shutdown()
      } 
      ELSE
      {
       $objWMI = Get-WmiObject -Class Win32_operatingsystem `
       -computername $computer 
       $objWMI.psbase.Scope.Options.EnablePrivileges = $true
       $objWMI.shutdown()
      }
     }
 "r" {
      if($computer -ne "localhost")
      {
       $objWMI = Get-WmiObject -Class Win32_operatingsystem `
       -computername $computer -credential $user
       $objWMI.psbase.Scope.Options.EnablePrivileges = $true
       $objWMI.reboot()
      } 
      ELSE
      {
       $objWMI = Get-WmiObject -Class Win32_operatingsystem `
       -computername $computer 
       $objWMI.psbase.Scope.Options.EnablePrivileges = $true
       $objWMI.reboot()
      }
     }
 DEFAULT { "You must supply an action. Try this"
           "ShutdownRebootComputer.ps1 -help ?" }
}