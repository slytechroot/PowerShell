
$a = ([wmiclass]"win32_process").create("notepad")
$a | gm