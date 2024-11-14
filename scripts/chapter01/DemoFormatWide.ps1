###############################################
# DemoFormatWide.ps1
# ed wilson, msft, 5/10/2007
# illustrates use of format-wide
# note, when the column text begins to truncate
# now, note how many columns -autosize uses
# uses a function to get the process, and to 
# format-wide. Uses if else to evaluate if $args
# is present. $args is an automatic variable that
# is created when an argument is present. 
# I pass "auto" an argument to the function, BUT
# we do not use the argument. Only if it is present
# or not. 
###############################################

function funGetProcess()
{ 
 if ($args)
  {
   Get-Process | 
   Format-Wide -autosize
  }
 else
  {
   Get-Process | 
   Format-Wide -column $i
  }
}

cls
$i = 1
for 
   ($i ; $i -le 10 ; $i++) 
{ 
  Write-Host -ForegroundColor red "`$i is equal to $i"
  funGetProcess
}
  Write-Host -ForeGroundColor red "Now use format-wide -autosize"
  funGetProcess("auto")
