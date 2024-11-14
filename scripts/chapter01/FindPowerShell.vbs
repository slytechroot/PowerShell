'==========================================================================
'
'
' NAME: <FindPowerShell.vbs>
'
' AUTHOR: Ed Wilson , MS
' DATE  : 5/8/2007
'
' COMMENT: <Identifies the existence of Windows PowerShell>
'
'==========================================================================

Option Explicit 
On Error Resume Next
dim strComputer			'target computer
dim wmiNS			'target wmi name space
dim wmiQuery			'the WMI query
dim objWMIService		'sWbemservices object
dim colItems			'sWbemObjectSet object
dim objItem			'sWbemObject

Const RtnImmedFwdOnly = &h30 'iflags for ExecQuery method of swbemservices object
strComputer = "."
wmiNS = "\root\cimv2"
wmiQuery = "Select * from win32_QuickFixEngineering where hotfixid like '928439'"

Set objWMIService = GetObject("winmgmts:\\" & strComputer & wmiNS)
Set colItems = objWMIService.ExecQuery(wmiQuery,,RtnImmedFwdOnly)

For Each objItem in colItems
    Wscript.Echo "PowerShell is present on " & objItem.CSName
    Wscript.quit
Next

Wscript.Echo "PowerShell is not installed"