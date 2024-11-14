#########################################################
# checkUsers.ps1
#
#########################################################

$Choose = $args
$strQUery = "select * from win32_useraccount"
switch($choose){
"local" {$strQUery = $strQuery + " where localaccount = 'true'"}
"disabled" {$strQUery = $strQuery + " where disabled = 'true'"}
"lockOut" {$strQUery = $strQuery + " where lockOut = 'true'"}
DEFAULT { Write-Host "Alowed values are local, disabled, and lockout. 
 EXAMPLE: > CheckUsers.ps1 local
            Displays all local users" 
			exit
		}
}

Get-WmiObject -query $strQuery



