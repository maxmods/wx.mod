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
bbdoc: wxCTB
End Rem
Module wx.wxCTB

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
bbdoc: 
End Rem
Type wxIOBase

	Field wxObjectPtr:Byte Ptr
	
	Method Close:Int()
		Return bmx_wxiobase_close(wxObjectPtr)
	End Method
	
	Method IsOpen:Int() Abstract
	
	Method Open:Int(deviceName:String)
		Return bmx_wxiobase_open(wxObjectPtr, deviceName)
	End Method
	
	Method PutBack:Int(char:Int)
		Return bmx_wxiobase_putback(wxObjectPtr, char)
	End Method
	
	Method Read:Int(buffer:Byte Ptr, size:Int) Abstract
	
	Method ReadUntilEOS:Int(buffer:Byte Ptr, bytesRead:Int Var, eos:String = "~n", timeout:Int = 1000, quota:Int = 0)
		Return bmx_wxiobase_readuntileos(wxObjectPtr, buffer, Varptr bytesRead, eos, timeout, quota)
	End Method
	
	Method Readv:Int(buffer:Byte Ptr, size:Int, timeoutFlag:Int Var, nice:Int = False)
		Return bmx_wxiobase_readv(wxObjectPtr, buffer, size, Varptr timeoutFlag, nice)
	End Method
	
	Method Write:Int(buffer:Byte Ptr, size:Int) Abstract
	
	Method Writev:Int(buffer:Byte Ptr, size:Int, timeoutFlag:Int Var, nice:Int = False)
		Return bmx_wxiobase_writev(wxObjectPtr, buffer, size, Varptr timeoutFlag, nice)
	End Method
	
End Type


Rem
bbdoc: 
End Rem
Type wxSerialPort_x Extends wxIOBase

End Type

Rem
bbdoc: 
End Rem
Type wxSerialPort Extends wxSerialPort_x

	Rem
	bbdoc: 
	End Rem
	Function CreateSerialPort:wxSerialPort()
		Return New wxSerialPort.Create()
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxSerialPort()
		wxObjectPtr = bmx_wxserialport_create()
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Method ChangeLineState:Int(flags:Int)
		Return bmx_wxserialport_changelinestate(wxObjectPtr, flags)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ClrLineState:Int(flags:Int)
		Return bmx_wxserialport_clrlinestate(wxObjectPtr, flags)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetLineState:Int()
		Return bmx_wxserialport_getlinestate(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Ioctl:Int(cmd:Int, args:Byte Ptr)
		Return bmx_wxserialport_ioctl(wxObjectPtr, cmd, args)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsOpen:Int()
		Return bmx_wxserialport_isopen(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Read:Int(buffer:Byte Ptr, size:Int)
		Return bmx_wxserialport_read(wxObjectPtr, buffer, size)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SendBreak:Int(duration:Int)
		Return bmx_wxserialport_sendbreak(wxObjectPtr, duration)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetBaudRate:Int(baudRate:Int)
		Return bmx_wxserialport_setbaudrate(wxObjectPtr, baudRate)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetLineState:Int(flags:Int)
		Return bmx_wxserialport_setlinestate(wxObjectPtr, flags)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Write:Int(buffer:Byte Ptr, size:Int)
		Return bmx_wxserialport_write(wxObjectPtr, buffer, size)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Free()
		If wxObjectPtr Then
			bmx_wxserialport_free(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
	Method Delete()
		Free()
	End Method

End Type


