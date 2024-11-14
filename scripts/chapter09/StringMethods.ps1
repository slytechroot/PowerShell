#########################
# StringMethods.ps1
# ed wilson, 8/1/2007
# 
# illustrates using a few 
# methods from the 
# system.string class
#
##########################

$a="this is a string"
$a=$a.toUpper()
$a
$a=$a.ToLower()
$a
$a=$a.replace("a","the")
$a
