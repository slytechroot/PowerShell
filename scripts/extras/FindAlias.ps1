#######################################
# FindAlias.ps1
# ed wilson, msft, 5/10/2007
#
# this function uses get-alias to find
# alias for command that gets supplied
# to it when it is called. The function
# would be nice if added to your profile
# it could be done as a parameter to a
# script as well
#
########################################
function findAL()
{
 $a = $args
 Get-Alias | 
 Where-Object { $_.definition -eq $a }
}

findAL("get-childItem")




