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
