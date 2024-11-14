###########################################################
# InstallPrinterDriver.ps1
# ed wilson, 7/14/2007, msft
#
# installs printer driver
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
$rtnCode = $objwmi.addPrinterDriver($objDriver)
$rtncode.returnValue
