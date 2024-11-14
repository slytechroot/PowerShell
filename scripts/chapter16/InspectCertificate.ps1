###################################################################
# InspectCertificate.ps1
# ed wilson, msft, 10/6/2007
#
# uses the dot net framework class x509certificate
# the x509certificate .net framework class resides in the namespace
# security.cryptography.x509certificates. This script takes the path
# to an exported certificate, and then retrieves all information 
# about it. This script does not work with pfx certificates which 
# include the personal key, as these are password protected and there 
# is not a mechanism to include a password in this script. To import
# password protected pfx certificates use the wizard.
# 
###################################################################

param($cert, [switch]$help)

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: InspectCertificate.ps1
Finds certificates of a particular use on the local machine 

PARAMETERS: 
-cert      the full path to the certificate to inspect
-help      prints help file

SYNTAX:
InspectCertificate.ps1 
Generates an error that a certificate is required

InspectCertificate.ps1 -cert "c:\fso\filerecovery.cer"

Inspects a certificate called filerecovery in the c:\fso
directory. This certificate could be DER encoded or base -64
encoded .cer file. 

InspectCertificate.ps1 -help

Prints the help topic for the script

"@
 $helpText
 exit
}

if($help) { "Printing help now..." ; funHelp }
if(!$cert) { "A certificate is required..." ; funHelp }

$objCert=[security.cryptography.x509certificates.x509certificate]"$cert"
"HashString: $($objCert.GetCertHashString())"
"EffectiveDate: $($objCert.GetEffectiveDateString())"
"ExpirationDate: $($objCert.GetExpirationDateString())"
"HashCode: $($objCert.GetHashCode())"
"KeyAlgorithm: $($objCert.GetKeyAlgorithm())"
"KeyAlgorithmParameters: $($objCert.GetKeyAlgorithmParametersString())"
"Name: $($objCert.GetName())`n"
"PublicKey: $($objCert.GetPublicKeyString())`n"
"RawCertData: $($objCert.GetRawCertDataString())`n"
"SerialNumber: $($objCert.GetSerialNumberString())"
"Cert: $($objCert.ToString())"
"Issuer: $($objCert.Issuer)"
"Subject: $($objCert.Subject)"