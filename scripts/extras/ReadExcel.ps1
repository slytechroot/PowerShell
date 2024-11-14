#-----------------------------------------------------------------------------
# ReadExcel.ps1
# ed wilson, 9/15/2007, msft
# 
# uses excel.application comobject to read from an excel spreadsheet
# this syntax is excel 2007 and has not been tested on earlier versions
# Once the excel.application com object has been created, we use the item
# method of the sheets object to connect to the a spread sheet named newuser
# we then use the usedrange object and query the rows property and get the count
# of the max number of rows
# our user information starts on row 4, and row 3 has all the attribute names
# in our newuser.xls spread sheet
# we use the item method to retrieve the values of each cell in our range
# cells is a property of the sheet object, and returns a cells object
#
#------------------------------------------------------------------------------

$strPath="H:\BU_9_6_2007_FULL\BookDocs\WindowsPowerShell\Chapter13\NewUser.xls"
$objExcel=New-Object -ComObject Excel.Application
$objExcel.Visible=$false
$WorkBook=$objExcel.Workbooks.Open($strPath)
$worksheet = $workbook.sheets.item("newuser")
$intRow = 4
$intRowMax =  ($worksheet.UsedRange.Rows).count
$intHdrRow = 3
$intcolumn = $null
$lname = 3 
for($introw = 4 ; $intRow -le $intRowMax ; $intRow++)
{
  for($intcolumn = 1 ; $intcolumn -le 30 ; $intcolumn++)
  {
   if ($worksheet.cells.item($intRow,$intcolumn).value2 -eq $null)
   {
    "missing value for $($worksheet.cells.item($intHdrRow,$intcolumn).value2)" +
	"for user $($worksheet.cells.item($intRow,$lname).value2)"
   }
   ELSE { 
         Write-host -ForegroundColor green $worksheet.cells.item($intHdrRow,$intcolumn).value2
	     $worksheet.cells.item($intRow,$intcolumn).value2
	    }
   }
}
$objexcel.quit()