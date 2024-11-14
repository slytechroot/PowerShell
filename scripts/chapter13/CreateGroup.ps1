# ==============================================================================================
# 
# NAME: CreateGroup.ps1
# 
# AUTHOR: Ed Wilson , microsoft
# DATE  : 8/29/2007
# 
# COMMENT: Creates a group called MyNewGroup
# 1. Creates a group
#2. Uses the [ADSI] accelerator
#3. Uses the create and the setinfo methods
# ==============================================================================================
param($name,$ou,$dc,[switch]$help)
function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: CreateGroup.ps1
Creates a group

PARAMETERS: 
-name        name of the group to create
-ou          ou to create group in
-dc          domain to create group in
-help        prints help file

SYNTAX:
CreateGroup.ps1 -name "CN=MyNewGroup" -ou "myOU" `
               -dc "dc=nwtraders,dc=com"

Creates a group named MyNewGroup in the myOU 
organizational unit in the nwtraders.com domain

CreateGroup.ps1 -name "CN=MyNewGroup" `
               -dc "dc=nwtraders,dc=com"

Creates a group named MyNewGroup in the users 
container in the nwtraders.com domain

CreateGroup.ps1 -help

Displays the help topic for the script

"@
$helpText
exit
}

if($help){ "Obtaining help ..." ; funhelp }
if(!$name -or !$dc) { "Missing name parameter ..." ; funhelp }
if($ou)
 {  "Creating group $name in LDAP://$ou,$dc"  
  $ADSI = [ADSI]"LDAP://$ou,$dc" 
 }
ELSE
 { "Creating group $name in LDAP://cn=users,$dc" 
  $ADSI = [ADSI]"LDAP://cn=users,$dc" 
 }

$CLass = "Group"
$Group = $ADSI.create($CLass, $Name)
$Group.setInfo()