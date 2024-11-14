###############################################
# ListClusterWMIClasses.ps1
# ed wilson, msft, 10/10/2007
#
# lists wmi classes related to clustering
# must be run on a clustered server
#
###############################################
param(
      $computer = "localhost",
      $namespace = "root\mscluster",
      [switch]$help
     )

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: ListClusterWMIClasses.ps1
Lists wmi classes in a wmi namespace

PARAMETERS: 
-computer   name of the computer
-namespace  name of the wmi namespace
-help       prints help file

SYNTAX:
ListClusterWMIClasses.ps1 
Prints out a listing of all Cluster WMI classes
in the root\mscluster wmi namespace on the local
computer. Removes all cim and system classes.

ListClusterWMIClasses.ps1 -computer cluster1
Prints out a listing of all Cluster WMI classes
in the root\mscluster wmi namespace on a remote
computer named cluster1. Removes all cim and system 
classes.

ListClusterWMIClasses.ps1 -help

Prints the help topic for the script

"@
 $helpText
 exit
}

Function funTestNS()
{
 $erroractionpreference="silentlycontinue"
 $objWMI = New-Object -ComObject wbemscripting.swbemlocator
 [void]$objWMI.ConnectServer($computer,$namespace)
 if(!$?) 
   { 
    Write-host -foregroundcolor red "$namespace is not" `
    "a valid wmi namespace on $computer"
    exit
   }
 $erroractionpreference="continue"
}

Function funWMIClass()
{
 $wmiClasses = Get-wmiobject -computername $computer `
             -namespace $namespace -list
 "There are $($wmiclasses.count) classes in $namespace" `
  + " on $computer `nThe WMI classes are listed below: "

 Get-WmiObject -computername $computer -Namespace $namespace -list | 
 Where-Object { $_.name -like '[a-z]*' -and $_.name -notlike 'cim*' } |
 select-object -property name | 
 sort-object -property name
}

if($help) { "obtaining help now ..." ; funhelp }
funTestNS
funWMIClass

