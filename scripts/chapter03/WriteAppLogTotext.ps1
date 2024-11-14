#############################################
# WriteAppLogToText.txt
# ed wilson
#
# uses get-eventlog to get the app log and
# write the output to a text file.
#
##############################################

Get-EventLog application > c:\fso\applog.txt