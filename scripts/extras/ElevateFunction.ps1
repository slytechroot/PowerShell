# elevateFunction.ps1
function elevate
{
	$file, [string]$arguments = $args;
	$psi = new-object System.Diagnostics.ProcessStartInfo $file;
	$psi.Arguments = $arguments;
	$psi.Verb = "runas";
	[System.Diagnostics.Process]::Start($psi);
}
