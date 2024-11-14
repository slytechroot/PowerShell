# ==============================================================================================
# 
# NAME: ModifyTelephoneProperties.ps1
# 
# AUTHOR: Ed Wilson , microsoft
# DATE  : 9/2/2007
# 
# COMMENT: Modifies a user called MyNewUser
# 1. Modifies a user account
# 2. Uses the [ADSI] accelerator
# 3. Uses the put and the setinfo methods
# 4. Adds the information for the telephone page
# ==============================================================================================

$objUser = [ADSI]"LDAP://cn=MyNewUser,ou=myTestOU,dc=nwtraders,dc=msft" 
$objUser.Put("homePhone", "(215)788-4312")
$objUser.Put("pager", "(215)788-0112")
$objUser.Put("mobile", "(715)654-2341")
$objUser.Put("facsimileTelephoneNumber", "(215)788-3456")
$objUser.Put("ipPhone", "192.168.6.112")
$objUser.Put("info", "All contact information is confidential," `
	 + "and is for official use only.")
$objUser.setInfo()