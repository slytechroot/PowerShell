############################################################################
# SetDNSServerConfig.ps1
# ed wilson, msft, 9/21/2007
#
# Sets DNS Server configuration info
# DNS Server
# uses get-wmiobject
# uses MicrosoftDNS_Server class which is in the root\microsoftDNS namespace
# 
#############################################################################

param($computer="localhost", $change, [switch]$query,[switch]$list,[switch]$help)
function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: SetDNSServerConfig.ps1
Produces a listing of DNS Server configuration information
on a local or remote machine. Allows to set DNS server config.

PARAMETERS: 
-computer Specifies the name of the computer to run the script
-list     Prints the current configuration of the DNS server
-change   The property and value to change
-help     prints help file

SYNTAX:
SetDNSServerConfig.ps1 -list

Lists default DNS Server configuration on local computer 

SetDNSServerConfig.ps1 -computer MunichServer -list

Lists default DNS Server configuration on a remote server
named MunichServer

SetDNSServerConfig.ps1 -computer MunichServer -change "RoundRobin",0

Configures a remote server named MunichServer to disallow RoundRobin

SetDNSServerConfig.ps1 -computer MunichServer -change "RoundRobin",-1,
"AllowUpdate",0,eventloglevel,1

Configures a remote server named MunichServer to allow RoundRobin,
configures AllowUpdate to unrestricted, and eventloglevel to errors only

SetDNSServerConfig.ps1 -help

Prints the help topic for the script

"@
 $helpText
 exit
}

function funList()
{
 if(test-path .\SetDNSServerConfigOptions.txt)
  {
   .\SetDNSServerConfigOptions.txt
  }
 ELSE
  { 
   Write-Host -foregroundcolor red `
   "Unable to find SetDNSServerConfigOptions.txt"
  }

}

function funQuery()
{
 $class="MicrosoftDNS_Server"
 Get-WmiObject -class $class -computername $computer `
			-namespace root\microsoftDNS | 
			format-list [a-z]*
 exit
}

function funChange($change)
 { 
  $class="MicrosoftDNS_Server"
  $dnsServer=Get-WmiObject -class $class -computername $computer `
	        -namespace root\microsoftDNS
  for ($element=0 ; $element -le $change.length-1 ; $element+=2)
   { 
    $hash += @{ $change[$element]=$change[$element+1] }
   }
  foreach($prop in $hash.keys)
 { "Preparing to make the following changes: "
  "$prop `t`t$($hash[$prop])"
  $dnsServer.$prop = $hash[$prop]
  $dnsServer.put()
 }
 }


if($help)   { "Printing help now..." ; funHelp }
if($list)   { "Printing all changeable properties..." ; funList }
if($query)  { "Printing the current DNS server configuration" ; funQuery }
if($change) { "Change $change now ..." ; funChange($change) }





