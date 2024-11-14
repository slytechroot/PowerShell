# ==============================================================================================
# 
# NAME: CreateOU.ps1
# 
# AUTHOR: Ed Wilson , microsoft
# DATE  : 8/29/2007
# 
# COMMENT: Creates a OrganizationalUnit called MyNewOU
# 1. Creates a OrganizationalUnit
#2. Uses the [ADSI] accelerator
#3. Uses the create and the setinfo methods
# ==============================================================================================
param($name,$ou,$dc,[switch]$help)
function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: CreateOU.ps1
Creates a OrganizationalUnit

PARAMETERS: 
-name        name of the OrganizationalUnit to create
-ou          ou to create OrganizationalUnit in
-dc          domain to create OrganizationalUnit in
-help        prints help file

SYNTAX:
CreateOU.ps1 -name "OU=MyNewOU" -ou "myOU" `
               -dc "dc=nwtraders,dc=com"

Creates a OrganizationalUnit named MyNewOU in the myOU 
organizational unit in the nwtraders.com domain

CreateOU.ps1 -name "ou=mynewou" -dc "dc=nwtraders,dc=com"

Creates a OrganizationalUnit named MyNewOU in the root 
of the nwtraders.com domain

CreateOU.ps1 -help

Displays the help topic for the script

"@
$helpText
exit
}

if($help){ "Obtaining help ..." ; funhelp }
if(!$name -or !$dc) { "Missing parameter ..." ; funhelp }
if($ou)
 {  "Creating OU $name in LDAP://$ou,$dc"  
  $ADSI = [ADSI]"LDAP://$ou,$dc" 
 }
ELSE
 { "Creating OU $name in LDAP://$dc" 
  $ADSI = [ADSI]"LDAP://$dc" 
 }


$CLass = "OrganizationalUnit"
$OrganizationalUnit = $ADSI.create($CLass, $Name)
$OrganizationalUnit.setInfo()