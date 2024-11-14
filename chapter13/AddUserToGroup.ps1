# ===================================================
# 
# NAME: AddUserToGroup.ps1
# 
# AUTHOR: Ed Wilson , microsoft
# DATE  : 8/29/2007
# 
# COMMENT: Adds a user to a group in the same OU
# 1. Modifies a group account
# 2. Uses the [ADSI] accelerator
# 3. Uses the put and the setinfo methods
# ===================================================
param($name,$group,$ou,$dc,[switch]$help)
function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: AddUserToGroup.ps1
Adds a user account to a group

PARAMETERS: 
-name        name of the user 
-ou          ou of the group
-dc          domain of the user
-group       group to modify
-help        prints help file

SYNTAX:
AddUserToGroup.ps1 -name "cn=MyNewUser" -ou "ou=myOU" `
               -dc "dc=nwtraders,dc=com" `
               -group "cn=MyGroup"
               
Adds a user named MyNewUser in the myOU 
organizational unit in the nwtraders.com domain
to the MyGroup group in the same OU.

AddUserToGroup.ps1 -help

Displays the help topic for the script

"@
$helpText
exit
}

if($help){ "Obtaining help ..." ; funhelp }
if(!$name -or !$dc -or !$group -or !$ou) 
  { "Missing parameter ..." ; funhelp }

$CLass = "User"
"Modifying $name,$ou,$dc"
$ADSI = [ADSI]"LDAP://$group,$ou,$dc" 
$ADSI.add("LDAP://$name,$ou,$dc")
