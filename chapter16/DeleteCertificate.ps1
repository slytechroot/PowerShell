###################################################################
# DeleteCertificate.ps1
# ed wilson, msft, 10/5/2007
#
# uses the .NET framework certificate store class to remove a 
# specified certificate from a specified store. by defualt it 
# uses the my certificate store. The class is X509Store and the
# .net framework namespace is listed here: 
# System.Security.Cryptography.X509Certificates
# Make certain that the property you use to find the certificate 
# identifies only that certificate you wish to delete. The best
# property to use is the THUMBPRINT. 
#
###################################################################

param(
      $cert,
      $store = "my",
      [switch]$listcerts,
      [switch]$help
     )

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: DeleteCertificate.ps1
Removes a certificate from a certificate store 

PARAMETERS: 
-store      the certificate store on the computer
-cert       certificate to delete
-listcerts  lists certificates in specified store
-help       prints help file

SYNTAX:
DeleteCertificate.ps1 

Prints error message a certificate is required, and displays
help

DeleteCertificate.ps1 -cert "B67BAFECA1E77B8F3AEAB8EB9054D5D31C3C0A03"

Removes a certificate with thumbprint of
B67BAFECA1E77B8F3AEAB8EB9054D5D31C3C0A03 from the my store of 
the currentuser

DeleteCertificate.ps1 -store "my" -cert "OU=EFS File Encryption 
Certificate"

Removes a certificate with subject of
OU=EFS File Encryption Certificate from the my store 
of the currentuser

DeleteCertificate.ps1 -store "smartcardroot" 
-cert "E47F375796238DB54CB70DA7A5E88F79"

Removes a certificate with the serial number of
E47F375796238DB54CB70DA7A5E88F79 from the smartcardroot 
store of the currentuser

DeleteCertificate.ps1 -listcerts

Gets a listing of certificates for the my store of the
currentuser

DeleteCertificate.ps1 -help

Prints the help topic for the script

"@
 $helpText
 exit
}

Function funcert()
{
 $crypto = "System.Security.Cryptography.X509Certificates.X509Store"
 $objStore = new-object $crypto $store, $userStore
 $objstore.Open("ReadWrite")
 $colcerts = $objstore.Certificates 
 Write-Host -ForegroundColor blue 
  "
   There are $($colcerts.count) certificates in the $store store.
   They are listed below:
  "
 foreach($cert in $colCerts)
  {
   "FriendlyName:  $($cert.FriendlyName)"
   "Serialnumber: $($cert.SerialNumber)"
   "Thumbprint: $($cert.thumbprint)"
   "Subject: $($cert.subject)`n"
  }
 $objstore.Close()
 exit
}

Function findcert($key)
{
 $crypto = "System.Security.Cryptography.X509Certificates.X509Store"
 $objStore = new-object $crypto $store, $userStore
 $objstore.Open("ReadWrite")
 $colcerts = $objstore.Certificates 
 
 foreach($cert in $colCerts)
  {
   if($cert.thumbprint -match $key)   { $global:mycert = $cert }
   if($cert.serialnumber -match $key) { $global:mycert = $cert }
   if($cert.friendlyname -match $key) { $global:mycert = $cert }
   if($cert.subject -match $key)      { $global:mycert = $cert }
  }
 }

new-variable -name userStore -value "currentUser" -option readonly
$global:mycert = $null

if($help)  { "Printing help now..." ; funHelp }
if($listcerts) { "Listing certificates in $store" ; funcert }
if(!$cert) { 
             "A certificate is required..." ; 
             funhelp 
           }

Findcert($cert)

$crypto = "System.Security.Cryptography.X509Certificates.X509Store"
$objStore = new-object $crypto $store, $userStore
$objstore.Open("ReadWrite")
$objstore.remove($mycert)
$objstore.Close()