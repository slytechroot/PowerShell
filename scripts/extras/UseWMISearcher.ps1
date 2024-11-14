function getW($str)
 {
  $b = [wmisearcher]"select * from $str" 
  $b.get()
   $a = $b.query

   Write-Host $a.queryString " was submitted by " (gi env:\username).value $(Get-Date)
 }

$str ="win32_bios"
getw($str)
