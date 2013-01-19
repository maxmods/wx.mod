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
bbdoc: wxArchiveClassFactory
End Rem
Module wx.wxArchiveClassFactory

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2008-2009 Bruce A Henderson"


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
bbdoc: 
End Rem
Type wxArchiveClassFactory Extends wxObject

	Function _create:wxArchiveClassFactory(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxArchiveClassFactory = New wxArchiveClassFactory
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Method CanHandle:Int(protocol:String, protocolType:Int = wxSTREAM_PROTOCOL)
		Return bmx_wxarchiveclassfactory_canhandle(wxObjectPtr, protocol, protocolType)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Function Find:wxArchiveClassFactory(protocol:String, protocolType:Int = wxSTREAM_PROTOCOL)
		Return wxArchiveClassFactory._create(bmx_wxarchiveclassfactory_find(protocol, protocolType))
	End Function
	
	Function GetFirst:wxArchiveClassFactory()
	End Function
	
	Method GetNext:wxArchiveClassFactory()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetProtocol:String()
		Return bmx_wxarchiveclassfactory_getprotocol(wxObjectPtr)
	End Method
	
	Method GetProtocols:String[]()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method NewInputStream:wxArchiveInputStream(stream:wxInputStream)
		Return wxArchiveInputStream._create(bmx_wxarchiveclassfactory_newinputstream(wxObjectPtr, stream.wxStreamPtr))
	End Method
	
	Method NewOutputStream:wxArchiveOutputStream(stream:wxOutputStream)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method PopExtension:String(location:String)
		Return bmx_wxarchiveclassfactory_popextension(wxObjectPtr, location)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method PushFront()
		bmx_wxarchiveclassfactory_pushfront(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Remove()
		bmx_wxarchiveclassfactory_remove(wxObjectPtr)
	End Method

End Type

