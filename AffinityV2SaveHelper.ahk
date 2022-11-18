#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance, force

BUFFERTIME := 300

;#NoTrayIcon
#F12::ExitApp  ; Quit Script with Win+F12

#IfWinActive ahk_exe Publisher.exe
!^+s::
{
  ;We are working in Publisher,so we get the window id:
  hwndPub := WinActive("ahk_exe Publisher.exe")

  ;Open Folder where the File lies!:
  BlockInput, On
  Send, ^+e ;You should set an hotkey for "Open Folder in Explorer" in Files menu, in that example its Ctrl+Shift+E
  WinWaitActive, ahk_class CabinetWClass,,4 ;wait for explorer to open up.
  BlockInput, Off
  if ErrorLevel { ;timeout occured! (Also happens if the file is not saved on the first place)
    Send, !^+s ;open save window non the less
    return ;and exit
  }
  BlockInput, On
  Sleep, BUFFERTIME ;tiny buffer just to make sure everyhing is ready.
  Path := GetActiveExplorerPath() ;get the path of the folder where the file is in.
  WinClose, A
  WinActivate, ahk_id %hwndPub%
  Send, !^+s ;Affinity Publisher default hotkey for Export Alt+Ctrl+Shift+s
  BlockInput, Off

  WinWaitNotActive, ahk_id %hwndPub% ;Main Publisher not in Focus anymore!

  WinWaitNotActive, Export ;Wait for export window to close (this also includes the more options window)
  WinWaitActive, ahk_class #32770,,4 ;wait for save window with timeout!
  if ErrorLevel 
  return ;timeout occured!
  ;now enter the path of the file source folder!

  BlockInput, On
  Sleep, BUFFERTIME ;tiny buffer just to make sure everyhing is ready.
  Send, {AltDown}e{AltUp} ;windows hotkey to go directly to address bar, as writing directly to control seems messy on win11
  SendInput, %Path%/{enter} ;send path
  BlockInput, Off
}
return


GetActiveExplorerPath()
{
	explorerHwnd := WinActive("ahk_class CabinetWClass")
	if (explorerHwnd)
	{
		for window in ComObjCreate("Shell.Application").Windows
		{
			if (window.hwnd==explorerHwnd)
			{
				return window.Document.Folder.Self.Path
			}
		}
	}
}