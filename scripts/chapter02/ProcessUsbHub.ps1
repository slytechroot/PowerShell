######################################################################
# ProcessUsbHub.ps1
# ed wilson, msft, 5/17/2007
#
# uses get-wmiobject to retrive the win32_usbhub class
# uses foreach-object to begin, process, and end
# the begin prints out the computer name from the env drive
# the process prints out the pnp device ID's
# the end prints out when are done
# You only have access to $_, the pipeline object during process
#
######################################################################

Get-WmiObject win32_usbhub | 
foreach-object `
-begin { Write-Host "Usb Hubs on:" $(Get-Item env:\computerName).value } `
-process { $_.pnpDeviceID}  `
-end { Write-Host "The command completed at $(get-date)" }

