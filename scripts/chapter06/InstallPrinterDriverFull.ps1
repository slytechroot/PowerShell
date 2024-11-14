###########################################################
# InstallPrinterDriverFull.ps1
# ed wilson, 7/14/2007, msft
#
# installs printer driver that is not on system
# requires admin rights
# uses the [wmiclass] type accelerator to get the class
# uses the createinstance() from the win32_printerDriver
# uses the addPrinterDriver method which takes an instance
# of the wmi class
# prints out the returnvalue property of the error object
#
##########################################################

$objWMI = [wmiclass]"Win32_PrinterDriver"
$objDriver=$objWMI.CreateInstance()

$objDriver.name = "Generic / Text Only"
$objDriver.DriverPath = "C:\WINDOWS\System32\spool\DRIVERS\W32X86\3\UNIDRV.DLL"
$objDriver.ConfigFile = "C:\WINDOWS\System32\spool\DRIVERS\W32X86\3\UNIDRVUI.DLL"
$objDriver.DataFile = "C:\WINDOWS\System32\spool\DRIVERS\W32X86\3\TTY.GPD"
$objDriver.DependentFiles ="C:\WINDOWS\System32\spool\DRIVERS\W32X86\3\TTYRES.DLL", `
"C:\WINDOWS\System32\spool\DRIVERS\W32X86\3\TTY.INI", `
"C:\WINDOWS\System32\spool\DRIVERS\W32X86\3\TTY.DLL", `
"C:\WINDOWS\System32\spool\DRIVERS\W32X86\3\TTYUI.DLL", `
"C:\WINDOWS\System32\spool\DRIVERS\W32X86\3\UNIRES.DLL", `
"C:\WINDOWS\System32\spool\DRIVERS\W32X86\3\TTYUI.HLP", `
"C:\WINDOWS\System32\spool\DRIVERS\W32X86\3\STDNAMES.GPD"
$objDriver.HelpFile = "C:\WINDOWS\System32\spool\DRIVERS\W32X86\3\UNIDRV.HLP"

$rtnCode = $objwmi.addPrinterDriver($objDriver)
$rtncode.returnValue