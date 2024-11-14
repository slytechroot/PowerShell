# ==============================================================================================
# 
# NAME: MonitorServer.ps1
# 
# AUTHOR: Ed Wilson , microsoft
# DATE  : 10/19/2007
# 
# COMMENT: performs basic wmi queries
#1. returns information about:
#2. processor, process, disk, network, cpu and bios
#3. can run local or remote
#4. uses [io.path]::getTempFileName() to create a temporary
#5. file name. the tmpfile name is used to avoid having to 
#6. create a temp file name for the script
# ==============================================================================================

Param($computer="localhost",[switch]$help)

function funhelp()
{
 $helptext=@"
Description:
MonitorServer.ps1 performs basic wmi queries

Parameters:
-computer name of computer to target
-help     display help
 
Syntax:
MonitorServer.ps1 
returns information about:processor, process, 
disk, network, cpu and bios on local server

MonitorServer.ps1 -computer core
returns information about:processor, process, 
disk, network, cpu and bios on a remote 
computer named core

MonitorServer.ps1 -help
Displays this help topic
"@
$helptext
exit 
}

if($help)   { funhelp }

$aryclass = "win32_processor,win32_process,win32_volume" + `
            ",win32_networkadapter,win32_bios"
$tmpfilename = [io.path]::getTempFileName()
foreach($class in $aryclass.split(","))
 {
  Get-wmiobject -class $class -computername $computer |
  format-list [a-z]* |
  out-file -filepath $tmpfilename -append
 }

"The results are stored in $tmpfilename. Displaying same ..."
Notepad $tmpfilename
