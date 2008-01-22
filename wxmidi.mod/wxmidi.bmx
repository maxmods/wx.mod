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
bbdoc: wxMidi
End Rem
Module wx.wxMidi

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
bbdoc: MIDI messages are be represented by a wxMidiMessage object.
about: It is an abstract class from which the specific Midi messages derive. It contains
information about the type, data length, and status byte of the MIDI message. In addition,
it provides a timestamp value that is used by devices involved in MIDI timing, such as
sequencers.
End Rem
Type wxMidiMessage

	Method SetTimestamp(timestamp:Int)
	End Method
	
	Method GetTimestamp:Int()
	End Method
	
	Method GetType:Int()
	End Method
	
	Method GetStatus:Int()
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxMidiShortMessage Extends wxMidiMessage

	Method GetData1:Int()
	End Method
	
	Method GetData2:Int()
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxMidiSysExMessage Extends wxMidiMessage
End Type

Rem
bbdoc: The base interface for devices is wxMidiDevice.
about: It is an abstract class with two derived classes: wxMidiInDevice and wxMidiOutDevice
<p>
A wxMidiDevice object represents a MIDI stream on which MIDI data traffic can be read or sent. All
MIDI communication is achieved through a wxMidiDevice by using MIDI messages. Devices can be opened
and closed, and they provide descriptions of themselves.
</p>
<p>
MIDI messages are represented by the wxMidiMessage abstract class and are read and sent from/to the
MIDI stream by using methods Read and Write, respectively.
</p>
<p>
For the most common output operations, such as note on or note off, there are specific methods
implemented so that wxMidi user has not to build and send the appropriate messages. See: NoteOn,
NoteOff, ProgramChange, AllSoundsOff.
</p>
End Rem
Type wxMidiDevice

	Method Close:Int()
	End Method
	
	Method DeviceName:String()
	End Method
	
	Method InterfaceUsed:String()
	End Method
	
	Method IsInputPort:Int()
	End Method
	
	Method IsOutputPort:Int()
	End Method
	
	Method HasHostError:Int()
	End Method

End Type

Rem
bbdoc: A wxMidiOutDevice object represents a MIDI stream on which MIDI data traffic can be sent..
End Rem
Type wxMidiOutDevice Extends wxMidiDevice

	Method Abort:Int()
	End Method
	
	Method AllSoundsOff:Int()
	End Method
	
	Method NoteOn:Int(channel:Int, note:Int, velocity:Int)
	End Method
	
	Method NoteOff:Int(channel:Int, note:Int, velocity:Int)
	End Method
	
	Method Open:Int(latency:Int)
	End Method
	
	Method ProgramChange:Int(channel:Int, instrument:Int)
	End Method
	
	Method WriteShort:Int(msg:wxMidiShortMessage)
	End Method
	
	Method WriteSysEx:Int(msg:wxMidiSysExMessage)
	End Method
	
	Method WriteBytes:Int(bytes:Byte[], when:Int = 0)
	End Method

End Type

Rem
bbdoc: A wxMidiInDevice object represents a MIDI stream on which MIDI data traffic can be read.
End Rem
Type wxMidiInDevice Extends wxMidiDevice

	Method Open:Int()
	End Method
	
	Method Flush()
	End Method
	
	Method Poll:Int()
	End Method
	
	Method Read:wxMidiMessage(error:Int Var)
	End Method
	
	Method SetFilter:Int(filters:Int)
	End Method
	
	Method SetChannelMask:Int(mask:Int)
	End Method
	
	Method StartListening:Int(window:wxWindow, pollingRate:Int = 50)
	End Method
	
	Method StopListening:Int()
	End Method
	
End Type

Type wxMidiDatabaseGM

End Type

Rem
bbdoc: wxMidiSystem acts as the user application's entry point to the MIDI music system.
about: It provides information about, and access to, the set of installed MIDI devices.
<p>
wxMidiSystem is a singleton and access to the only instance must be through the function GetInstance.
</p>
End Rem
Type wxMidiSystem

	Field wxObjectPtr:Byte Ptr

	Function _create:wxMidiSystem(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxMidiSystem = New wxMidiSystem
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Returns a the only wxMidiSystem instance.
	End Rem
	Function GetInstance:wxMidiSystem()
		Return _create(bmx_wxmidisystem_getinstance())
	End Function
	
	Rem
	bbdoc: Returns current value of the Midi timer.
	about: This timer is started when the Midi package is initialized and has a resolution
	of one millisecond.
	End Rem
	Method GetTime:Int()
		Return bmx_wxmidisystem_gettime(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Translates a portmidi error number into a human readable message.
	about: For a explanation of error codes see wxMidi error codes.
	End Rem
	Method GetErrorText:String(errnum:Int)
		Return bmx_wxmidisystem_geterrortext(wxObjectPtr, errnum)
	End Method
	
	Rem
	bbdoc: Translate portmidi host error into human readable message.
	about: After this routine executes, the host error is cleared.
	End Rem
	Method GetHostErrorText:String()
		Return bmx_wxmidisystem_gethosterrortext(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the number of MIDI devices present in the system.
	about: The IDs of the MIDI devices will range from 0 to CountDevices() - 1. So, for
	example, if CountDevices() returns 3, it means that there are three MIDI devices in the
	system and that their IDs will be 0, 1 and 2.To determine if they are output devices or
	input devices, you will have to instantiate the corresponding wxMidiDevice object and
	use methods IsInput() or IsOutput(), as in the following example:
	End Rem
	Method CountDevices:Int()
		Return bmx_wxmidisystem_countdevices(wxObjectPtr)
	End Method

End Type


