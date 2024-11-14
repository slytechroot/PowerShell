# ==============================================================================================
# 
# NAME: PingArange.ps1
# 
# AUTHOR: Ed Wilson , microsoft
# DATE  : 1/8/2007
# 
# COMMENT: Pings a range of ip addresses
#1. uses [int] to specify integer
#2. uses [string] to specify string
#3. uses for statement to repeat action 10 times
#4. holds wmi query in separate variable
#5. uses concatenation to create ip address
#6. uses get-wmiobject to execute wmi query
#7. uses if ... else to evaluate the returned status code
#8. uses the win32_pingstatus wmi class
# ==============================================================================================
[int]$intPing = 10
[string]$intNetwork = "127.0.0."

for ($i=1;$i -le $intPing; $i++)
{
$strQuery = "select * from win32_pingstatus where address = '" + $intNetwork + $i + "'"
   $wmi = get-wmiobject -query $strQuery
   "Pinging $intNetwork$i ... "
   if ($wmi.statuscode -eq 0)
      {"success"}
      else
         {"error: " + $wmi.statuscode + " occurred"}
}