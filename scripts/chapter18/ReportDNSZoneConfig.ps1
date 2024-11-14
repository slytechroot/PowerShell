############################################################################
# ReportDNSZoneConfig.ps1
# ed wilson, msft, 9/21/2007
#
# Reports DNS Zone configuration info
# DNS Server
# uses get-wmiobject
# uses MicrosoftDNS_Zone class which is in the root\microsoftDNS namespace
# 
#############################################################################

param($computer="localhost", [switch]$help)
function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: ReportDNSZoneConfig.ps1
Produces a listing of DNS Server Zone configuration information
on a local or remote machine. 

PARAMETERS: 
-computer Specifies the name of the computer to run the script
-help     prints help file

SYNTAX:
ReportDNSZoneConfig.ps1 

Produces a listing of DNS Server Zone configuration information
on a local machine. 

SetDNSServerConfig.ps1 -computer MunichServer 

Produces a listing of DNS Server Zone configuration information
on a remote machine named MunichServer. 

ReportDNSZoneConfig.ps1 -help

Prints the help topic for the script

"@
 $helpText
 exit
}

if($help)   { "Printing help now..." ; funHelp }

Get-WmiObject -Class MicrosoftDNS_ZONE -computer $computer `
              -Namespace root\microsoftDNS |
			  format-list [a-z]*
