#################################################################################
# AddNodeEvictNode.ps1
# ed wilson, msft, 10/20/2007
#
# Uses get-wmiobject and the root\mscluster namespace and the 
# mscluster_cluster wmi class
# adds or evicts a node to a cluster
# lists current node configuration. implements -whatif
#
#################################################################################
param(
      $computer="localhost",
      $namespace="root\mscluster",
      $node,
      [switch]$add,
      [switch]$evict,
      [switch]$list,
      [switch]$whatif,
      [switch]$help
     )

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: AddNodeEvictNode.ps1
List, Add or evict nodes on cluster

PARAMETERS: 
-computer  name of the computer
-namespace name of the wmi namespace
-node      the cluster node name
-add       add cluster node to cluster
-evict     evict cluster node from cluster
-list      list current node config 
-whatif    prototypes the command
-help      prints help file

SYNTAX:
AddNodeEvictNode.ps1 
Displays missing parameter and calls help

AddNodeEvictNode.ps1 -list
Lists node configuration for a cluster

AddNodeEvictNode.ps1 -node node2 -evict
Evicts node2 from the cluster

AddNodeEvictNode.ps1 -node node2 -evict -whatif
Displays the following: what if: Perform 
operation evict node node2

AddNodeEvictNode.ps1 -node node2 -add
Adds node2 to the cluster

AddNodeEvictNode.ps1 -help

Prints the help topic for the script

"@
 $helpText
 exit
} #end function funhelp

function funwmi()
 {
  $class = "mscluster_node"
  Get-WmiObject -class $class -computername $computer `
                 -namespace $namespace | 
   foreach-object `
    {  
     "Querying: $class on $computer"
      $_.psobject.properties | 
      foreach-object `
       { 
        If($_.value)
         { 
	  if ($_.name -match "__"){}
          ELSE
	   { 
            $aryProp +=@{ $($_.name)=$($_.value) }
           } #else
         } #if($_.value) 
       } #foreach-object $_.psobject.properties
      $aryProp
      $aryProp = $null
    } #foreach-object mscluster_node
  exit
  } #end function funwmi

function funadd()
{
 $class = "mscluster_cluster"
 $objWMI = Get-wmiobject -namespace $namespace -class $class `
           -computername $computer
 $objwmi.addnode($node)
 exit
} #end funadd

function funevict()
{
 $class = "mscluster_cluster"
 $objWMI = Get-wmiobject -namespace $namespace -class $class `
           -computername $computer
 $objwmi.evictnode($node)
 exit
} #end funevict

function funwhatif()
{
 if($evict)
 {
  "what if: Perform operation evict node $node"
 }
 if($add)
 {
  "what if: Perform operation add node $node"
 }
 exit
} #end funwhatif

if($help)   { "obtaining help" ; funhelp }
if($list)   { "listing node config" ; funwmi }
if($whatif) { funwhatif }
if(!$node)  { "A node is required" ; funhelp }
if($add)    { "Adding node $node" ; funadd }
if($evict)  { "Evicting node $node" ; funevict }
if(!$add -or !$evict) { "missing parameter" ; funhelp }