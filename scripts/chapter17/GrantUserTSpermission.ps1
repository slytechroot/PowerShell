#####################################################################
# GrantUserTSPermission.ps1
# ed wilson, msft, 10/8/2007
#
# uses the "win32_TSPermissionsSetting" wmi class from the
# root\cimv2\TerminalServices wmi namespace. Uses AddAccount() method
# Specifies whether new sessions are allowed. This setting will 
# not affect existing settings. 
#####################################################################

param(
      $computer = "localhost", 
      $user,
      $level,
      [switch]$help
     )

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: GrantUserTSPermission.ps1
Grants user access permission to a local or remote terminal server

PARAMETERS: 
-computer the computer to target the script to
-user     the user to grant permission to
-level    the level of access < guest, user, all >
-help     prints help file

SYNTAX:
GrantUserTSPermission.ps1 
Displays an error that a user must be supplied. Prints out
the help message

GrantUserTSPermission.ps1 -user bob -level guest

Grants user bob guest permission to the local terminal server

GrantUserTSPermission.ps1 -user sandra -level user -computer ts1

Grants user sandra user permission to remote terminal server
named ts1

GrantUserTSPermission.ps1 -user ed -level all

Grants user ed all permission to the local terminal server

GrantUserTSPermission.ps1 -help

Prints the help topic for the script

"@
 $helpText
 exit
}

if($help)       { "Printing help now ..." ; funHelp }
if(!$user)      { "A user is required ..." ; funHelp }
if(!$level)     { "Level of access is required ..." ; funHelp }

switch($level)
{ 
  "guest" { $level = 0 }
  "user"  { $level = 1 }
  "all"   { $level = 2 }
}

$namespace = "root\cimv2\TerminalServices"
$class = "win32_TSPermissionsSetting"
$objClient=get-wmiobject -namespace $namespace -computername $computer `
          -class $class  -filter "terminalName = 'rdp-tcp'"
$objClient.addAccount($user,$level)