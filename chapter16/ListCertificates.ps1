################################################################### 
# ListCertificates.ps1
# ed wilson, 10/6/2007
#
# uses the System.Security.Cryptography.X509Certificates
# namespace and the X509Store .net framework class
#
###################################################################

param($store="my", [switch]$listStores, [switch]$help)

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: ListCertificates.ps1
Lists certificates on the current machine 

PARAMETERS: 
-store     the certificate store to search
-help      prints help file

SYNTAX:
ListCertificates.ps1 
Gets a listing of all certificates in the my store

ListCertificates.ps1 -store "authroot"

Gets a listing of certificates in authroot store on 
local computer

ListCertificates.ps1 -store "my"

Gets a listing of certificates in my store on local
computer

ListCertificates.ps1 -help

Prints the help topic for the script

"@
 $helpText
 exit
}

Function funstore()
{
 write-host -foregroundcolor green "Listing currentuser stores:"
  Get-ChildItem cert:\CurrentUser
  write-host -foregroundcolor green "Listing localmachine stores:`n"
  Get-ChildItem cert:\LocalMachine
  exit
}

if($help) { "Printing help now..." ; funHelp }
if($liststore) { funstore }

new-variable -name userStore -value "currentUser" -option readonly
$crypto = "System.Security.Cryptography.X509Certificates.X509Store"

$objStore = new-object $crypto $store
$objstore.Open("Readonly")
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