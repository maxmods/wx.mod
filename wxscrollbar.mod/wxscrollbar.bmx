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
bbdoc: wxScrollBar
End Rem
Module wx.wxScrollBar

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
bbdoc: A wxScrollBar is a control that represents a horizontal or vertical scrollbar.
about: It is distinct from the two scrollbars that some windows provide automatically, but the two types
of scrollbar share the way events are received.
<p>
A scrollbar has the following main attributes: range, thumb size, page size, and position.
</p>
<p>
The range is the total number of units associated with the view represented by the scrollbar. For a table
with 15 columns, the range would be 15.
</p>
<p>
The thumb size is the number of units that are currently visible. For the table example, the window might
be sized so that only 5 columns are currently visible, in which case the application would set the thumb
size to 5. When the thumb size becomes the same as or greater than the range, the scrollbar will be
automatically hidden on most platforms.
</p>
<p>
The page size is the number of units that the scrollbar should scroll by, when 'paging' through the data.
This value is normally the same as the thumb size length, because it is natural to assume that the visible
window size defines a page.
</p>
<p>
The scrollbar position is the current thumb position.
</p>
<p>
Most applications will find it convenient to provide a function called AdjustScrollbars which can be
called initially, from an OnSize event handler, and whenever the application data changes in size. It will
adjust the view, object and page size according to the size of the window and the size of the data.
</p>
End Rem
Type wxScrollBar Extends wxControl

	Rem
	bbdoc: Constructor, creating and showing a scrollbar.
	End Rem
	Function CreateScrollBar:wxScrollBar(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, ..
			style:Int = wxSB_HORIZONTAL)
		Return New wxScrollBar.Create(parent, id, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: Scrollbar creation function called by the scrollbar constructor.
	about: See CreateScrollBar for details.
	End Rem
	Method Create:wxScrollBar(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, ..
			style:Int = wxSB_HORIZONTAL)

		wxObjectPtr = bmx_wxscrollbar_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		Return Self			
	End Method

	Rem
	bbdoc: Returns the length of the scrollbar.
	End Rem
	Method GetRange:Int()
		Return bmx_wxscrollbar_getrange(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the page size of the scrollbar.
	about: This is the number of scroll units that will be scrolled when the user pages up or down.
	Often it is the same as the thumb size.
	End Rem
	Method GetPageSize:Int()
		Return bmx_wxscrollbar_getpagesize(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the current position of the scrollbar thumb.
	End Rem
	Method GetThumbPosition:Int()
		Return bmx_wxscrollbar_getthumbposition(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the thumb or 'view' size.
	End Rem
	Method GetThumbSize:Int()
		Return bmx_wxscrollbar_getthumbsize(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the position of the scrollbar.
	End Rem
	Method SetThumbPosition(viewStart:Int)
		bmx_wxscrollbar_setthumbposition(wxObjectPtr, viewStart)
	End Method
	
	Rem
	bbdoc: Sets the scrollbar properties.
	about: Let's say you wish to display 50 lines of text, using the same font. The window is sized so
	that you can only see 16 lines at a time.
	<p>
	You would use:
	<pre>
	scrollbar.SetScrollbar(0, 16, 50, 15)
	</pre>
	</p>
	<p>
	The page size is 1 less than the thumb size so that the last line of the previous page will be visible
	on the next page, to help orient the user.
	</p>
	<p>
	Note that with the window at this size, the thumb position can never go above 50 minus 16, or 34.
	</p>
	<p>
	You can determine how many lines are currently visible by dividing the current view size by the character
	height in pixels.
	</p>
	<p>
	When defining your own scrollbar behaviour, you will always need to recalculate the scrollbar settings when
	the window size changes. You could therefore put your scrollbar calculations and SetScrollbar call into a
	method named AdjustScrollbars, which can be called initially and also from a wxSizeEvent event handler
	function.
	</p>
	End Rem
	Method SetScrollbar(position:Int, thumbSize:Int, range:Int, pageSize:Int, refresh:Int = True)
		bmx_wxscrollbar_setscrollbar(wxObjectPtr, position, thumbSize, range, pageSize, refresh)
	End Method
	
End Type

