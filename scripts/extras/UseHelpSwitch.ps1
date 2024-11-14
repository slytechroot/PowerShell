param($computer = "localhost", [switch]$help)

if($help) { "displays information about bios" ; exit}
gwmi -Class win32_bios -computername $computer