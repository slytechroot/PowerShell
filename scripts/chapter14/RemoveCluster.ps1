#################################################################################
# RemoveCluster.ps1
# ed wilson, msft, 10/20/2007
#
# Uses get-wmiobject and the root\mscluster namespace and the 
# mscluster_cluster wmi class
# Removes a cluster
#
#################################################################################
param(
      $computer="localhost",
      $namespace="root\mscluster",
      [switch]$remove,
      [switch]$list,
      [switch]$force,
      [switch]$whatif,
      [switch]$help
     )

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: RemoveCluster.ps1
Removes a cluster

PARAMETERS: 
-computer  name of the computer
-namespace name of the wmi namespace
-remove    removes the cluster
-list      displays cluster info
-whatif    prototypes the command
-help      prints help file

SYNTAX:
RemoveCluster.ps1 
Displays a parameter is required, and 
calls help

RemoveCluster.ps1 -list
Lists cluster configuration info

RemoveCluster.ps1 -remove

Removes the cluster 

RemoveCluster.ps1 -remove -whatif

Displays the following: what if: Perform operation 
Remove cluster

RemoveCluster.ps1 -help

Prints the help topic for the script

"@
 $helpText
 exit
} #end function funhelp

function funList()
 {
  $class = "mscluster_cluster"
  $objWMI = Get-WmiObject -class $class `
            -computername $computer `
            -namespace $namespace
   $objWMI
  exit
  } #end function funList

function funCountResource()
{
 $count = (Get-WmiObject -computername $computer -Namespace `
           $namespace -Class mscluster_resource).count
 if($count -gt 0)
   { 
    "There are still $($count) resources on $computer"
    "You should not attempt to delete the cluster with"
    "published resources. If you are sure you "
    "can use the -force to avoid this check"
    }
    exit
}
function funRemoveCluster()
 {
  if(!$force) { funCountResource }
  $class = "mscluster_cluster"
  $objWMI = Get-WmiObject -class $class `
            -computername $computer `
            -namespace $namespace
  $objWMI.psbase.Scope.Options.EnablePrivileges = $true
  $objWMI.DestroyCluster($true)
  exit
  } #end function funRemoveCluster

function funwhatif()
{
 $class = "mscluster_cluster"
 $objWMI = Get-WmiObject -class $class `
              -computername $computer `
              -namespace $namespace
 "what if: Perform operation Remove cluster $($objwmi.name)"
  exit
}

if($help)   { "obtaining help" ; funhelp }
if($list)   { "current config" ; funlist }
if($whatif) { funwhatif }
if($remove) { funRemoveCluster }
if(!$help -or !$list -or !$remove) { funhelp }