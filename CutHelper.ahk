#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, force

Loop{
    Loop, Files, E:\CutFiles\*.pdf
    {
        ;Ok lets start by converting files to right format in illustrator
        Run, C:\Program Files\Adobe\Adobe Illustrator CS6 (64 Bit)\Support Files\Contents\Windows\Illustrator.exe "%A_LoopFilePath%"
        WinWait, %A_LoopFileName% ahk_class illustrator
        Sleep, 100
        BlockInput, On
        WinActivate, %A_LoopFileName% ahk_class illustrator
        Sleep, 400
        Send, {Shift down}{Ctrl down}
        Sleep, 100
        Send, {F12}
        Sleep, 100
        Send, {Shift up}{Ctrl up}
        Sleep, 100
        WinMinimize, ahk_class illustrator


        ;Next Step is to open the file in iMark
        If (WinExist("ahk_exe iMark.exe") = 0)
        {
            Run, C:\Script\iMark.exe, C:\Script\
        }
        SplitPath, A_LoopFilePath, OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
        ; WinWait, ahk_exe iMark.exe
        ; ;MsgBox, Waited some...
        WinActivate, ahk_exe iMark.exe
        BlockInput, Off

        ;copy PDF to Archive
        FileCreateDir, %OutDir%\Archive\
        FileMove, %A_LoopFileFullPath%, %OutDir%\Archive\*.*,1
    }
    Sleep, 1000
}

#NoTrayIcon
#F12::ExitApp  ; Win+F12