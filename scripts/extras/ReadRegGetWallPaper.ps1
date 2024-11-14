#################################################
# ReadRegGetWallPaper.ps1
# ed wilson, msft, 7/29/2007
# 
# uses get-itemproperty cmdlet to retrieve reg
# information
#
#################################################

 get-itemproperty 'HKCU:\Control Panel\Desktop\'  -Name wallpaper