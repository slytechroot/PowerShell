############################################
# switchRegEx.ps1
# ed wilson, msft, 5/20/2007
#
# uses switch statement, and regex to
# parse a text file. Uses ${filename} to 
# read a text file into memory. Very cool
# the regex matches the patterns specified
# and then the write-host writes the line
# that was found in the pattern match
#
###########################################

switch -regex (${c:\fso\testa.txt})
{
 'test' {Write-Host $switch.current}
 'good' {Write-Host $switch.current}
}