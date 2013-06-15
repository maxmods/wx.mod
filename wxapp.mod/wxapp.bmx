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
bbdoc: wxApp
End Rem
Module wx.wxApp

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
bbdoc: The wxApp type represents the application itself.
about: It is used to:
<ul>
<li>set and get application-wide properties</li>
<li>implement the windowing system message or event loop</li>
<li>initiate application processing via wxApp::OnInit</li>
<li>allow default processing of events not handled by other objects in the application.</li>
</ul>
End Rem
Type wxApp Extends wxEvtHandler Abstract

	Global app:wxApp
	
	Method New()
		If Not app Then
			app = Self
		End If
	End Method

	Rem
	bbdoc: This must be provided by the application, and will usually create the application's main window, optionally calling wxApp::SetTopWindow.
	about: You may use OnExit to clean up anything initialized here, provided that the method returns true.
	<p>
	Notice that if you want to to use the command line processing provided by wxWidgets you have to call the
	base type version in the derived type OnInit().
	</p>
	<p>
	Return true to continue processing, false to exit the application immediately.
	</p>
	End Rem
	Method OnInit:Int() Abstract

	Function _OnInit:Int()
		app.wxObjectPtr = bmx_app_getapp()
		Return app.OnInit()
	End Function

	Rem
	bbdoc: Override this method for any processing which needs to be done as the application is about to exit.
	about: OnExit is called after destroying all application windows and controls, but before wxWidgets cleanup.
	Note that it is not called at all if OnInit failed.
	<p>
	The return value of this method is currently ignored, return the same value as returned by the base class
	method if you override it.
	</p>
	End Rem
	Method OnExit:Int()
	End Method
	
	Function _OnExit:Int()
		Return app.OnExit()
	End Function

	Rem
	bbdoc: TODO
	End Rem
	Method Run:Int()
		Return bmx_app_wxentry()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method EntryStart:Int()
		Return bmx_app_wxentrystart()
	End Method
	
	Rem
	bbdoc: Sets the 'top' window.
	about: You can call this from within wxApp::OnInit to let wxWidgets know which is the main window.
	You don't have to set the top window; it is only a convenience so that (for example) certain dialogs without
	parents can use a specific window as the top window. If no top window is specified by the application,
	wxWidgets just uses the first frame or dialog in its top-level window list, when it needs to use the top window.
	End Rem
	Method SetTopWindow(window:wxWindow)
		bmx_wxapp_settopwindow(window.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the top window
	about: If the top window hasn't been set using wxApp::SetTopWindow, this method will
	find the first top-level window (frame or dialog) and return that.
	End Rem
	Method GetTopWindow:wxWindow()
		Return wxWindow._find(bmx_wxapp_gettopwindow())
	End Method
	
	Rem
	bbdoc: Sets the name of the application.
	about: The name may be used in dialogs (for example by the document/view framework). A default name is set by
	wxWidgets.
	End Rem
	Method SetAppName(name:String)
		bmx_wxapp_setappname(name)
	End Method
	
	Rem
	bbdoc: Returns the application name.
	about: wxWidgets sets this to a reasonable default before calling wxApp::OnInit, but the application can reset it at will.
	End Rem
	Method getAppName:String()
		Return bmx_wxapp_getappname()
	End Method
	
	Rem
	bbdoc: Returns the application's vendor name.
	End Rem
	Method SetVendorName(name:String)
		bmx_wxapp_setvendorname(name)
	End Method
	
	Rem
	bbdoc: Returns the application's vendor name.
	End Rem
	Method GetVendorName:String()
		Return bmx_wxapp_getvendorname()
	End Method
	
	Rem
	bbdoc: Allows the programmer to specify whether the application will exit when the top-level frame is deleted.
	End Rem
	Method SetExitOnFrameDelete(flag:Int)
		bmx_wxapp_setexitonframedelete(flag)
	End Method
	
	Rem
	bbdoc: Returns true if the application is active, i.e. if one of its windows is currently in the foreground.
	about: If this method returns false and you need to attract users attention to the application,
	you may use wxTopLevelWindow::RequestUserAttention to do it.
	End Rem
	Method IsActive:Int()
		Return bmx_wxapp_isactive()
	End Method
	
	Rem
	bbdoc: Yields control to pending messages in the windowing system.
	about: This can be useful, for example, when a time-consuming process writes to a text window.
	Without an occasional yield, the text window will not be updated properly, and on systems with
	cooperative multitasking, such as Windows 3.1 other processes will not respond.
	<p>
	Caution should be exercised, however, since yielding may allow the user to perform actions which
	are not compatible with the current task. Disabling menu items or whole menus during processing
	can avoid unwanted reentrance of code: see ::wxSafeYield for a better function.
	</p>
	<p>
	Note that Yield() will not flush the message logs. This is intentional as calling Yield() is
	usually done to quickly update the screen and popping up a message box dialog may be undesirable.
	If you do wish to flush the log messages immediately (otherwise it will be done during the next
	idle loop iteration), call wxLog::FlushActive.
	</p>
	<p>
	Calling Yield() recursively is normally an error and an assert failure is raised in debug build
	if such situation is detected. However if the onlyIfNeeded parameter is true, the method will just
	silently return false instead.
	</p>
	End Rem
	Method Yield:Int(onlyIfNeeded:Int = False)
		Return bmx_wxapp_yield(onlyIfNeeded)
	End Method
	
End Type

Rem
bbdoc: Returns a reference to the application object
End Rem
Function wxGetApp:wxApp()
	Return wxApp.app
End Function

Rem
bbdoc: 
End Rem
Function wxPollEvents()
	bmx_wxapp_pollevents()
End Function

Rem
bbdoc: 
End Rem
Type wxAppMain Extends wxApp Abstract

	Method Run:Int()
		bmx_wxapp_setownmain()
		Return Super.Run()
	End Method

	Rem
	bbdoc: 
	End Rem
	Method Dispatch:Int()
		Return bmx_wxapp_dispatch()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method MainLoop:Int() Abstract

	Function _MainLoop:Int()
		Return wxAppMain(app).MainLoop()
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Pending:Int()
		Return bmx_wxapp_pending()
	End Method
	
	Method ProcessIdle:Int()
		Return bmx_wxapp_processidle()
	End Method
Rem
	Method FilterEvent:Int(event:wxEvent)
		Return -1
	End Method

	Function _FilterEvent:Int(event:Byte Ptr)
DebugLog "...filterevent"
		Local evt:TEventHandler = New TEventHandler
		
		Local eType:EvtIntWrap = EvtIntWrap.Set(bmx_wxevent_geteventtype(event))
		Local _eventId:EvtIntWrap = EvtIntWrap(maxToWxMap.ValueForKey(eType))
		If _eventId Then
			evt.eventType = _eventId.otherId
DebugLog "eventType = " + evt.eventType
		End If
		
		evt.callback = __evtcallback
		TEventHandler.eventCallback(event, evt)
		Return -1
	End Function
	
	Function __evtcallback(event:wxEvent)
DebugLog "evtcallback"
		event._eventFilter = wxAppMain(wxGetApp()).FilterEvent(event)
	End Function
End Rem

End Type

Rem
bbdoc: This function disables the user input to all program windows before calling wxYield and re-enables it again afterwards.
about: If @win is not NULL, this window will remain enabled, allowing the implementation of some limited user
interaction.
End Rem
Function wxSafeYield:Int(win:wxWindow = Null, onlyIfNeeded:Int = False)
	If win Then
		Return bmx_wxsafeyield(win.wxObjectPtr, onlyIfNeeded)
	Else
		Return bmx_wxsafeyield(Null, onlyIfNeeded)
	End If
End Function

Rem
bbdoc: This function wakes up the (internal and platform dependent) idle system.
about: It will force the system to send an idle event even if the system currently is idle and thus would not send
any idle event until after some other event would get sent. This is also useful for sending events between two
threads and is used by the corresponding functions ::wxPostEvent and wxEvtHandler::AddPendingEvent.
End Rem
Function wxWakeUpIdle()
	bmx_wxwakeupidle()
End Function


Type TAppEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		If evt.eventType = wxEVT_ACTIVATE_APP Then
			Return wxActivateEvent.Create(wxEventPtr, evt)
		End If
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		If eventType = wxEVT_ACTIVATE_APP Then
			Return bmx_eventtype_value(eventType)
		End If
	End Method

End Type

New TAppEventFactory

