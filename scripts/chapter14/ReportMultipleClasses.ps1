#################################################################################
# ReportMultipleClasses.ps1
# ed wilson, msft, 10/20/2007
#
# Uses get-wmiobject and the root\mscluster namespace 
# Queries one or more wmi classes in clustered server.
# Displays the output on screen, or writes  to tmp text
# file
#
#################################################################################
param(
      $computer="localhost",
      $namespace="root\mscluster",
      $class,
      [switch]$file,
      [switch]$list,
      [switch]$all,
      [switch]$help
     )

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: ReportMultipleClasses.ps1
Queries one or more wmi classes in clustered server.
Displays the output on screen, or writes  to tmp text
file

PARAMETERS: 
-computer  name of the computer
-namespace name of the wmi namespace
-class     name or names of wmi class to query 
-file      writes output to temp file, and displays
           same in notepad
-list      lists the wmi classes in the namespace
-all       queries all wmi classes, output to temp
           file
-help      prints help file

SYNTAX:
ReportMultipleClasses.ps1 
Displays a message that a class is required and displays 
help

ReportMultipleClasses.ps1 -class MSCluster_Network
Prints out a detailed information about the network
interface configuration of the current cluster

ReportMultipleClasses.ps1 -class mscluster_service, mscluster_cluster
Prints out information about the cluster service and the cluster
itself by querying two wmi classes: mscluster_service and the
mscluster_cluster wmi class. note: quotes are not required, but the
classes must be separated with a comma

ReportMultipleClasses.ps1 -all
queries every wmi class in the namespace and writes to a temp
text file. Do not specify -file with this command as it automatically
writes to a text file due to the amound of data returned

ReportMultipleClasses.ps1 -list
Produces a listing of all the wmi classes in the namespace

ReportMultipleClasses.ps1 -list -file
Produces a listing of all the wmi classes in the namespace
and writes the result to a temp text file

ReportMultipleClasses.ps1 -class mscluster_service -file
Queries the mscluster_service wmi class on local machine and
writes the results to a temp text file


ReportMultipleClasses.ps1 -help

Prints the help topic for the script

"@
 $helpText
 exit
} #end function

function funline($strIN)
{
 $num = $strIN.length
 for($i=1 ; $i -le $num ; $i++)
  { 
   $funline = $funline + "=" 
  }
   Write-Host -ForegroundColor yellow `n$strIN 
   Write-Host -ForegroundColor darkYellow $funline
} #end function funhelp

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
} #end function funtestns

Function funList()
{
 funtestNS
 $wmiClasses = Get-wmiobject -computername $computer `
             -namespace $namespace -list
 $header = "There are $($wmiclasses.count) classes" `
         + " in $namespace on $computer
          The WMI classes are listed below: 
           "
 if($file)
  {
   $header |
   out-file -filepath $tmpfile -append
  }
 ELSE
  {
   $header
  }

  $classes = Get-WmiObject -computername $computer -Namespace `
            $namespace -list | 
 Where-Object { $_.name -like '[a-z]*' -and $_.name -notlike 'cim*' } |
 select-object -property name |
 sort-object -property name
 if($file)
  { 
   $classes | 
   out-file -filepath $tmpfile -append
   notepad $tmpfile
  }
 ELSE
  { 
   $classes 
  }
exit
} #end function funlist

function funall()
 {
  funtestNS
  Get-WmiObject -Namespace $namespace -list | 
  Where-Object { $_.name -like '[a-z]*' -and `
  $_.name -notlike 'cim*' } |
  foreach-object `
   { 
    $_.name ; 
    Get-WmiObject -class $_.name -namespace $namespace |
    out-file -filepath $tmpfile -append 
   }
  notepad $tmpfile
  exit
 } #end function funall

function funwmi($class)
 { 
  funtestNS
  Foreach($objClass in $class)
   { 
    Get-WmiObject -class $objclass -computername $computer `
                  -namespace $namespace | 
    foreach-object `
     {  
      funLine("Querying: $objclass on $computer")
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
       If($file)
        {
         $($objClass) | out-file -filepath $tmpfile -append 
         $aryProp | 
         out-file -filepath $tmpfile -append 
        }
       ELSE
        {
         $aryProp
        }
       $aryProp = $null
     } #foreach-object mscluster_node
   } #foreach $objClass  
   if($file) { notepad $tmpfile }
  } #end function funwmi


if($help) { "obtaining help" ; funhelp }
if($file) { $tmpfile = [io.path]::getTempfilename() }
if($list) { "listing classes ..." ; funTestNS ; funList }
if($all)  { 
            $tmpfile = [io.path]::getTempfilename()
            "Querying all wmi classes in $namespace" ; 
            funTestNS ; funAll 
          }
if(!$Class) { "A class is required..." ; funhelp }
funwmi($class)