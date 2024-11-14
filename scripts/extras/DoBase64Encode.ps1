##################################################
# DoBase64Encode.ps1
# ed wilson, msft, 5/14/2007
#
# illustrates using the system static method
# toBase64String .. takes array of integers
# is also fromBase64String ... 
#
# but this is NOT the same public key seen in cert.mgr
# use $a | GM -memberType method to see ALL the cool
# methods here. Including: getPublicKeyString()
##################################################
$a = Get-childItem cert:\currentUser\my
[System.Convert]::ToBase64String($a.getPublicKey())

Write-Host `n $a.GetPublicKeyString()

