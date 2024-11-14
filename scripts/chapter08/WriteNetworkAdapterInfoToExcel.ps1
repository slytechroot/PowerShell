######################################################
# WriteNetworkAdapterInfoToExcel.ps1
# ed wilson, msft, 7/22/2007
# 
# uses excel.application com object
# there are a lot of differences from VBScript here
#
#
######################################################

$strPath="c:\fso\netAdapter.xls"
$objExcel=New-Object -ComObject Excel.Application
$objExcel.Visible=-1 
$WorkBook=$objExcel.Workbooks.Add()
$sheet=$workbook.worksheets.item(1)

$x=2

$Computer = $env:computerName
$objWMIService = Get-WmiObject -class win32_NetworkAdapter `
   -computer $Computer
for($b=1 ; $b -le 10 ; $b++)
  {$sheet.Cells.item(1,$b).font.bold=$true}
$sheet.Cells.item(1,1)=("Name of Adapter")
$sheet.Cells.item(1,2)=("Interface Index")
$sheet.Cells.item(1,3)=("Index")
$sheet.Cells.item(1,4)=("DeviceID")
$sheet.Cells.item(1,5)=("AdapterType")
$sheet.Cells.item(1,6)=("MacAddress")
$sheet.Cells.item(1,7)=("netconnectionid")
$sheet.Cells.item(1,8)=("NetConnectionStatus")
$sheet.Cells.item(1,9)=("NetworkAddresses")
$sheet.Cells.item(1,10)=("PermanentAddress")

ForEach ($objNet in $objWMIService)
{
    $sheet.Cells.item($x, 1)=($objNet.Name)
    $sheet.Cells.item($x, 2)=($objNet.InterfaceIndex)
	$sheet.Cells.item($x, 3)=($objNet.index)
	$sheet.Cells.item($x, 4)=($objNet.DeviceID)
    $sheet.Cells.item($x, 5)=($objNet.adapterType)
	$sheet.Cells.item($x, 6)=($objNet.MacAddress)
	$sheet.Cells.item($x,7)=($objNet.netconnectionid)
    $sheet.Cells.item($x,8)=($objNet.NetConnectionStatus)
    $sheet.Cells.item($x,9)=($objNet.NetworkAddresses)
    $sheet.Cells.item($x,10)=($objNet.PermanentAddress)

    If($objNet.AdapterType -notMatch 'ethernet')
    {
     $sheet.Cells.item($x,5).font.colorIndex=3 # 32 is blue 16 silver/gray 8 is Aqua, 4 is green, 3 is red
     $sheet.Cells.item($x,5).font.bold=$true
    }
	$x++
}
 $range = $sheet.usedRange
 $range.EntireColumn.AutoFit()

IF(Test-Path $strPath)
  { 
   Remove-Item $strPath
   $objExcel.ActiveWorkbook.SaveAs($strPath)
  }
ELSE
  {
   $objExcel.ActiveWorkbook.SaveAs($strPath)
  }

