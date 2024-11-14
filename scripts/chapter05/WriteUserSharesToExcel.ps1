######################################################
# WriteUserSharesToExcel.ps1
# ed wilson, msft, 6/14/2007
# 
# uses excel.application com object
# there are a lot of differences from VBScript here
#
#
######################################################

$strPath="c:\fso\mySheet.xls"
$objExcel=New-Object -ComObject Excel.Application
$objExcel.Visible=-1 
$WorkBook=$objExcel.Workbooks.Add()
$sheet=$workbook.worksheets.item(1)

$x=2

$strComputer = "."
$objWMIService = Get-WmiObject win32_Share
    
$sheet.Cells.item(1,1)=("Name of Share")
$sheet.Cells.item(1,2)=("Description of Share")
$sheet.Cells.item(1,3)=("Type of Share")


ForEach ($objShare in $objWMIService)
{
    $sheet.Cells.item($x, 1)=($objShare.Name)
    $sheet.Cells.item($x, 2)=($objShare.Description)
	$sheet.Cells.item($x, 3)=($objShare.Type)
	
    If($objShare.type -ne 0)
    {
     $sheet.Cells.item($x,3).font.colorIndex=3 # 32 is blue 16 silver/gray 8 is Aqua, 4 is green, 3 is red
     $sheet.Cells.item($x,3).font.bold=$true
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
