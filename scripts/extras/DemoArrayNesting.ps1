##################################
# demoArrayNesting.ps1
# ed wilson, msft, 7/17/2007
#
# demos nesting an array in the
# element of another array
# also shows how to add an element
##################################

$a = "a","B"
$b = $a, "c"  #here we are nesting an array
"the value of `$b: "
$b
"The value of `$b[0]"
$b[0]
"The value of element 0 in $a `$b[0][0]
$b[0][0]
'The value of $b[1]'
$b[1]

## end of nested array demo ###

'Now add an element to $b. This will fail'
$b[2] = 5

'now lets add an element to $b. this works'
$b +=5

'lets prove that it worked'
$b

'lets retrieve the value of the new element'
$b[2]
