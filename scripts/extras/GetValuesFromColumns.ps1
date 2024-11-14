# GetValuesFromColumns.ps1

$zeroOffset = 1
$file = "C:\fso\user.csv"
$users = Import-Csv -Path $file
$properties = ($users.psobject.Properties | where { $_.name -eq 'syncroot' } ).value

foreach($p in $properties)
 {
$aryproperties = $p | gm -MemberType noteproperty
foreach ($prop in $aryproperties)
{  $eq=($prop.definition.indexof("=")) + $zeroOffset
  "This is the value: $($prop.definition.substring($eq))"
}
}
