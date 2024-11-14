#################################################################################
# CreateLocalUser.ps1
# ed wilson, msft, 8/9/2007
#
# Uses [adsi] type accelerator to use ADSI to create a local group
# Uses throw to generate error if $group is not present
# Uses the WinNT provider to connect to local SAM database. is case sensitive
# This script must run with ADMIN rights to create local groups
#
#################################################################################

param($computer="localhost", $user, $password, $help)

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: CreateLocalUser.ps1 
Creates a local user on either a local or remote machine.

PARAMETERS: 
-computer Specifies the name of the computer upon which to run the script
-user    Name of user to create
-help     prints help file

SYNTAX:
CreateLocalUser.ps1
Generates an error. You must supply a user name

CreateLocalUser.ps1 -computer MunichServer -user myUser 
 -password Passw0rd^&!

Creates a local user called myUser on a computer named MunichServer
with a password of Passw0rd^&!

CreateLocalUser.ps1 -user myUser -password Passw0rd^&!

Creates a local user called myUser on local computer with 
a password of Passw0rd^&!

CreateLocalUser.ps1 -help ?

Displays the help topic for the script

"@
$helpText
exit
}

if($help){ "Obtaining help ..." ; funhelp }

if(!$user -or !$password) 
      {
       $(Throw 'A value for $user and $password is required. 
       Try this: CreateLocalUser.ps1 -help ?')
	  }
	
$OBJou = [ADSI]"WinNT://$computer"
$objUser = $objOU.Create("User", $user)
$objUser.setpassword($password)
$objUser.SetInfo()
$objUser.description = "Test user"
$objUser.SetInfo()