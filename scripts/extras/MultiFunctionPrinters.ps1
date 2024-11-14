######################################################################
# MultiFunctionPrinters.ps1
# ed wilson, msft, 7/14/2007
#
######################################################################

param($strPTR, $strComputer="localhost", $strAction, $strUser, $strPwd)

function funQuery
{
 Get-WmiObject -class Win32_Printer -computer $strComputer | 
 format-table -Property name -autosize -noTableHeader
}

function funDelete
{

}

function funTest
{

}

function funResume
{

}

function funPause
{

}


 switch($strAction)
 { 
  "q" { funQuery  }
  "d" { fundelete }
  "t" { funTest   }
  "r" { funResume }
  "p" { funPause  }
}
