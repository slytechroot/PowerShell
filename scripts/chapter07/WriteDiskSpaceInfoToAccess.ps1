#####################################################################
# WriteDiskSpaceInfoToAccess.ps1
# ed wilson, msft, 7/18/2007
#
# uses ado to write to an access database
# uses wmi to retrieve information about physical disks
# uses the write-host cmdlet, foreach statement, if statement and 
# the wshNetwork object. Also uses a ado connection and recordset 
# object
#
#####################################################################

$strWMIQuery = "Select * from win32_volume where drivetype=3"
$objdisks = get-wmiobject -query $strWMIQuery
$percentFree=$free=$capacity=$null
$adOpenStatic = $adLockOptimistic = 3
$strDB = "c:\fso\configurationmaintenance.mdb"
$strTable = "diskSpace"

$SystemName = (New-Object -ComObject WScript.Network).computername
$DomainName = (New-Object -ComObject WScript.Network).userDomain
$objConnection = New-Object -ComObject ADODB.Connection
$objRecordSet = new-object -ComObject ADODB.Recordset
$objConnection.Open("Provider = Microsoft.Jet.OLEDB.4.0; `
  Data Source= $strDB")
$objRecordSet.Open("SELECT * FROM $strTable", `
$objConnection, $adOpenStatic, $adLockOptimistic)

write-host -foreGroundColor yellow "Obtaining disk space info ..."

foreach ($disk in $objdisks) 
 { 
   [int]$free =$disk.freespace/1MB
   [int]$capacity = $disk.capacity/1MB
   $percentFree = ($free/$capacity)*100
   $objRecordSet.AddNew()
   $objRecordSet.Fields.item("TimeStamp") = Get-Date 
   $objRecordSet.Fields.item("systemName") = $systemName
   $objRecordSet.Fields.item("DomainName") = $DomainName
   $objRecordSet.Fields.item("DriveLetter") = $disk.DriveLetter
   $objRecordSet.Fields.item("FreeSpace") = $free
   $objRecordSet.Fields.item("Capacity") = $capacity
   $objRecordSet.Fields.item("PercentFree") = $percentFree
   $objRecordSet.Update()
   write-host -foregroundColor yellow "/\" -noNewLine
 }
   "`r"
$objRecordSet.Close()
$objConnection.Close()
