################################################
# GetNetAdapterConfig.ps1
# ed wilson, msft, 7/22/2007
#
# returns ip protocol config on
# net adapter
# uses get-wmiobject
# uses win32_networkadapterconfiguration class
#
################################################

param($computer="localhost",$query,$help)
function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: GetNetAdapterConfig.ps1
Produces a listing of network adapter configuration information
on a local or remote machine.

PARAMETERS: 
-computer Specifies the name of the computer to run the script
-help     prints help file
-query    the type of query < ip, dns, dhcp, all >
SYNTAX:
GetNetAdapterConfig.ps1 -computerName MunichServer

Lists default network adapter configuration on a 
computer named MunichServer

GetNetAdapterConfig.ps1 -computerName MunichServer -query IP

Lists IPaddress, IPsubnet, DefaultIPgateway, MACAddress 
on a computer named MunichServer

GetNetAdapterConfig.ps1 -computerName MunichServer -query DNS

Lists DNSDomain, DNSDomainSuffixSearchOrder, DNSServerSearchOrder, 
DomainDNSRegistrationEnabled on a computer named MunichServer

GetNetAdapterConfig.ps1 -computerName MunichServer -query DHCP

Lists Index,DHCPEnabled, DHCPLeaseExpires, DHCPLeaseObtained, 
DHCPServer on a computer named MunichServer

GetNetAdapterConfig.ps1 -computerName MunichServer -query ALL

Lists all network adapter configuration information on a computer 
named MunichServer

GetNetAdapterConfig.ps1 -help ?

Prints the help topic for the script

"@
$helpText
exit
}

if($help) { "Printing help now..." ; funHelp }

$class="win32_networkadapterconfiguration"
$IPproperty="IPaddress, IPsubnet, DefaultIPgateway, MACAddress"
$dnsProperty="DNSDomain, DNSDomainSuffixSearchOrder, `
 DNSServerSearchOrder, DomainDNSRegistrationEnabled"
$dhcpProperty="Index,DHCPEnabled, DHCPLeaseExpires, `
 DHCPLeaseObtained, DHCPServer"

if($query)
{
 switch($query)
 {
  "ip"    { $query="Select $IPproperty from $class" }
  "dns"   { $query="Select $dnsProperty from $class" }
  "dhcp"  { $query="Select $dhcpProperty from $class" }
  "all"   { 
            $query = "Select * from $class" ; `
		    Get-WmiObject -Query $query | format-list * ; 
		    exit
		 }	
  DEFAULT { 
           $query = "Select * from $class" ; `
		   Get-WmiObject -Query $query ; exit  
		  }
 }
}
ELSE
 { 
  $query = "Select * from $class" ; `
  Get-WmiObject -Query $query ; exit 
 }

Get-WmiObject -query $query | format-table [a-z]* -AutoSize