' Copyright (c) 2007-2013 Bruce A Henderson & Nigel Brown
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
bbdoc: wxRemovable
End Rem
Module wx.wxRemovable

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

' enable the monitoring...
?MacOS
	StartListener()
?

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

		?Win32
			If wxWindow(evtHandler) Then
				OldWindowFunc = _SetWindowFunc( Int(wxWindow(evtHandler).GetHandle()), _wxWindowFunc )
			Else
				OldWindowFunc = _SetWindowFunc( Int(wxGetApp().GetTopWindow().GetHandle()), _wxWindowFunc )
			End If
		?
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

?Win32
'
'
'---------------------------------------------------------------------
Function __DriveFromMask:String( unitmask:Int)
'---------------------------------------------------------------------
	Local i:Int
	For i = 0 Until 26
		If unitmask & $1 Then Exit
		unitmask :Shr 1
	Next
	Return Chr(Asc("A") + i)

End Function

'
'---------------------------------------------------------------------
Function _wxWindowFunc:Int( hwnd:Int, msg:Int, wparam:Int, lparam:Int ) "Win32"
'---------------------------------------------------------------------

	Local hdr:Int Ptr = Int Ptr(lparam)

	Select msg

		Case WM_DEVICECHANGE
		
			Select wparam
			
				Case DBT_DEVICEARRIVAL
				
					If hdr[1] = DBT_DEVTYP_VOLUME Then

						_volumeDidMount(__DriveFromMask( hdr[3]))
					
					EndIf
				
				Case DBT_DEVICEREMOVECOMPLETE
				
					If hdr[1] = DBT_DEVTYP_VOLUME Then
					
						_volumeDidUnmount(__DriveFromMask( hdr[3]))
						
					EndIf
			End Select
	
		' this MUST be handled, otherwise MaxGUI freezes on window close.
		Case WM_DESTROY
			SetWindowLong( hwnd, GWL_WNDPROC, OldWindowFunc)
	EndSelect

	Return CallWindowProc( OldWindowFunc, hwnd, msg, wparam, Int(lparam))

End Function

?


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
