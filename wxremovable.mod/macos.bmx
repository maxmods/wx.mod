' Copyright (c) 2007-2015 Bruce A Henderson & Nigel Brown
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


Import "common.bmx"

' enable the monitoring...
StartListener()

Rem
bbdoc: 
End Rem
Type wxRemovable

	Global eventHandler:wxEvtHandler
	
	Rem
	bbdoc: 
	End Rem
	Function SetEventHandler(evtHandler:wxEvtHandler)
		eventHandler = evtHandler
	End Function

End Type


Function _volumeDidMount(devicePath:String)

	If wxRemovable.eventHandler Then
		Local event:wxCommandEvent = New wxCommandEvent.NewEvent( wxEVT_VOLUME_INSERTED )
		event.SetEventObject( wxRemovable.eventHandler )
		event.SetString(devicePath)
		wxRemovable.eventHandler.AddPendingEvent( event )
	End If

End Function


Function _volumeDidUnmount(devicePath:String)

	If wxRemovable.eventHandler Then
		Local event:wxCommandEvent = New wxCommandEvent.NewEvent( wxEVT_VOLUME_REMOVED )
		event.SetEventObject( wxRemovable.eventHandler )
		event.SetString(devicePath)
		wxRemovable.eventHandler.AddPendingEvent( event )
	End If
	
End Function

Type TRemovableEventFactory Extends TCustomEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Select evt.eventType
			Case wxEVT_VOLUME_REMOVED, ..
					wxEVT_VOLUME_INSERTED
				Return wxCommandEvent.Create(wxEventPtr, evt)
		End Select
		Return Null
	End Method
	
End Type

New TRemovableEventFactory

