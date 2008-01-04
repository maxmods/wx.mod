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
bbdoc: wxMediaCtrl
End Rem
Module wx.wxMediaCtrl

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
bbdoc: wxMediaCtrl is a type for displaying types of media, such as videos, audio files, natively through native codecs.
about: wxMediaCtrl uses native backends to render media, for example on Windows there is a
ActiveMovie/DirectShow backend, and on Macintosh there is a QuickTime backend.
End Rem
Type wxMediaCtrl Extends wxControl

	Function CreateMediaCtrl:wxMediaCtrl(parent:wxWindow, id:Int, filename:String = "", x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = 0, backend:String = "")
			
		Local this:wxMediaCtrl = New wxMediaCtrl
		
		this.wxObjectPtr = bmx_wxmediactrl_create(this, parent.wxObjectPtr, id, filename, x, y, w, h, style, backend)
		
		Return this
	End Function
	
	Method GetBestSize(w:Int Var, h:Int Var)
		bmx_wxmediactrl_getbestsize(wxObjectPtr, Varptr w, Varptr h)
	End Method
	
	Method GetPlaybackrate:Double()
		Return bmx_wxmediactrl_getplaybackrate(wxObjectPtr)
	End Method
	
	Method GetVolume:Double()
		Return bmx_wxmediactrl_getvolume(wxObjectPtr)
	End Method
	
	Method GetState:Int()
		Return bmx_wxmediactrl_getstate(wxObjectPtr)
	End Method
	
	Method Length:Int()
		Return bmx_wxmediactrl_length(wxObjectPtr)
	End Method
	
	Method Load:Int(filename:String)
		Return bmx_wxmediactrl_load(wxObjectPtr, filename)
	End Method
	
	Method LoadURI:Int(uri:wxURI)
		Return bmx_wxmediactrl_loaduri(wxObjectPtr, uri.wxURIPtr)
	End Method
	
	Method LoadURIWithProxy:Int(uri:wxURI, proxy:wxURI)
		Return bmx_wxmediactrl_loaduriwithproxy(wxObjectPtr, uri.wxURIPtr, proxy.wxURIPtr)
	End Method
	
	Method Pause:Int()
		Return bmx_wxmediactrl_pause(wxObjectPtr)
	End Method
	
	Method Play:Int()
		Return bmx_wxmediactrl_play(wxObjectPtr)
	End Method
	
	Method Seek:Int(where:Int, mode:Int)
		Return bmx_wxmediactrl_seek(wxObjectPtr, where, mode)
	End Method
	
	Method SetPlaybackRate:Int(rate:Double)
		Return bmx_wxmediactrl_setplaybackrate(wxObjectPtr, rate)
	End Method
	
	Method SetVolume:Int(volumne:Double)
		Return bmx_wxmediactrl_setvolume(wxObjectPtr, volume)
	End Method
	
	Method ShowPlayerControls:Int(flags:Int)
		Return bmx_wxmediactrl_showplayercontrols(wxObjectPtr, flags)
	End Method
	
	Method Stop:Int()
		Return bmx_wxmediactrl_stop(wxObjectPtr)
	End Method
	
	Method Tell:Int()
		Return bmx_wxmediactrl_tell(wxObjectPtr)
	End Method

End Type

Rem
bbdoc: 
End Rem
Type wxMediaEvent Extends wxNotifyEvent

	Function create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
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
				
				Return wxMediaEvent.create(wxEventPtr, evt)
		End Select
		
		Return Null
	End Method
	
End Type

New TMediaEventFactory


