#####################################################################
# WritePrinterInfoToAccess.ps1
# ed wilson, msft, 7/3/2007
#
# uses ado to write to an access database
# uses wmi to retrieve information about printers
# uses the write-host cmdlet, foreach statement, if statement and 
# the wshNetwork object. Also uses a ado connection and recordset 
# object
#
#####################################################################

$StrComputer = (New-Object -ComObject WScript.Network).computername
$StrDomain = (New-Object -ComObject WScript.Network).userDomain
$strWMIQuery = "Select * from win32_printer"
$objprinters = get-wmiobject -query $strWMIQuery

$adOpenStatic = 3
$adLockOptimistic = 3
$strDB = "c:\fso\configurationmaintenance.mdb"
$strTable = "printers"
$objConnection = New-Object -ComObject ADODB.Connection
$objRecordSet = new-object -ComObject ADODB.Recordset
$objConnection.Open("Provider = Microsoft.Jet.OLEDB.4.0; `
  Data Source= $strDB")
$objRecordSet.Open("SELECT * FROM $strTable", `
  $objConnection, $adOpenStatic, $adLockOptimistic)

write-host -foreGroundColor yellow "Obtaining printer info ..."

foreach ($printer in $objprinters) 
 {
   $objRecordSet.AddNew()
   $objRecordSet.Fields.item("TimeStamp") = Get-Date 
   $objRecordSet.Fields.item("strComputer") = $strComputer
   $objRecordSet.Fields.item("strDomain") = $strDomain
   $objRecordSet.Fields.item("averagePagesPerMinute") = $printer.averagePagesPerMinute
   $objRecordSet.Fields.item("caption") = $printer.caption
   $objRecordSet.Fields.item("default") = $printer.default
   $objRecordSet.Fields.item("comment") = $printer.comment
   $objRecordSet.Fields.item("averagePagesPerMinute") = $printer.averagePagesPerMinute
   $objRecordSet.Fields.item("description") = $printer.description
   $objRecordSet.Fields.item("deviceID") = $printer.deviceID
   $objRecordSet.Fields.item("direct") = $printer.direct
   $objRecordSet.Fields.item("doCompleteFirst") = $printer.doCompleteFirst
   $objRecordSet.Fields.item("driverName") = $printer.driverName
   $objRecordSet.Fields.item("enableBIDI") = $printer.enableBIDI
   $objRecordSet.Fields.item("enableDevQueryPrint") = $printer.enableDevQueryPrint
   $objRecordSet.Fields.item("extendedPrinterStatus") = $printer.extendedPrinterStatus
   $objRecordSet.Fields.item("hidden") = $printer.hidden
   $objRecordSet.Fields.item("horizontalresolution") = $printer.horizontalresolution
   $objRecordSet.Fields.item("verticalresolution") = $printer.verticalresolution
   $objRecordSet.Fields.item("local") = $printer.local
   $objRecordSet.Fields.item("keepprintedjobs") = $printer.keepprintedjobs
   $objRecordSet.Fields.item("network") = $printer.network
   $objRecordSet.Fields.item("printerstate") = $printer.printerstate
   $objRecordSet.Fields.item("printerstatus") = $printer.printerstatus
   $objRecordSet.Fields.item("printjobdatatype") = $printer.printjobdatatype
   $objRecordSet.Fields.item("printprocessor") = $printer.printprocessor
   $objRecordSet.Fields.item("priority") = $printer.priority
   $objRecordSet.Fields.item("published") = $printer.published
   $objRecordSet.Fields.item("queued") = $printer.queued
   $objRecordSet.Fields.item("spoolenabled") = $printer.spoolenabled
   $objRecordSet.Fields.item("systemname") = $printer.systemname
   $objRecordSet.Fields.item("workoffline") = $printer.workoffline
   $objRecordSet.Update()
   write-host -foregroundColor yellow "/\" -noNewLine
 }

$objRecordSet.Close()
$objConnection.Close()
















