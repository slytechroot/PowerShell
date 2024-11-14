##########################################################
# CreateMultipleShares.ps1
# ed wilson, msft, 6/25/2007
# Creates multiple shares using win32_share. Uses default Share permissions
# It can be run against a remote machine
# For a local computer, we check for the folder, and create the folder
# BUT it cannot create folder remotely - so the folder will need to exist.
# We do not query for the name of the share. If it exists, then a duplicate 
# share error will be generated.
###########################################################################
param($folderPath, $shareName, $maxAllowed=5, $description="Created by PowerShell")

function funHelp()
{
$helpText=@"

NAME: CreateMultipleShares.ps1
Creates multiple shares on a local machine using default permissions
The folder to be shared does not need to exist as the script
checks for the existance of the folder and will create it if
it is not present

PARAMETERS:
-folderPath  Specifies the path to the folder you wish to share
-shareName   Specifies the name to assign to the share
-maxAllowed  [optional] the maximum number of connections
-description [optional] description of the share (notes, reason etc)

SYNTAX:
CreateMultipleShares.ps1 -folderPath "c:\fso", "c:\fso1" `
-shareName "fso", "fso1"

Creates two shares of the folder c:\fso, and c:\fso1 and 
gives it the name fso, and fso1 5 people will be allowed 
to access the shares, and they have a description of 
Created by PowerShell

CreateMultipleShares.ps1 -folderPath "c:\fso", "c:\fso1 `
-shareName "fso", "fso1" -maxAllowed 1

Creates two shares of the folder c:\fso, and c:\fso1 and 
gives it the name fso and fso1 1 person will be allowed 
to access the shares, and they have a description of 
Created by PowerShell

CreateMultipleShares.ps1 -folderPath "c:\fso", "c:\fso1", "c:\fso2" `
-shareName "fso", "fso1", "fso2" -maxAllowed 3 -description "fso share"

Creates three shares of the folder c:\fso, c:\fso1, c:\fso2 
and gives it the name fso, fso1, fso2 3 people will be allowed
to access the shares, and they have a description of fso share

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
$iLength = $folderPath.length-1

for($i=0;$i -le $iLength;$i++)
{
if(!(Test-Path $folderPath[$i]))
 {
  "Creating $folderPath ..."
  New-Item -Path $folderPath[$i] -type directory
 }
$objWMI = [wmiClass]$class 

$folder= $folderPath[$i] 
$share= $shareName[$i]
$errRTN=$objWMI.create($folder, $share, $Type, $MaxAllowed, $description)
funLookup($errRTN.returnValue)
}
