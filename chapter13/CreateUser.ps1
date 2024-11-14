# ==============================================================================================
# 
# NAME: CreateUser.Ps1
# 
# AUTHOR: Ed Wilson , microsoft
# DATE  : 8/29/2007
# 
# COMMENT: Creates a user called MyNewUser
# 1. Creates a user account
#2. Uses the [ADSI] accelerator
#3. Uses the create and the setinfo methods
# ==============================================================================================
param($name,$ou,$dc,[switch]$help)
function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: CreateUser.Ps1
Creates a user account

PARAMETERS: 
-name        name of the user to create
-ou          ou to create user in
-dc          domain to create user in
-help        prints help file

SYNTAX:
CreateUser.Ps1 -name "CN=MyNewUser" -ou "ou=myOU" `
               -dc "dc=nwtraders,dc=com"

Creates a user named MyNewUser in the myOU 
organizational unit in the nwtraders.com domain

CreateUser.ps1 -name "cn=myuser" -ou "ou=ou2,ou=mytestou" `
               -dc "dc=nwtraders,dc=com"

Creates a user named MyNewUser in the ou2 organizational 
unit. A child OU of the mytestou Organizational unit
in the nwtraders.com domain

CreateUser.Ps1 -name "CN=MyNewUser" `
               -dc "dc=nwtraders,dc=com"

Creates a user named MyNewUser in the users 
container in the nwtraders.com domain

CreateUser.Ps1 -help

Displays the help topic for the script

"@
$helpText
exit
}

if($help){ "Obtaining help ..." ; funhelp }
if(!$name -or !$dc) { "Missing name parameter ..." ; funhelp }
if($ou)
 {  "Creating user $name in LDAP://$ou,$dc"  
  $ADSI = [ADSI]"LDAP://$ou,$dc" 
 }
ELSE
 { "Creating user $name in LDAP://cn=users,$dc" 
  $ADSI = [ADSI]"LDAP://cn=users,$dc" 
 }

$CLass = "User"
$User = $ADSI.create($CLass, $Name)
$User.setInfo()