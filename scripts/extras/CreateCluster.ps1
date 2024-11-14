#################################################################################
# CreateCluster.ps1
# ed wilson, msft, 10/20/2007
#
# Uses get-wmiobject and the root\mscluster namespace and the 
# mscluster_cluster wmi class
# Creates a cluster
#
#################################################################################
param(
      $computer="localhost",
      $namespace="root\mscluster",
      $name,
      $node,
      $ip,
      $subnet,
      $quorum,
      [switch]$whatif,
      [switch]$help
     )

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: CreateCluster.ps1
Creates a cluster

PARAMETERS: 
-computer  name of the computer
-namespace name of the wmi namespace
-name      name of the cluster
-node      name of the node(s)
-ip        ip address of the cluster
-subnet    subnet mask
-quorum    path to quorum
-whatif    prototypes the command
-help      prints help file

SYNTAX:
CreateCluster.ps1 
Displays a parameter is required, and 
calls help

CreateCluster.ps1 -list
Lists node configuration for a cluster

CreateCluster.ps1 -name cluster1 -node node1 `
-ip "192.168.2.200" -subnet "255.255.255.0" `
-quorum "Q:"

Creates a cluster named cluster1 and adds
node1 to the cluster. Assigns the ip address
of 192.168.2.200 to the cluster with the 
subnet mask of 255.255.255.0. The quorum
drive will be the Q drive. 

CreateCluster.ps1 -name cluster1 -node node1 `
-ip "192.168.2.200" -subnet "255.255.255.0" `
-quorum "Q:" -whatif

Displays the following: what if: Perform operation 
create cluster cluster 1 node node1 IP 192.168.2.200
subnet mask 255.255.255.0 and quorum Q:

CreateCluster.ps1 -help

Prints the help topic for the script

"@
 $helpText
 exit
} #end function funhelp

function funcreateCluster()
 {
  $class = "mscluster_cluster"
  $objWMI = Get-WmiObject -class $class `
            -computername $computer `
            -namespace $namespace
   $objWMI.createCluster($name, $node, $ip, $subnet, $quorum)
  exit
  } #end function funcreateCluster

function funwhatif()
{
 "what if: Perform operation create cluster $name `n" `
 + "node $node with IP $ip subnet mask $subnet and `n" `
 + "quorum $quorum"
  exit
}

if($help)   { "obtaining help" ; funhelp }
if($whatif) { funwhatif }
if(!$name -or !$node -or !$ip -or !$subnet) 
  { 
   Write-host -foregroundcolor cyan "missing parameter"
   funhelp 
  }
funCreateCluster 