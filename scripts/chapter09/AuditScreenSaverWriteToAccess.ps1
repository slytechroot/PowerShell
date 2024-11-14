#################################################################################
# AuditScreenSaverWriteToAccess.ps1 
# ed wilson, msft, 8/3/2007
#
# Uses get-wmiobject and the win32_desktop wmi class
# uses the funline function
# Uses get-wmiobject and win32_computersystem to get logged on user name. This
# allows to only get information of current user
# uses where-object
# uses -eq to perform exact match of the username
#
#################################################################################
param($computer="localhost", $help)
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
NAME: AuditScreenSaverWriteToAccess.ps1 
writes secure screensaver config of a local or remote machine,
to an access database

PARAMETERS: 
-computerName Specifies the name of the computer upon which to run the script
-help         prints help file

SYNTAX:
AuditScreenSaverWriteToAccess.ps1 -computer MunichServer

Writes secure screensaver configuration of a computer named MunichServer
to an access database

AuditScreenSaverWriteToAccess.ps1 

Writes secure screensaver configuration of local computer to an
access database

AuditScreenSaverWriteToAccess.ps1 -help ?

Displays the help topic for the script

"@
$helpText
exit
}

if($help){funline("Obtaining help ...") ; funhelp }
$adOpenStatic = $adLockOptimistic = 3
$strDB = "c:\fso\configurationmaintenance.mdb"
$strTable = "screensaver"
$objConnection = New-Object -ComObject ADODB.Connection
$objRecordSet = new-object -ComObject ADODB.Recordset
$objConnection.Open("Provider = Microsoft.Jet.OLEDB.4.0; `
  Data Source= $strDB")
$objRecordSet.Open("SELECT * FROM $strTable", `
$objConnection, $adOpenStatic, $adLockOptimistic)

write-host -foreGroundColor yellow "Obtaining screen saver info ..."


$aryscreensaver = Get-WmiObject -Class win32_desktop `
  -computername $computer `
  -Property name, screensaversecure, screensavertimeout, `
  __server, ScreenSaverActive

foreach( $screensaver in $aryScreensaver)
{
   $objRecordSet.AddNew()
   $objRecordSet.Fields.item("TimeStamp") = Get-Date 
   $objRecordSet.Fields.item("SystemName") = $($screensaver.name)
   $objRecordSet.Fields.item("Executable") = $($screensaver.screensaverExecutable)
   $objRecordSet.Fields.item("Secure") = $($screensaver.ScreenSaverSecure)
   $objRecordSet.Fields.item("Active") = $($screensaver.ScreenSaverActive)
   $objRecordSet.Fields.item("Timeout") = $($screensaver.ScreenSaverTimeout)
   $objRecordSet.Update()
   write-host -foregroundColor yellow "/\" -noNewLine
}

$objRecordSet.Close()
$objConnection.Close()