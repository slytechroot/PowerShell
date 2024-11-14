###########################################################
# QueryOldFiles.ps1
# ed wilson, msft, 7/18/2007
#
# Uses variable to hold folder, date, and date limit
# Uses Get-ChildItem, and ForEach-Object
# uses the addDays() method to add the limit to 
# lastAccessTime.
# uses new-timespan to calculate number of days between
# when file was accessed, and 30 days hence
# Uses a hash table to hold the name and the lastAccessTime
# Uses count property of hashTable to count files
#
###########################################################
function funline ($strIN)
{
 $num = $strIN.length
 for($i=1 ; $i -le $num ; $i++)
  { $funline = $funline + "=" }
    Write-Host -ForegroundColor yellow $strIN 
    Write-Host -ForegroundColor darkYellow $funline
}

$folder = "c:\fso"
$date = Get-Date
$limit = 30

Get-ChildItem -Path $folder -force |
foreach-object `
{ 
 $newDate=($_.LastAccessTime).adddays($limit) 
 $limitDate = New-TimeSpan -start $date -end $newDate

 if ($limitDate -le 0) 
  { 
   $xfiles += @{ $_.name = $_.lastAccessTime }
  }
    
}
Write-Host "There are $($xfiles.count) files from $folder greater than $limit days old."
FunLine("The expired files are listed below:")

$xfiles
