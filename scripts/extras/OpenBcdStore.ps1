
$a=[wmiclass]"root\wmi:bcdstore"
$a.psbase.Scope.Options.EnablePrivileges = $true
$a.openstore("")
#$a.getSystemDisk()
#$a.getSystemPartition()
#$a.exportStore("C:\fso\store.txt")
$a | gm -MemberType method