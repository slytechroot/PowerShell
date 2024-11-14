#################################################################################
# AddLocalUserToLocalGroup.ps1
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
NAME: AddLocalUserToLocalGroup.ps1 
Adds a local user to a local group on either a local or remote machine.

PARAMETERS: 
-computer Specifies the name of the computer upon which to run the script
-user     Name of user to create
-group    Name of group to add user to
-help     prints help file

SYNTAX:
AddLocalUserToLocalGroup.ps1
Generates an error. You must supply a user and group

AddLocalUserToLocalGroup.ps1 -computer MunichServer -user myUser 
 -group mygroup

Adds a local user called myUser on a computer named MunichServer
to a local group called mygroup

AddLocalUserToLocalGroup.ps1 -user myUser -group mygroup

Adds a local user called myUser on local computer to a 
group called mygroup

AddLocalUserToLocalGroup.ps1 -help ?

Displays the help topic for the script

"@
$helpText
exit
}

#Debug
$user = "mytest"
$group = "mytestgroup"

if($help){funline("Obtaining help ...") ; funhelp }

if(!$user -or !$group) 
      {
       $(Throw 'A value for $user and $group is required. 
       Try this: CreateLocalUser.ps1 -help ?')
	  }
	
$OBjOU = [ADSI]"WinNT://$computer/$group"
$objOU| gm
$objOU.add("WinNT://$computer/$user")
$objOU.SetInfo()
#$objUser = $objOU.add("WinNT://$computer/$user")
#$objUser.SetInfo()

