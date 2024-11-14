#################################################################################
# BackupFolderToServer.ps1
# ed wilson, msft, 8/15/2007
#
# Uses copy-item cmdlet to copy items to a mapped drive
# uses the -recurse switch to copy nested folders
# 
#
#################################################################################

param($source, $destination, $help)

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: BackupFolderToServer.ps1 
Backes up files in a folder to a mapped drive. The destination
folder does not have to be present

PARAMETERS: 
-source      the source of the files and folders
-destination where the files are to be copied
-help        prints help file

SYNTAX:
BackupFolderToServer.ps1 -source c:\fso -destination h:\fso

Backs up all files and folders in c:\fso on local machine to
a mapped drive called h. The \fso folder does not need to 
exist on the h:\ drive.

BackupFolderToServer.ps1 

generates an error. the -source and -destination parameters
must be present

BackupFolderToServer.ps1 -help ?

Displays the help topic for the script

"@
$helpText
exit
}

if($help){ "Obtaining help ..." ; funhelp }

if(!$source -or !$destination) 
  { 
    $(throw "You must supply both source and destination.
	 Try this BackupFolderToServer.ps1 -help -?") 
  }
Copy-Item -Path $source -destination $destination -recurse