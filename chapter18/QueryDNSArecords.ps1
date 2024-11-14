#--------------------------------------------------------------------------- 
# QueryDNSArecords.ps1
# ed wilson, msft, 9/28/2007
#
# queries the MicrosoftDNS_AType wmi class and retrieves A records
# only obtains listing from specified domain name. By default the domain
# is set to nwtraders.com which does not exist. You should set it to your
# primary domain. NOTE: this script IS NOT NSLOOKUP and will not work unless
# you target a domain that is running Microsoft DNS. It only returns A 
# records from a zone that is PRESENT on the DNS server. 
#
#--------------------------------------------------------------------------

param($computer="localhost",$domain,[switch]$help)

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: QueryDNSArecords.ps1
Queries for A records on a local or or remote machine running the
Microsoft DNS service.

PARAMETERS: 
-computer  Specifies the name of the computer to run the script
-domain    The specific domain's A records to retrieve
-help      prints help file

SYNTAX:
QueryDNSArecords.ps1 -domain contoso.com

Retrieves A records from the contoso.com domain. Uses local computer

QueryDNSArecords.ps1 -domain nwtraders.com

Retrieves A records from the nwtraders.com domain. Uses local computer

QueryDNSArecords.ps1 -computer MunichServer -domain nwtraders.com

Connects to a computer named MunichServer which is running the Microsoft
DNS service. Retrieves A records from the nwtraders.com domain

QueryDNSArecords.ps1 -help

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
if(!$domain)   { "Missing the -domain parameter ..." ; funHelp }

$arydns = Get-WmiObject -Namespace root\microsoftdns -Class MicrosoftDNS_AType `
              -computername $computer -filter "domainName = `"$domain`" "

"*** A records from DNS server:
`t$($arydns[0].dnsServerName)
`t--------------------"

foreach($dns in $aryDNS)
{
  $hash += @{ $dns.ownername = $dns.recordData }
}
$hash