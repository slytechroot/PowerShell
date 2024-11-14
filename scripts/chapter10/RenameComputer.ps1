#################################################################################
# RenameComputer.ps1
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
      $user = "administrator", 
      $password, 
      $help
     )

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: RenameComputer.ps1 
Renames a local or remote machine.

PARAMETERS: 
-computer Specifies the name of the computer upon which to run the script
-newname  new name of the computer
-user     user credentials 
-password password of the user
-help     prints help file

SYNTAX:
RenameComputer.ps1 -computer MunichServer -newname BerlinServer

Renames a computer named MunichServer to BerlinServer

RenameComputer.ps1 -computer MunichServer -newname BerlinServer
-user munich\admin -password MyPassword

Renames a computer named MunichServer to BerlinServer. Uses
the credentials of the munich admin, with password of MyPassword

RenameComputer.ps1 

Generates an error. Must supply new name for computer

RenameComputer.ps1 -help ?

Displays the help topic for the script

"@
$helpText
exit
}

if($help){ "Obtaining help ..." ; funhelp }

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