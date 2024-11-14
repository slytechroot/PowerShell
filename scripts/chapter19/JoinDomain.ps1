#################################################################################
# JoinDomain.ps1
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
      [switch]$unjoin,
      [switch]$reboot,
      [switch]$help
     )

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: JoinDomain.ps1 
Renames a local or remote machine.

PARAMETERS: 
-computer   Specifies the name of the computer upon which to run the script
-domainName name of the domain or workgroup
-username   user credentials 
-password   user password
-unjoin     unjoin domain or workgroup
-reboot     reboots computer
-help       prints help file

SYNTAX:
JoinDomain.ps1 
Displays message you must supply an action. calls help

JoinDomain.ps1 -reboot
Reboots the local computer

JoinDomain.ps1 -reboot -computer MunichServer
Reboots the remote computer named MunichServer. Munich must be domain 
joined for this command to work.

JoinDomain.ps1 -computer MunichServer -domainName nwtraders.com `
-username nwtraders\administrator -password Password1 

Joins a remote computer named MunichServer to the nwtraders.com domain
using the nwtraders\administrator account and password of Password1.
When the join is complete, it will reboot the machine. The computer
account is placed in default location which is by default is the
computers container.

JoinDomain.ps1 -help

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
 $command = "netdom join $computer /domain:$domainName " + `
            "/userD:$userName /passwordD:$password"
 $sdcommand = "shutdown /m \\$computer /r " + `
              "/c" + "joined domain"

 invoke-expression $command
 start-sleep -seconds 2
 "We will now reboot $computer"
 Invoke-expression $sdcommand
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