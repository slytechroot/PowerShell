#################################################################################
# ParseFWlog.ps1
# ed wilson, msft, 7/26/2007
#
# uses switch to read a log file. Uses -regex to do regular expression match
# and -file to open the file for reading
# counts the number of times a particular value occurs in the log file
#
# \s is a space \t is a tab. See regex patterns in vbscript chm
#
# REQUIRES ADMIN rights!!!
#
#################################################################################

$tcp=$udp=$dns=$icmp=$PdnsServer=$SdnsServer=$web=$ssl=$null

$fwlog = get-content "C:\Windows\system32\LogFiles\Firewall\firewall.log"
switch -regex ($fwlog)
 {
  "65.53.192.15" { $PdnsServer+=1 }
  "65.53.192.14" { $SdnsServer+=1 }
  "tcp" { $tcp+=1 }
  "udp" { $udp+=1 }
  "icmp" { $icmp+=1 }
  "\s53"   { $dns+=1 }
  "\s80"   { $web+=1 }
  "\s443"   { $ssl+=1 ; $switch.current}
 }

"`$PdnsServer $Pdnsserver"
"`$SdnsServer $SdnsServer"
"`$tcp $tcp"
"`$udp $udp"
"`$icmp $icmp"
"`$dns $dns"
"`$web $web"
"`$ssl $ssl"


 