# ==============================================================================================
# 
# NAME: CreateAndEnableUser.Ps1
# 
# AUTHOR: Ed Wilson , microsoft
# DATE  : 9/14/2007
# 
# COMMENT: Creates and enables a series of users by reading a csv file
# 1. Creates a user account
# 2. Uses the [ADSI] accelerator
# 3. Uses the create and the setinfo methods
# 4. Reads a CSV file and creates the users
# 5. Sets the password for the user
# 6. Enables the user account
#
# ==============================================================================================
param([switch]$help)
function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: CreateAndEnableUser.Ps1
Creates an enabled user account by reading csv file

PARAMETERS: 

-help        prints help file

SYNTAX:
CreateAndEnableUser.Ps1 

Creates an enabled user by reading a csv file

CreateAndEnableUser.Ps1 -help

Displays the help topic for the script

"@
$helpText
exit
}

if($help){ "Obtaining help ..." ; funhelp }

$aryUser= import-csv -Path c:\psbook\enabledusers.csv
$Class = "User"
$dc = "dc=nwtraders,dc=com"

foreach($strUser in $aryUser)
{
 $ou = "ou="+$strUser.OU
 $ADSI = [ADSI]"LDAP://$ou,$dc" 
 $cnuser="cn="+$($strUser.userName)
 $User = $ADSI.create($CLass,$cnuser)
 $User.put("SamaccountName", $($strUser.username))
 $User.setInfo()
 $User.put("userPassword", $($strUser.Password))
 $user.psbase.invokeset("AccountDisabled", "False")
 $User.setInfo()
}