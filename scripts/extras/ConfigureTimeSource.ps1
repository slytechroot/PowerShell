#############################################################################
#
# ConfigureTimeSource.ps1
# ed wilson, msft, 9/14/2007
# 
# uses various net time commands and params
#
#########################################################################

param($computer="localhost",$a,$timeServer,$help)

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: SetTimeSource.ps1 
Prints and sets the current time source on a local or remote machine.

PARAMETERS: 
-computer   Specifies the name of the computer upon which to run the script
-a(ction)   The specific action to perform < qt, qs, s >
-timeServer The name of the time server to use
-help       prints help file

SYNTAX:
SetTimeSource.ps1 -computer MunichServer

Lists current time on a computer named MunichServer

SetTimeSource.ps1 

Lists current time on local computer

SetTimeSource.ps1 -computer MunichServer -a qs

Lists current time server on a computer named MunichServer

SetTimeSource.ps1 -computer MunichServer -a s -timeServer 192.168.2.5

Sets the current time server on a computer named MunichServer
to 192.168.2.5

SetTimeSource.ps1 -help ?

Displays the help topic for the script

"@
$helpText
exit
}

if($help){funline("Obtaining help ...") ; funhelp }

switch($a)
{
 "qt"    { net time \\$computer }
 "qs"    { net time \\$computer  /querySNTP}
 "s"     { net time \\$computer /setSNTP:$timeServer }
 DEFAULT { 	net time \\$computer }
}
