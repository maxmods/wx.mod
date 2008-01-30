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
	End Method
	
	Method IsOpen:Int()
	End Method
	
	Method Open:Int(deviceName:String)
	End Method
	
	Method PutBack:Int(char:Int)
	End Method
	
	Method Read:Int(buffer:Byte Ptr, size:Int)
	End Method
	
	Method ReadUntilEOS:Int(buffer:Byte Ptr, bytesRead:Int Var, eos:String = "~n", timeout:Int = 1000, quota:Int = 0)
	End Method
	
	Method Readv:Int(buffer:Byte Ptr, size:Int, timeoutFlag:Int Var, nice:Int = False)
	End Method
	
	Method Write:Int(buffer:Byte Ptr, size:Int)
	End Method
	
	Method Writev:Int(buffer:Byte Ptr, size:Int, timeoutFlag:Int Var, nice:Int = False)
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

	Function CreateSerialPort:wxSerialPort()
		Return New wxSerialPort.Create()
	End Function
	
	Method Create:wxSerialPort()
		
		Return Self
	End Method

	Method ChangeLineState:Int(flags:Int)
	End Method
	
	Method ClrLineState:Int(flags:Int)
	End Method
	
	Method GetLineState:Int()
	End Method
	
	Method Ioctl:Int(cmd:Int, args:Byte Ptr)
	End Method
	
	Method IsOpen:Int()
	End Method
	
	Method Read:Int(buffer:Byte Ptr, size:Int)
	End Method
	
	Method SendBreak:Int(duration:Int)
	End Method
	
	Method SetBaudRate:Int(baudRate:Int)
	End Method
	
	Method SetLineState:Int(flags:Int)
	End Method
	
	Method Write:Int(buffer:Byte Ptr, size:Int)
	End Method

End Type


