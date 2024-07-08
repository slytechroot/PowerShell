##############################Powershell script - generate random password################################################
#.Synopsis
#    Generates a complex password of the specified length and text encoding.
#
#.Description
#    Generates a pseudo-password using only common ASCII code numbers.  The
#    password will be four characters in length at a minimum so that it may
#    contain at least one of each of the following character types: uppercase,
#    lowercase, number and password-legal non-alphanumerics.  To make the
#    output play nice, the following characters are excluded from the
#    output password string: extended ASCII, spaces, #, ", `, ', /, 0, O.
#    The output should be compatible with any code page or culture when
#    an appropriate encoding is chosen.  Because of how certain characters
#    are excluded, the randomness of the password is slightly lower, hence,
#    the length may need to be increased to achieve a particular entropy.
#
#.Parameter Length
#    Length of password to be generated.  Minimum is 4.  Default is 15.
#    Complexity requirements force a minimum length of 4 characters.
#    Maximum is 2147483647.
#
#.Parameter Encoding
#    The encoding of the output string. Must be one of these:
#
#        ASCII
#        UTF8
#        UNICODE
#        UTF16
#        UTF16-LE
#        UTF32
#        UTF16-BE
#
#    The default is UTF16-LE.  Note that UNICODE, UTF16 and UTF16-LE are
#    identical on Windows and in this script.  Because of how characters
#    are generated, ASCII and UTF8 are identical here too. 'LE' stands for
#    Little Endian, and 'BE' stands for Big Endian.
#
#.Example
#    Generate-RandomPassword -Length 25
#
#    Returns a 25-character UTF16-LE string.  Note that if you will save the
#    output to a file, beware of unexpected Byte Order Mark (BOM) bytes and
#    newline bytes added by cmdlets like Out-File and Set-Content.  
#
#Requires -Version 2.0
#
#.Notes
#  Author: Jason Fossen (http://www.sans.org/windows-security/)  
# Version: 2.1
# Updated: 4.Aug.2015
#   LEGAL: PUBLIC DOMAIN.  SCRIPT PROVIDED "AS IS" WITH NO WARRANTIES OR GUARANTEES OF
#          ANY KIND, INCLUDING BUT NOT LIMITED TO MERCHANTABILITY AND/OR FITNESS FOR
#          A PARTICULAR PURPOSE.  ALL RISKS OF DAMAGE REMAINS WITH THE USER, EVEN IF
#          THE AUTHOR, SUPPLIER OR DISTRIBUTOR HAS BEEN ADVISED OF THE POSSIBILITY OF
#          ANY SUCH DAMAGE.  IF YOUR STATE DOES NOT PERMIT THE COMPLETE LIMITATION OF
#          LIABILITY, THEN DELETE THIS FILE SINCE YOU ARE NOW PROHIBITED TO HAVE IT.
####################################################################################


Param ([Int32] $Length = 15, [String] $Encoding = "UTF16-LE")


