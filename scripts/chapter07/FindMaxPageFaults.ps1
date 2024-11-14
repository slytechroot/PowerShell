######################################
# FindMaxPageFaults.ps1
# ed wilson, msft, 7/21/2007
# 
# finds the top five processes that 
# genereate page faults
#
######################################
Get-WmiObject -Class win32_process | 
Sort-Object -property pagefaults| 
Select-Object name, pagefaults -last 5