# ==============================================================================================
# 
# NAME: ModifySecondPage.Ps1
# 
# AUTHOR: Ed Wilson , microsoft
# DATE  : 2/2/2007
# 
# COMMENT: Modifies a user called MyNewUser
# 1. Modifies a user account
#2. Uses the [ADSI] accelerator
#3. Uses the put and the setinfo methods
# ==============================================================================================

$objUser = [ADSI]"LDAP://cn=MyNewUser,ou=myTestOU,dc=nwtraders,dc=msft" 
$objUser.put("streetAddress", "123 main st")
$objUser.put("postOfficeBox", "po box 12")
$objUser.put("l", "Bedrock")
$objUser.put("st", "Arkansas")
$objUser.put("postalCode" , "12345")
$objUser.put("c", "US")
$objUser.put("co", "United States")
$objUser.put("countryCode", "840")
$objUser.setInfo()