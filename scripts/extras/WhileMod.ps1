################################################
# WhileMod.ps1
# ed wilson, msft, 6/6/2007
#
# uses modulo division and a while loop
# the % symbol is used for modulo division
# which returns the remainder after dividing 
# two numbers. The IF $i % 2 means IF there is
# a remainder which would be an ODD number here.
# I have if NOT $i % 2 which means if there is
# NOT a remainder ... EVEN numbers. 
#
################################################


while ( $i -le 10)
{
 $i++
   if( !($i % 2) ) { Write-Output "$i is mod" }
   ELSE { Write-Output $i }
}