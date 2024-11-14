##############################3
#
# FunctionLib.ps1
#
# holds functions to use with include
# function library
# use an include for a dot source script
# Used by the callfunctionlib.ps1 script
# DO NOT MODIFY WITH OUT CHECKING CALLING 
# script. 
#
########################################

function addOne($intIN)
 {
  $intIN ++
  $intIN
 }

function addTwo($intIN)
 {
  $intIn+=2
  $intIn
 }

#addone(1)
#addtwo(1)