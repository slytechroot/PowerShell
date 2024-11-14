############################################################################
# GetDNSServerConfig.ps1
# ed wilson, msft, 9/21/2007
#
# DNS Server configuration info
# DNS Server
# uses get-wmiobject
# uses MicrosoftDNS_Server class which is in the root\microsoftDNS namespace
#
#############################################################################

param($computer="localhost",$query,[switch]$help)
function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: GetDNSServerConfig.ps1
Produces a listing of DNS Server configuration information
on a local or remote machine.

PARAMETERS: 
-computer Specifies the name of the computer to run the script
-query    the type of query < all, advanced, cache, forward, interval, log, recurse >
-help     prints help file
SYNTAX:
GetDNSServerConfig.ps1 

Lists default DNS Server configuration on local computer 

GetDNSServerConfig.ps1 -computer MunichServer -query advanced

Lists roundrobin, SecureResponses, EnableDnsSec, BindSecondaries 
on a computer named MunichServer

GetDNSServerConfig.ps1 -computer MunichServer -query cache

Lists AutoCacheUpdate, EDnsCacheTimeout, MaxCacheTTL,
MaxNegativeCacheTTL on a computer named MunichServer

GetDNSServerConfig.ps1 -computer MunichServer -query forward

Lists ForwardDelegations, Forwarders, ForwardingTimeout
on a computer named MunichServer

GetDNSServerConfig.ps1 -computer MunichServer -query interval

Lists DefaultNoRefreshInterval, DefaultRefreshInterval,
DisjointNets, DsPollingInterval, DsTombstoneInterval,
ScavengingInterval on a computer named MunichServer

GetDNSServerConfig.ps1 -computer MunichServer -query log

Lists EventLogLevel, LogFileMaxSize, LogFilePath, LogIPFilterList,
LogLevel on a computer named MunichServer

GetDNSServerConfig.ps1 -computer MunichServer -query recurse

Lists NoRecursion, RecursionRetry, RecursionTimeout
on a computer named MunichServer

GetDNSServerConfig.ps1 -computer MunichServer -query ALL

Lists all DNS Server configuration information on a computer 
named MunichServer

GetDNSServerConfig.ps1 -help

Prints the help topic for the script

"@
$helpText
exit
}

if($help) { "Printing help now..." ; funHelp }

$class="MicrosoftDNS_Server"
$logProperty = "EventLogLevel","LogFileMaxSize","LogFilePath", `
               "LogIPFilterList","LogLevel"
$forwardProperty = "ForwardDelegations", "Forwarders", "ForwardingTimeout"
$recurseProperty = "NoRecursion","RecursionRetry","RecursionTimeout"   
$cacheProperty = "AutoCacheUpdate","EDnsCacheTimeout","MaxCacheTTL", `
                  "MaxNegativeCacheTTL"
$intervalProperty = "DefaultNoRefreshInterval","DefaultRefreshInterval", `
                     "DisjointNets","DsPollingInterval","DsTombstoneInterval", `
                     "ScavengingInterval"
$advroperty = "roundrobin","SecureResponses","EnableDnsSec","BindSecondaries"
if($query)
{
 switch($query)
 {
  "log"       { $query=$logProperty }
  "forward"   { $query=$forwardProperty }
  "recurse"   { $query= $recurseProperty  }
  "cache"     { $query=$cacheProperty  }
  "interval"  { $query=$intervalProperty }
  "advanced"  { $query=$advroperty }
  "all"   { 
            Get-WmiObject -class $class -computername $computer `
			-namespace root\microsoftDNS| format-list * ; 
		    exit
		 }	
  DEFAULT {  "
             Using default: all items. For options try this:
             GetDNSServerConfig.ps1 -help
			 "
           Get-WmiObject -class $class -computername $computer `
			-namespace root\microsoftDNS| format-list * ; 
		    exit
		  }
 }
}
ELSE
 { 
  "
  Using default: all items. For options try this:
  GetDNSServerConfig.ps1 -help
  "
  Get-WmiObject -class $class -computername $computer `
			-namespace root\microsoftDNS| format-list * ; 
		    exit
 }

  Get-WmiObject -class $class -computername $computer `
			-namespace root\microsoftDNS | 
			format-list -property $query