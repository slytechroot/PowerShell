#
# ResolveDNS.ps1
# ed wilson, msft
# resolve dns name to address

$target = "www.edwilson.net"
[system.net.dns]::GetHostByName($target)