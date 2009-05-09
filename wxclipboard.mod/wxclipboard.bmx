' Copyright (c) 2007-2009 Bruce A Henderson
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
bbdoc: wxClipboard
End Rem
Module wx.wxClipboard

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2009 Bruce A Henderson"


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
bbdoc: A type for manipulating the clipboard.
about: Note that this is not compatible with the clipboard class from wxWidgets 1.xx, which has the same
name but a different implementation.
<p>
Call wxClipboard::Open to get ownership of the clipboard. If this operation returns true,
you now own the clipboard. Call wxClipboard::SetData to put data on the clipboard, or
wxClipboard::GetData to retrieve data from the clipboard. Call wxClipboard::Close to close
the clipboard and relinquish ownership. You should keep the clipboard open only momentarily.
</p>
<p>
To receive (paste in usual terminology) data from the clipboard, you should create a wxDataObject derived type which
supports the data formats you need and pass it as argument to wxClipboard::GetData. If it returns false,
no data in (any of) the supported format(s) is available. If it returns true, the data has been successfully
transferred to the wxDataObject.
</p>
End Rem
Type wxClipboard Extends wxObject

	Function _create:wxClipboard(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxClipboard = New wxClipboard
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: 
	End Rem
	Function Get:wxClipboard()
		Return wxClipboard._create(bmx_wxclipboard_get())
	End Function
	
	Rem
	bbdoc: Call this method to add the data object to the clipboard.
	about: You may call this method repeatedly after having cleared the clipboard using wxClipboard::Clear.
	End Rem
	Method AddData:Int(data:wxDataObject)
		Local ret:Int = bmx_wxclipboard_adddata(wxObjectPtr, data.wxObjectPtr)
		data.releaseObject()
		Return ret
	End Method
	
	Rem
	bbdoc: Clears the global clipboard object and the system's clipboard if possible.
	End Rem
	Method Clear()
		bmx_wxclipboard_clear(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Call this method to close the clipboard, having opened it with wxClipboard::Open.
	End Rem
	Method Close()
		bmx_wxclipboard_close(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Flushes the clipboard.
	returns: False if the operation is unsuccessful for any reason.
	about: This means that the data which is currently on clipboard will stay available even after the application
	exits (possibly eating memory), otherwise the clipboard will be emptied on exit.
	End Rem
	Method Flush:Int()
		Return bmx_wxclipboard_flush(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Call this method to fill data with data on the clipboard, if available in the required format.
	returns: True on success.
	End Rem
	Method GetData:Int(data:wxDataObject)
		Return bmx_wxclipboard_getdata(wxObjectPtr, data.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the clipboard has been opened.
	End Rem
	Method IsOpened:Int()
		Return bmx_wxclipboard_isopened(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsSupported:Int()
	End Method
	
	Rem
	bbdoc: Call this method to open the clipboard before calling wxClipboard::SetData and wxClipboard::GetData.
	returns: True on success. This should be tested.
	about: Call wxClipboard::Close when you have finished with the clipboard. You should keep the clipboard
	open for only a very short time.
	End Rem
	Method Open:Int()
		Return bmx_wxclipboard_open(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Call this method to set the data object to the clipboard.
	about:This method will clear all previous contents in the clipboard, so calling it several times does
	not make any sense.
	End Rem
	Method SetData:Int(data:wxDataObject)
		Local ret:Int = bmx_wxclipboard_setdata(wxObjectPtr, data.wxObjectPtr)
		data.releaseObject()
		Return ret
	End Method

?linux
	Rem
	bbdoc: 
	End Rem
	Method UsePrimarySelection(primary:Int = True)
		bmx_wxclipboard_useprimaryselection(wxObjectPtr, primary)
	End Method
?
	
End Type