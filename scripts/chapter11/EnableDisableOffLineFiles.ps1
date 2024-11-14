#################################################################################
# EnableDisableOffLineFiles.ps1
# ed wilson, msft, 8/15/2007
#
# Uses [wmiclass]"win32_offlinefilescache" [wmiclass] type accelerator
# uses the funline function to underline the comptuer name
# uses $env:computername to obtain name of local computer
# uses the write-host cmdlet
# uses format-table cmdlet
# calls the enable method (a boolean value)
# uses $global to declare a global variable
# uses $global in the function to use the specific global variable
#
#################################################################################

param($computer="localhost", $a, $help)

function funline ($strIN)
{
 $num = $strIN.length
 for($i=1 ; $i -le $num ; $i++)
  { $funline += "=" }
    Write-Host -ForegroundColor yellow $strIN 
    Write-Host -ForegroundColor darkYellow $funline
}

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: EnableDisableOffLineFiles.ps1 
Enables or disables offline files on a local or remote machine.
A reboot of the machine MAY be required. This information will
be displayed in the status message once the script is run.

PARAMETERS: 
-computer Specifies name of the computer upon which to run the script
-a(ction) < e(nable), d(isable) >
-help     prints help file

SYNTAX:
EnableDisableOffLineFiles.ps1 -computer MunichServer -a e

Enables offline files on a computer named MunichServer

EnableDisableOffLineFiles.ps1 -a d

Disables offline files on local computer

EnableDisableOffLineFiles.ps1 -help ?

Displays the help topic for the script

"@
$helpText
exit
}

function funtranslatemethod($a)
{
 switch($a)
  {
   "e" { $global:m = $true 
         $global:msg = "Enable offline files" 
       }
   "d" { 
        $global:m = $false
        $global:msg = "Disable offline files" 
       }
  default{ 
          $global:msg = "$a is not an allowed response`n" 
		 }
  }
}

if($help){ funline("Obtaining help ...") ; funhelp }
if(!$a)
   {
    $(throw "You must supply an action. try this:
	EnableDIsableOfflineFiles.ps1 -help ?")
   }
$global:msg = $global:m = $null
funtranslatemethod($a)

$objWMI = [wmiclass]"\\$computer\root\cimv2:win32_offlinefilescache"
funline("Configure Offline files on $computer ...")
$rtn = $objwmi.enable($m)
if($rtn.returnvalue -eq 0)
 {
  Write-Host -ForegroundColor green "$msg succeeded"
 }
ELSE
 {
  Write-Host -ForegroundColor red "$msg failed with $($rtn.returnvalue) "
 }
if($rtn.rebootrequired) 
  { Write-Host -ForegroundColor cyan "reboot required" }