###################################################
#
# funline2.ps1
# ed wilson, msft, 8/10/2007
# 
# passes the string to the function by reference
# there is a system.object .net class called
# psreference [ref] that allows us to do this
# when passed by reference, we can change the value
# of the variable prior to handing it back
# this allows us to return a value from the function
# 
# in the funline2 function, we build up a line the
# length of the value of the variable that is passed
# we then add it to the present value, and then
# pass the bundle back
#
####################################################
function funline ([ref]$strIN)
{ 
 
 $num = $strIN.value.length
 for($i=1 ; $i -le $num ; $i++)
  { $funline += "=" }
    $strIN.value = "$($strIN.value)`n" + $funline
}

$strIN = "This is a string"
funline([ref]$strIN)

$strIN