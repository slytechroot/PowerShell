################################################
# WriteAppLogToXML.ps1
# ed wilson, msft, 5/22/2007
#
# uses both get-eventlog and export-clixml
# to dump the application log into an xml file
# this can then be opened in Excel, Access, etc
# the dept of 2 setting is required to get data
# 
###############################################

Get-EventLog application | 
Export-Clixml -Path c:\fso\applog.xml -Depth 2