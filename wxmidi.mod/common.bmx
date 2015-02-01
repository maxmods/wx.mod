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
Import wx.wxWindow
Import wx.wxControlWithItems
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

Import "src/portmidi/*.h"
Import "src/include/*.h"

Import "src/wxMidi/wxMidi.cpp"
Import "src/wxMidi/wxMidiDatabase.cpp"

Import "src/portmidi/porttime/*.h"
Import "src/portmidi/porttime/porttime.c"

Import "src/portmidi/pm_common/*.h"
Import "src/portmidi/pm_common/portmidi.c"
Import "src/portmidi/pm_common/pmutil.c"


?Win32
Import "src/portmidi/porttime/ptwinmm.c"

Import "src/portmidi/pm_win/*.h"
Import "src/portmidi/pm_win/pmwin.c"
Import "src/portmidi/pm_win/pmdll.c"
Import "src/portmidi/pm_win/pmwinmm.c"

?MacOS
Import "-framework CoreAudio"
Import "-framework CoreMIDI"

Import "src/portmidi/pm_mac/*.h"
Import "src/portmidi/pm_mac/pmmacosxcm.c"
Import "src/portmidi/pm_mac/pmmac.c"

Import "src/portmidi/porttime/ptmacosx_mach.c"
Import "src/portmidi/porttime/ptmacosx_cf.c"

?Linux
Import "src/portmidi/pm_linux/*.h"
Import "src/portmidi/pm_linux/pmlinuxalsa.c"
Import "src/portmidi/pm_linux/pmlinux.c"

Import "src/portmidi/porttime/ptlinux.c"
?

Import "glue.cpp"

