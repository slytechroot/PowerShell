########################################################
# killSpecificProcessesFromText.ps1
# ed wilson, msft, 7/4/2007
# reads a text file and then kills the processes
# calculates the memory savings prior to offering 
# to kill the processes.
# Uses read-host to solicit user input when script is
# run
# uses switch to evaluate the yes or no input
#
#######################################################

$mem = 0
$procFile = "H:\BU_9_6_2007_FULL\FSO\annoy.txt" #DEMO FILE ... use Annoy.txt for real

Get-process -name $(Get-Content $procFile) -ErrorAction continue |
foreach ($_.workingset) { $mem += $_.workingset }
"{0:N2}"-f $($mem/1MB) +" meg of ram is being consumed by $procFile Processes" 

$rtnPrompt = Read-Host -Prompt `
  " 
   would like to kill $procfile processes? 
   <y / n>
  "

switch($rtnPrompt) 
{
 "y" { 
      Write-Host -BackgroundColor green "$procfile processes will be killed..." 
	  stop-process -name $(Get-Content $procFile) -ErrorAction continue 
	 }
 "n" { Write-Host -BackgroundColor yellow "$procfile processes will not be killed" }
 default { Write-Host -BackgroundColor red "Response y or n expected. exiting..." ;
           exit
		 }
}