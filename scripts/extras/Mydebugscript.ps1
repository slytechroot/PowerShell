# mydebugscript.ps1
# ed wilson, msft, 8/28/2007
#
# illustrates the use of debug statements
#
#########################################

$a = 5
$b = 4
'$a is ' + $a # debug
'$b is ' +$b  # debug
$c = $a + $b
"The answer to `$a + `$b is $c"