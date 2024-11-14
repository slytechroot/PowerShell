##################################################
# RunScriptGetPath.ps1
# ed wilson, msft, 8/1/2007
# 
# illustrates multiple ways of getting the path 
# to a script that was run
#
##################################################
function GetScriptPath
{
   $myinvocation.ScriptName
}

$aryclasses = "win32_bios","win32_computersystem"

foreach($class in $aryclasses)
 {
  Get-WmiObject -Class $class
 }

getscriptpath

[IO.Path]::GetFullPath($MyInvocation.MyCommand.Definition)

split-path $myInvocation.MyCommand.Path