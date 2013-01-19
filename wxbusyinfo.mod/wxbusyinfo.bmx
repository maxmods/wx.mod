' Copyright (c) 2007-2013 Bruce A Henderson
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
bbdoc: wxBusyInfo
End Rem
Module wx.wxBusyInfo

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2013 Bruce A Henderson"


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
ModuleInfo "CC_OPTS: -D__WXOSX_COCOA__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?

Import "common.bmx"

Rem
bbdoc: This type makes it easy to tell your user that the program is temporarily busy. 
about: Just create a wxBusyInfo object, and a message window will be shown. When you are done. Call Free().
<p>
For example:
<pre>
Local wait:wxBusyInfo = New wxBusyInfo.Create("Please wait, working...")

For Local i:Int = 0 Until 100000
	DoACalculation()
Next

wait.Free()
</pre>
</p>
<p>
It works by creating a window in the constructor, and deleting it in the destructor.
</p>
<p>
You may also want to call wxGetApp().Yield() to refresh the window periodically (in case it had been obscured
by other windows, for example) like this:
<pre>
Local wait:wxBusyInfo = New wxBusyInfo.Create("Please wait, working...")

For Local i:Int = 0 Until 100000
	DoACalculation()
	If i Mod 1000 = 0 Then
		wxGetApp().Yield()
	End if
Next

wait.Free()
</pre>
</p>
End Rem
Type wxBusyInfo

	Field wxObjectPtr:Byte Ptr
	
	Rem
	bbdoc: Constructs a busy info window as child of parent and displays msg in it. 
	End Rem
	Function CreateBusyInfo:wxBusyInfo(message:String, parent:wxWindow = Null)
		Return New wxBusyInfo.Create(message, parent)
	End Function
	
	Rem
	bbdoc: Constructs a busy info window as child of parent and displays msg in it. 
	End Rem
	Method Create:wxBusyInfo(message:String, parent:wxWindow = Null)
		If parent Then
			wxObjectPtr = bmx_wxbusyinfo_create(message, parent.wxObjectPtr)
		Else
			wxObjectPtr = bmx_wxbusyinfo_create(message, Null)
		End If
		
		Return Self
	End Method

	Rem
	bbdoc: Hides and closes the window containing the information text. 
	End Rem
	Method Free()
		If wxObjectPtr Then
			bmx_wxbusyinfo_free(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
	Method Delete()
		Free()
	End Method

End Type


