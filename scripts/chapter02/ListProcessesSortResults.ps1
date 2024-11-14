# ==============================================================================================
# 
# NAME: ListProcessesSortResults.ps1
# 
# AUTHOR: Ed Wilson , microsoft
# DATE  : 1/4/2007
# Included in: Microsoft Powershell Step by Step
# COMMENT: WMI script. Uses Get-WMIObject
# 1. use of foreach loop  
# 2. command line arguments
# 3. use of Get-WmiObject, Where-Object, Sort-Object and Pipelining
# 4. line continuation: Pipeline character can continue a line, also 
# 5. command separator semi-colon ;
#6. uses Write-Host to write out to Powershell console
#7. uses Out-File to write to text file
#8. uses + to concatenate three strings to form path for file
# ==============================================================================================
$args = "localhost","loopback","127.0.0.1"

foreach ($i in $args)
   {$strFile = "c:\mytest\"+ $i +"Processes.txt"
    Write-Host "Testing" $i "please wait ..."; 
    Get-WmiObject -computername $i -class win32_process | 
    Select-Object name, processID, Priority, ThreadCount, PageFaults, PageFileUsage | 
    Where-Object {!$_.processID -eq 0} | Sort-Object -property name | 
    Format-Table | Out-File $strFile}
