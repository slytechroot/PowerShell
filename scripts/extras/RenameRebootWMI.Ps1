#################################################################################
# RenameReboot.ps1
# ed wilson, msft, 8/9/2007
#
# Uses get-wmiobject cmdlet. allows for use of alternate credentials for remote
# This script must run with ADMIN rights to rename a remote machine
# a reboot will be required for new name to take effect
#
#################################################################################

param(
      $computer="localhost", 
      $newName, 
      $user, 
      [switch]$reboot,
      [switch]$help
     )

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: RenameReboot.ps1 
Renames a local or remote machine.

PARAMETERS: 
-computer Specifies the name of the computer upon which to run the script
-newname  new name of the computer
-user     user credentials 
-reboot   reboots computer
-help     prints help file

SYNTAX:
RenameReboot.ps1 
Displays message you must supply an action. calls help

RenameReboot.ps1 -reboot
Reboots the local computer

RenameReboot.ps1 -reboot -computer MunichServer
Reboots the remote computer named MunichServer

RenameReboot.ps1 -computer MunichServer -newname BerlinServer

Renames a local computer named MunichServer to BerlinServer

RenameReboot.ps1 -computer MunichServer -newname BerlinServer
-user munich\admin 

Renames a remote computer named MunichServer to BerlinServer. Uses
the credentials of the munich admin, with password supplied via
a popup dialog box

RenameReboot.ps1 -computer MunichServer -newname BerlinServer
-user munich\admin -reboot

Renames a remote computer named MunichServer to BerlinServer. Uses
the credentials of the munich admin, with password supplied via
a popup dialog box. Then it reboots the newly named BerlinServer

RenameReboot.ps1 -help

Displays the help topic for the script

"@
$helpText
exit
}

Function funRename()
{
 if($computer -ne "localhost")
 {
  $objWMI = Get-WmiObject -Class Win32_Computersystem `
  -computername $computer -credential $user
  $objWMI.rename($newName)
 }
ELSE
 {
  $objWMI = Get-WmiObject -Class Win32_Computersystem `
  -computername $computer 
  $objWMI.rename($newName)
 }
}

Function funReboot()
{
 if($computer -ne "localhost")
 {
  if($user)
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
  exit
 }
 ELSE
 {
  $objWMI = Get-WmiObject -Class Win32_operatingsystem `
               -computername $computer 
  $objWMI.psbase.Scope.Options.EnablePrivileges = $true
  $objWMI.reboot()
  exit
 }
}

if($help)   { "Obtaining help ..." ; funhelp }
if($newName) 
            { 
             "Renaming $computer to $newName" 
              FunRename
            }
if($reboot)
            {
             "Rebooting $computer now ..."
             FunReboot
            }
if(!$help -or !$newname -or !$reboot) 
           { 
            "you must supply an action ..."
             funhelp
           }