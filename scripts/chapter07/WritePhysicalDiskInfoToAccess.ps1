#####################################################################
# WritePhysicalDiskInfoToAccess.ps1
# ed wilson, msft, 7/18/2007
#
# uses ado to write to an access database
# uses wmi to retrieve information about physical disks
# uses the write-host cmdlet, foreach statement, if statement and 
# the wshNetwork object. Also uses a ado connection and recordset 
# object
#
#####################################################################

$SystemName = (New-Object -ComObject WScript.Network).computername
$DomainName = (New-Object -ComObject WScript.Network).userDomain
$strWMIQuery = "Select * from win32_diskdrive"
$objdisks = get-wmiobject -query $strWMIQuery

$adOpenStatic = $adLockOptimistic = 3
$strDB = "c:\fso\configurationmaintenance.mdb"
$strTable = "phydisk"
$objConnection = New-Object -ComObject ADODB.Connection
$objRecordSet = new-object -ComObject ADODB.Recordset
$objConnection.Open("Provider = Microsoft.Jet.OLEDB.4.0; `
  Data Source= $strDB")
$objRecordSet.Open("SELECT * FROM $strTable", `
  $objConnection, $adOpenStatic, $adLockOptimistic)

write-host -foreGroundColor yellow "Obtaining physical disk info ..."

foreach ($disk in $objdisks) 
 {
   $objRecordSet.AddNew()
   $objRecordSet.Fields.item("TimeStamp") = Get-Date 
   $objRecordSet.Fields.item("systemName") = $systemName
   $objRecordSet.Fields.item("DomainName") = $DomainName
   $objRecordSet.Fields.item("DeviceID") = $disk.DeviceID
   $objRecordSet.Fields.item("Partitions") = $disk.Partitions
   $objRecordSet.Fields.item("Index") = $disk.Index
   $objRecordSet.Fields.item("SectorsPerTrack") = $disk.SectorsPerTrack
   $objRecordSet.Fields.item("Size") = $disk.Size
   $objRecordSet.Fields.item("TotalCylinders") = $disk.TotalCylinders
   $objRecordSet.Fields.item("TotalHeads") = $disk.TotalHeads
   $objRecordSet.Fields.item("TotalSectors") = $disk.TotalSectors
   $objRecordSet.Fields.item("TotalTracks") = $disk.TotalTracks
   $objRecordSet.Fields.item("TracksPerCylinder") = $disk.TracksPerCylinder
   $objRecordSet.Fields.item("FirmWareRevision") = $disk.FirmWareRevision
   $objRecordSet.Fields.item("Caption") = $disk.Caption
   $objRecordSet.Fields.item("Model") = $disk.Model
   $objRecordSet.Fields.item("SerialNumber") = $disk.SerialNumber
   
   $objRecordSet.Update()
   write-host -foregroundColor yellow "/\" -noNewLine
 }

$objRecordSet.Close()
$objConnection.Close()
















