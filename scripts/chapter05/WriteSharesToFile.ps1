########################################################################
# WriteSharesToFile.ps1
# ed wilson, msft, 6/29/2007
# 
# uses get-wmiobject to retrieve properties of win32_share class
# uses format-table to remove table headers and select property
# uses out-file to write to text file, and to use ASCII formatting.
#
#########################################################################
$class = "win32_share"
$filePath = "c:\fso\shares.txt"
Get-WmiObject -class $class | 
Format-Table -property name -hidetableheader |
Out-File -FilePath $filePath -encoding ASCII 