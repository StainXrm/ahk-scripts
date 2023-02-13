#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
DetectHiddenWindows, On

#Persistent
#SingleInstance, force
#InstallKeybdHook
SetKeyDelay, 100

;Check for that useless: Network error window and close it! Also skips the new useless Printer window on ID
SetTimer, WindowsSucks, 500
return


; #IfWinActive ahk_exe Code.exe
 ~^s::
     Sleep 1000
     Reload
     Sleep 1000 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
     MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
     IfMsgBox, Yes, Edit
 return

;#NoTrayIcon
#F12::ExitApp  ; Win+F12

;-------------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------

^+d::
if ( WinActive("ahk_class CabinetWClass ahk_exe explorer.exe") ) { ;WinExplorer Fast Folder "2022" opener/namer
    FormatTime, OutputTime,, yyyy
    Send, %OutputTime%
    Sleep,100
    Send, {Enter}
} else if( WinActive("StudioM - Brave ahk_exe brave.exe") ) { ;Invoiceplane
    FormatTime, OutputTime,, dd.MM.yyyy
    Send, [%OutputTime%]
} else { ;Normal Datetime for Rest
    FormatTime, OutputTime,, dd.MM.yyyy
    Send, %OutputTime%
}
return

;#IfWinActive ahk_class CabinetWClass ahk_exe explorer.exe
!^d:: ;File naming helper
    FormatTime, OutputTime,, -dd_MM_yyyy
    Send, %OutputTime%
return

:*:gm2::
    Send, g/m²
return

:*:0/::
    Send, Ø
return

+!a::
if( WinActive("Affinity Publisher ahk_exe Publisher.exe") ){
    WinMinimize, A
} else {
    WinRestore, Affinity Publisher ahk_exe Publisher.exe
    WinActivate, Affinity Publisher ahk_exe Publisher.exe
    WinMaximize, Affinity Publisher ahk_exe Publisher.exe
    }
return

+!d::
if( WinActive("ahk_class indesign ahk_exe InDesign.exe") ){
    WinMinimize, A
} else {
    WinRestore, ahk_class indesign ahk_exe InDesign.exe
    WinActivate, ahk_class indesign ahk_exe InDesign.exe
    WinMaximize, ahk_class indesign ahk_exe InDesign.exe
    }
return

+!s::
if( WinActive("ahk_exe FontBase.exe") ){
    WinMinimize, A
} else {
    WinRestore, ahk_exe FontBase.exe
    WinActivate, ahk_exe FontBase.exe 
    }
return

#IfWinActive ahk_exe thunderbird.exe
~^c::
Sleep, 100
ClipWait, 1
oldClip = %Clipboard%
newClip := RegExReplace(oldClip, "[ ]+" ," ")
newClip := RegExReplace(newClip, "[\r\n]{2,}" ,"`r`n")
Clipboard := newClip 
; MsgBox %newClip%
return

#IfWinActive ahk_exe thunderbird.exe
:C:WGM::
    Send, Einen wunderschönen, guten Morgen{!}
return

#IfWinActive ahk_exe thunderbird.exe
:C:SGH::
    Send, Sehr geehrter Herr %Clipboard%, `n `r
    Send, Mit freundlichen Grüßen `n `r
    Send, {Tab}Rainer Mayrhofer{Up 2}
return

#IfWinActive ahk_exe thunderbird.exe
:C:SGF::
    Send, Sehr geehrte Frau %Clipboard%, `n `r
    Send, Mit freundlichen Grüßen `n `r
    Send, {Tab}Rainer Mayrhofer{Up 2}
return

#IfWinActive ahk_exe thunderbird.exe
:C:SGDH::
    Send, Sehr geehrte Damen und Herren, `n `r
    Send, Mit freundlichen Grüßen `n `r
    Send, {Tab}Rainer Mayrhofer{Up 2}
return

#IfWinActive ahk_exe thunderbird.exe
:C:MFG::
    Send, Mit freundlichen Grüßen `n `r
    Send, {tab}Rainer Mayrhofer
return

#IfWinActive ahk_exe thunderbird.exe
:C:FUA::
    Send, Bei Fragen oder Anregungen bitte einfach bei mir melden{.}
return

#IfWinActive ahk_exe thunderbird.exe
:C:HI::
{
    If A_Hour between 4 and 9 ;morining glory!
    {
        Random, rnd,0,2
        Switch rnd
        {
            Case 0:
                Send, Guten Morgen{!}`n `r
            Case 1:
                Send, Einen wunderschönen, guten Morgen{!}`n `r
            Default:
                Send, Morgendliche Grüße{!}`n `r
        }
    } else {
        Random, rnd,0,3
        Switch rnd
        {
            Case 0:
                Send, Servus{!}`n `r
            Case 1:
                Send, Hi{!}`n `r
            Case 2:
                Send, Hi,`n `r
            Default:
                Send, Hallo{!}`n `r
        }
    }
    If (A_WDay == 6 && A_Hour >= 11)
    { ;Wochenende
        Send,Liebe Grüße & Schönes Wochenende!`n `r
        Send,{Tab}Rainer{Up 2}
    } else {
        Random, rnd,0,2
        Switch rnd
        {
            Case 0:
                Send,`n `rLiebe Grüße, Rainer{Up 2}
            Case 1:
                Send,`n `rlg Rainer{Up 2}
            Default:
                Send,`n `rBeste Grüße, Rainer{Up 2} 
        }
        
    }
}
return

#IfWinActive ahk_exe thunderbird.exe
:C:DSF::
    Send, Hi{!} `n `r
    Send, Kurze Info: `n
    Send, Die Drucksorten wären fertig.😊`n `r
    Send, LG Rainer
return

#IfWinActive ahk_exe thunderbird.exe
::lg::
    Send, Liebe Grüße, Rainer!
return

#IfWinActive ahk_exe thunderbird.exe
::lgsw::
    Send, Liebe Grüße & Schönes Wochenende!`n `r
    Send, {Tab}Rainer
return

;Print helper:
#IfWinActive ahk_exe thunderbird.exe
~^p::
    BlockInput On
    Sleep, 300
    Send, {Tab 3}{Down 3}1{Enter}
    BlockInput Off
return

;Check for that useless: Network error window and close it!
WindowsSucks:

; if( WinActive("Drucken aus der Win32-Anwendung. – Drucken") ){
;     Sleep, 1000
;     Send, {ShiftDown}{Tab 5}{ShiftUp}{Enter}
;     ; Sleep, 2000
;     ; WinWaitActive, Drucken aus der Win32-Anwendung. – Drucken
;     ; Send, {Tab}{Enter}
; }

while WinExist("Netzwerkfehler ahk_class #32770 ahk_exe explorer.exe") {
    WinKill, Netzwerkfehler ahk_class #32770 ahk_exe explorer.exe
}
return