Get-EventLog -LogName application | 
Where-Object { $_.source -eq "ps_script" }