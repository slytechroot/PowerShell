#################################################################################
# ReportClusterConfig.ps1
# ed wilson, msft, 10/20/2007
#
# Uses get-wmiobject and the root\mscluster namespace and the 
# mscluster_cluster wmi class
# uses the funline function
# Uses foreach-object cmdlet
# uses if statement, and the write-host cmdlet, and `n for new line `t for tab
# uses -match to perform regex match in the if statement
# filters out properties that return no value by using psobject
# in this way we avoid null and empty property values cluttering up screen
# use hash table to collect the output, and display 
#
#################################################################################
param(
      $computer="localhost",
      $namespace="root\mscluster",
      $class = "mscluster_cluster",
      [switch]$help
     )

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: ReportClusterConfig.ps1
Lists current cluster configuration

PARAMETERS: 
-computer  name of the computer
-namespace name of the wmi namespace
-class     name of wmi class to query 
-help      prints help file

SYNTAX:
ReportClusterConfig.ps1 
Prints out a listing of current cluster config
on local computer

ReportClusterConfig.ps1 -computer cluster1
Prints out a listing of current cluster config
on remote computer named cluster1

ReportClusterConfig.ps1 -help

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
    } #foreach-object mscluster_cluster
  } #funwmi

if($help) { "obtaining help" ; funhelp }
funwmi($class)