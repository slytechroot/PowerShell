############################################## 
# DocumentHelpExamples.ps1
# ed wilson, 9/10/2007
# uses the members of the help object
# uses get-command to retrieve all cmdlets
#
##############################################
$command = Get-Command

foreach($cmdlet in $command)
{ "`nCode Examples in $cmdlet`n" | Out-File c:\fso1\commands.txt -Append
 (Get-Help $cmdlet).examples.example | 
  foreach { $_.code } | Out-File c:\fso1\commands.txt -Append
}