﻿#SingleInstance force
#NoEnv
#Persistent
#NoTrayIcon
SetBatchLines -1

#Include ..\lib\Class OnMouseMove.ahk
#Include ..\lib\Class MouseTip.ahk

global MaxLen := 30
global MaxLines := 4

Power := ComObjActive("{40677552-fdbd-444d-a9dd-6dce43b0cd56}")
Power.AutoClose(A_ScriptHwnd)
OnClipboardChange("ClipTip")
Power.Finished()
return

ClipTip() {
	for Index, Line in (Split := StrSplit(Clipboard, "`r`n")), Added := 1
		if (Added <= MaxLines) && StrLen(Line)
			Tip .= SubStr(Line, 1, MaxLen) . (StrLen(Line) > MaxLen ? "..." : "") . "`n", Added++, LastAdd := Index
	MouseTip.Create(rtrim(Tip, "`n") . (Split.MaxIndex() > LastAdd ? "`n..." : ""))
}