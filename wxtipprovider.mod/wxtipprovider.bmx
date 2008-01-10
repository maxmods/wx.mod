' Copyright (c) 2007,2008 Bruce A Henderson
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
bbdoc: wxTipProvider
End Rem
Module wx.wxTipProvider

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007 Bruce A Henderson"
ModuleInfo "Modserver: BRL"

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
ModuleInfo "CC_OPTS: -D__WXMAC__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?

Import "common.bmx"

Rem
bbdoc: This is the type used together with wxShowTip function.
about: It must implement GetTip function and return the current tip from it (different tip
each time it is called).
End Rem
Type wxTipProvider

	Field wxObjectPtr:Byte Ptr
	
	Function _create:wxTipProvider(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxTipProvider = New wxTipProvider
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Creates a new wxTipProvider.
	End Rem
	Function CreateTipProvder:wxTipProvider(currentTip:Int)
		Return New wxTipProvider.Create(currentTip)
	End Function
	
	Rem
	bbdoc: Creates a new wxTipProvider.
	End Rem
	Method Create:wxTipProvider(currentTip:Int)
		wxObjectPtr = bmx_wxtipprovider_create(Self, currentTip)
		Return Self
	End Method
	
	Rem
	bbdoc: Return the text of the current tip and pass to the next one.
	about: This method should be implemented in the derived type.
	End Rem
	Method GetTip:String()
		Return ""
	End Method
	
	Function _GetTip:String(obj:wxTipProvider)
		Return obj.GetTip()
	End Function
	
	Rem
	bbdoc: Returns a modified tip.
	about: This method will be called immediately after read, and before being check whether
	it is a comment, an empty string or a string to translate. You can optionally override this in
	your custom user-derived class to optionally to modify the tip as soon as it is read.
	You can return any modification to the string. If you return an empty string, then this tip
	is skipped, and the next one is read.
	End Rem
	Method PreProcessTip:String(tip:String)
		Return tip
	End Method
	
	Function _PreProcessTip:String(obj:wxTipProvider, tip:String)
		Return obj.PreProcessTip(tip)
	End Function
	
	Rem
	bbdoc: Returns the index of the current tip (i.e. the one which would be returned by GetTip).
	about: The program usually remembers the value returned by this function after calling wxShowTip.
	Note that it is not the same as the value which was passed to wxShowTip + 1 because the user might
	have pressed the "Next" button in the tip dialog.
	End Rem
	Method GetCurrentTip:Int()
		Return bmx_wxtipprovider_getcurrenttip(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Frees the tip provider.
	End Rem
	Method Free()
		If wxObjectPtr Then
			bmx_wxtipprovider_free(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

Rem
bbdoc: This function creates a wxTipProvider which may be used with wxShowTip.
End Rem
Function wxCreateFileTipProvider:wxTipProvider(filename:String, currentType:Int)
	Return wxTipProvider._create(bmx_wxcreatefiletipprovider(filename, currentType))
End Function

Rem
bbdoc: This function shows a "startup tip" to the user.
about: The return value is the state of the 'Show tips at startup' checkbox.
End Rem
Function wxShowTip:Int(parent:wxWindow, tipProvider:wxTipProvider, showAtStartup:Int = True)
	Return bmx_wxshowtip(parent.wxObjectPtr, tipProvider.wxObjectPtr, showAtStartup)
End Function
