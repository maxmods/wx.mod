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
bbdoc: wxMediaCtrl
End Rem
Module wx.wxMediaCtrl

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
bbdoc: wxMediaCtrl is a type for displaying types of media, such as videos, audio files, natively through native codecs.
about: wxMediaCtrl uses native backends to render media, for example on Windows there is a
ActiveMovie/DirectShow backend, and on Macintosh there is a QuickTime backend.
<p>
By default, wxMediaCtrl will scale the size of the video to the requested amount passed to its constructor. After calling wxMediaCtrl::Load
or performing an equivilant operation, you can subsequently obtain the "real" size of the video (if there is any) by calling
wxMediaCtrl::GetBestSize(). Note that the actual result on the display will be slightly different when wxMediaCtrl::ShowPlayerControls is
activated and the actual video size will be less then specified due to the extra controls provided by the native toolkit. In addition, the
backend may modify wxMediaCtrl::GetBestSize() to include the size of the extra controls - so if you want the real size of the video just
disable wxMediaCtrl::ShowPlayerControls().
</p>
<p>
The idea with setting wxMediaCtrl::GetBestSize() to the size of the video is that GetBestSize() is a wxWindow-derived function that is
called when sizers on a window recalculate. What this means is that if you use sizers by default the video will show in its original size
without any extra assistance needed from the user.
</p>
<p>
Normally, when you use wxMediaCtrl it is just a window for the video to play in. However, some toolkits have their own media player interface.
For example, QuickTime generally has a bar below the video with a slider. A special feature available to wxMediaCtrl, you can use the
toolkits interface instead of making your own by using the ShowPlayerControls() function. There are several options for the flags parameter, with
the two general flags being wxMEDIACTRLPLAYERCONTROLS_NONE which turns off the native interface, and wxMEDIACTRLPLAYERCONTROLS_DEFAULT which
lets wxMediaCtrl decide what native controls on the interface. Be sure to review the caveats outlined in Video size before doing so.
</p>
End Rem
Type wxMediaCtrl Extends wxControl

	Rem
	bbdoc: 
	End Rem
	Function CreateMediaCtrl:wxMediaCtrl(parent:wxWindow, id:Int, filename:String = "", x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0, backend:String = "")
		Return New wxMediaCtrl.Create(parent, id, filename, x, y, w, h, style, backend)
	End Function

	Rem
	bbdoc: 
	End Rem
	Method Create:wxMediaCtrl(parent:wxWindow, id:Int, filename:String = "", x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0, backend:String = "")
		wxObjectPtr = bmx_wxmediactrl_create(Self, parent.wxObjectPtr, id, filename, x, y, w, h, style, backend)
		OnInit()
		Return Self
	End Method
	
	Rem
	bbdoc: Obtains the best size relative to the original/natural size of the video, if there is any.
	End Rem
	Method GetBestSize(w:Int Var, h:Int Var)
		bmx_wxmediactrl_getbestsize(wxObjectPtr, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: Obtains the playback rate, or speed of the media.
	about: 1.0 represents normal speed, while 2.0 represents twice the normal speed of the media, for example. Not supported on
	the GStreamer (Unix) backend.
	End Rem
	Method GetPlaybackrate:Double()
		Return bmx_wxmediactrl_getplaybackrate(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the volume of the media from a 0.0 to 1.0 range.
	about: Due to rounding and other errors the value returned may not be the exact value sent to SetVolume().
	End Rem
	Method GetVolume:Double()
		Return bmx_wxmediactrl_getvolume(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Obtains the state the playback of the media is in.
	about: One of wxMEDIASTATE_STOPPED, wxMEDIASTATE_PAUSED or wxMEDIASTATE_PLAYING.
	End Rem
	Method GetState:Int()
		Return bmx_wxmediactrl_getstate(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Obtains the length - the total amount of time the movie has in milliseconds.
	End Rem
	Method Length:Long()
		Local v:Long
		bmx_wxmediactrl_length(wxObjectPtr, Varptr v)
		Return v
	End Method
	
	Rem
	bbdoc: Loads the file that fileName refers to.
	returns: False if loading fails.
	End Rem
	Method Load:Int(filename:String)
		Return bmx_wxmediactrl_load(wxObjectPtr, filename)
	End Method
	
	Rem
	bbdoc: Loads the location that uri refers to.
	returns: False if loading fails.
	about: Note that this is very implementation-dependant, although HTTP URI/URLs are generally supported, for example.
	End Rem
	Method LoadURI:Int(uri:String)
		Return bmx_wxmediactrl_loaduri(wxObjectPtr, uri)
	End Method
	
	Rem
	bbdoc: Loads the location that uri refers to with the proxy proxy.
	returns: False if loading fails.
	about: Not implemented on most backends so it should be called with caution.
	End Rem
	Method LoadURIWithProxy:Int(uri:String, proxy:String)
		Return bmx_wxmediactrl_loaduriwithproxy(wxObjectPtr, uri, proxy)
	End Method
	
	Rem
	bbdoc: Pauses playback of the movie.
	End Rem
	Method Pause:Int()
		Return bmx_wxmediactrl_pause(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Resumes playback of the movie.
	End Rem
	Method Play:Int()
		Return bmx_wxmediactrl_play(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Seeks to a position within the movie.
	about: 
	End Rem
	Method Seek:Long(where:Long, mode:Int = wxFromStart)
		Local v:Long
		bmx_wxmediactrl_seek(wxObjectPtr, where, mode, Varptr v)
		Return v
	End Method
	
	Rem
	bbdoc: Sets the playback rate, or speed of the media, to that referred by @rate.
	returns: True if successful.
	about: 1.0 represents normal speed, while 2.0 represents twice the normal speed of the media, for example. Not supported on
	the GStreamer (Unix) backend. 
	End Rem
	Method SetPlaybackRate:Int(rate:Double)
		Return bmx_wxmediactrl_setplaybackrate(wxObjectPtr, rate)
	End Method
	
	Rem
	bbdoc: Sets the volume of the media from a 0.0 to 1.0 range to that referred by @volume.
	about: 1.0 represents full volume, while 0.5 represents half (50 percent) volume, for example.
	End Rem
	Method SetVolume:Int(volume:Double)
		Return bmx_wxmediactrl_setvolume(wxObjectPtr, volume)
	End Method
	
	Rem
	bbdoc: Show the native player controls.
	returns: True on success.
	about: Applications using native toolkits such as QuickTime usually have a scrollbar, play button, and more provided to them by
	the toolkit. By default wxMediaCtrl does not do this. However, on the directshow and quicktime backends you can show or hide the
	native controls provided by the underlying toolkit at will using ShowPlayerControls(). Simply calling the function with default
	parameters tells wxMediaCtrl to use the default controls provided by the toolkit. The method takes a wxMediaCtrlPlayerControls enumeration,
	please see available show modes there.
	<p>
	Currently only implemented on the QuickTime and DirectShow backends.
	</p>
	End Rem
	Method ShowPlayerControls:Int(flags:Int = wxMEDIACTRLPLAYERCONTROLS_DEFAULT)
		Return bmx_wxmediactrl_showplayercontrols(wxObjectPtr, flags)
	End Method
	
	Rem
	bbdoc: Stops the media.
	End Rem
	Method Stop:Int()
		Return bmx_wxmediactrl_stop(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Obtains the current position in time within the movie in milliseconds.
	End Rem
	Method Tell:Long()
		Local v:Long
		bmx_wxmediactrl_tell(wxObjectPtr, Varptr v)
		Return v
	End Method

End Type

Rem
bbdoc: 
End Rem
Type wxMediaEvent Extends wxNotifyEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxMediaEvent = New wxMediaEvent
		
		this.wxEventPtr = wxEventPtr
		this.userData = evt.userData
		this.parent = evt.parent
		
		Return this
	End Function

End Type

Type TMediaEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		Select evt.eventType
			Case wxEVT_MEDIA_FINISHED, ..
					wxEVT_MEDIA_STOP, ..
					wxEVT_MEDIA_LOADED, ..
					wxEVT_MEDIA_STATECHANGED, ..
					wxEVT_MEDIA_PLAY, ..
					wxEVT_MEDIA_PAUSE
				
				Return wxMediaEvent.Create(wxEventPtr, evt)
		End Select
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_MEDIA_FINISHED, ..
					wxEVT_MEDIA_STOP, ..
					wxEVT_MEDIA_LOADED, ..
					wxEVT_MEDIA_STATECHANGED, ..
					wxEVT_MEDIA_PLAY, ..
					wxEVT_MEDIA_PAUSE
				Return bmx_wxmediactrl_geteventtype(eventType)
		End Select
	End Method
	
End Type

New TMediaEventFactory


