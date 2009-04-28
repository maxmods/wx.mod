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
bbdoc: wxTimer
End Rem
Module wx.wxTimer

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
bbdoc: The wxTimer type allows you to execute code at specified intervals.
about: Its precision is platform-dependent, but in general will not be better than 1ms nor worse than 1s.
<p>
If you want to completely remove a wxTimer instance, call Free().
</p>
End Rem
Type wxTimer Extends wxEvtHandler

	Rem
	bbdoc: Constructor.
	about: If you use it to construct the object with no owner, and don't call SetOwner later, you must
	override Notify method to process the notifications.
	End Rem
	Function CreateTimer:wxTimer(owner:wxEvtHandler = Null, id:Int = -1)
		Return New wxTimer.Create(owner, id)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxTimer(owner:wxEvtHandler = Null, id:Int = -1)
		If owner Then
			wxObjectPtr = bmx_wxtimer_create(Self, owner.wxObjectPtr, id)
		Else
			wxObjectPtr = bmx_wxtimer_create(Self, Null, id)
		End If
		
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the current interval for the timer (in milliseconds).
	End Rem
	Method GetInterval:Int()
		Return bmx_wxtimer_getinterval(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the timer is one shot, i.e. if it will stop after firing the first notification automatically.
	End Rem
	Method IsOneShot:Int()
		Return bmx_wxtimer_isoneshot(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the timer is running, false if it is stopped.
	End Rem
	Method IsRunning:Int()
		Return bmx_wxtimer_isrunning(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Associates the timer with the given owner object.
	about: When the timer is running, the owner will receive timer events with id equal to id
	specified here.
	End Rem
	Method SetOwner(owner:wxEvtHandler, id:Int = -1)
		bmx_wxtimer_setowner(wxObjectPtr, owner.wxObjectPtr, id)
	End Method
	
	Rem
	bbdoc: (Re)starts the timer.
	about: If milliseconds parameter is -1 (value by default), the previous value is used. Returns
	false if the timer could not be started, true otherwise (in MS Windows timers are a limited resource).
	<p>
	If oneShot is False (the default), the Notify function will be called repeatedly until the timer 
	is stopped. If true, it will be called only once and the timer will stop automatically. To make your
	code more readable you may also use the following symbolic constants:
	<table align="center" width="90%">
	<tr><th>Constant</th><th>Description</th></tr>
	<tr><td>wxTIMER_CONTINUOUS</td><td>Start a normal, continuously running, timer </td></tr>
	<tr><td>wxTIMER_ONE_SHOT</td><td>Start a one shot timer</td></tr>
	</table>
	If the timer was already running, it will be stopped by this method before restarting it.
	</p>
	End Rem
	Method Start:Int(milliseconds:Int = -1, oneShot:Int = False)
		Return bmx_wxtimer_start(wxObjectPtr, milliseconds, oneShot)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Stop()
		bmx_wxtimer_stop(wxObjectPtr)
	End Method	
	
	Rem
	bbdoc: This method should be overridden by the user if the timer was created with no owner and SetOwner wasn't called.
	about: Perform whatever action which is to be taken periodically here.
	End Rem
	Method Notify()
	End Method

	Function _notify(obj:Object)
		wxTimer(obj).Notify()
	End Function
	
	Rem
	bbdoc: Frees a wxTimer and its resources.
	End Rem
	Method Free()
		Super.Free()
		If wxObjectPtr Then
			bmx_wxtimer_free(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

End Type

Rem
bbdoc: wxTimerEvent object is passed to the event handler of timer events.
End Rem
Type wxTimerEvent Extends wxEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxTimerEvent = New wxTimerEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function

	Rem
	bbdoc: Returns the interval of the timer which generated this event.
	End Rem
	Method GetInterval:Int()
		Return bmx_wxtimerevent_getinterval(wxEventPtr)
	End Method
	
End Type


Type TTimerEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		If evt.eventType = wxEVT_TIMER Then
			Return wxTimerEvent.Create(wxEventPtr, evt)
		End If
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		If eventType = wxEVT_TIMER Then
			Return bmx_wxtimer_geteventtype(eventType)
		End If
	End Method
		
End Type

New TTimerEventFactory