Extern


	Function bmx_wxmidisystem_getinstance:Byte Ptr()
	Function bmx_wxmidisystem_gettime:Int(handle:Byte Ptr)
	Function bmx_wxmidisystem_geterrortext:String(handle:Byte Ptr, errnum:Int)
	Function bmx_wxmidisystem_gethosterrortext:String(handle:Byte Ptr)
	Function bmx_wxmidisystem_countdevices:Int(handle:Byte Ptr)

	Function bmx_wxmidiindevice_create:Byte Ptr(device:Int)
	Function bmx_wxmidiindevice_open:Int(handle:Byte Ptr)
	Function bmx_wxmidiindevice_flush(handle:Byte Ptr)
	Function bmx_wxmidiindevice_poll:Int(handle:Byte Ptr)
	Function bmx_wxmidiindevice_read:Byte Ptr(handle:Byte Ptr, error:Int Ptr)
	Function bmx_wxmidiindevice_setfilter:Int(handle:Byte Ptr, filters:Int)
	Function bmx_wxmidiindevice_setchannelmask:Int(handle:Byte Ptr, mask:Int)
	Function bmx_wxmidiindevice_startlistening:Int(handle:Byte Ptr, window:Byte Ptr, pollingRate:Int)
	Function bmx_wxmidiindevice_stoplistening:Int(handle:Byte Ptr)

	Function bmx_wxmidioutdevice_create:Byte Ptr(device:Int)
	Function bmx_wxmidioutdevice_abort:Int(handle:Byte Ptr)
	Function bmx_wxmidioutdevice_allsoundsoff:Int(handle:Byte Ptr)
	Function bmx_wxmidioutdevice_noteon:Int(handle:Byte Ptr, channel:Int, note:Int, velocity:Int)
	Function bmx_wxmidioutdevice_noteoff:Int(handle:Byte Ptr, channel:Int, note:Int, velocity:Int)
	Function bmx_wxmidioutdevice_open:Int(handle:Byte Ptr, latency:Int)
	Function bmx_wxmidioutdevice_programchange:Int(handle:Byte Ptr, channel:Int, instrument:Int)
	Function bmx_wxmidioutdevice_writeshort:Int(handle:Byte Ptr, msg:Byte Ptr)
	Function bmx_wxmidioutdevice_writesysex:Int(handle:Byte Ptr, msg:Byte Ptr)
	Function bmx_wxmidioutdevice_writebytes:Int(handle:Byte Ptr, bytes:Byte Ptr, when:Int)

	Function bmx_wxmidimessage_free(handle:Byte Ptr)
	Function bmx_wxmidimessage_settimestamp(handle:Byte Ptr, timestamp:Int)
	Function bmx_wxmidimessage_gettimestamp:Int(handle:Byte Ptr)
	Function bmx_wxmidimessage_gettype:Int(handle:Byte Ptr)
	Function bmx_wxmidimessage_getstatus:Int(handle:Byte Ptr)

	Function bmx_wxmidishortmessage_create:Byte Ptr(status:Int, data1:Int, data2:Int)
	Function bmx_wxmidishortmessage_getdata1:Int(handle:Byte Ptr)
	Function bmx_wxmidishortmessage_getdata2:Int(handle:Byte Ptr)

	Function bmx_wxmidisysexmessage_create:Byte Ptr(msg:Byte Ptr, timestamp:Int)
	Function bmx_wxmidisysexmessage_error:Int(handle:Byte Ptr)
	Function bmx_wxmidisysexmessage_getmessage:Byte[](handle:Byte Ptr)

	Function bmx_wxmididevice_free(handle:Byte Ptr)
	Function bmx_wxmididevice_close:Int(handle:Byte Ptr)
	Function bmx_wxmididevice_devicename:String(handle:Byte Ptr)
	Function bmx_wxmididevice_interfaceused:String(handle:Byte Ptr)
	Function bmx_wxmididevice_isinputport:Int(handle:Byte Ptr)
	Function bmx_wxmididevice_isoutputport:Int(handle:Byte Ptr)
	Function bmx_wxmididevice_hashosterror:Int(handle:Byte Ptr)

	Function bmx_wxmidi_geteventtype:Int(evt:Int)

	Function bmx_wxmidi_version:String()

	Function bmx_wxmididatabasegm_getinstance:Byte Ptr()
	Function bmx_wxmididatabasegm_populatewithinstruments(handle:Byte Ptr, ctrl:Byte Ptr, section:Int, nInstr:Int)
	Function bmx_wxmididatabasegm_populatewithpercusioninstr(handle:Byte Ptr, ctrl:Byte Ptr, iSel:Int)
	Function bmx_wxmididatabasegm_populatewithsections:Int(handle:Byte Ptr, ctrl:Byte Ptr, nSelInstr:Int)
	Function bmx_wxmididatabasegm_populatewithallinstruments(handle:Byte Ptr, ctrl:Byte Ptr, nInstr:Int)
	Function bmx_wxmididatabasegm_getnumsections:Int(handle:Byte Ptr)
	Function bmx_wxmididatabasegm_getnuminstrumentsinsection:Int(handle:Byte Ptr, sect:Int)
	Function bmx_wxmididatabasegm_getinstrfromsection:Int(handle:Byte Ptr, sect:Int, i:Int)
	Function bmx_wxmididatabasegm_getinstrumentname:String(handle:Byte Ptr, nInstr:Int)
	Function bmx_wxmididatabasegm_getsectionname:String(handle:Byte Ptr, sect:Int)

End Extern

Const wxEVT_MIDI_INPUT:Int = -650

Const wxMIDI_UNDEFINED_MSG:Int = 0
Const wxMIDI_SHORT_MSG:Int = 1
Const wxMIDI_SYSEX_MSG:Int = 2

Const wxMIDI_NO_ERROR:Int = 0

'error codes from portmidi. Name changed from pmXxxx To wxMIDI_ERROR_Xxxx
Const wxMIDI_ERROR_HostError:Int = -10000
Const wxMIDI_ERROR_InvalidDeviceId:Int = -9999 ' out of range Or output device when Input is requested Or vice versa */
Const wxMIDI_ERROR_InsufficientMemory:Int = -9998
Const wxMIDI_ERROR_BufferTooSmall:Int = -9997
Const wxMIDI_ERROR_BufferOverflow:Int = -9996
Const wxMIDI_ERROR_BadPtr:Int = -9995
Const wxMIDI_ERROR_BadData:Int = -9994 ' illegal midi data, e.g. missing EOX */
Const wxMIDI_ERROR_InternalError:Int = -9993
Const wxMIDI_ERROR_BufferMaxSize:Int = -9992 ' buffer is already as large as it can be */

