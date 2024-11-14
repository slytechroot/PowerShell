#####################################################################
# WriteServiceConfigToAccess.ps1
# ed wilson, msft, 6/8/2007
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
   $strServiceName = $service.name
   $strStartName = $service.StartName
   $strStartMode = $service.StartMode
   $blnAcceptPause = $service.AcceptPause
   $blnAcceptStop = $service.AcceptStop
   $adOpenStatic = 3
   $adLockOptimistic = 3
   $strDB = "c:\fso\services.mdb"
   $strTable = "ServiceConfiguration"
   $strAccessQuery = "Select * from $strTable"
   $objConnection = New-Object -ComObject ADODB.Connection
   $objRecordSet = new-object -ComObject ADODB.Recordset
   $objConnection.Open("Provider = Microsoft.Jet.OLEDB.4.0; `
     Data Source= $strDB")
   $objRecordSet.Open($strAccessQuery, `
     $objConnection, $adOpenStatic, $adLockOptimistic)

   $objRecordSet.AddNew()
   $objRecordSet.Fields.item("TimeStamp") = Get-Date 
   $objRecordSet.Fields.item("strComputer") = $strComputer
   $objRecordSet.Fields.item("strDomain") = $strDomain
   $objRecordSet.Fields.item("strService") = $strServiceName
   $objRecordSet.Fields.item("strStartName") = $strStartName
   $objRecordSet.Fields.item("strStartMode") = $strStartMode
   $objRecordSet.Fields.item("blnAcceptPause") = $blnAcceptPause
   $objRecordSet.Fields.item("blnAcceptStop") = $blnAcceptStop
   $objRecordSet.Update()
   write-host -foregroundColor yellow "/\" -noNewLine
}

$objRecordSet.Close()
$objConnection.Close()