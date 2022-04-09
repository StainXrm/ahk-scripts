#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
FileEncoding, UTF-8
#SingleInstance, force

FileDelete, FolderChecklist.txt
Loop, Files, *.*, D
{
    FileGetAttrib, Attributes, %A_LoopFileName%
    if !InStr(Attributes, "H"){
        FileAppend, ◯ %A_LoopFileName%`n, FolderChecklist.txt
    }  
}
