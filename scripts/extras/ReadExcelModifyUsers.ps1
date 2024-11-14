#-----------------------------------------------------------------------------
# ReadExcelModifyUsers.ps1
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
# makes connection to AD using [adsi], the adsi type accelerator to accelerate
# using adsi in the script.
#------------------------------------------------------------------------------

$strPath="c:\Chapter13\NewUser.xls"
$objExcel=New-Object -ComObject Excel.Application
$objExcel.Visible=$false
$WorkBook=$objExcel.Workbooks.Open($strPath)
$worksheet = $workbook.sheets.item("newuser")
$intRow = 4
$intRowMax =  ($worksheet.UsedRange.Rows).count
$intHdrRow = 3
$intcolumn = $null
$lname = 3 
$intName = 1
$intOU = 2
$CLass = "User"
$dc = "dc=nwtraders,dc=com" # modify as required

for($introw = 4 ; $intRow -le $intRowMax ; $intRow++)
{
 $name = $worksheet.cells.item($intRow,$intName).value2
 $ou =  $worksheet.cells.item($intRow,$intOU).value2
 "Modifying $name,$ou,$dc"
 $ADSI = [ADSI]"LDAP://$name,$ou,$dc" 

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
		 $ADSI.put($property, $value)
	    }
   }
$ADSI.setInfo()
}
$objexcel.quit()