#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
FileEncoding, UTF-8
#SingleInstance, force
CoordMode, Mouse , Screen

MouseGetPos,X,Y
Y -= 130

InputBox, fileending, Dateiendung, Dateiendung für Liste (* as wildcard),,300,130,%X%,%Y%,,,pdf


FileDelete, FileChecklist.txt
Loop, Files, *.%fileending%
{
    FileGetAttrib, Attributes, %A_LoopFileName%
    if !InStr(Attributes, "H"){
        FileAppend, ◯ %A_LoopFileName%`n, FileChecklist.txt
    }  
}
