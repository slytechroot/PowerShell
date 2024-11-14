################################################
# Find2LetterAlias.ps1
# ed wilson, msft, 6/10/2007
#
# identifies all alias that are 2 letters
# long. Sorts by name
# uses get-alias, where-object and sort-object
#
###############################################

Get-Alias | 
Where-Object { ($_.name).length -eq 2 } | 
Sort-Object -Property name