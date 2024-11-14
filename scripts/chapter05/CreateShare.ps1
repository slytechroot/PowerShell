##########################################################
# CreateShare.ps1
# ed wilson, msft, 6/24/2007
#Creates a share using win32_share. Uses default Share permissions
#It can be remote machine
#For a local computer, we check for the folder, and creates the folder
#BUT it cannot create folder remotely - so the folder will need to exist.
#We do a query for the name of the share. If it exists, then we
#delete the dude. If it does not exist, then we go on to the next sub. 
#Need to have admin rights to create shares.
###########################################################################
param($folderPath, $shareName, $maxAllowed=5, $description="Created by PowerShell")

function funHelp()
{
$helpText=@"

NAME: CreateShare.ps1
Creates a share on a local machine using default permissions
The folder to be shared does not need to exist as the script
checks for the existance of the folder and will create it if
it is not present

PARAMETERS:
-folderPath  Specifies the path to the folder you wish to share
-shareName   Specifies the name to assign to the share
-maxAllowed  [optional] the maximum number of connections
-description [optional] description of the share (notes, reason etc)

SYNTAX:
CreateShare.ps1 -folderPath "c:\fso" -shareName "fso"

Creates a share of the folder c:\fso and gives it the name fso
5 people will be allowed to access the share, and it has a 
description of Created by PowerShell

CreateShare.ps1 -folderPath "c:\fso" -shareName "fso" -maxAllowed 1

Creates a share of the folder c:\fso and gives it the name fso
1 person will be allowed to access the share, and it has a 
description of Created by PowerShell

CreateShare.ps1 -folderPath "c:\fso" -shareName "fso" -maxAllowed 3 -description "fso share"

Creates a share of the folder c:\fso and gives it the name fso
3 people will be allowed to access the share, and it has a 
description of fso share

"@
$helpText
exit
}

Function funlookup($intIN)
{
 Switch($intIN)
 {
  0  { "Success" }
  2  { "Access denied" }
  8  { "Unknown failure" } 
  9  { "Invalid name" } 
  10 { "Invalid level" } 
  21 { "Invalid parameter" } 
  22 { "Duplicate share" } 
  23 { "Redirected path" } 
  24 { "Unknown device or directory" } 
  25 { "Net name not found" }
  DEFAULT { "$intIN is an Unknown value" }

 }
}


if(!($folderpath)) { "you must supply a path" ; funHelp }
if(!($sharename))  { "you must supply a name" ; funHelp }

$class = "Win32_share"
$Type = 0
if(!(Test-Path $folderPath))
 {
  "Creating $folderPath ..."
  New-Item -Path $folderPath -type directory
 }
$objWMI = [wmiClass]$class 
$errRTN=$objWMI.create($folderPath, $shareName, $Type, $MaxAllowed, $description)
funLookup($errRTN.returnValue)
