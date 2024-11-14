########################################
# ParseFWconfig.ps1
# ed wilson, msft, 7/21/2007
# 
# uses netsh firewall show config 
# uses switch and regex to parse 
# uses += to concatenate to same var
# uses $switch.current to retrieve line
# uses $env:computername for comp name
#
########################################
$fwCfg = netsh firewall show config
$enable=$disable=$null

switch -regex ($fwCfg)
 {
  "enable" 
    { 
	 $enable+=$switch.current+"`n"
	}
  "disable" 
    { 
	 $disable+=$switch.current+"`n"
	}
 }

Write-Host -ForegroundColor cyan `
  "Firewall configuration on $env:computername"
Write-Host -ForegroundColor green `
  "The following are enabled`n"
  $enable
Write-Host -ForegroundColor red `
  "The following are disabled`n"
  $disable
