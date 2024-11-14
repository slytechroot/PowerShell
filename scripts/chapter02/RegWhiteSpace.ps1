#################################################################
# RegWhiteSpace.ps1
# ed wilson, msft, 5/21/2007
#
# uses the [regex] accelerator to access regular expressions
# we use the $pattern to define the pattern to use
# we then use the match method to perform a match
# We then use the replace method to replace a blank
# space between words with an underscore.
#
#################################################################
$strText = "a nice line of text. We will search for an expression"
$Pattern = "\s"
$matches = [regex]::match($strText, $pattern)

"Result of using the match method, we get the following:"
$matches

$strReplace = [regex]::replace($strText, $pattern, "_")
"Now we will replace, using the same pattern. We will use
an underscore to replace the space between words:"

$strReplace