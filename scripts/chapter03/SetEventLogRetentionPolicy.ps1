########################################################
# SetEventLogRetentionPolicy.ps1
# ed wilson, msft, 5/27/2007
#
# uses system.diagnostics.eventlog to retrieve settings
# uses write-host to print out results
# uses new-object to create the eventlog object
# uses $strLog to hold log name
# uses $objLog to hold the eventlog object
# uses modifyOverFlowPolicy method to change settings
########################################################

function DisplayLogSettings() 
{ 
 Write-Host `
 "
 The current settings on the $($objlog.LogDisplayName) file are: 
 max kilobytes: $($objLog.maximumKiloBYtes)
 min retention days: $($objLog.minimumRetentionDays)
 overflow policy: $($objLog.overFlowAction)
"
 if (!$args) { ChangeLogSettings("help") }
}

function ChangeLogSettings($policy) 
{ if($policy -ne "help")
    { 
     Write-Host -ForegroundColor green "changing log policy ..."
    }
 switch($policy) 
  {
   "doNotOW"    { $objlog.modifyoverflowpolicy("DoNotOverwrite",-1) }
   "owAsNeeded" { $objlog.modifyoverflowpolicy("OverwriteAsNeeded",-1) }
   "owOlder"    { $objlog.modifyoverflowpolicy("Overwriteolder",$intRetention) }
   DEFAULT      { 
                 Write-Host -ForegroundColor red `
                  "
                 You need to specify either of the following: `n
                 doNotOW - do not overwrite logs
                 owAsNeeded - overwrite as needed
                 owOlder - overwrite events older than $intRetention days `n
                 Example: > SetEventLogRetentionPolicy.ps1 doNotOW
                            Sets retention policy to Do not Overwrite

                 Example: > SetEventLogRetentionPolicy.ps1 owAsNeeded
                            Sets retention policy to Overwrite as needed

                 Example: > SetEventLogRetentionPolicy.ps1 owOlder
                            Sets retention policy to Overwrite older than 30 days

                 Example: > SetEventLogRetentionPolicy.ps1 help
                            Displays this help message

                  " 
    exit             }
 }
}

$strLog = "application" #modify for different log
$intRetention = 30      #modify for different number of retention days
$objLog = New-Object system.diagnostics.eventlog("$strLog")

DisplayLogSettings($args)
ChangeLogSettings($args)
DisplayLogSettings($args)
