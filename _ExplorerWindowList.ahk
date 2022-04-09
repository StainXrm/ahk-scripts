;
; Explorer Window Select
;

#NoEnv
;#Warn
#NoTrayIcon
#SingleInstance Force
SetWorkingDir, %A_ScriptDir%

WinGet, WinList, List, ahk_class CabinetWClass ahk_exe explorer.exe
Send, #d
Loop %WinList% {
  Window := WinList%A_Index%
  ;WinGetTitle, WLName, ahk_id %Window% ; WLName is the variable the title of the window is saved to
  WinRestore, ahk_id %Window%

  ;MsgBox % "The title of window " A_Index " is " WLName
}