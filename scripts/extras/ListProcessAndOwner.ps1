####################################
# ListProcessAndOwner.ps1
# ed wilson, msft, 5/17/2007
#
# uses get-wmiobject to return
# the win32_process class. We
# then select only the name and
# we use the getOwner method to
# get the owner information.
# Format-list [a-z]* strips off the
# system properties
#
####################################

Get-WmiObject win32_process | 
   foreach {
      $_.name ;   
	  $_.getOwner() } | 
   format-list [a-z]*