function Generate-RandomPassword ([Int] $length = 15, [String] $Encoding = "UTF16-LE")
{
    If ($length -lt 4) { $length = 4 }   #Password must be at least 4 characters long in order to satisfy complexity requirements.

    #Use the .NET crypto random number generator, not the weaker System.Random class with Get-Random:
    $RngProv = [System.Security.Cryptography.RNGCryptoServiceProvider]::Create()
    [byte[]] $onebyte = @(255)
    [Int32] $x = 0

    Do {
        [byte[]] $password = @()
        
        $hasupper =     $false    #Has uppercase letter character flag.
        $haslower =     $false    #Has lowercase letter character flag.
        $hasnumber =    $false    #Has number character flag.
        $hasnonalpha =  $false    #Has non-alphanumeric character flag.
        $isstrong =     $false    #Assume password is not complex until tested otherwise.
        
        For ($i = $length; $i -gt 0; $i--)
        {                                                         
            While ($true)
            {   
                #Generate a random US-ASCII code point number.
                $RngProv.GetNonZeroBytes( $onebyte )
                [Int32] $x = $onebyte[0]                  
                if ($x -ge 32 -and $x -le 126){ break }   
            }
            
            # Even though it reduces randomness, eliminate problem characters to preserve sanity while debugging.
            # If you're worried, increase the length of the password or comment out the desired line(s):
            If ($x -eq 32) { $x++ }    #Eliminates the space character; causes problems for other scripts/tools.
            If ($x -eq 34) { $x-- }    #Eliminates double-quote; causes problems for other scripts/tools.
            If ($x -eq 39) { $x-- }    #Eliminates single-quote; causes problems for other scripts/tools.
            If ($x -eq 47) { $x-- }    #Eliminates the forward slash; causes problems for net.exe.
            If ($x -eq 96) { $x-- }    #Eliminates the backtick; causes problems for PowerShell.
            If ($x -eq 48) { $x++ }    #Eliminates zero; causes problems for humans who see capital O.
            If ($x -eq 79) { $x++ }    #Eliminates capital O; causes problems for humans who see zero.
            
            $password += [Byte] $x  

            If ($x -ge 65 -And $x -le 90)  { $hasupper = $true }   #Non-USA users may wish to customize the code point numbers by hand,
            If ($x -ge 97 -And $x -le 122) { $haslower = $true }   #which is why we don't use functions like IsLower() or IsUpper() here.
            If ($x -ge 48 -And $x -le 57)  { $hasnumber = $true }
            If (($x -ge 32 -And $x -le 47) -Or ($x -ge 58 -And $x -le 64) -Or ($x -ge 91 -And $x -le 96) -Or ($x -ge 123 -And $x -le 126)) { $hasnonalpha = $true }
            If ($hasupper -And $haslower -And $hasnumber -And $hasnonalpha) { $isstrong = $true }
        }
    } While ($isstrong -eq $false)

    #$RngProv.Dispose() #Not compatible with PowerShell 2.0.

    #Output as a string with the desired encoding:
    Switch -Regex ( $Encoding.ToUpper().Trim() )
    {
        'ASCII'
            { ([System.Text.Encoding]::ASCII).GetString($password) ; continue }
        'UTF8'     
            { ([System.Text.Encoding]::UTF8).GetString($password) ; continue }
        'UNICODE|UTF16-LE|^UTF16$'  
            {
                $password = [System.Text.AsciiEncoding]::Convert([System.Text.Encoding]::ASCII, [System.Text.Encoding]::Unicode, $password )  
                ([System.Text.Encoding]::Unicode).GetString($password)
                continue
            }
        'UTF32'    
            {
                $password = [System.Text.AsciiEncoding]::Convert([System.Text.Encoding]::ASCII, [System.Text.Encoding]::UTF32, $password )  
                ([System.Text.Encoding]::UTF32).GetString($password)
                continue
            }
        '^UTF16-BE$'
            {
                $password = [System.Text.AsciiEncoding]::Convert([System.Text.Encoding]::ASCII, [System.Text.Encoding]::BigEndianUnicode, $password )  
                ([System.Text.Encoding]::BigEndianUnicode).GetString($password)
                continue
            }
        default #UTF16-LE Unicode
            {
                $password = [System.Text.AsciiEncoding]::Convert([System.Text.Encoding]::ASCII, [System.Text.Encoding]::Unicode, $password )  
                ([System.Text.Encoding]::Unicode).GetString($password)
                continue
            }
    }

}





##############################################################################
# This demonstrates the function.
##############################################################################
"`nHere's 20 pseudo-random passwords:`n`n"
1..20 | foreach { Generate-RandomPassword }




exit

##############################################################################
# The road to Vegas is paved with good intentions!
# Watch out when saving your password to a file.
##############################################################################
$pw = Generate-RandomPassword -length 8 -Encoding "ascii"

#The following converts to UTF16-LE ("Unicode") with BOM and newline bytes.
$pw | out-file c:\temp\password1.txt  

#The following adds newline bytes (0D,0A) to the end without asking.
$pw | out-file c:\temp\password2.txt -Encoding ascii

#The following writes only the raw bytes: no BOM, no Unicode, no newline bytes.
$pw.ToCharArray() | foreach { [byte] $_ } | Set-Content -Path c:\temp\password3.txt -Encoding Byte





##############################################################################
# Here are the characters and ASCII codes for the password
# characters as a reference.  The excluded ones are noted.
##############################################################################
#   = 32  Excluded (the space character)
# ! = 33  
# " = 34  Excluded
# # = 35
# $ = 36
# % = 37
# & = 38
# ' = 39  Excluded
# ( = 40
# ) = 41
# * = 42
# + = 43
# , = 44
# - = 45
# . = 46
# / = 47  Excluded
# 0 = 48  Excluded
# 1 = 49
# 2 = 50
# 3 = 51
# 4 = 52
# 5 = 53
# 6 = 54
# 7 = 55
# 8 = 56
# 9 = 57
# : = 58
# ; = 59
# < = 60
# = = 61
# > = 62
# ? = 63
# @ = 64
# A = 65
# B = 66
# C = 67
# D = 68
# E = 69
# F = 70
# G = 71
# H = 72
# I = 73
# J = 74
# K = 75
# L = 76
# M = 77
# N = 78
# O = 79  Excluded
# P = 80
# Q = 81
# R = 82
# S = 83
# T = 84
# U = 85
# V = 86
# W = 87
# X = 88
# Y = 89
# Z = 90
# [ = 91
# \ = 92
# ] = 93
# ^ = 94
# _ = 95
# ` = 96  Excluded
# a = 97
# b = 98
# c = 99
# d = 100
# e = 101
# f = 102
# g = 103
# h = 104
# i = 105
# j = 106
# k = 107
# l = 108
# m = 109
# n = 110
# o = 111
# p = 112
# q = 113
# r = 114
# s = 115
# t = 116
# u = 117
# v = 118
# w = 119
# x = 120
# y = 121
# z = 122
# { = 123
# | = 124
# } = 125
# ~ = 126
