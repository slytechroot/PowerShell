# ==============================================================================================
# 
# NAME: ModifyProfileProperties.ps1
# 
# AUTHOR: Ed Wilson , microsoft
# DATE  : 0/2/2007
# 
# COMMENT: Modifies a user called MyNewUser
# 1. Modifies a user account
# 2. Uses the [ADSI] accelerator
# 3. Uses the put and the setinfo methods
# 4. Adds the information for the profile page
# ==============================================================================================

$objUser = [ADSI]"LDAP://cn=MyNewUser,ou=myTestOU,dc=nwtraders,dc=msft" 
$objUser.put("profilePath", "\\London\profiles\myNewUser")
$objUser.put("scriptPath", "logon.vbs")
$objUser.put("homeDirectory", "\\london\users\myNewUser")
$objUser.put("homeDrive", "H:")
$objUser.setInfo()