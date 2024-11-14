#####################################################################
# WriteSharesToAccess.ps1
# ed wilson, msft, 6/15/2007
#
# uses ado to write to an access database
# uses wmi to retrieve information about services
# uses the write-host cmdlet, foreach statement, if statement and 
# the wshNetwork object. Also uses a ado connection and recordset 
# object
#
#####################################################################

$StrComputer = (New-Object -ComObject WScript.Network).computername
$StrDomain = (New-Object -ComObject WScript.Network).userDomain
$strWMIQuery = "Select * from win32_Share"
$objservice = get-wmiobject -query $strWMIQuery

$adOpenStatic = 3
$adLockOptimistic = 3
$strDB = "c:\fso\ConfigurationMaintenance.mdb"
$strTable = "Shares"
$strAccessQuery = "Select * from $strTable"

$objConnection = New-Object -ComObject ADODB.Connection
$objRecordSet = new-object -ComObject ADODB.Recordset
$objConnection.Open("Provider = Microsoft.Jet.OLEDB.4.0; `
  Data Source= $strDB")
$objRecordSet.Open($strAccessQuery, `
  $objConnection, $adOpenStatic, $adLockOptimistic)

write-host -foreGroundColor yellow "Obtaining share info ..."

foreach ($service in $objService) 
{
   $blnAllowMaximum = $service.AllowMaximum
   $strCaption = $service.Caption
   $strDescription = $service.Description
   $intMaximumAllowed = $service.MaximumAllowed
   $strName = $service.name
   $strPath = $service.path
   $intType = $service.type
   
   $objRecordSet.AddNew()
   $objRecordSet.Fields.item("TimeStamp") = Get-Date 
   $objRecordSet.Fields.item("strComputer") = $strComputer
   $objRecordSet.Fields.item("strDomain") = $strDomain
   $objRecordSet.Fields.item("blnAllowMaximum") = $blnAllowMaximum
   $objRecordSet.Fields.item("strCaption") = $strCaption
   $objRecordSet.Fields.item("strDescription") = $strDescription
   $objRecordSet.Fields.item("intMaximumAllowed") = $intMaximumAllowed
   $objRecordSet.Fields.item("strName") = $strName
   $objRecordSet.Fields.item("strPath") = $strPath
   $objRecordSet.Fields.item("intType") = $intType
   $objRecordSet.Update()
   write-host -foregroundColor yellow "/\" -noNewLine
}

$objRecordSet.Close()
$objConnection.Close()