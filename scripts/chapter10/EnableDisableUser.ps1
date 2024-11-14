#################################################################################
# EnableDisableUser.ps1
# ed wilson, msft, 8/9/2007
#
# Uses [adsi] type accelerator to use ADSI to create a local group
# Uses throw to generate error if $group is not present
# Uses the WinNT provider to connect to local SAM database. is case sensitive
# This script must run with ADMIN rights to create local groups
# The System.DirectoryServices.DirectoryEntry class does not have the 
# accountDisabled property like IadsUser does. Therefore we have to use the 
# userflags property. THIS is not documented, but the userflags property here 
# can accept any of the ADS_USER_FLAG_ENUM enumeration values
#
#################################################################################

param($computer="localhost", $a, $user, $password, $help)

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: EnableDisableUser.ps1 
Enables or Disables a local user on either a local or remote machine.

PARAMETERS: 
-computer Specifies the name of the computer upon which to run the script
-a(ction) Action to perform < e(nable) d(isable) >
-user     Name of user to modify
-help     prints help file

SYNTAX:
EnableDisableUser.ps1
Generates an error. You must supply a user name

EnableDisableUser.ps1 -computer MunichServer -user myUser 
-password Passw0rd^&! -a e

Enables a local user called myUser on a computer named MunichServer
with a password of Passw0rd^&!

EnableDisableUser.ps1 -user myUser -a d
Disables a local user called myUser on the local machine

EnableDisableUser.ps1 -help ?

Displays the help topic for the script

"@
$helpText
exit
}

$EnableUser = 512 # ADS_USER_FLAG_ENUM enumeration value from SDK
$DisableUser = 2  # ADS_USER_FLAG_ENUM enumeration value from SDK

if($help){ "Obtaining help ..." ; funhelp }

if(!$user) 
      {
       $(Throw 'A value for $user is required. 
       Try this: EnableDisableUser.ps1 -help ?')
	  }
	
$ObjUser = [ADSI]"WinNT://$computer/$user"

switch($a)
{
 "e" {
      if(!$password) 
	    { 
		  $(Throw 'a value for $password is required.
		  Try this: EnableDisableUser.ps1 -help ?')
	    }
      $objUser.setpassword($password)
      $objUser.description = "Enabled Account"
      $objUser.userflags = $EnableUser
      $objUser.setinfo()
	 }
 "d" {
      $objUser.description = "Disabled Account"
      $objUser.userflags = $DisableUser
      $objUser.setinfo()
	 }
 DEFAULT 
        {
		 "You must supply a value for the action.
		 Try this: EnableDisableUser.ps1 -help ?"
		}
}