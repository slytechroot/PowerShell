###################################################################
# CreateSite.ps1
# ed wilson, msft, 10/2/2007
#
# uses the iis 7 wmi classes found in root\webadministration
# uses the site class and the bindingelement wmi class
# uses the [wmiclass] type accelerator to perform a GET method
# to retrieve the instance of the class. uses the createinstance()
# method to spawninstance a new instance of the bindingelement 
# wmi class. 
#
###################################################################

param(
      $sitename,
      $computer="localhost", 
      $path="C:\inetpub\wwwroot", 
      $port=80, 
      $tld="com",
      $protocol="http",
      [switch]$help
     )

function funHelp()
{
$helpText=@"
DESCRIPTION:
NAME: CreateSite.ps1
Creates a web site on a local or or remote machine. 

PARAMETERS: 
-computer  Specifies the name of the computer to run the script
-sitename  the name of the new web site
-path      physical path to the web directory
-port      port the web site listens to
-tld       top level domain: com, net, org ...
-protocol  the protocol to use: http, https ...
-help      prints help file

SYNTAX:
CreateSite.ps1 -sitename "mywebsite"

Creates an web site on the local machine named mywebsite. The path
to the web site files will be c:\inetpub\wwwroot. The connection 
to the site will be port 80 to www.mywebsite.com. The new site 
will respond to the http protocol. 

CreateSite.ps1 -sitename "mywebsite" -computer "webserverII"

Creates an web site on web server named webserverII. The new web
site will be named mywebsite. The path to the web site files will 
be c:\inetpub\wwwroot. The connection to the site will be port 80
to www.mywebsite.com. The new site will respond to the http protocol. 

CreateSite.ps1 -sitename "mywebsite" -computer "webserverII" -port 8080

Creates an web site on web server named webserverII. The new web
site will be named mywebsite. The path to the web site files will 
be c:\inetpub\wwwroot. The connection to the site will be port 8080
to www.mywebsite.com. The new site will respond to the http protocol. 

CreateSite.ps1 -sitename "mywebsite" -path "d:\mywebdirectory"

Creates an web site on the local machine named mywebsite. The path
to the web site files will be d:\mywebdirectory. The connection 
to the site will be port 80 to www.mywebsite.com. The new site 
will respond to the http protocol. 

CreateSite.ps1 -help

Prints the help topic for the script

"@
 $helpText
 exit
}

if($help)      { "Printing help now..." ; funHelp }
if(!$sitename) { "Missing the sitename ..." ; funHelp}

$siteBinding = "*:$($port):www.$($sitename).$($tld)"

$site = [wmiclass]"\\$computer\root\WebAdministration:site"
$binding = ([wmiclass]"\\$computer\root\WebAdministration:bindingElement").createinstance()
$binding.bindinginformation = $siteBinding
$binding.protocol = $protocol
$bindingArray = [array]$binding
$site.create($sitename, $bindingArray, $path)