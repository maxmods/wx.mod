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

Import wx.wx
Import wx.wxURI
Import wx.wxControl
Import BRL.Blitz

?linux
Import "-lgstreamer-0.10"
Import "-lgstinterfaces-0.10"
?

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

Import "glue.cpp"

Extern

	Function bmx_wxmediactrl_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, filename:String, x:Int, y:Int, w:Int, h:Int, style:Int, backend:String)
	Function bmx_wxmediactrl_getbestsize(handle:Byte Ptr, w:Int Ptr, h:Int Ptr)
	Function bmx_wxmediactrl_getplaybackrate:Double(handle:Byte Ptr)
	Function bmx_wxmediactrl_getvolume:Double(handle:Byte Ptr)
	Function bmx_wxmediactrl_getstate:Int(handle:Byte Ptr)
	Function bmx_wxmediactrl_length(handle:Byte Ptr, value:Long Ptr)
	Function bmx_wxmediactrl_load:Int(handle:Byte Ptr, filename:String)
	Function bmx_wxmediactrl_loaduri:Int(handle:Byte Ptr, uri:String)
	Function bmx_wxmediactrl_loaduriwithproxy:Int(handle:Byte Ptr, uri:String, proxy:String)
	Function bmx_wxmediactrl_pause:Int(handle:Byte Ptr)
	Function bmx_wxmediactrl_play:Int(handle:Byte Ptr)
	Function bmx_wxmediactrl_seek(handle:Byte Ptr, where:Long, Mode:Int, value:Long Ptr)
	Function bmx_wxmediactrl_setplaybackrate:Int(handle:Byte Ptr, rate:Double)
	Function bmx_wxmediactrl_setvolume:Int(handle:Byte Ptr, volume:Double)
	Function bmx_wxmediactrl_showplayercontrols:Int(handle:Byte Ptr, flags:Int)
	Function bmx_wxmediactrl_stop:Int(handle:Byte Ptr)
	Function bmx_wxmediactrl_tell(handle:Byte Ptr, value:Long Ptr)

	Function bmx_wxmediactrl_geteventtype:Int(eventType:Int)
	
End Extern


Const wxEVT_MEDIA_FINISHED:Int = 13000
Const wxEVT_MEDIA_STOP:Int = 13001
Const wxEVT_MEDIA_LOADED:Int = 13002
Const wxEVT_MEDIA_STATECHANGED:Int = 13003
Const wxEVT_MEDIA_PLAY:Int = 13004
Const wxEVT_MEDIA_PAUSE:Int = 13005

Const wxMEDIABACKEND_DIRECTSHOW:String = "wxAMMediaBackend"
Const wxMEDIABACKEND_MCI:String = "wxMCIMediaBackend"
Const wxMEDIABACKEND_QUICKTIME:String = "wxQTMediaBackend"
Const wxMEDIABACKEND_GSTREAMER:String = "wxGStreamerMediaBackend"
Const wxMEDIABACKEND_REALPLAYER:String = "wxRealPlayerMediaBackend"
Const wxMEDIABACKEND_WMP10:String = "wxWMP10MediaBackend"

Const wxMEDIACTRLPLAYERCONTROLS_NONE:Int = 0
Const wxMEDIACTRLPLAYERCONTROLS_STEP:Int = 1 Shl 0
Const wxMEDIACTRLPLAYERCONTROLS_VOLUME:Int = 1 Shl 1
Const wxMEDIACTRLPLAYERCONTROLS_DEFAULT:Int = wxMEDIACTRLPLAYERCONTROLS_STEP | wxMEDIACTRLPLAYERCONTROLS_VOLUME

Rem
bbdoc: The movie has stopped.
End Rem
Const wxMEDIASTATE_STOPPED:Int = 0
Rem
bbdoc: The movie is paused.
End Rem
Const wxMEDIASTATE_PAUSED:Int = 1
Rem
bbdoc: The movie is currently playing.
End Rem
Const wxMEDIASTATE_PLAYING:Int = 2

