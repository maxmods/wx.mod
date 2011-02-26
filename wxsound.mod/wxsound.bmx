' Copyright (c) 2007-2011 Bruce A Henderson & Oliver Skawronek
' 
' Permission is hereby granted, free of charge, to any person obtaining a copy
' of this software and associated documentation files (the "Software"), to deal
' in the Software without restriction, including without limitation the rights
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
' copies of the Software, and to permit persons to whom the Software is
' furnished to do so, subject to the following conditions:
' 
' The above copyright notice and this permission notice shall be included in
' all copies or substantial portions of the Software.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
' THE SOFTWARE.
' 
SuperStrict

Rem
bbdoc: wxSound
End Rem
Module wx.wxSound

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2011 Bruce A Henderson"


?linux
ModuleInfo "CC_OPTS: -D__WXGTK__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?win32
ModuleInfo "CC_OPTS: -DHAVE_W32API_H"
ModuleInfo "CC_OPTS: -D__WXMSW__"
ModuleInfo "CC_OPTS: -D_UNICODE"
ModuleInfo "CC_OPTS: -DUNICODE"
?macos
ModuleInfo "CC_OPTS: -D__WXOSX_CARBON__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?

Import "common.bmx"

Rem
bbdoc: This type represents a short sound (loaded from Windows WAV file), that can be stored in memory and played.
about: On Linux, uses either Open Sound System or Simple DirectMedia Layer.
End Rem
Type wxSound Extends wxObject

	' creates a "soft link" to a wxSound*
	Function _create:wxSound(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxSound = New wxSound
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Function _find:wxSound(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local sound:wxSound = wxSound(wxfind(wxObjectPtr))
			If Not sound Then
				Return _create(wxObjectPtr)
			End If
			Return sound
		End If
	End Function

	Rem
	bbdoc: Constructs a #wxSound object.
	about: TODO
	End Rem
	Function CreateSound:wxSound(fileName:String, isResource:Int = False)
		Return New wxSound.Create(fileName, isResource)
	End Function

	Rem
	bbdoc: Constructs a #wxSound object.
	End Rem
	Method Create:wxSound(fileName:String, isResource:Int = False)
		wxObjectPtr = bmx_wxsound_create(Self, fileName, isResource)
		Return Self
	End Method
	
	Rem
	bbdoc: Returns true if the object contains a successfully loaded file or resource, false otherwise.
	about: TODO
	End Rem
	Method IsOk:Int()
		Return bmx_wxsound_isok(wxObjectPtr)
	End Method

'	Rem
'	bbdoc: Returns True If the Object contains a successfully loaded file Or resource, False otherwise.
'	about: TODO
'	End Rem
'	Method IsPlaying:Int()
'		Return bmx_wxsound_isplaying(wxObjectPtr)
'	End Method

	Rem
	bbdoc: Plays the sound file.
	about: If another sound is playing, it will be interrupted. Returns true on success, false otherwise.
	Note that in general it is possible to delete the object which is being asynchronously played any time after
	calling this function and the sound would continue playing, however this currently doesn't work under Windows
	for sound objects loaded from memory data.
	End Rem
	Method Play:Int(flags:Int = wxSOUND_ASYNC)
		Return bmx_wxsound_play(wxObjectPtr, flags)
	End Method

	Rem
	bbdoc: If a sound is playing, this stops it.
	about: TODO
	End Rem
	Method Stop()
		bmx_wxsound_stop(wxObjectPtr)
	End Method

	Rem
	bbdoc: Frees the Sound
	End Rem
	Method Free()
		If wxObjectPtr Then
			bmx_wxsound_free(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

