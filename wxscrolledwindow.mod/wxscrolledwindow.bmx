' Copyright (c) 2007-2011 Bruce A Henderson
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
bbdoc: wxScrolledWindow
End Rem
Module wx.wxScrolledWindow

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2011 Bruce A Henderson"


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
ModuleInfo "CC_OPTS: -D__WXOSX_CARBON__"
ModuleInfo "CC_OPTS: -D_FILE_OFFSET_BITS=64"
ModuleInfo "CC_OPTS: -D_LARGE_FILES"
ModuleInfo "CC_OPTS: -DWX_PRECOMP"
?

Import "common.bmx"


Rem
bbdoc: The wxScrolledWindow manages scrolling for its client area, transforming the coordinates according to the scrollbar positions, and setting the scroll positions, thumb sizes and ranges according to the area in view.
about: There are three ways to set the size of the scrolling area:
<p>
One way is to set the scrollbars directly using a call to wxScrolledWindow::SetScrollbars. This is the way it
used to be in any previous version of wxWidgets and it will be kept for backwards compatibility.
</p>
<p>
An additional method of manual control, which requires a little less computation of your own, is to set the total
size of the scrolling area by calling either wxWindow::SetVirtualSize, or wxWindow::FitInside, and setting the
scrolling increments for it by calling wxScrolledWindow::SetScrollRate. Scrolling in some orientation is enabled
by setting a non-zero increment for it.
</p>
<p>
The most automatic and newest way is to simply let sizers determine the scrolling area. This is now the default
when you set an interior sizer into a wxScrolledWindow with wxWindow::SetSizer. The scrolling area will be set
to the size requested by the sizer and the scrollbars will be assigned for each orientation according to the need
for them and the scrolling increment set by wxScrolledWindow::SetScrollRate. As above, scrolling is only enabled in
orientations with a non-zero increment. You can influence the minimum size of the scrolled area controlled by a
sizer by calling wxWindow::SetVirtualSizeHints. (calling wxScrolledWindow::SetScrollbars has analogous effects in
wxWidgets 2.4 -- in later versions it may not continue to override the sizer)
</p>
<p>
Note: if Maximum size hints are still supported by SetVirtualSizeHints, use them at your own dire risk. They may or
may not have been removed for 2.4, but it really only makes sense to set minimum size hints here. We should probably
replace SetVirtualSizeHints with SetMinVirtualSize or similar and remove it entirely in future.
</p>
<p>
As with all windows, an application can draw onto a wxScrolledWindow using a device context.
</p>
<p>
You have the option of handling the OnPaint handler or overriding the OnDraw function, which is passed a pre-scrolled
device context (prepared by DoPrepareDC).
</p>
<p>
If you don't wish to calculate your own scrolling, you must call DoPrepareDC when not drawing from within OnDraw, to
set the device origin for the device context according to the current scroll position.
</p>
<p>
A wxScrolledWindow will normally scroll itself and therefore its child windows as well. It might however be desired
to scroll a different window than itself: e.g. when designing a spreadsheet, you will normally only have to scroll
the (usually white) cell area, whereas the (usually grey) label area will scroll very differently. For this special
purpose, you can call SetTargetWindow which means that pressing the scrollbars will scroll a different window.
</p>
<p>
Note that the underlying system knows nothing about scrolling coordinates, so that all system functions (mouse events,
expose events, refresh calls etc) as well as the position of subwindows are relative to the "physical" origin of the
scrolled window. If the user insert a child window at position (10,10) and scrolls the window down 100 pixels
(moving the child window out of the visible area), the child window will report a position of (10,-90).
</p>
End Rem
Type wxScrolledWindow Extends wxPanel

	Function _create:wxScrolledWindow(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxScrolledWindow = New wxScrolledWindow
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Function _xrcNew:wxScrolledWindow(wxObjectPtr:Byte Ptr)
		Return wxScrolledWindow._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: Default constructor.
	End Rem
	Function CreateScrolledWindow:wxScrolledWindow(parent:wxWindow, id:Int = -1, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, ..
			style:Int = wxHSCROLL | wxVSCROLL)
		Return New wxScrolledWindow.Create(parent, id, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxScrolledWindow(parent:wxWindow, id:Int = -1, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, ..
			style:Int = wxHSCROLL | wxVSCROLL)
		wxObjectPtr = bmx_wxscrolledwindow_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method
	
	Rem
	bbdoc: Translates the logical coordinates to the device ones.
	about: For example, if a window is scrolled 10 pixels to the bottom, the device coordinates of
	the origin are (0, 0) (as always), but the logical coordinates are (0, 10) and so the call
	to CalcScrolledPosition(0, 10, xx, yy) will return 0 in yy.
	End Rem
	Method CalcScrolledPosition(x:Int, y:Int, xx:Int Var, yy:Int Var)
		bmx_wxscrolledwindow_calcscrolledposition(wxObjectPtr, x, y, Varptr xx, Varptr yy)
	End Method
	
	Rem
	bbdoc: Translates the device coordinates to the logical ones.
	about: For example, if a window is scrolled 10 pixels to the bottom, the device coordinates of the
	origin are (0, 0) (as always), but the logical coordinates are (0, 10) and so the call to
	CalcUnscrolledPosition(0, 0, xx, yy) will return 10 in yy.
	End Rem
	Method CalcUnScrolledPosition(x:Int, y:Int, xx:Int Var, yy:Int Var)
		bmx_wxscrolledwindow_calcunscrolledposition(wxObjectPtr, x, y, Varptr xx, Varptr yy)
	End Method
	
	Rem
	bbdoc: Enable or disable physical scrolling in the given direction.
	about: Physical scrolling is the physical transfer of bits up or down the screen when a scroll event
	occurs. If the application scrolls by a variable amount (e.g. if there are different font sizes)
	then physical scrolling will not work, and you should switch it off. Note that you will have to
	reposition child windows yourself, if physical scrolling is disabled.
	End Rem
	Method EnableScrolling(xScrolling:Int, yScrolling:Int)
		bmx_wxscrolledwindow_enablescrolling(wxObjectPtr, xScrolling, yScrolling)
	End Method
	
	Rem
	bbdoc: Get the number of pixels per scroll unit (line), in each direction, as set by wxScrolledWindow::SetScrollbars.
	about: A value of zero indicates no scrolling in that direction.
	End Rem
	Method GetScrollPixelsPerUnit(xUnit:Int Var, yUnit:Int Var)
		bmx_wxscrolledwindow_getscrollpixelsperunit(wxObjectPtr, Varptr xUnit, Varptr yUnit)
	End Method
	
	Rem
	bbdoc: Get the position at which the visible portion of the window starts.
	End Rem
	Method GetViewStart(x:Int Var, y:Int Var)
		bmx_wxscrolledwindow_getviewstart(wxObjectPtr, Varptr x, Varptr y)
	End Method
	
	Rem
	bbdoc: Gets the size in device units of the scrollable window area (as opposed to the client size, which is the area of the window currently visible).
	End Rem
	Method GetVirtualSize(x:Int Var, y:Int Var)
		bmx_wxscrolledwindow_getvirtualsize(wxObjectPtr, Varptr x, Varptr y)
	End Method
	
	Rem
	bbdoc: Call this method to prepare the device context for drawing a scrolled image.
	about: It sets the device origin according to the current scroll position.
	<p>
	DoPrepareDC is called automatically within the default wxScrolledWindow::OnPaint event handler, so your
	wxScrolledWindow::OnDraw override will be passed a 'pre-scrolled' device context. However, if you wish to
	draw from outside of OnDraw (via OnPaint), or you wish to implement OnPaint yourself, you must call this
	function yourself. For example:
	<pre>
	Function OnEvent(event:wxEvent)
	    Local dc:wxClientDC(wxWindow(event.parent))
	    DoPrepareDC(dc)
	
	    dc.SetPen(wxBLACK_PEN())
	
	    Local x:Int, y:Int
	    wxMouseEvent(event).GetPosition(x, y)
	
	    If xpos > -1 And ypos > -1 And wxMouseEvent(event).Dragging() Then
	        dc.DrawLine(xpos, ypos, x, y)
	    End If
	    xpos = x
	    ypos = y
	
	    dc.Free()
	End Function
	</pre>
	</p>
	End Rem
	Method DoPrepareDC(dc:wxDC)
		bmx_wxscrolledwindow_dopreparedc(wxObjectPtr, dc.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Scrolls a window so the view start is at the given point.
	End Rem
	Method Scroll(x:Int, y:Int)
		bmx_wxscrolledwindow_scroll(wxObjectPtr, x, y)
	End Method
	
	Rem
	bbdoc: Sets up vertical and/or horizontal scrollbars.
	End Rem
	Method SetScrollbars(pixelsPerUnitX:Int, pixelsPerUnitY:Int, noUnitsX:Int, noUnitsY:Int, xPos:Int = 0, ..
			yPos:Int = 0, noRefresh:Int = False)
		bmx_wxscrolledwindow_setscrollbars(wxObjectPtr, pixelsPerUnitX, pixelsPerUnitY, noUnitsX, noUnitsY, xPos, yPos, noRefresh)
	End Method
	
	Rem
	bbdoc: Set the horizontal and vertical scrolling increment only.
	about: See the pixelsPerUnit parameter in SetScrollbars.
	End Rem
	Method SetScrollRate(xStep:Int, yStep:Int)
		bmx_wxscrolledwindow_setscrollrate(wxObjectPtr, xStep, yStep)
	End Method
	
	Rem
	bbdoc: Call this method to tell wxScrolledWindow to perform the actual scrolling on a different window (and not on itself).
	End Rem
	Method SetTargetWindow(window:wxWindow)
		bmx_wxscrolledwindow_settargetwindow(wxObjectPtr, window.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Called by the default paint event handler to allow the application to define painting behaviour without having to worry about calling wxScrolledWindow::DoPrepareDC.
	about: Instead of overriding this method you may also just process the paint event in the derived type
	as usual, but then you will have to call DoPrepareDC() yourself.
	End Rem
	Method OnDraw(dc:wxDC)
		bmx_wxscrolledwindow_ondraw_default(wxObjectPtr, dc.wxObjectPtr)
	End Method
	
	Function _OnDraw(handle:Object, dc:Byte Ptr)
		If wxScrolledWindow(handle) Then
			wxScrolledWindow(handle).OnDraw(wxDC._create(dc))
		End If
	End Function
	
End Type

Type TScrolledWindowResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxscrolledwindow_addresourcehandler()
	End Method
		
End Type

New TScrolledWindowResourceFactory
