######################################################
# ArgsShare.ps1
# ed wilson, msft, 5/21/2007
#
# Uses win32_share to display share information
# Uses cmdline arguments to provide different info
# Uses $args collection to see if an argument is pres
#
######################################################
Function FunWMI($strShare)
 {
  Get-WmiObject win32_share -Filter "type = $strShare"
 }


if(!$args) 
{ "you must supply an argument. Try ArgsShare.ps1 ?"}
ELSE
{
$strShare = $args
switch ($strShare) 
  {  
   "admin" { $strShare = 2147483648 ; funwmi($strShare) }
   "print" { $strShare = 2147483649 ; funwmi($strShare) }
   "file"  { $strShare = 0 ; funwmi($strShare) }
   "ipc"   { $strShare = 2147483651 ; funwmi($strShare) }
   "all"   { Get-WmiObject win32_share }
   Default { Write-Host "You must supply either: admin, print, file, ipc, or all `n
             Example: > ArgsShare.ps1 admin" }
  }
}  

 