'Additional error codes Not in portmidi
Const wxMIDI_ERROR_AlreadyListening:Int = -9991
Const wxMIDI_ERROR_CreateThread:Int = -9990
Const wxMIDI_ERROR_StartThread:Int = -9989
Const wxMIDI_ERROR_BadSysExMsg_Start:Int = -9988
Const wxMIDI_ERROR_BadSysExMsg_Length:Int = -9987
Const wxMIDI_ERROR_NoDataAvailable:Int = -9986

Const wxMIDI_NO_FILTER:Int = 0

Const wxMIDI_FILT_ACTIVE:Int = 1 Shl $0E
' filter system exclusive messages ($F0): */
Const wxMIDI_FILT_SYSEX:Int = 1 Shl $00
' filter MIDI clock message ($F8) */
Const wxMIDI_FILT_CLOCK:Int = 1 Shl $08
' filter play messages (start $FA, stop $FC, Continue $FB) */
Const wxMIDI_FILT_PLAY:Int = (1 Shl $0A) | ( 1 Shl $0C) | ( 1 Shl $0B)
' filter tick messages ($F9) */
Const wxMIDI_FILT_TICK:Int = 1 Shl $09
' filter undefined FD messages */
Const wxMIDI_FILT_FD:Int = 1 Shl $0D
' filter undefined real-time messages */
Const wxMIDI_FILT_UNDEFINED:Int = wxMIDI_FILT_FD
' filter reset messages ($FF) */
Const wxMIDI_FILT_RESET:Int = 1 Shl $0F
' filter all real-time messages */
Const wxMIDI_FILT_REALTIME:Int = wxMIDI_FILT_ACTIVE | wxMIDI_FILT_SYSEX | wxMIDI_FILT_CLOCK | ..
		wxMIDI_FILT_PLAY | wxMIDI_FILT_UNDEFINED | wxMIDI_FILT_RESET | wxMIDI_FILT_TICK
' filter note-on And note-off ($90-$9F And $80-$8F */
Const wxMIDI_FILT_NOTE:Int = (1 Shl $19) | (1 Shl $18)
' filter channel aftertouch (most midi controllers use this) ($D0-$DF)*/
Const wxMIDI_FILT_CHANNEL_AFTERTOUCH:Int = 1 Shl $1D
' per-note aftertouch ($A0-$AF) */
Const wxMIDI_FILT_POLY_AFTERTOUCH:Int = 1 Shl $1A
' filter both channel And poly aftertouch */
Const wxMIDI_FILT_AFTERTOUCH:Int = wxMIDI_FILT_CHANNEL_AFTERTOUCH | wxMIDI_FILT_POLY_AFTERTOUCH
' Program changes ($C0-$CF) */
Const wxMIDI_FILT_PROGRAM:Int = 1 Shl $1C
' Control Changes (CC's) ($B0-$BF)*/
Const wxMIDI_FILT_CONTROL:Int = 1 Shl $1B
' Pitch Bender ($E0-$EF*/
Const wxMIDI_FILT_PITCHBEND:Int = 1 Shl $1E
' MIDI Time Code ($F1)*/
Const wxMIDI_FILT_MTC:Int = 1 Shl $01
' Song Position ($F2) */
Const wxMIDI_FILT_SONG_POSITION:Int = 1 Shl $02
' Song Select ($F3)*/
Const wxMIDI_FILT_SONG_SELECT:Int = 1 Shl $03
' Tuning request ($F6)*/
Const wxMIDI_FILT_TUNE:Int = 1 Shl $06
' All System Common messages (mtc, song position, song Select, tune request)
Const wxMIDI_FILT_SYSTEMCOMMON:Int = wxMIDI_FILT_MTC | wxMIDI_FILT_SONG_POSITION | wxMIDI_FILT_SONG_SELECT | wxMIDI_FILT_TUNE

