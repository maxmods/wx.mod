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
bbdoc: wxRarInputStream
End Rem
Module wx.wxRarInputStream

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

ModuleInfo "CC_OPTS: -fexceptions"
ModuleInfo "CC_OPTS: -DRARDLL"
ModuleInfo "CC_OPTS: -DGUI -DSILENT"

Import "common.bmx"

Rem
bbdoc: 
End Rem
Type wxRarInputStream

	Field wxStreamPtr:Byte Ptr

	Rem
	bbdoc: 
	End Rem
	Function CreateRarInputStream:wxRarInputStream(filename:String)
		Return New wxRarInputStream.Create(filename)
	End Function

	Rem
	bbdoc: 
	End Rem
	Method Create:wxRarInputStream(filename:String)
		wxStreamPtr = bmx_wxrarinputstream_create(filename)
		Return Self
	End Method
	
	'Method OpenFile:int(Const char* szFileName);
	
	Rem
	bbdoc: 
	End Rem
	Method OpenNextFile:Int()
		Return bmx_wxrarinputstream_opennextfile(wxStreamPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ExtractFile:Int(destPath:String, destName:String = Null)
		Return bmx_wxrarinputstream_extractfile(wxStreamPtr, destPath, destName)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetFileInfo:wxRarFileInfo()
		Return wxRarFileInfo._create(bmx_wxrarinputstream_getfileinfo(wxStreamPtr))
	End Method

	Rem
	bbdoc: Closes the input stream
	End Rem
	Method Close()
		If wxStreamPtr Then
			bmx_wxrarinputstream_close(wxStreamPtr)
			wxStreamPtr = Null
		End If
	End Method
	
	Method Delete()
		Close()
	End Method
	
End Type

Rem
bbdoc:
End Rem
Type wxRarFileInfo

	Field wxObjectPtr:Byte Ptr

	Function _create:wxRarFileInfo(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxRarFileInfo = New wxRarFileInfo
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method GetName:String()
		Return bmx_wxrarfileinfo_getname(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetComment:String()
		Return bmx_wxrarfileinfo_getcomment(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetUncompressedSize:Int()
		Return bmx_wxrarfileinfo_getuncompressedsize(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetCompressedSize:Int()
		Return bmx_wxrarfileinfo_getcompressedsize(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetFileTime:Int()
		Return bmx_wxrarfileinfo_getfiletime(wxObjectPtr)
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxrarfileinfo_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

