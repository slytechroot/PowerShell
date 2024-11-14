#
#  DisplayAuditPolicy.ps1

Param($action="sys",$help)

function funcat($policy)
{
 $pattern = "^\s"
 $filtered = $policy -notmatch $pattern
   foreach ($line in $filtered)
    { 
      if($line -and $line -notmatch "category") 
      { $line}
    }
}

$global:Policy= auditpol.exe /get /category:*

switch($action)
{ 
 "sc" { "audit categories:" ; funCat($policy) }
 "all" { "audit categories and levels: " ; $policy }
 "sys" 
      { "audit category system and levels: "
	    auditpol.exe /get /category:system 
	  }
}


