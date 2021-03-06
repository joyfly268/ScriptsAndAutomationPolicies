'##########################################
'# Copyright 2009 by N-able Technologies  #
'# All Rights Reserved                    #
'# May not be reproduced or redistributed #
'# Without written consent from N-able    #
'# Technologies                           #
'# www.n-able.com                         #
'##########################################


' Script Name: Vipre - Full Scan.vbs
' Version: 1.0
' Author: Eli Selig
' Date: Oct. 1st, 2009
' Description: This script will auto-update Vipre 8.x, and then have Vipre do a complete scan and auto-clean of the device.



' Let's declare some variables
Option Explicit
dim wshShell, wshSysEnv, ProgramFiles, Executable, updatecmd, scancmd, OSType



'STEP 1: Determine whether this is a 32-bit machine or a 64-bit machine
    Set wshShell = WScript.CreateObject("WScript.Shell")
    Set wshSysEnv = wshShell.Environment("PROCESS")
    ProgramFiles = wshSysEnv("ProgramFiles")
    OsType = WshShell.RegRead("HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\PROCESSOR_ARCHITECTURE")
    
    ' Determine if (x86)
    If OSType= "x86" then
      Executable = "SBAMCommandLineScanner.exe" ' The 32-bit executable
    Else 
      Executable = "SBAMCommandLineScanner.exe" ' Executable expected to change for x64 in next version
    End If
    
  


' Get Vipre to auto-update
Set wshShell = CreateObject("Wscript.Shell")
updatecmd = chr(34) & ProgramFiles & "\Sunbelt Software\SBEAgent\" & Executable & chr(34) & " /updatedefs"
wshShell.Run updatecmd,7,TRUE
Set wshShell = Nothing



' Scan the entire PC and auto-clean everything
Set wshShell = CreateObject("Wscript.Shell")
scancmd =  chr(34) & ProgramFiles & "\Sunbelt Software\SBEAgent\" & Executable & chr(34) & " /scannowquick"
wshShell.Run scancmd,7,TRUE
Set wshShell = Nothing



'Clear all the variables that were used
Set wshShell = Nothing
Set wshSysEnv = Nothing
Set ProgramFiles = Nothing
Set Executable = Nothing
Set updatecmd = Nothing
Set scancmd = Nothing
set OSType= Nothing