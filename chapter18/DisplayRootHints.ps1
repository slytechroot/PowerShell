#-------------------------------------------------------------------
# DisplayRootHints.ps1
# ed wilson, msft, 9/19/2007
#
# Uses the MicrosoftDNS_AType wmi class to retrieve A records
# Uses where-object to examine th ownername property and look for 
# word root. When found, it then displays the results in a table
# by using format-table cmdlet. It uses Get-wmiobject cmdlet to
# retrieve the dns class. The DNS wmi classes are in the 
# root\microsoftdns wmi namespace.
#------------------------------------------------------------------

Get-WmiObject -Namespace root\microsoftdns -Class MicrosoftDNS_AType | 
Where-Object { $_.ownerName -match 'root' } | 
format-table textRepresentation