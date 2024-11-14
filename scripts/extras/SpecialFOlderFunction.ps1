

function specialFOlder($strIN)
{
 $a=(New-Object -ComObject wscript.shell).specialFolders.item($strIN)
 write-host $a
}


$strIN = "desktop"
specialFolder($strIN)
