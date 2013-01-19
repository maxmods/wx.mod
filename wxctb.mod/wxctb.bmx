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
bbdoc: wxCTB
End Rem
Module wx.wxCTB

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
bbdoc: 
End Rem
Type wxIOBase

	Field wxObjectPtr:Byte Ptr
	
	Rem
	bbdoc: Close the interface.
	End Rem
	Method Close:Int()
		Return bmx_wxiobase_close(wxObjectPtr)
	End Method
	
	Method IsOpen:Int() Abstract
	
	Rem
	bbdoc: Opens the specified device.
	about: The optional dcs will be used for special device dependent settings. Because this is very specific,
	the struct or destination of the dcs will be defined by every device itself. (For example: a serial device
	type should refer things like parity, word length and count of stop bits, a IEEE type address and EOS character).
	End Rem
	Method Open:Int(deviceName:String, dcs:wxDCS = Null)
		If dcs Then
			Return bmx_wxiobase_open(wxObjectPtr, deviceName, dcs.wxObjectPtr)
		Else
			Return bmx_wxiobase_open(wxObjectPtr, deviceName, Null)
		End If
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method PutBack:Int(char:Int)
		Return bmx_wxiobase_putback(wxObjectPtr, char)
	End Method
	
	Method Read:Int(buffer:Byte Ptr, size:Int) Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method ReadUntilEOS:Int(buffer:Byte Ptr, bytesRead:Int Var, eos:String = "~n", timeout:Int = 1000, quota:Int = 0)
		Return bmx_wxiobase_readuntileos(wxObjectPtr, buffer, Varptr bytesRead, eos, timeout, quota)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Readv:Int(buffer:Byte Ptr, size:Int, timeoutFlag:Int Var, nice:Int = False)
		Return bmx_wxiobase_readv(wxObjectPtr, buffer, size, Varptr timeoutFlag, nice)
	End Method
	
	Method Write:Int(buffer:Byte Ptr, size:Int) Abstract
	
	Rem
	bbdoc: 
	End Rem
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
	bbdoc: Creates a new serial port instance.
	End Rem
	Function CreateSerialPort:wxSerialPort()
		Return New wxSerialPort.Create()
	End Function
	
	Rem
	bbdoc: Creates a new serial port instance.
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
	bbdoc: Frees the serial port object.
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

Rem
bbdoc: The base device control struct
End Rem
Type wxDCS

	Field wxObjectPtr:Byte Ptr

End Type


Rem
bbdoc: The device control struct for the serial communication type.
about: This type should be used, if you want to use advanced parameters.
End Rem
Type wxSerialPort_DCS Extends wxDCS

	Rem
	bbdoc: Creates a new serial device control struct.
	End Rem
	Function CreateSerialPortDCS:wxSerialPort_DCS()
		Return New wxSerialPort_DCS.Create()
	End Function
	
	Rem
	bbdoc: Creates a new serial device control struct.
	End Rem
	Method Create:wxSerialPort_DCS()
		wxObjectPtr = bmx_wxserialportdcs_create()
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the internal settings of the DCS as a human readable string like '8N1 115200'.
	End Rem
	Method GetSettings:String()
		Return bmx_wxserialportdcs_getsettings(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the baud rate.
	End Rem
	Method SetBaud(baud:Int)
		bmx_wxserialportdcs_setbaud(wxObjectPtr, baud)
	End Method
	
	Rem
	bbdoc: Sets the parity.
	End Rem
	Method SetParity(parity:Int)
		bmx_wxserialportdcs_setparity(wxObjectPtr, parity)
	End Method
	
	Rem
	bbdoc: Sets the word length.
	End Rem
	Method SetWordLen(wordLen:Int)
		bmx_wxserialportdcs_setwordlen(wxObjectPtr, wordLen)
	End Method
	
	Rem
	bbdoc: Sets the count of stopbits.
	End Rem
	Method SetStopBits(stopBits:Int)
		bmx_wxserialportdcs_setstopbits(wxObjectPtr, stopBits)
	End Method
	
	Rem
	bbdoc: Enables rtscts flow control.
	about: Use a @value of False to disable.
	End Rem
	Method EnableRTSCTS(value:Int = True)
		bmx_wxserialportdcs_enablertscts(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: Enables XON/XOFF flow control.
	about: Use a @value of False to disable.
	End Rem
	Method EnableXONXOFF(value:Int = True)
		bmx_wxserialportdcs_enablexonxoff(wxObjectPtr, value)
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxserialportdcs_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

End Type

?macos
Rem
bbdoc: Returns a list of available serial ports.
End Rem
Function wxListSerialPorts:String[]()
	Return bmx_wxctb_listserialports()
End Function

Rem
bbdoc: Presents a choice dialog of serial ports, returning the port choosen or Null if cancelled.
End Rem
Function wxChooseSerialPort:String()
	Local ports:String[] = wxListSerialPorts()
	Local port:Int = wxGetSingleChoiceIndex("Please choose a serial port :", "Serial Port", ports)
	If port <> -1 Then
		Return ports[port]
	End If
	Return Null
End Function
?
