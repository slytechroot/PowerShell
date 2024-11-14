#
# UsePSObject.ps1
# ed wilson, msft, 7/27/2007
# illustrates using psobject to return a list of
# properties, and print out the name of the property
# and the associated value.
#

(get-wmiobject win32_bios).psobject.properties | 
Format-Table name, value -AutoSize