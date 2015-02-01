' Copyright (c) 2007-2015 Bruce A Henderson
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

Import wx.wx
?macos
Import wx.wxChoiceDialog
?
Import BRL.Blitz


' headers :-)
?linux
Import "../lib/linux/wx/include/gtk2-unicode-release-static/*.h"
Import "../include/*.h"
?win32
Import "../lib/win32/mswu/*.h"
Import "../include/*.h"
?macosppc
Import "../lib/macosppc/wx/include/mac-unicode-release-static/*.h"
Import "../include/*.h"
?macosx86
Import "../lib/macosx86/wx/include/mac-unicode-release-static/*.h"
Import "../include/*.h"
?

Import "include/*.h"

Import "src/fifo.cpp"
Import "src/getopt.cpp"
Import "src/iobase.cpp"
Import "src/fifo.cpp"
Import "src/kbhit.cpp"

?macos
Import "src/macos/timer.cpp"
Import "src/macos/serport.cpp"
?win32
Import "src/win32/timer.cpp"
Import "src/win32/serport.cpp"
?linux
Import "src/linux/timer.cpp"
Import "src/linux/serport.cpp"
?

Import "glue.cpp"

?macos
Import "macglue.cpp"
?

Extern

	Function bmx_wxserialport_create:Byte Ptr()
	Function bmx_wxserialport_changelinestate:Int(handle:Byte Ptr, flags:Int)
	Function bmx_wxserialport_clrlinestate:Int(handle:Byte Ptr, flags:Int)
	Function bmx_wxserialport_getlinestate:Int(handle:Byte Ptr)
	Function bmx_wxserialport_ioctl:Int(handle:Byte Ptr, cmd:Int, args:Byte Ptr)
	Function bmx_wxserialport_isopen:Int(handle:Byte Ptr)
	Function bmx_wxserialport_read:Int(handle:Byte Ptr, buffer:Byte Ptr, size:Int)
	Function bmx_wxserialport_sendbreak:Int(handle:Byte Ptr, duration:Int)
	Function bmx_wxserialport_setbaudrate:Int(handle:Byte Ptr, baudRate:Int)
	Function bmx_wxserialport_setlinestate:Int(handle:Byte Ptr, flags:Int)
	Function bmx_wxserialport_write:Int(handle:Byte Ptr, buffer:Byte Ptr, size:Int)
	Function bmx_wxserialport_free(handle:Byte Ptr)

	Function bmx_wxiobase_close:Int(handle:Byte Ptr)
	Function bmx_wxiobase_open:Int(handle:Byte Ptr, deviceName:String, dcs:Byte Ptr)
	Function bmx_wxiobase_putback:Int(handle:Byte Ptr, char:Int)
	Function bmx_wxiobase_readuntileos:Int(handle:Byte Ptr, buffer:Byte Ptr, bytesRead:Int Ptr, eos:String, timeout:Int, quota:Int)
	Function bmx_wxiobase_readv:Int(handle:Byte Ptr, buffer:Byte Ptr, size:Int, timeoutFlag:Int Ptr, nice:Int)
	Function bmx_wxiobase_writev:Int(handle:Byte Ptr, buffer:Byte Ptr, size:Int, timeoutFlag:Int Ptr, nice:Int)

	Function bmx_wxserialportdcs_create:Byte Ptr()
	Function bmx_wxserialportdcs_getsettings:String(handle:Byte Ptr)
	Function bmx_wxserialportdcs_setbaud(handle:Byte Ptr, baud:Int)
	Function bmx_wxserialportdcs_setparity(handle:Byte Ptr, parity:Int)
	Function bmx_wxserialportdcs_setwordlen(handle:Byte Ptr, wordLen:Int)
	Function bmx_wxserialportdcs_setstopbits(handle:Byte Ptr, stopBits:Int)
	Function bmx_wxserialportdcs_enablertscts(handle:Byte Ptr, value:Int)
	Function bmx_wxserialportdcs_enablexonxoff(handle:Byte Ptr, value:Int)
	Function bmx_wxserialportdcs_delete(handle:Byte Ptr)

?macos
	Function bmx_wxctb_listserialports:String[]()
?
End Extern

?linux
Const wxCOM1:String = "/dev/ttyS0"
Const wxCOM2:String = "/dev/ttyS1"
Const wxCOM3:String = "/dev/ttyS2"
Const wxCOM4:String = "/dev/ttyS3"
Const wxCOM5:String = "/dev/ttyS4"
Const wxCOM6:String = "/dev/ttyS5"
Const wxCOM7:String = "/dev/ttyS6"
Const wxCOM8:String = "/dev/ttyS7"
Const wxCOM9:String = "/dev/ttyS8"
?win32
Const wxCOM1:String = "com1"
Const wxCOM2:String = "com2"
Const wxCOM3:String = "com3"
Const wxCOM4:String = "com4"
Const wxCOM5:String = "com5"
Const wxCOM6:String = "com6"
Const wxCOM7:String = "com7"
Const wxCOM8:String = "com8"
Const wxCOM9:String = "com9"
Const wxCOM10:String = "\\.\com10"
Const wxCOM11:String = "\\.\com11"
Const wxCOM12:String = "\\.\com12"
Const wxCOM13:String = "\\.\com13"
Const wxCOM14:String = "\\.\com14"
Const wxCOM15:String = "\\.\com15"
Const wxCOM16:String = "\\.\com16"
?macos
Const wxCOM1:String = "/dev/tty.PL2303-0000101D" ' just a guess :-p
Const wxCOM2:String = ""
Const wxCOM3:String = ""
Const wxCOM4:String = ""
Const wxCOM5:String = ""
Const wxCOM6:String = ""
Const wxCOM7:String = ""
Const wxCOM8:String = ""
Const wxCOM9:String = ""
?

Const wxBAUD_150:Int = 150
Const wxBAUD_300:Int = 300       
Const wxBAUD_600:Int = 600
Const wxBAUD_1200:Int = 1200
Const wxBAUD_2400:Int = 2400
Const wxBAUD_4800:Int = 4800
Const wxBAUD_9600:Int = 9600
Const wxBAUD_19200:Int = 19200
Const wxBAUD_38400:Int = 38400
Const wxBAUD_57600:Int = 57600
Const wxBAUD_115200:Int = 115200
Const wxBAUD_230400:Int = 230400
Const wxBAUD_460800:Int = 460800
Const wxBAUD_921600:Int = 921600


Const wxPARITY_NONE:Int = 0
Const wxPARITY_ODD:Int = 1
Const wxPARITY_EVEN:Int = 2
Const wxPARITY_MARK:Int = 3
Const wxPARITY_SPACE:Int = 4

Const wxSERIAL_LINESTATE_DCD:Int = $040
Const wxSERIAL_LINESTATE_CTS:Int = $020
Const wxSERIAL_LINESTATE_DSR:Int = $100
Const wxSERIAL_LINESTATE_DTR:Int = $002
Const wxSERIAL_LINESTATE_RING:Int = $080
Const wxSERIAL_LINESTATE_RTS:Int = $004
Const wxSERIAL_LINESTATE_NULL:Int = $000

