# CallFunctionLib.ps1
# ed wilson, msft
# illustrates dot sourcing functions from another script. Also called 
# an include.
# this allows access to both functions from the functionlib.ps1 script
# to dot source you preceed the path with dot . and a space as in 
# . c:\fso\functionlib.ps1
#
######################################################################

. c:\fso\functionlib.ps1 
addone(1)
addtwo(2)

gci function:\