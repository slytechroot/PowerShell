###############################
# DemoWriteHostColors.ps1
# ed wilson, msft, 7/7/07
#
# prints out all 16 colors
#
############################## 
for ($i=0 ; $i -le 15 ; $i++) { write-host -ForegroundColor $i "$i" }