# This function library could used by several scripts. 
# ed wilson, msft, 10/18/2007
####################################################

Function funReboot()
{
 if($computer -ne "localhost")
 {
  if($username)
  {
   $objWMI = Get-WmiObject -Class Win32_operatingsystem `
                -computername $computer -credential $username
   $objWMI.psbase.Scope.Options.EnablePrivileges = $true
   $objWMI.reboot()
  }
  ELSE
   {
    $objWMI = Get-WmiObject -Class Win32_operatingsystem `
                -computername $computer
    $objWMI.psbase.Scope.Options.EnablePrivileges = $true
    $objWMI.reboot()
   }
  exit
 }
 ELSE
 {
  $objWMI = Get-WmiObject -Class Win32_operatingsystem `
               -computername $computer 
  $objWMI.psbase.Scope.Options.EnablePrivileges = $true
  $objWMI.reboot()
  exit
 }
}


function FunEvalRTN($rtn)
{ 
 Switch ($rtn.returnvalue) 
  { 
   0 { Write-Host -foregroundcolor green "No errors for $strCall" }
   66 { Write-Host -foregroundcolor red "$strCall reports" `
       " invalid subnetMask" }
   70 { Write-Host -ForegroundColor red "$strCall reports" `
       " invalid IP" }
   71 { Write-Host -ForegroundColor red "$strCall reports" `
         " invalid gateway" }
   91 { Write-Host -ForegroundColor red "$strCall reports" `
         " access denied"}
   96 { Write-Host -ForegroundColor red "$strCall reports" `
         " unable to contact dns server"}
   DEFAULT { Write-Host -ForegroundColor red "$strCall service reports" `
             " ERROR $($rtn.returnValue)" }
  }
   $rtn=$strCall=$null
}

Function funlist()
{ 
 Write-host "Listing Network adapters on $($computer) `n"

 Get-WmiObject -Class win32_networkadapter `
 -computername $computer | format-list [a-z]*

 Write-host "Listing network adapter configuration on " `
 "$($computer) `n"

 Get-WmiObject -Class win32_networkadapterconfiguration `
 -computername $computer | format-list [a-z]*
 exit
}

