############################################################################
# FindPrinterPorts.ps1
# ed wilson, msft, 7/4/2007
#
# uses named arguments (parameters) to allow to specify different computer
# uses here string for help text
# uses win32_TcpIpPrinterPort class to manage printports 
# uses match to identify only the ports associated with the IP network
#
############################################################################

param( $strcomputer="localhost", $network="192.168", $help)
function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: FindPrinterPorts.ps1
Allows for the management of printer ports on a local or remote machine.

PARAMETERS: 
-computerName Specifies the name of the computer upon which to run the script
-help         prints help file
-network      IP address one, two, or three octets 


SYNTAX:
FindPrinterPorts.ps1 -comptuerName MunichServer 
  Lists all the printer ports on a computer named MunichServer

FindPrinterPorts.ps1 -help ?
  Prints the help topic for the script

FindPrinterPorts.ps1 -computername MunichServer -network "10"
 Sets a class A network address of 10 on the remote server munich server. Only
 Printer ports assigned to the 10.x.x.x range will be returned 

FindPrinterPorts.ps1 
 Returns printer ports in the 192.168.x.x range on the local machine

"@
$helpText
exit
}

if($help) { "Printing help now..." ; funHelp }
$class = "Win32_TcpIpPrinterPort"

Write-Host -foregroundColor Yellow "Below are printer ports in the $network range:`n"
Get-WmiObject -class $class -computername $strcomputer | 
where-object { $_.name -match $network } | foreach($_){ 
 
 if($($_.SNMPEnabled))
 {
  Write-Host -foregroundColor yellow "`tFollowing printer is SNMP enalbled" 
  Write-Host "`t$($_.name), $($_.portNumber), $($_.SNMPCommunity, $($_.SNMPDevIndex)`n" 
 }
 ELSE 
 {
  Write-Host -foregroundColor yellow "`tFollowing printer is NOT SNMP enabled`n"
  write-host "`t$($_.name), $($_.portNumber)"  
 }
}
