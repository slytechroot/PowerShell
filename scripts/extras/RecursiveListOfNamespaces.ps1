# recursiveListOfNamespaces.ps1
# ed wilson, 7/18/2007
# 
# uses get-wmiobject to retrieve list of namespaces
# feeds this list to get-wmiobject and does
# another query.
#
#####################################################

get-wmiobject -Class __namespace -Namespace root | 

foreach {
 Write-host $_.__path
 Get-WmiObject -class __namespace -namespace "root\$($_.name)" } | 
format-list [a-z]*