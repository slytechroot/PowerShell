#############################################################################
# CreateDNSZone.ps1
# ed wilson, msft, 9/23/2007
#
# creates a dns zone
# uses the [wmiclass] wmi accelerator to gain access to the create method
# uses the MicrosoftDNS_ZONE wmi class which is in the root\microsoftDNS 
# namespace. Note the syntax for specifying a remote machine and other than
# default wmi namespace. 
# 
#############################################################################


Param(
      $computer="localhost",$ZoneName,
      $action,[switch]$Datafile,
      [switch]$IPAddr,[switch]$help
      )

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: CreateDNSZone.ps1
Creates a DNS Zone on a local or or remote machine. 

PARAMETERS: 
-computer  Specifies the name of the computer to run the script
-action    Type of DNS zone to configure:
           adp AD integrated primary: -zoneName 
           ads AD integrated secondary: -zonename -ipaddr
           adst Ad integrated stubby: -zonename
           nadp NON AD primary: -zonename -datafile
           nads NON AD secondary: -zonename -datafile -ipaddr
           nadst NON AD stubby: -zonename -datafile
-zoneName  Name of the zone to create
-datafile  Used when not creating an AD integrated DNS zone
-IPaddr    Used when creating a secondary DNS zone
-help      prints help file

SYNTAX:
CreateDNSZone.ps1 -action adp -zonename vienna

Creates an AD integrated primary DNS zone on the local
machine with the name of vienna.

CreateDNSZone.ps1 -action ads -zonename vienna -ipaddr "192.168.3.100"

Creates an AD integrated secondary zone named vienna on the local 
machine with the master zone ip address of 192.168.3.100

CreateDNSZone.ps1 -computer MunichServer -action nadp -zonename vienna
-datafile c:\windows\system32\dns\vienna.dns

Creates a non AD integrated primary zone named vienna on a remote
machine named munichserver with a dns zone file 
c:\windows\system32\dns\vienna.dns

CreateDNSZone.ps1 -help

Prints the help topic for the script

"@
 $helpText
 exit
}

if($help)   { "Printing help now..." ; funHelp }
if(!$zonename -or !$action) { "Missing parameters..." ; funHelp}


[bool]$adintegrated = -1
$nonadintegrated = 0
[int32]$Primary = 0
$secondary = 1
$stuby = 2
$forwarder = 3
[array]$aryIP = $IPaddr

$dnsServer = [wmiclass]"\\$computer\root\microsoftDNS:MicrosoftDNS_ZONE"
switch($action)
 { 
  "adp"    { 
             $dnsServer.createZone($ZoneName, $primary, $adintegrated) ;
             exit 
           }
  "ads"    { 
             $dnsServer.createZone($ZoneName, $secondary, $adintegrated, $null, $aryIP) ; 
             exit 
           }
  "adst"   { $dnsServer.createZone($ZoneName, $stuby, $adintegrated) }
  "nadp"   { 
             $dnsServer.createZone($ZoneName, $primary, $nonadintegrated, $Datafile) ; 
             exit }
  "nads"   { 
             $dnsServer.createZone($ZoneName, $secondary, $nonadintegrated, $Datafile, `
             $aryIP) ; exit 
           }
  "nadst"  { 
              $dnsServer.createZone($ZoneName, $stuby, $nonadintegrated, $Datafile) ; 
              exit 
           }  
  DEFAULT  { "No valid action was specified. Printing help now ..." ; $funHelp }
 }

"No valid action was specified. Printing help now... ; $funhelp "
