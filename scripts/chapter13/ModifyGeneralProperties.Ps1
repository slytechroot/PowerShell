# ==============================================================================================
# 
# NAME: ModifyGeneralProperties.Ps1
# 
# AUTHOR: Ed Wilson , microsoft
# DATE  : 9/2/2007
# 
# COMMENT: Modifies a user called MyNewUser
# 1. Modifies a user account
#2. Uses the [ADSI] accelerator
#3. Uses the put and the setinfo methods
# ==============================================================================================

$objUser = [ADSI]"LDAP://cn=MyNewUser,ou=myTestOU,dc=nwtraders,dc=msft" 
$objUser.put("SamaccountName", "myNewUser")
$objUser.put("givenName", "My")
$objUser.Put("initials", "N.")
$objUser.Put("sn", "User")
$objUser.Put("DisplayName", "My New User")
$objUser.Put("description" , "simple new user")
$objUser.Put("physicalDeliveryOfficeName", "RQ2")
$objUser.Put("telephoneNumber", "999-222-1111")
$objUser.Put("mail", "mnu@hotmail.com")
$objUser.Put("wwwHomePage", "http://www.mnu.msn.com")
$objUser.setInfo()