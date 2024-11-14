#################################################################################
# ListSystemRestorePoints.ps1
# ed wilson, msft, 8/18/2007
#
# Uses get-wmiobject and the SystemRestore wmi class
# This class is in the root\default wmi namespace
# uses format-table cmdlet 
# uses a hash table to display calculated values and unique column names in
# the format-table
# passes the status code to a funlookup function ... passes by reference and so
# uses the [ref] type constraint
# uses the Management.ManagementDatetimeConverter .NET framework class to display
# the time stamp in date time format instead of utc format.
#
#################################################################################
param($computer="localhost", $help)

function funLookup([ref]$StrIN)
{
 switch($strIN.value)
  {
   0   { $strIN.value = "APPLICATION INSTALL" }
   1   { $strIN.value = "APPLICATION UNINSTALL" }
   7   { $strIN.value = "SCHEDULED RESTORE POINT" }
   13  { $strIN.value = "CANCELLED OPERATION" }
   10  { $strIN.value = "DEVICE DRIVER INSTALL" }
   12  { $strIN.value = "MODIFY SETTINGS" }  
  }
}

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: ListSystemRestorePoints.ps1
Lists the system restore points on a local or remote machine.

PARAMETERS: 
-computer Specifies name of the computer upon which to run the script
-help     prints help file

SYNTAX:
ListSystemRestorePoints.ps1-computer MunichServer

Lists system restore points on a computer named MunichServer

ListSystemRestorePoints.ps1

Lists system restore points on local computer

ListSystemRestorePoints.ps1-help ?

Displays the help topic for the script

"@
$helpText
exit
}

if($help){ funline("Obtaining help ...") ; funhelp }
Get-WmiObject -Class systemrestore -namespace root\default  `
               -computername $computer |
format-Table -property `
   @{ 
      Label = "Time Created" ;
      Expression = { $([Management.ManagementDatetimeConverter]::`
	  toDateTime($_.creationTime)) } 
	}, 
	"description",
	@{ 
      Label = "RestorePoint Type" ;
      Expression = { $strIN = $_.restorepointtype ; 
	  funlookup([ref]$strIN) ; $strIN } 
	 }, 
	"SequenceNumber" -autosize