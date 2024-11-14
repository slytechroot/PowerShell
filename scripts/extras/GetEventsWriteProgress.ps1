#################################################################
# GetEventsWriteProgress.ps1
# ed wilson, msft 7/18/2007
#
# uses get-eventlog
# uses foreach-object
# uses hash table for output
# uses write-progress 
# uses begin, progress for foreach 
#
#################################################################
$events = get-eventlog -logname application
$events | 
foreach-object `
  -begin {clear-host;$i=0;$out=$null} `
  -process `
  {
   if($_.source -match "desktop") 
	{
	 $aryEvt+=@{$_.Index=$_.Message}
	}
     $i++ ;`
      write-progress `
	   -activity "Searching For Events" `
       -status "Progress:" -percentcomplete ($i/$events.count*100)
	} `
   -end{$aryEvt}
