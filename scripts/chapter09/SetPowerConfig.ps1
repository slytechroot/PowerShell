############################################################
# SetPowerConfig.ps1
# ed wilson, msft, 8/7/2007
#
# uses powercfg to set a variety of power settings
# accepts several command line parameters c,t,q and help
# try: SetPowerConfig.ps1 -help ? for use
#
############################################################
param($c, $t, $q, $help)
function funline ($strIN)
{
 $num = $strIN.length
 for($i=1 ; $i -le $num ; $i++)
  { $funline += "=" }
    Write-Host -ForegroundColor yellow `n$strIN 
    Write-Host -ForegroundColor darkYellow $funline
}

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: SetPowerConfig.ps1
Sets power config on a local machine.

PARAMETERS: 
-c(hange)   <mp,mb,dp,db,sp,sb,hp,hb>
-q(uery)    detailed query of current power plan 
-t(ime out) time out value for change. Required when 
            using -c to change a value
-help       prints help file

SYNTAX:
SetPowerConfig.ps1

Displays error message. Must supply a parameter

SetPowerConfig.ps1 -c mp -t 10

Sets time out value of monitor when on power to
10 minutes

SetPowerConfig.ps1 -c mb -t 5

Sets time out value of monitor when on battery
to 5 minutes

SetPowerConfig.ps1 -c dp -t 15

Sets time out value of disk when on power to
15 minutes

SetPowerConfig.ps1 -c db -t 7

Sets time out value of disk when on battery
to 7 minutes

SetPowerConfig.ps1 -c sp -t 30

Sets time out value of standby when on power to
30 minutes

SetPowerConfig.ps1 -c sb -t 10

Sets time out value of standby when on battery
to 10 minutes

SetPowerConfig.ps1 -c hp -t 45

Sets time out value of hibernate when on power to
45 minutes

SetPowerConfig.ps1 -c hb -t 15

Sets time out value of hibernate when on battery
to 15 minutes

SetPowerConfig.ps1 -q c

Lists detailed configuration settings of the current
power scheme

SetPowerConfig.ps1 -help ?

Displays the help topic for the script

"@
$helpText
exit
}

if($help){funline("Obtaining help ...") ; funhelp }
$computer = (New-Object -ComObject WScript.Network).computername

if($q)
{
 funline("Power configuration on: $($computer)")
 powercfg -query 
 exit
}

if($c -and !$t) 
      {
       $(Throw 'A value for $t is required. 
       Try this: SetPowerConfig.ps1 -help ?')
      }

switch($c)
{
 "mp" { powercfg -CHANGE -monitor-timeout-ac $t }
 "mb" { powercfg -CHANGE -monitor-timeout-dc $t }
 "dp" { powercfg -CHANGE -disk-timeout-ac $t}
 "db" { powercfg -CHANGE -disk-timeout-dc $t }
 "sp" { powercfg -CHANGE -standby-timeout-ac $t }
 "sb" { powercfg -CHANGE -standby-timeout-dc $t }
 "hp" { powercfg -CHANGE -hibernate-timeout-ac $t }
 "hb" { powercfg -CHANGE -hibernate-timeout-dc $t }
 DEFAULT { 
           "$c is not allowed. Try the following:
           SetPowerConfig.ps1 -help ?"
         }
}
