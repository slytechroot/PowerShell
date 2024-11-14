#######################################################################
# EvaluateServicesAndCount.ps1
# ed wilson, msft, 6/10/2007
#
# uses get-wmiObject to retrieve the win32_service class
# uses foreach statement to walk through collection of services
# uses switch to count services, and to retrieve the names
# note: use WordPad to view the report. Notepad does not handle the `n
#######################################################################
$a=$m=$d=0 
$lsvc=$lsys=$nsvc=$osn=0
$objWMIService = Get-WmiObject -Class win32_service -computer localhost
  
foreach ($i in $objWMIService) 
{
switch ($i.startmode) 
{
 "auto"     { $a++ ; $auto+="$($i.name)`n"}
 "manual"   { $m++ ; $manual+="$($i.name)`n"}
 "disabled" { $d++ ; $disabled+="$($i.name)`n"}
 DEFAULT { }
}
switch -regex ($i.startName)
{
 "localsystem"    { $lsys++ }
 "localservice"   { $lsvc++ }
 "NetworkService" { $nsvc++ }
 DEFAULT           { $osn++ ; $otherServiceNames+="$($i.startName)`n"}
}
}

$string =  @"
There are $($objWMIService.length) services defined
They start as follows:
automatic $a Manual $m disabled $d

The automatic services are: 
---------------------------
$auto

The manual services are:
------------------------
$manual

The disabled services are:
--------------------------
$disabled


The services start using the following accounts:
 localsystem $lsys times
 localService $lsvc times 
 networkService $nsvc times
 Other user id $osn times
"@

if($osn -ne 0) 
{ 
$string+= @"

The other ids in use are listed here:
$otherServiceNames

You should investigate the passwords being used by:
$otherServiceNames
"@
}
Out-File -InputObject $string -FilePath c:\fso\a.txt




