#################################################################################
# JoinDomainJoinWorkgroup.ps1
# ed wilson, msft, 8/15/2007
#
# Uses get-wmiobject cmdlet. allows for use of alternate credentials for remote
# This script must run with ADMIN rights to reboot a remote machine
# a reboot will be required for new domain name to take effect
#
#################################################################################

param(
      $computer="localhost", 
      $domainName, 
      $username,
      $password,
      $accountOU,
      [switch]$unjoin,
      [switch]$workgroup, 
      [switch]$reboot,
      [switch]$help
     )

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: JoinDomainJoinWorkgroup.ps1 
Renames a local or remote machine.

PARAMETERS: 
-computer   Specifies the name of the computer upon which to run the script
-domainName name of the domain or workgroup
-username   user credentials 
-password   user password
-accountOU  OU to place the computer
-workgroup  place in workgroup not domain
-unjoin     unjoin domain or workgroup
-reboot     reboots computer
-help       prints help file

SYNTAX:
JoinDomainJoinWorkgroup.ps1 
Displays message you must supply an action. calls help

JoinDomainJoinWorkgroup.ps1 -reboot
Reboots the local computer

JoinDomainJoinWorkgroup.ps1 -reboot -computer MunichServer
Reboots the remote computer named MunichServer

JoinDomainJoinWorkgroup.ps1 -computer MunichServer -domainName nwtraders.com `
-username nwtraders\administrator -password Password1 -reboot

Joins a remote computer named MunichServer to the nwtraders.com domain
using the nwtraders\administrator account and password of Password1.
When the join is complete, it will reboot the machine. The computer
account is placed in default location which is by default is the
computers container.

JoinDomainJoinWorkgroup.ps1 -computer MunichServer -domainName nwtraders.com `
-accountOU "OU=testOU,DC=Nwtraders,DC=com" -username `
administrator@nwtraders.com -password Password1

Joins a remote computer named MunichServer to the nwtraders.com domain
using the administrator@nwtraders.com account and password of Password1.
The computer account is placed in test OU in Nwtraders.com domain. The
computer is NOT rebooted after joining. 

JoinDomainJoinWorkgroup.ps1 -computer MunichServer -domainName workgroup1 `
-reboot -username munichServer\administrator -password Password1 `
-workgroup

Joins a remote computer named MunichServer to a workgroup named workgroup1. 
Uses the local administrator account with a password of Password1. It then
reboots the computer to complete joining the workgroup. 


JoinDomainJoinWorkgroup.ps1 -help

Displays the help topic for the script

"@
$helpText
exit
}

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

Function FunJoinDomain()
{
 if($workgroup) 
   { $option = $null }
 ELSE 
   { $option = 1 } # join a domain
 $objWMI = Get-WmiObject -Class Win32_computersystem `
                -computername $computer
 $objWMI.psbase.Scope.Options.EnablePrivileges = $true
 $objWMI.JoinDomainOrWorkgroup($domainName,$password,$userName,$accountOU,$option)
 exit
}

Function FunUnjoin()
{
 $option = 0 # 2 = disable but not delete account in AD
 $objWMI = Get-WmiObject -Class Win32_computersystem `
                -computername $computer
 $objWMI.psbase.Scope.Options.EnablePrivileges = $true
 $objWMI.UnjoinDomainOrWorkgroup($password,$userName,$option)
 exit
}


if($help)   { "Obtaining help ..." ; funhelp }
if($domainName) 
            { 
             "Joining $computer to $domainName" 
              FunJoinDomain
            }
if($reboot)
            {
             "Rebooting $computer now ..."
             FunReboot
            }
if(!$help -or !$domainname -or !$reboot) 
           { 
            "you must supply an action ..."
             funhelp
           }