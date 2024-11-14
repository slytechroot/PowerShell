###################################################################
# FindCertificates.ps1
# ed wilson, msft, 10/4/2007
#
# uses the certificate provider and the cert:\ psdrive
# uses the site class. Uses get-wmiobject and format-table
# uses the -use parameter to look for cert with name such as 
# digital or code or smart 
# 
###################################################################

param($use, [switch]$help)

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: FindCertificates.ps1
Finds certificates of a particular use on the local machine 

PARAMETERS: 
-use       the purpose for the certificate ex: code signing,
           client authentication, smart card logon etc.
-help      prints help file

SYNTAX:
FindCertificates.ps1 
Gets a listing of all certificates in the my store

FindCertificates.ps1 -use "digital signature"

Gets a listing of certificates in my store that provide a digital
signature on local computer

FindCertificates.ps1 -use "code signing"

Gets a listing of certificates in my store that provide code
signing support

FindCertificates.ps1 -help

Prints the help topic for the script

"@
 $helpText
 exit
}

if($help) { "Printing help now..." ; funHelp }
if(!$use) { "A use is required..." ; funHelp }

$myCert = Get-ChildItem cert:\CurrentUser\My
ForEach( $cert in $myCert)
 {
   $certExt = $cert.get_extensions()
    Foreach( $ext in $certExt )
      { 
        foreach( $name in $ext.enhancedKeyUsages ) 
          { 
           if($name.friendlyname -match $use)
              { 
               "Certificates that match $use"
               "$($name.friendlyname) certificate: `
               `n$($cert.thumbprint) `n$($cert.subject)`n" 
              } 
          }
      }
  }