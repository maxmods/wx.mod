' Copyright (c) 2007 Bruce A Henderson
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
bbdoc: wxFindReplaceDialog
End Rem
Module wx.wxFindReplaceDialog

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
bbdoc: wxFindReplaceDialog is a standard modeless dialog which is used to allow the user to search for some text (and possibly replace it with something else).
about: The actual searching is supposed to be done in the owner window which is the parent of this dialog. Note that it
means that unlike for the other standard dialogs this one must have a parent window. Also note that there is no way to
use this dialog in a modal way; it is always, by design and implementation, modeless.
End Rem
Type wxFindReplaceDialog Extends wxDialog

	Function CreateFindReplaceDialog:wxFindReplaceDialog(parent:wxWindow, data:wxFindReplaceData, title:String = "", style:Int = 0)
		Return New wxFindReplaceDialog.Create(parent, data, title, style)
	End Function
	
	Method Create:wxFindReplaceDialog(parent:wxWindow, data:wxFindReplaceData, title:String = "", style:Int = 0)
		wxObjectPtr = bmx_wxfindreplacedialog_create(Self, parent.wxObjectPtr, data.wxObjectPtr, title, style)
		Return Self
	End Method
	
	Method GetData:wxFindReplaceData()
	End Method

End Type

Rem
bbdoc: wxFindReplaceData holds the data for wxFindReplaceDialog.
about: It is used to initialize the dialog with the default values and will keep the last values from the dialog
when it is closed. It is also updated each time a wxFindDialogEvent is generated so instead of using the
wxFindDialogEvent methods you can also directly query this object.
<p>
Note that all SetXXX() methods may only be called before showing the dialog and calling them has no effect later.
</p>
End Rem
Type wxFindReplaceData Extends wxObject

	Function CreateFindReplaceData:wxFindReplaceData()
		Return New wxFindReplaceData.Create()
	End Function
	
	Method Create:wxFindReplaceData()
		wxObjectPtr = bmx_wxfindreplacedata_create(Self)
		Return Self
	End Method

	Method GetFindString:String()
		Return bmx_wxfindreplacedata_getfindstring(wxObjectPtr)
	End Method
	
	Method GetReplaceString:String()
		Return bmx_wxfindreplacedata_getreplacesstring(wxObjectPtr)
	End Method
	
	Method GetFlags:Int()
		Return bmx_wxfindreplacedata_getflags(wxObjectPtr)
	End Method
	
	Method SetFlags(flags:Int)
		bmx_wxfindreplacedata_setflags(wxObjectPtr, flags)
	End Method
	
	Method SetFindString(s:String)
		bmx_wxfindreplacedata_setfindstring(wxObjectPtr, s)
	End Method
	
	Method SetReplaceString(s:String)
		bmx_wxfindreplacedata_setreplacesstring(wxObjectPtr, s)
	End Method
	
	Method Free()
		If wxObjectPtr Then
			bmx_wxfindreplacedata_free(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
	Method Delete()
		Free()
	End Method
	
End Type

Rem
bbdoc: wxFindReplaceDialog events
End Rem
Type wxFindDialogEvent Extends wxCommandEvent

	Method GetFlags:Int()
	End Method
	
	Method GetFindString:String()
	End Method
	
	Method GetReplaceString:String()
	End Method
	
	Method GetDialog:wxFindReplaceDialog()
	End Method
	
End Type
