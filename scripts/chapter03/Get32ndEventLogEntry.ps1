##############################
# Get32ndEventLogEntry.ps1
# ed wilson, msft, 5/26/2007
# retrieves specific event
# log entry by element number
# Array is 0 based so is 31
# not 32 in [31]
#############################
(get-eventlog system)[31]