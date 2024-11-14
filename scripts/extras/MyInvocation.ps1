##########################################
# myInvocation.ps1
# ed wilson, msft, 5/17/2007
#
###########################################
Write-Host "
This is the $($myinvocation.mycommand) script.
The Members of the `$myInvocation automatic variable 
are displayed. Note, it is an: $myINvocation object
"
$myinvocation | gm

"`nThis is the invocation live data"
$myInvocation
