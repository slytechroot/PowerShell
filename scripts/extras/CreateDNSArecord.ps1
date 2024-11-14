#--------------------------------------------------------------------------- 
# CreateDNSArecord.ps1
# ed wilson, msft, 9/28/2007
#
# Uses the MicrosoftDNS_AType wmi class and creates A records
# in the specified domain name.
#
#--------------------------------------------------------------------------

param($computer,$domain,$owner,$ip,[switch]$help)

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: CreateDNSArecord.ps1
Creates A records on a local or or remote machine running the
Microsoft DNS service.

PARAMETERS: 
-computer  Specifies the name of the computer to run the script. By
           default, this is the DNS server where the new A record 
           will be created
-domain    The name of the domain into which the new A record resides
-owner     The FQDN of the new A record
-ip        The IP address of the new A record
-help      prints help file

SYNTAX:
CreateDNSArecord.ps1 -domain nwtraders.com -owner london -ip 192.168.12.50

Creates an A record on local server in the nwtraders.com domain. The record
is for a computer named london.nwtraders.com with an ip address of 192.168.12.50

CreateDNSArecord.ps1 -computer berlin -domain nwtraders.com -owner bonn -ip 10.1.1.8

Creates an A record on a remote server named berlin.nwtraders.com. The new 
A record is for a computer named bonn.nwtraders.com with an IP address of
10.1.1.8

CreateDNSArecord.ps1 -help

Prints the help topic for the script

"@
 $helpText
 exit
}

if($help)   { 
             for($i = 0 ; $i -le 15 ; $i+=2)
              { 
               write-host -foregroundcolor $i `
               "Printing help now for $($myinvocation.mycommand)"
               start-sleep -milliseconds 100
               clear-host
              } 
             funHelp 
            }          
if(!$computer) { 
                "missing computer, using default:" 
                $computer = $env:computername
               }
if(!$domain)   { "Missing the -domain parameter ..." ; funHelp }

#initialize properties
$recClass = 1
$ttl = 3600
$container = $domain
[string]$dnsserver = "$($computer).$($domain)"

$DNS = get-wmiobject -computername $dnsServer -namespace root\microsoftdns `
       -class microsoftdns_atype -filter "containername = $container"
$dns.CreateInstanceFromTextRepresentation($dnsserver, $container, $owner, $recClass,$ttl,$ip)


