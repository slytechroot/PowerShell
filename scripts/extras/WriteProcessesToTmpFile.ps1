#################################################################################
# WriteProcessesToTmpFile.ps1
# ed wilson, msft, 7/24/2007
#
# Uses get-wmiobject and the win32_networkadapterconfiguration wmi class
# uses the funline function
# Uses foreach-object cmdlet
# uses if statement, and the write-host cmdlet, and `n for new line `t for tab
# uses -match to perform regex match in the if statement
#
#################################################################################

$tmpFile= [io.path]::getTempFileName()

Get-WmiObject win32_process | 
Where-Object { $_.commandline } |
format-table -Property name, commandline -autosize |
Out-File -FilePath $tmpFile -encoding ASCII 
$tmpfile # debug
Test-Path $tmpFIle # debug
notepad $tmpFile | Out-Null
Remove-Item $tmpFile
Test-Path $tmpFIle # #debug


