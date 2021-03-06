﻿Class Actions {
	static List := GetActionsList()
	
	Send(Input) {
		SendInput % Input
	}
	
	SendRaw(Input) {
		SendRaw % Input
	}
	
	Run(param) {
		if !Run(param)
			Error("Run() failed.", A_ThisFunc, param, true)
	}
	
	Spotify(CMD) {
		PostMessage, 0x319,, % CMD,, ahk_class SpotifyMainWindow ; 0x319 = WM_APPCOMMAND
	}
	
	SpotifyItem(Top, Sub) {
		WinMenuSelectItem, ahk_class SpotifyMainWindow, Chrome Legacy Window, % Top, % Sub
	}
	
	Screenshot(Size) {
		if (Size = "Area")
			Capture.Rect()
		else if (Size = "Window")
			Capture.Window()
		else if (Size = "Full")
			Capture.Screen()
	}
	
	; if running the clipboard fails (ie, not a file/link), it googles the clipboard text
	RunClipboard() {
		if !StrLen(clipboard)
			return TrayTip("Clipboard is empty!")
		
		if !Run(clipboard) ; running the clipboard failed, google the contents
			Run("https://www.google.com/#q=" HTTP.UriEncode(clipboard))
	}
	
	UploadClip() {
		PastebinUpload()
	}
	
	Open(tab := "") {
		Big.Open(tab)
	}
	
	Settings() {
		Settings()
	}
	
	ListVars() {
		ListVars
	}
	
	CheckForUpdates() {
		CheckForUpdates()
	}
	
	PrintHeaders() {
		for a, b in Uploader.LastHeaders
			if InStr(a, "X-Post-Rate-Limit")
				temp .= a ": " b "`n"
		if StrLen(temp)
			TrayTip("IMGUR HEADERS", temp)
		else
			TrayTip("No headers stored.")
	}
	
	PrintSettings() {
		m(Settings.Data())
	}
	
	PrintKeybinds() {
		m(Keybinds.Data())
	}
	
	PrintHotkeys() {
		m(Hotkey.Keys)
	}
	
	PurgeImages() {
		for Index, Image in Images.Data(), Save := []
			Save[Image.id "." Image.extension] := true
		Loop, files, Images\imgur\*.*
			if !Save.HasKey(A_LoopFileName)
				FileDelete % A_LoopFileFullPath
		FileRemoveDir, Images\local, 1
		FileRemoveDir, Images\deleted, 1
		FileCreateDir, Images\local
		FileCreateDir, Images\deleted
		Rem := []
		for Date, Image in Images.Data() {
			if (FileExist(Uploader.ImgurFolder "\" Image.id  "." Image.extension) != "A")
				Rem.Push(Date)
		} for Index, Date in Rem
			Images.Remove(Date)
		Images.Save()
	}
	
	GetDownloadCount() {
		static URL := "https://api.github.com/repos/Run1e/PowerPlay/releases"
		if !HTTP.Get(URL, Data)
			return TrayTip("Failed getting download count")
		JSONData := JSON.Load(Data.ResponseText)
		for a, b in JSONData
			count += b.assets.1.download_count
		MouseTip.Create(count)
	}
	
	CopyUploaderSHA() {
		clipboard(FileSHA1(A_ScriptDir "\PowerPlayUploader.exe"))
		SoundBeep
	}
	
	CopyIconSHA() {
		clipboard(FileSHA1(A_ScriptDir "\icons\powerplay.ico"))
		SoundBeep
	}
	
	OpenConsole() {
		ForceConsole := true
		p()
	}
	
	Reload() {
		reload
		ExitApp
	}
	
	Exit() {
		ExitApp
	}
}