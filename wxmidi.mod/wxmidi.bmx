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

ModuleInfo "CC_OPTS: -DNEWBUFFER"

Import "common.bmx"

Rem
bbdoc: MIDI messages are be represented by a wxMidiMessage object.
about: It is an abstract class from which the specific Midi messages derive. It contains
information about the type, data length, and status byte of the MIDI message. In addition,
it provides a timestamp value that is used by devices involved in MIDI timing, such as
sequencers.
End Rem
Type wxMidiMessage

	Field wxObjectPtr:Byte Ptr

	Function _createfortype:wxMidiMessage(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Select bmx_wxmidimessage_gettype(wxObjectPtr)
				Case wxMIDI_SHORT_MSG
					Return wxMidiShortMessage._create(wxObjectPtr)
				Case wxMIDI_SYSEX_MSG
					Return wxMidiSysExMessage._create(wxObjectPtr)
			End Select
			Return Null
		End If
	End Function

	Rem
	bbdoc: Set the message timestamp value.
	about: On output to a wxMidiOutDevice opened with non-zero latency, the timestamp will determine the time to
	begin sending the message. If the wxMidiOutDevice was opened with a latency value of zero, timestamps will be
	ignored and messages will be delivered inmediatelly.
	End Rem
	Method SetTimestamp(timestamp:Int)
		bmx_wxmidimessage_settimestamp(wxObjectPtr, timestamp)
	End Method
	
	Rem
	bbdoc: Returns the message timestamp value.
	about: On input, the timestamp ideally denotes the arrival time of the status byte of the message.
	End Rem
	Method GetTimestamp:Int()
		Return bmx_wxmidimessage_gettimestamp(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns either wxMIDI_SHORT_MSG, or wxMIDI_SYSEX_MSG, identifying the type of message object.
	End Rem
	Method GetType:Int()
		Return bmx_wxmidimessage_gettype(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the status byte of the message.
	about: For a wxSysExMessage status byte is always 0xF0 but the end of sysex message (0xF7) is also included in
	the message data. According MIDI standard the most significative bit of the status byte is always 1 so the range
	of staus values goes from 0x80 to 0xFF.
	<p>
	Values lower than 0xF0 identify channel messages, with the four lower bits specifying the channel (0-15); for example, status byte 0x93 is a NoteOn for channel 3:
	<table width="80%">
	<tr><td>Note-Off Event</td><td>0x8n</td></tr>
	<tr><td>Note-On  Event</td><td>0x9n</td></tr>
	<tr><td>Polyphonic Key Pressure</td><td>0xAn</td></tr>
	<tr><td>Control Change</td><td>0xBn</td></tr>
	<tr><td>Program Change</td><td>0xCn</td></tr>
	<tr><td>Channel Pressure</td><td>0xDn</td></tr>
	<tr><td>Pitch Bend</td><td>0xEn</td></tr>
	</table>
	</p>
	<p>
	Values 0xF0 to 0xFF are for system messages and are no intended for a specific channel:
	<table width="80%">
	<tr><td>Begin System Exclusive</td><td>0xF0</td></tr>
	<tr><td>MIDI  Time Code</td><td>0xF1</td></tr>
	<tr><td>Song Position Pointer</td><td>0xF2</td></tr>
	<tr><td>Song Select</td><td>0xF3</td></tr>
	<tr><td>Tune Request</td><td>0xF6</td></tr>
	<tr><td>End System Exclusive</td><td>0xF7</td></tr>
	<tr><td>Real-time Clock</td><td>0xF8</td></tr>
	<tr><td>Undefined</td><td>0xF9</td></tr>
	<tr><td>Start</td><td>0xFA</td></tr>
	<tr><td>Continue</td><td>0xFB</td></tr>
	<tr><td>Stop</td><td>0xFC</td></tr>
	<tr><td>Undefined</td><td>0xFD</td></tr>
	<tr><td>Active Sensing</td><td>0xFE</td></tr>
	<tr><td>System Reset</td><td>0xFF</td></tr>
	</table>	
	</p>
	End Rem
	Method GetStatus:Int()
		Return bmx_wxmidimessage_getstatus(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Frees a message.
	End Rem
	Method Free()
		If wxObjectPtr Then
			bmx_wxmidimessage_free(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
	Method Delete()
		Free()
	End Method
	
End Type

Rem
bbdoc: wxMidiShortMessage are the most common and have a status byte and at most two data bytes.
End Rem
Type wxMidiShortMessage Extends wxMidiMessage

	Function _create:wxMidiShortMessage(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxMidiShortMessage = New wxMidiShortMessage
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Returns the first data byte of the message or 0x00 if the type of message only has the status byte.
	End Rem
	Method GetData1:Int()
		Return bmx_wxmidishortmessage_getdata1(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the second data byte of the message or 0x00 if the type of message only has one data byte.
	End Rem
	Method GetData2:Int()
		Return bmx_wxmidishortmessage_getdata2(wxObjectPtr)
	End Method
	
End Type

Rem
bbdoc: Object wxMidiSysExMessage represents a system-exclusive MIDI message.
about: As the MIDI specification allows that sysex messages be interrupted by real-time messages, the wxMidi package
takes care of this and ensures that any real-time messsage embeded into a sysex message will be delivered first. Also
it ensures that when a sysex message is delivered it is complete and does not contain real-time messages embeded into
it.
<p>
The sysex message encapsulated in a wxMidiSysExMessage will normally be terminated by an EOX status byte (0xF7), but
this can not be guaranteed. If the last byte of a received wxMidiSysExMessage is not an EOX it means the sysex
message was somehow truncated. This is not considered an error, as a missing EOX can result from the user
disconnecting a MIDI cable during sysex transmission.
</p>
<p>
The timestamp of a wxMidiSysExMessage is the time at which the status byte (the first byte of the message) arrived.
</p>
End Rem
Type wxMidiSysExMessage Extends wxMidiMessage

	Function _create:wxMidiSysExMessage(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxMidiSysExMessage = New wxMidiSysExMessage
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Error:Int()
		Return bmx_wxmidisysexmessage_error(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetMessage:Byte[]()
		Return bmx_wxmidisysexmessage_getmessage(wxObjectPtr)
	End Method

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

	Field wxObjectPtr:Byte Ptr

	Rem
	bbdoc: Closes a MIDI stream, flushing any pending messages.
	about: Any wxMidiDevice that is successfully opened should eventually be closed calling Close().
	End Rem
	Method Close:Int()
		Return bmx_wxmididevice_close(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns a string containing the name of the MIDI device.
	about: For example "MPU-401 Compatible card".
	End Rem
	Method DeviceName:String()
		Return bmx_wxmididevice_devicename(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns a string containing the name of the API used internally to implement MIDI communication.
	about: Examples are "MMSystem", "DirectX", "ALSA", "OSS", etc. At present, the only Win32 interface implemented
	is "MMSystem", the only Linux interface is "ALSA", and the only Max OS X interface is "CoreMIDI".
	End Rem
	Method InterfaceUsed:String()
		Return bmx_wxmididevice_interfaceused(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the device has input capabilities and then can be used as wxMidiInDevice.
	End Rem
	Method IsInputPort:Int()
		Return bmx_wxmididevice_isinputport(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the device has output capabilities and then can be used as wxMidiOutDevice.
	End Rem
	Method IsOutputPort:Int()
		Return bmx_wxmididevice_isoutputport(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Check if the wxMidiDevice has a pending host error to be reported.
	about: Normally, the application finds out about wxMidi errors through returned error codes, but some errors can
	occur asynchronously where the application does not explicitly call a function, and therefore cannot receive an
	error code.
	<p>
	The client can test for a pending error using method HasHostError(). If true, the error can be accessed and
	cleared by calling wxMidiSystem::GetErrorText. It is nor necessary to call HasHostError() as any pending error
	will be reported the next time the application performs an explicit function call on the wxMidiDevice, i.e. an
	input or output operation.
	</p>
	End Rem
	Method HasHostError:Int()
		Return bmx_wxmididevice_hashosterror(wxObjectPtr)
	End Method

End Type

Rem
bbdoc: A wxMidiOutDevice object represents a MIDI stream on which MIDI data traffic can be sent..
End Rem
Type wxMidiOutDevice Extends wxMidiDevice

	Function _create:wxMidiOutDevice(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxMidiOutDevice = New wxMidiOutDevice
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Terminates any outgoing message immediately; this call may result in a partial transmission of a MIDI message.
	about: The caller should immediately close the output port.
	End Rem
	Method Abort:Int()
		Return bmx_wxmidioutdevice_abort(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: From time to time, specially during user application debugging, you may encounter a situation in which a MIDI synthesizer sounds as if its keys are "stuck," and it plays continuously as though someone's still pressing them.
	about: Sends the MIDI device a signal that tells it to stop inmediatelly all sounds.
	End Rem
	Method AllSoundsOff:Int()
		Return bmx_wxmidioutdevice_allsoundsoff(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Prepares and sends a NoteOn MIDI message.
	about: Parameters :
	<ul>
	<li>@channel - The number (0 to 15) of the logical channel that will be used to send the message.</li>
	<li>@note - A number in the range 0 to 127 that specifies the note's pitch. Middle C note corresponds to
	MIDI note 60, middle C # is 61, middle D is 62, and so on.</li>
	<li>@velocity - Velocity refers to how hard the key, on a MIDI keyboard, was pressed. This parameter controls
	the volume of the sound to be produced. So you can consider velocity as synonimous with volume. Parameter
	@velocity is a value from 0 to 127. A logarithmic scale is recommended, for example:
	<TABLE>
	<TR><TD>OFF</TD><TD> ppp</TD><TD>pp</TD><TD> p</TD><TD>mp</TD><TD>mf</TD><TD>f</TD><TD>ff</TD><TD>fff</TD></TR>
	<TR><TD>0</TD><TD> 1</TD><TD> 2</TD><TD> 4</TD><TD> 8</TD><TD> 16</TD><TD>32</TD><TD>64</TD><TD>127</TD></TR>
	</TABLE>
	</li>
	</ul>
	<p>
	You must be aware that in MIDI systems, the activation of a particular note and the release of the same note are
	considered as two separate events. So, after calling method NoteOn() it is necessary to call later to method
	NoteOff() to stop the sound generator, even if the sound produced by the NoteOn() command is no longer audible 
	due to natural soud extintion because of the chosen intrument (i.e.piano or percussion instruments).
	</p>
	End Rem
	Method NoteOn:Int(channel:Int, note:Int, velocity:Int)
		Return bmx_wxmidioutdevice_noteon(wxObjectPtr, channel, note, velocity)
	End Method
	
	Rem
	bbdoc: Prepares and sends a NoteOff MIDI message.
	about: It is normally used to stop a sound started by a previous call to NoteOn().
	<p>Parameters :
	<ul>
	<li>@channel - The number (0 to 15) of the logical channel that will be used to send the message. </li>
	<li>@note - A number in the range 0 to 127 that specifies the note's pitch to stop.</li>
	<li>@velocity - A number in the range 0 to 127 that specifies the velocity with which the key was released.
	This information is usually ignored by MIDI synthesizers.</li>
	</ul>
	</p>
	End Rem
	Method NoteOff:Int(channel:Int, note:Int, velocity:Int)
		Return bmx_wxmidioutdevice_noteoff(wxObjectPtr, channel, note, velocity)
	End Method
	
	Rem
	bbdoc: Opens a wxMidiOutDevice stream so that it can be used.
	End Rem
	Method Open:Int(latency:Int)
		Return bmx_wxmidioutdevice_open(wxObjectPtr, latency)
	End Method
	
	Rem
	bbdoc: Prepares and sends a ProgramChange MIDI message.
	about: This message is used to change the sound (instrument) assigned to a channel.
	End Rem
	Method ProgramChange:Int(channel:Int, instrument:Int)
		Return bmx_wxmidioutdevice_programchange(wxObjectPtr, channel, instrument)
	End Method
	
	Rem
	bbdoc: Sends a wxMidiShortMessage to the MIDI device represented by the wxMidiOutDevice object.
	End Rem
	Method WriteShort:Int(msg:wxMidiShortMessage)
		Return bmx_wxmidioutdevice_writeshort(wxObjectPtr, msg.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sends a wxMidiSysExMessage to the MIDI device represented by the wxMidiOutDevice object.
	End Rem
	Method WriteSysEx:Int(msg:wxMidiSysExMessage)
		Return bmx_wxmidioutdevice_writesysex(wxObjectPtr, msg.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method WriteBytes:Int(bytes:Byte Ptr, when:Int = 0)
		Return bmx_wxmidioutdevice_writebytes(wxObjectPtr, bytes, when)
	End Method

End Type

Rem
bbdoc: A wxMidiInDevice object represents a MIDI stream on which MIDI data traffic can be read.
End Rem
Type wxMidiInDevice Extends wxMidiDevice

	Function _create:wxMidiInDevice(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxMidiInDevice = New wxMidiInDevice
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Open the device, so that the device can be used.
	about: Upon success Open() returns zero (wxMIDI_NO_ERROR). If the open process fails a non-zero error code is returned.
	<p>
	Any successfully opened device should eventually be closed calling Close().
	</p>
	End Rem
	Method Open:Int()
		Return bmx_wxmidiindevice_open(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Discard any MIDI messages waiting to be read.
	End Rem
	Method Flush()
		bmx_wxmidiindevice_flush(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Check if there is a received MIDI message waiting to be Read().
	about: It returns TRUE if there are messages waiting, FALSE if not, or an error value if an error ocurred.
	End Rem
	Method Poll:Int()
		Return bmx_wxmidiindevice_poll(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Read:wxMidiMessage(error:Int Var)
		Return wxMidiMessage._createfortype(bmx_wxmidiindevice_read(wxObjectPtr, Varptr error))
	End Method
	
	Rem
	bbdoc: Sets filters on an open wxMidiInDevice to drop selected input types.
	about: By default, active sensing messages are filtered.. To allow all messages you have to call
	SetFilter(wxMIDI_NO_FILTER).
	<p>
	Filtering is useful when midi routing or midi thru functionality is being provided by the user application. For
	example, you may want to exclude timing messages (clock, MTC, start/stop/continue), while allowing note-related
	messages to pass. Or you may be using a sequencer or drum-machine for MIDI clock information but want to exclude
	any notes it may play.
	</p>
	End Rem
	Method SetFilter:Int(filters:Int)
		Return bmx_wxmidiindevice_setfilter(wxObjectPtr, filters)
	End Method
	
	Rem
	bbdoc: SetChannelMask() filters incoming messages based on channel.
	about: The mask is a 16-bit bitfield corresponding to appropriate channels. By default, messages for all channels
	are allowed.
	End Rem
	Method SetChannelMask:Int(mask:Int)
		Return bmx_wxmidiindevice_setchannelmask(wxObjectPtr, mask)
	End Method
	
	Rem
	bbdoc: This method creates and starts a thread to call Poll() method every @pollingRate milliseconds, and trigger a wxEVT_MIDI_INPUT command event if a MIDI message has been received and is waiting to be Read().
	End Rem
	Method StartListening:Int(window:wxWindow, pollingRate:Int = 50)
		Return bmx_wxmidiindevice_startlistening(wxObjectPtr, window.wxObjectPtr, pollingRate)
	End Method
	
	Rem
	bbdoc: Stops a listener thread created in a previous call to wxMidiInDevice::StartListening.
	End Rem
	Method StopListening:Int()
		Return bmx_wxmidiindevice_stoplistening(wxObjectPtr)
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

Rem
bbdoc: wxMidi version.
End Rem
Function wxMIDI_VERSION:String()
	Return bmx_wxmidi_version()
End Function

Type TMidiEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		If evt.eventType = wxEVT_MIDI_INPUT Then
			Return wxCommandEvent.Create(wxEventPtr, evt)
		End If
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		If eventType = wxEVT_MIDI_INPUT Then
			Return bmx_wxmidi_geteventtype(eventType)
		End If
	End Method
		
End Type

New TMidiEventFactory

