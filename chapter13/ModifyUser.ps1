# ===================================================
# 
# NAME: ModifyUser.ps1
# 
# AUTHOR: Ed Wilson , microsoft
# DATE  : 8/29/2007
# 
# COMMENT: Modifies a user called MyNewUser
# 1. Modifies a user account
# 2. Uses the [ADSI] accelerator
# 3. Uses the put and the setinfo methods
# ===================================================
param($name,$property,$value,$ou,$dc,[switch]$help)
function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: ModifyUser.ps1
Modifies a user account

PARAMETERS: 
-name        name of the user to modify
-ou          ou of the user
-dc          domain of the user
-property    attribute to modify
-value       value of the attribute
-help        prints help file

SYNTAX:
ModifyUser.ps1 -name "CN=MyNewUser" -ou "ou=myOU" `
               -dc "dc=nwtraders,dc=com" `
               -property "SamaccountName" `
               -value "MyNewUser"

Modifies a user named MyNewUser in the myOU 
organizational unit in the nwtraders.com domain
adds the SamaccountName attriute with a value
of MyNewUser

ModifyUser.ps1 -help

Displays the help topic for the script

"@
$helpText
exit
}

if($help){ "Obtaining help ..." ; funhelp }
if(!$name -or !$dc -or !$property -or !$value) 
  { "Missing parameter ..." ; funhelp }

$CLass = "User"
"Modifying $name,$ou,$dc"
$ADSI = [ADSI]"LDAP://$name,$ou,$dc" 
$ADSI.put($property, $value)
$ADSI.setInfo()