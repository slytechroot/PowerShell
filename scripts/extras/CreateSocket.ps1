# CreateSocket.ps1
#

[System.Reflection.Assembly]::LoadWithPartialName("System.net.IPEndPoint")
$socket = New-Object system.net.IPEndpoint(0,0)
$socket | gm