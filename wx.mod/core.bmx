' Copyright (c) 2007 Bruce A Henderson
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

Import "events.bmx"
Import "fonts.bmx"
'Import "common.bmx"



Type wxToolTip
End Type


Rem
bbdoc: 

Type wxArrayString

	Field wxArrayStringPtr:Byte Ptr
	
	Function Create:wxArrayString()
		Local this:wxArrayString = New wxArrayString
		
		this.wxArrayStringPtr = bmx_wxarraystring_create()
		
		Return this
	End Function
	
	'Rem
	'bbdoc: 
	'End Rem
	Method Add:Int(txt:String, copies:Int = 1)
		Return bmx_wxarraystring_add(wxArrayStringPtr, txt, copies)
	End Method

	'Rem
	'bbdoc: Preallocates enough memory To store nCount items.
	'about: This Function May be used To improve array class performance before adding a known number
	'of items consecutively.
	'End Rem
	Method Alloc(count:Int)
		bmx_wxarraystring_alloc(wxArrayStringPtr, count)
	End Method
	
	
	Method Delete()
		If wxArrayStringPtr Then
			bmx_wxarraystring_delete(wxArrayStringPtr)
			wxArrayStringPtr = Null
		End If
	End Method
	
End Type
End Rem

Rem
bbdoc: A colour is an object representing a combination of Red, Green, and Blue (RGB) intensity values, and is used to determine drawing colours.
about: See the entry for wxColourDatabase for how a pointer to a predefined, named colour may be returned
instead of creating a new colour.
<p>
Valid RGB values are in the range 0 to 255.
</p>
<p>
You can retrieve the current system colour settings with wxSystemSettings.
</p>
End Rem
Type wxColour Extends wxObject

	Rem
	bbdoc: 
	End Rem
	Function CreateColour:wxColour(r:Int, g:Int, b:Int, a:Int = wxALPHA_OPAQUE)
		Return New wxColour.Create(r, g, b, a)
	End Function
	
	Rem
	bbdoc: Constructs a colour from red, green, blue and alpha values.
	End Rem
	Method Create:wxColour(r:Int, g:Int, b:Int, a:Int = wxALPHA_OPAQUE)
		wxObjectPtr = bmx_wxcolour_create(r, g, b, a)
		Return Self
	End Method
	
	Rem
	bbdoc: Constructs a colour using the given string.
	End Rem
	Method CreateNamedColour:wxColour(name:String)
		wxObjectPtr = bmx_wxcolour_createnamedcolour(name)
		Return Self
	End Method

	Function _create:wxColour(wxObjectPtr:Byte Ptr)
		Local this:wxColour = New wxColour
		
		this.wxObjectPtr = wxObjectPtr
		
		Return this
	End Function
	
	Rem
	bbdoc: Returns the alpha value.
	End Rem
	Method Alpha:Int()
		Return bmx_wxcolour_alpha(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the blue intensity.
	End Rem
	Method Blue:Int()
		Return bmx_wxcolour_blue(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Converts this colour to a String using the given @flags.
	about: The supported flags are wxC2S_NAME, to obtain the colour name (e.g. wxColour(255,0,0) -&gt; "red"),
	wxC2S_CSS_SYNTAX, to obtain the colour in the "rgb(r,g,b)" syntax (e.g. wxColour(255,0,0) -&gt;
	"rgb(255,0,0)"), and wxC2S_HTML_SYNTAX, to obtain the colour as "#" followed by 6 hexadecimal
	digits (e.g. wxColour(255,0,0) -&gt; "#FF0000").
	<p>
	This method never fails and always returns a non-empty string.
	</p>
	End Rem
	Method GetAsString:String(flags:Int)
		Return bmx_wxcolour_getasstring(wxObjectPtr, flags)
	End Method
	
	Rem
	bbdoc: Returns the green intensity.
	End Rem
	Method Green:Int()
		Return bmx_wxcolour_green(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the colour object is valid (the colour has been initialised with RGB values).
	End Rem
	Method IsOk:Int()
		Return bmx_wxcolour_isok(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the red intensity.
	End Rem
	Method Red:Int()
		Return bmx_wxcolour_red(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the RGB intensity values using the given values.
	End Rem
	Method Set(red:Int, green:Int, blue:Int, alpha:Int = wxALPHA_OPAQUE)
		bmx_wxcolour_set(wxObjectPtr, red, green, blue, alpha)
	End Method
	
	Rem
	bbdoc: Sets the RGB intensity values using the given string.
	returns: True if the conversion was successful, False otherwise.
	about: Accepts - colour names (those listed in wxTheColourDatabase), the CSS-like "RGB(r,g,b)"
	syntax (case insensitive) and the HTML-like syntax (i.e. "#" followed by 6 hexadecimal digits for
	red, green, blue components).
	End Rem
	Method SetAsNamedColour:Int(name:String)
		Return bmx_wxcolour_setasnamedcolour(wxObjectPtr, name)
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxcolour_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

End Type

Rem
bbdoc: 
End Rem
Type wxPen Extends wxGDIObject

	Function _create:wxPen(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxPen = New wxPen
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Constructs a pen from a colour name, pen width and style.
	End Rem
	Method Create:wxPen(name:String, width:Int = 1, style:Int = wxSOLID)
		wxObjectPtr = bmx_wxpen_create(name, width, style)
		Return Self
	End Method

	Rem
	bbdoc: Constructs a pen from a colour object, pen width and style.
	End Rem
	Method CreateFromColour:wxPen(colour:wxColour, width:Int = 1, style:Int = wxSOLID)
		wxObjectPtr = bmx_wxpen_createfromcolour(colour.wxObjectPtr, width, style)
		Return Self
	End Method

	Method Delete()
		If wxObjectPtr Then
			bmx_wxpen_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type



Rem
bbdoc: This type is the base type of most stream related types in wxWidgets.
about: It must not be used directly.
End Rem
Type wxStreamBase

	Field wxStreamPtr:Byte Ptr
	
	Function _create:wxStreamBase(wxStreamPtr:Byte Ptr)
		If wxStreamPtr Then
			Local this:wxStreamBase = New wxStreamBase
			this.wxStreamPtr = wxStreamPtr
			Return this
		End If
	End Function
	
	Rem
	bbdoc: Returns the length of the stream in bytes.
	about: If the length cannot be determined (this is always the case for socket streams for
	example), returns wxInvalidOffset.
	End Rem
	Method GetLength:Long()
		Local value:Long
		bmx_wxstreambase_getlength(wxStreamPtr, Varptr value)
		Return value
	End Method
	
	Rem
	bbdoc: This method returns the last error.
	End Rem
	Method GetLastError:Int()
		Return bmx_wxstreambase_getlasterror(wxStreamPtr)
	End Method
	
	Rem
	bbdoc: This method returns the size of the stream.
	about: For example, for a file it is the size of the file.
	<p>
	<b>Warning</b> - There are streams which do not have size by definition, such as socket streams.
	In that cases, GetSize returns 0 so you should always test its return value.
	</p>
	End Rem
	Method GetSize:Int()
		Return bmx_wxstreambase_getsize(wxStreamPtr)
	End Method
	
	Rem
	bbdoc: Returns True if no error occurred on the stream.
	End Rem
	Method IsOk:Int()
		Return bmx_wxstreambase_isok(wxStreamPtr)
	End Method
	
	Rem
	bbdoc: Returns True if the streams supports seeking to arbitrary offsets.
	End Rem
	Method IsSeekable:Int()
		Return bmx_wxstreambase_isseekable(wxStreamPtr)
	End Method
	
End Type

Type wxInputStream Extends wxStreamBase

	

End Type



' wraps an input stream...
Type TInputStreamHandler

	 

End Type

Type wxAcceleratorTable

End Type

Rem
bbdoc: An object used by an application wishing to create an accelerator table.
End Rem
Type wxAcceleratorEntry

	Field wxAcceleratorPtr:Byte Ptr

	Function _create:wxAcceleratorEntry(wxAcceleratorPtr:Byte Ptr)
		If wxAcceleratorPtr Then
			Local this:wxAcceleratorEntry = New wxAcceleratorEntry
			this.wxAcceleratorPtr = wxAcceleratorPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Returns the command identifier for the accelerator table entry.
	End Rem
	Method GetCommand:Int()
		Return bmx_wxacceleratorentry_getcommand(wxAcceleratorPtr)
	End Method
	
	Rem
	bbdoc: Returns the flags for the accelerator table entry.
	End Rem
	Method GetFlags:Int()
		Return bmx_wxacceleratorentry_getflags(wxAcceleratorPtr)
	End Method
	
	Rem
	bbdoc: Returns the keycode for the accelerator table entry.
	End Rem
	Method GetKeyCode:Int()
		Return bmx_wxacceleratorentry_getkeycode(wxAcceleratorPtr)
	End Method
	
	Rem
	bbdoc: Sets the accelerator entry parameters.
	End Rem
	Method Set(flags:Int, keyCode:Int, cmd:Int)
		bmx_wxacceleratorentry_set(wxAcceleratorPtr, flags, keyCode, cmd)
	End Method

	Method Delete()
		If wxAcceleratorPtr Then
			bmx_wxacceleratorentry_delete(wxAcceleratorPtr)
			wxAcceleratorPtr = Null
		End If
	End Method
	
End Type


Type wxRegion

End Type


Rem
bbdoc: An erase event is sent when a window's background needs to be repainted.
about: On some platforms, such as GTK+, this event is simulated (simply generated just before the paint event)
and may cause flicker. It is therefore recommended that you set the text background colour explicitly in order
to prevent flicker. The default background colour under GTK+ is grey.
<p>
You must call wxEraseEvent::GetDC and use the returned device context if it is non-NULL. If it is NULL,
create your own temporary wxClientDC object. 
</p>
End Rem
Type wxEraseEvent Extends wxEvent

	Function create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxEraseEvent = New wxEraseEvent
		
		this.wxEventPtr = wxEventPtr
		this.userData = evt.userData
		this.parent = evt.parent
		
		Return this
	End Function
	

	Rem
	bbdoc: Returns the device context associated with the erase event to draw on.
	End Rem
'	Method GetDC:_wxDC()
'	End Method
	
End Type

Rem
bbdoc: Returns the string containing the description of the current platform in a user-readable form.
about: For example, this function may return strings like Windows NT Version 4.0 or Linux 2.2.2 i386.
End Rem
Function wxGetOsDescription:String()
	Return bmx_wxgetosdescription()
End Function

Rem
bbdoc: 
End Rem
Function wxIsalnum:Int(keycode:Int)
	Return bmx_wxisalnum(keycode)
End Function

Type TCoreEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		' TODO: determine the correct event, and return that type....
		Select evt.eventType
			Case wxEVT_COMMAND_MENU_SELECTED, ..
					wxEVT_COMMAND_SCROLLBAR_UPDATED, ..
					wxEVT_COMMAND_SLIDER_UPDATED, ..
					wxEVT_COMMAND_ENTER
				Return wxCommandEvent.create(wxEventPtr, evt)
'			Case wxEVT_CLOSE_WINDOW, ..
'					wxEVT_END_SESSION, ..
'					wxEVT_QUERY_END_SESSION
'				Return wxCloseEvent.create(wxEventPtr, evt)
			Case wxEVT_MOVE
				Return wxMoveEvent.create(wxEventPtr, evt)
'			Case wxEVT_UPDATE_UI
'				Return wxUpdateUIEvent.create(wxEventPtr, evt)
			Case wxEVT_PAINT
				Return wxPaintEvent.create(wxEventPtr, evt)
			Case wxEVT_SIZE
				Return wxSizeEvent.create(wxEventPtr, evt)
			Case wxEVT_SCROLLWIN_TOP, ..
					wxEVT_SCROLLWIN_BOTTOM, ..
					wxEVT_SCROLLWIN_LINEUP, ..
					wxEVT_SCROLLWIN_LINEDOWN, ..
					wxEVT_SCROLLWIN_PAGEUP, ..
					wxEVT_SCROLLWIN_PAGEDOWN, ..
					wxEVT_SCROLLWIN_THUMBTRACK, ..
					wxEVT_SCROLLWIN_THUMBRELEASE
				Return wxScrollWinEvent.create(wxEventPtr, evt)
			Case wxEVT_IDLE
				Return wxIdleEvent.create(wxEventPtr, evt)
			Case wxEVT_SCROLL_TOP, ..
					wxEVT_SCROLL_BOTTOM, ..
					wxEVT_SCROLL_LINEUP, ..
					wxEVT_SCROLL_LINEDOWN, ..
					wxEVT_SCROLL_PAGEUP, ..
					wxEVT_SCROLL_PAGEDOWN, ..
					wxEVT_SCROLL_THUMBTRACK, ..
					wxEVT_SCROLL_THUMBRELEASE, ..
					wxEVT_SCROLL_CHANGED
				Return wxScrollEvent.create(wxEventPtr, evt)
			Case wxEVT_CONTEXT_MENU
				Return wxContextMenuEvent.create(wxEventPtr, evt)
			Case wxEVT_CHAR, ..
					wxEVT_KEY_DOWN, ..
					wxEVT_KEY_UP
				Return wxKeyEvent.create(wxEventPtr, evt)
		End Select
		
		Return Null
	End Method
	
	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_COMMAND_MENU_SELECTED, ..
					wxEVT_COMMAND_SCROLLBAR_UPDATED, ..
					wxEVT_COMMAND_SLIDER_UPDATED, ..
					wxEVT_COMMAND_ENTER, ..
					wxEVT_MOVE, ..
					wxEVT_PAINT, ..
					wxEVT_SIZE, ..
					wxEVT_SCROLLWIN_TOP, ..
					wxEVT_SCROLLWIN_BOTTOM, ..
					wxEVT_SCROLLWIN_LINEUP, ..
					wxEVT_SCROLLWIN_LINEDOWN, ..
					wxEVT_SCROLLWIN_PAGEUP, ..
					wxEVT_SCROLLWIN_PAGEDOWN, ..
					wxEVT_SCROLLWIN_THUMBTRACK, ..
					wxEVT_SCROLLWIN_THUMBRELEASE, ..
					wxEVT_IDLE, ..
					wxEVT_SCROLL_TOP, ..
					wxEVT_SCROLL_BOTTOM, ..
					wxEVT_SCROLL_LINEUP, ..
					wxEVT_SCROLL_LINEDOWN, ..
					wxEVT_SCROLL_PAGEUP, ..
					wxEVT_SCROLL_PAGEDOWN, ..
					wxEVT_SCROLL_THUMBTRACK, ..
					wxEVT_SCROLL_THUMBRELEASE, ..
					wxEVT_SCROLL_CHANGED, ..
					wxEVT_CONTEXT_MENU, ..
					wxEVT_CHAR, ..
					wxEVT_KEY_DOWN, ..
					wxEVT_KEY_UP
				Return bmx_eventtype_value(eventType)
		End Select
	End Method
	
End Type

New TCoreEventFactory
