##############################################
# getDesktop.ps1
# ed wilson, msft, 6/1/2007
#
# gets the path to the desktop. stores in $a
# uses the wshshell object
# uses the specialfolders property, AND item
# to retrieve path to a special folder
#
##############################################
$a=(New-Object -ComObject wscript.shell).specialFolders.item("desktop")