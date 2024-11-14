# ---------------------------------------------------------------------
# UseDotNetDNS.ps1
# ed wilson, msft, 9/19/2007
# uses the system.net.dns .net framework class
# uses the static methods as it is a static class are no constructors
#
# ---------------------------------------------------------------------

$dns = [system.net.dns]
$dns::Gethostname()
$dns::Gethostaddresses("") # returns addresses of local machine
#$dns::Gethostaddresses($dns::Gethostname())
$dns::gethostentry("192.168.2.5")