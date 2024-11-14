#################################################################################
# NetworkAdapterConfigFiltered.ps1
# ed wilson, msft, 7/24/2007
#
# Uses get-wmiobject and the win32_networkadapterconfiguration wmi class
# uses the funline function
# Uses foreach-object cmdlet
# uses if statement, and the write-host cmdlet, and `n for new line `t for tab
# uses -match to perform regex match in the if statement
# uses psobject.properties to return the properties of the wmi properties
# examines the value property of the property, and if it exists, return the name
# and the value pair
#
#################################################################################
function funline ($strIN)
{
 $num = $strIN.length
 for($i=1 ; $i -le $num ; $i++)
  { $funline = $funline + "=" }
    Write-Host -ForegroundColor yellow `n$strIN 
    Write-Host -ForegroundColor darkYellow $funline
}

Get-WmiObject win32_networkadapterconfiguration | 
  foreach-object `
    {  
     funLine("Querying: $($_.caption)")
      $_.psobject.properties | 
	   foreach-object `
        { 
         If($_.value)
	      { 
	        if ($_.name -match "__"){}
		    ELSE
	       { 
		    Write-Host "$($_.name)`t`t $($_.value)" 
		   } 
	   }
   } 
}