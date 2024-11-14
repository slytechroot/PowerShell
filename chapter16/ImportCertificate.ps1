###################################################################
# ImportCertificate.ps1
# ed wilson, msft, 10/5/2007
#
# uses the capicom com object to import a previously exported
# certificate into a specified certificate store. by defualt it 
# uses the my certificate store
#
###################################################################

param(
      $cert,
      $store = "my", 
      [switch]$liststores,
      [switch]$help
     )

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: ImportCertificate.ps1
Imports a certificate into a certificate store 

PARAMETERS: 
-cert       path of certificate to import
-store      the certificate store on the computer
-liststores lists certificate stores on local machine
-help       prints help file

SYNTAX:
ImportCertificate.ps1 

Prints error message a certificate is required, and displays
help

ImportCertificate.ps1 -cert "c:\fso\mycert.pfx"

Imports a certificate stored in the c:\fso folder named 
mycert.pfx into the my store of the currentuser

ImportCertificate.ps1 -store "my" -cert 
"c:\fso\mycert.pfx"

Imports a certificate stored in the c:\fso folder named 
mycert.pfx into the my store of the currentuser

ImportCertificate.ps1 -store "smartcardroot" 
-cert "c:\fso\mycert.pfx"

Imports a certificate stored in the c:\fso folder named 
mycert.pfx into the smartcardroot store of the currentuser

ImportCertificate.ps1 -liststores

Gets a listing of certificate stores for the
currentuser

ImportCertificate.ps1 -help

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

if($help)  { "Printing help now..." ; funHelp }
if($liststores) { funStore }
if(!$cert) { 
             "A certificate path is required..." ; 
             funhelp 
           }
new-variable -name userStore -value "currentUser" -option readonly
$crypto = "System.Security.Cryptography.X509Certificates.X509Store"
$objStore = new-object $crypto $store, $userStore
$objstore.Open("ReadWrite")
$objstore.Add($cert)
$objstore.Close()