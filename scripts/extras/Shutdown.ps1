#######################################
# Shutdown.ps1
# ed wilson, msft, 7/23/2007
#
# Uses get-wmiobject and switch 
# uses the win32_operatingsystem class
# uses reboot() and shutdown() methods
#
#######################################

param($computer="localhost",$action="query", $help)

$erroractionpreference = "SilentlyContinue"

function funeval
{
 switch($rtnCode.returnvalue)
  {
   0 { "$method of $computer successful" }
   DEFAULT { "Error $RTNcode.returnValue occurred $method $computer" }
  }
}

function funHelp
 {
  write-host "Shutdown.ps1 < -computer -action <"sd" "rb" "query" -help <y>"
  Exit
 }

if($help) { funhelp }

$os=Get-WmiObject -Class win32_operatingsystem -computername $computer


switch($action) 
{
 "sd"     { 
           $rtnCode=$os.shutdown()
		$method = "Shutting Down"
		funEval
	  }
 "rb"    {
          $rtnCode=$os.reboot()
		$method = "Rebooting"
		funEval
	  }
 "query" {
          $os
         }
}
