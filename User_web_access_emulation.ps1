# Author: Justin Henderson
# Version: 1.0
# Last Update: 06/2017
#
# This script is a simple method of simulating web traffic
#

param(
    [Parameter()]
    [ValidateSet("general","it","hr","ceo","cfo","accounting")]
    [string[]]
    $user_type
)
# Set user_agent to mimic
$chrome_user_agent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.75 Safari/537.36"
$ie_user_agent = "Mozilla/5.0 (Windows NT 6.1; Trident/7.0; rv:11.0) like Gecko"
$edge_user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.79 Safari/537.36 Edge/14.14393"
$firefox_user_agent = "Mozilla/5.0 (Windows NT 6.1; rv:53.0) Gecko/20100101 Firefox/53.0"

# Set of websites to rotate through
$general_websites = @("http://www.labmeinc.com", "https://www.twitter.com", "https://www.sans.org", "https://www.amazon.com", "https://facebook.com", "https://www.google.com", "https://www.google.com/?q=sec555#safe=active&q=sec555", "https://www.google.com", "https://www.google.com/?q=sec555#safe=active&q=sec555", "https://www.google.com", "https://www.google.com/?q=sec555#safe=active&q=sec555", "https://www.google.com", "https://www.google.com/?q=sec555#safe=active&q=sec555", "https://www.google.com", "https://www.google.com/?q=sec555#safe=active&q=sec555", "https://www.gmail.com", "http://www.purple.com", "https://www.linkedin.com", "https://www.hasecuritysolutions.com")
$accounting_websites = @("https://www.docuware-online.com/login", "https://www.accountingtoday.com/", "http://topics.nytimes.com/top/news/business/small-business/accounting/index.html", "http://www.journalofaccountancy.com/", "http://www.softwareadvice.com/accounting/")
$it_websites = @("https://technet.microsoft.com", "https://www.microsoft.com", "http://www.networkcomputing.com", "http://www.imdb.com", "http://www.stackoverflow.com/", "http://www.thedailywtf.com/", "http://slashdot.org/", "https://www.reddit.com")
$hr_websites = @("https://www.bls.gov", "http://www.nolo.com/legal-encyclopedia/illegal-reasons-firing-employees-30209.html", "http://business.salary.com/9-dos-donts-firing-employees/", "https://hbr.org/2016/02/a-step-by-step-guide-to-firing-someone", "http://www.businessnewsdaily.com/7969-employee-firing-tips.html", "https://www.thebalance.com/top-10-don-ts-when-you-fire-an-employee-1918343", "https://www.irs.gov/uac/2017-standard-mileage-rates-for-business-and-medical-and-moving-announced")
$ceo_websites = @("http://www.healthcare-management-degree.net/faq/what-are-the-major-responsibilities-of-a-health-care-chief-executive-officer/", "http://www.ceo.com/", "http://www.investopedia.com/articles/financial-theory/10/manage-business-like-jack-welch.asp", "https://blogs.wsj.com/briefly/2016/08/03/5-approaches-for-the-strategic-ceo/", "https://www.entrepreneur.com/article/236232")
$cfo_websites = @("http://www.cfodailynews.com/", "https://www.wsj.com/news/cfo-journal", "http://ww2.cfo.com/", "http://ww2.cfo.com/source/cfo-news/")
$run_count = 1

Write-Host "Main - User type is set to $user_type"
# Based on "user" profile set possible site list
switch($user_type){
    "general" { 
        $sites = $general_websites 
        $user_agent = $ie_user_agent
    }
    "ceo" { 
        $sites = $general_websites + $ceo_websites
        $user_agent = $firefox_user_agent
    }
    "cfo" { 
        $sites = $general_websites + $cfo_websites 
        $user_agent = $edge_user_agent
    }
    "accounting" { 
        $sites = $general_websites + $accounting_websites
        $user_agent = $edge_user_agent
    }
    "it" { 
        $sites = $general_websites + $it_websites 
        $user_agent = $chrome_user_agent
    }
    "hr" { 
        $sites = $general_websites + $hr_websites 
        $user_agent = $chrome_user_agent
    }
}
Do {
    # Select site and random sleep interval
    $count = $sites.Count
    $random = Get-Random -Minimum 0 -Maximum $count

    # Access main site
    Write-Host "Main - Accessing" $sites[$random] " with run count of $run_count"
    $request = Invoke-WebRequest -Uri $sites[$random] -UserAgent $user_agent -ErrorAction SilentlyContinue

    # Find links from domain
    $domain = $sites[$random]
    $domain = $domain.Substring($domain.IndexOf('//')+2)
    if($domain.IndexOf('/') -gt 0){
        $domain = $domain.Substring(0,$domain.IndexOf('/'))
    }
    $domain_links = @()
    $request.RawContent -split "</a>" | select-string -pattern 'href="(?<content>.*)"' -AllMatches | Where-Object { $_ -match $domain } | ForEach-Object {
        $_ -match 'href="(?<content>.*)"' | Out-Null
        $output = $matches['content']
        if($output -notmatch "#|""|@|;|\$|\%|\^|\&|\*|\(|\)\!" -and ($output -match "^http:|https:")){
            $domain_links += $output
        }
    }

    # Calculate random link access
    $link_count = $domain_links.Count
    Write-Host "Link Access - There are $link_count links"
    if($link_count -lt 10 -and $link_count -gt 1){
        $link_limit = Get-Random -Minimum 1 -Maximum $link_count
    } elseif($link_count -eq 1) {
        $link_limit = 1
    } else {
        $link_limit = Get-Random -Minimum 1 -Maximum 10
    }
    if($link_count -ne 0){
        Write-Host "Link Access - Accessing $link_limit links before moving on"
        while($link_limit -ne 0){
            $link_number = Get-Random -Minimum 0 -Maximum $link_count
            Write-Host "Link Access - Acessing " $domain_links[$link_number] " with count of $link_limit"
            Invoke-WebRequest -Uri $domain_links[$link_number] -UserAgent $user_agent | Out-Null
            $link_limit = $link_limit - 1
            $sleep = Get-Random -Minimum 1 -Maximum 300
            Write-Host "Link Access - Sleeping $sleep seconds"
            Sleep -Seconds $sleep
        }
    }

    $random_sleep = Get-Random -Minimum 1 -Maximum 60
    Write-Host "Main - Sleeping $random_sleep seconds"
    Sleep -Seconds $random_sleep
    $run_count++
} 
Until (1 -ne 1)