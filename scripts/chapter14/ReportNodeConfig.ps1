#################################################################################
# ReportNodeConfig.ps1
# ed wilson, msft, 10/20/2007
#
# Uses get-wmiobject and the root\mscluster namespace and the 
# mscluster_node wmi class
# Lists current cluster node configuration 
#
#################################################################################
param(
      $computer="localhost",
      $namespace="root\mscluster",
      $class = "mscluster_node",
      [switch]$help
     )

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: ReportNodeConfig.ps1
Lists current cluster node configuration

PARAMETERS: 
-computer  name of the computer
-namespace name of the wmi namespace
-class     name of wmi class to query 
-help      prints help file

SYNTAX:
ReportNodeConfig.ps1 
Lists node configuration for a cluster

ReportNodeConfig.ps1 
Prints out a listing of node config for cluster
on local computer

ReportNodeConfig.ps1 -computer cluster1
Prints out a listing of node config for cluster
on remote computer named cluster1

ReportNodeConfig.ps1 -help

Prints the help topic for the script

"@
 $helpText
 exit
}

function funline($strIN)
{
 $num = $strIN.length
 for($i=1 ; $i -le $num ; $i++)
  { 
   $funline = $funline + "=" 
  }
   Write-Host -ForegroundColor yellow `n$strIN 
   Write-Host -ForegroundColor darkYellow $funline
}

function funwmi($class)
 {
  Get-WmiObject -class $class -computername $computer `
                 -namespace $namespace | 
   foreach-object `
    {  
     funLine("Querying: $class on $computer")
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
  } #funwmi

if($help) { "obtaining help" ; funhelp }
funwmi($class)