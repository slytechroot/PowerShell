#####################################################################
# WriteRunningServicesToAccess.ps1
# ed wilson, msft, 6/4/2007
#
# uses ado to write to an access database
# uses wmi to retrieve information about services
# uses the write-host cmdlet, foreach statement, if statement and 
# the wshNetwork object. Also uses a ado connection and recordset 
# object
#
#####################################################################

$StrComputer = (New-Object -ComObject WScript.Network).computername
$StrDomain = (New-Object -ComObject WScript.Network).Domain
$strWMIQuery = "Select * from win32_Service"
$objservice = get-wmiobject -query $strWMIQuery

write-host -foreGroundColor yellow "Obtaining service info ..."

foreach ($service in $objService) 
 {
  if ($service.state -eq "running")
  {
   $strServiceName = $service.name
   $strStatus = $service.State
   $adOpenStatic = 3
   $adLockOptimistic = 3
   $strDB = "c:\fso\services.mdb"
   $strTable = "runningServices"
   $objConnection = New-Object -ComObject ADODB.Connection
   $objRecordSet = new-object -ComObject ADODB.Recordset
   $objConnection.Open("Provider = Microsoft.Jet.OLEDB.4.0; `
     Data Source= $strDB")
   $objRecordSet.Open("SELECT * FROM runningServices", `
     $objConnection, $adOpenStatic, $adLockOptimistic)

   $objRecordSet.AddNew()
   $objRecordSet.Fields.item("TimeStamp") = Get-Date 
   $objRecordSet.Fields.item("strComputer") = $strComputer
   $objRecordSet.Fields.item("strDomain") = $strDomain
   $objRecordSet.Fields.item("strService") = $strServiceName
   $objRecordSet.Fields.item("strStatus") = $strStatus
   $objRecordSet.Update()
   write-host -foregroundColor yellow "/\" -noNewLine
  }
 }

$objRecordSet.Close()
$objConnection.Close()