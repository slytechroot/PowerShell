#############################################
# GetTopMemory.ps1
# ed wilson, msft, 5/17/2007
#
# uses get-process to obtain a listing of
# processes. Then uses sort-object to arrange
# by memory consumption. Then uses Select-
# object to choose the top five memory users
#
############################################

Get-Process | 
Sort-Object workingset -Descending | 
Select-Object -First 5