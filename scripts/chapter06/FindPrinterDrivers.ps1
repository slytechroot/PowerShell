######################################################
# FindPrinterDrivers.ps1
# ed wilson, msft, 6/10/2007
#
# looks for printer drivers included with the OS.
# they are in the inf folder of the %systemroot%
# They are inf files, and have prn in the name
# This script finds these exact things
#
######################################################

Get-ChildItem ((Get-Item Env:\systemroot).value+"\inf") -Exclude *.pnf | 
Where-Object { $_.name -match "prn" } | 
Sort-Object -Property name |
format-table -Property name, length, creationTime, lastWriteTime


