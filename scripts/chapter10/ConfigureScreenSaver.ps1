#################################################################################
# ConfigureScreenSaver.ps1
# ed wilson, msft, 8/12/2007
#
# Uses get-wmiobject and the stdregprov wmi class
# uses the funline2 function which passes by reference to return a modified value
# uses the write-host cmdlet
# uses the [wmiclass] type accelertor
# uses the \\comptuername\root\default to go to different namespace on
# a remote machine [wmiclass]"\\$computer\root\default:stdregprov" and
# connect to the specific class to use its wmi methods
# with .net framework, the stdregprov methods are diffent in they do not use
# an output variable in the 4th position of the method call. also need to 
# specify the hklm value in decimal NOT hex format.
#
#################################################################################

param($computer="localhost", $a, $v, $help)

function funline ([ref]$strIN)
{ 
 $num = $strIN.value.length
 for($i=1 ; $i -le $num ; $i++)
  { $funline += "=" }
    $strIN.value = "$($strIN.value)`n" + $funline
}

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: ConfigureScreenSaver.ps1 
Configures screen saver settings on a local or remote machine.

PARAMETERS: 
-computer Specifies the name of the computer upon which to run the script
-a(ction) Action to perform < q(uery), ex(ecutable), at(active),
          se(cure), to(time out) >
-v(alue)  Value for above action (does not apply to query)
-help     prints help file

SYNTAX:
ConfigureScreenSaver.ps1 -computer MunichServer -a ex -v bubbles.scr

Configures screen saver on a computer named MunichServer
The screen saver executable is bubbles.scr

ConfigureScreenSaver.ps1  -a se -v 1

Configures secure screen saver on local computer
The screen saver is the one already configured

ConfigureScreenSaver.ps1  -a at -v 1

Configures screen saver on local computer to be active
The screen saver is the one already configured

ConfigureScreenSaver.ps1  -a to -v 300

Configures screen saver time out value on local computer to
5 minutes. The screen saver is the one already configured

ConfigureScreenSaver.ps1 -help ?

Displays the help topic for the script

"@
$helpText
exit
}

function funeval ($strRTN)
{ 
 if($strRTN.returnvalue -eq 0)
  { Write-Host -ForegroundColor green "success" }
 ELSE
  { Write-Host -ForegroundColor red "$($strRTN.returnvalue) error" }
}
if($help){ "Obtaining help ..." ; funhelp }

$hkcu = 2147483649  # numeric representation of HKCU from WMI SDK
$strKey = "Control Panel\Desktop"
$strExe = "SCRNSAVE.EXE", "ScreenSaver Executable"
$blnAct = "ScreenSaveActive", "ScreenSaver Active"
$blnSec = "ScreenSaverIsSecure", "ScreenSaver Secure"
$intTim = "ScreenSaveTimeOut", "ScreenSaver TimeOut"
$stdReg =  [wmiclass]"\\$computer\root\default:stdregprov"


switch($a)
{
 "q" { 
      $aryValue = $strExe, $blnAct, $blnSec, $intTim
      foreach($strValue in $aryValue)
      {
       $strRTN = $stdReg.GetStringValue($hkcu,$strKey,$strValue[0])
        if($strRTN.returnvalue -eq 0)
         { 
          $strOUT="$($strRTN.sValue)" 
          funline([ref]$strOut)
         }
        ELSE
         { 
          $strOut="An error $($strRTN.returnvalue) occurred"
          funline([ref]$strOut)
         }
         Write-Host -foregroundcolor green "$($strValue[1]) on $computer"
         Write-Host -ForegroundColor cyan $strout
      }
	}
 "ex" {
       $v = "C:\Windows\System32\$v"
       $strRTN = $stdReg.SetStringValue($hkcu,$strKey,$strExe[0],$v)
	   "Setting $($strExe[1]) ... "
	   funeval($strRTN)
	  }   
 "at" {
       $strRTN = $stdReg.SetStringValue($hkcu,$strKey,$blnAct[0],$v)
	   "Setting $($blnAct[1]) ... "
	   funeval($strRTN)
      }
 "se" {
       $strRTN = $stdReg.SetStringValue($hkcu,$strKey,$blnSec[0],$v)
	   "Setting $($blnSec[1]) ... "
	   funeval($strRTN)
      }
 "to" {
       $strRTN = $stdReg.SetStringValue($hkcu,$strKey,$intTim[0],$v)
	   "Setting $($intTim[1]) ... "
	   funeval($strRTN)
      }
}
