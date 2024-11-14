#########################################################
# GetDriveArgs.ps1
# ed wilson, msft, 5/21/2007
#
# uses get-wmiObject to perform three different queries
# a command line argument is used to modify the way the 
# script runs. We use switch to make the determination
# Uses the $args default argument variable
# Uses a here string for the help message
# uses write-host cmdlet to print out help string
# uses unusual syntax for wmi. As win32_logicaldisk 
# returns a collection, we can use [1] to get the second
# drive in the collection. And even [1].freespace for disk
#
##########################################################
Function funArg() 
{
switch ($args) 
{
 "all" { gwmi win32_logicalDisk }
 "c"   { (gwmi win32_logicaldisk)[1] }
 "free" { (gwmi win32_logicaldisk)[1].freespace }
 "help" { $help = @"
This script will print out the drive information for
All drives, only the c drive, or the free space on c:
It also will print out a help topic
EXAMPLE: 
 >GetDriveArgs.ps1 all
   Prints out information on all drives
 >GetDriveArgs.ps1 c
   Prints out information on only the c drive
 >GetDriveArgs.ps1 free
   Prints out freespace on the c drive
"@ ; Write-Host $help }
}
}

#$args = "help"
funArg($args)