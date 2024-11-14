# ==============================================================================================
# 
# NAME: ModifyOrganizationProperties.ps1
# 
# AUTHOR: Ed Wilson , microsoft
# DATE  : 9/2/2007
# 
# COMMENT: Modifies a user called MyNewUser
# 1. Modifies a user account
# 2. Uses the [ADSI] accelerator
# 3. Uses the put and the setinfo methods
# ==============================================================================================
$strDomain = "dc=nwtraders,dc=msft"
$strOU = "ou=myTestOU"
$strUser = "cn=MyNewUser"
$strManager = "cn=myBoss"

$objUser = [ADSI]"LDAP://$strUser,$strOU,$strDomain" 
$objUser.put("title", "Mid-Level Manager")
$objUser.put("department", "sales")
$objUser.put("company", "North Wind Traders")
$objUser.put("manager", "$strManager,$strou,$strDomain")

$objUser.setInfo()