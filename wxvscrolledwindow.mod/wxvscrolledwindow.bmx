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
bbdoc: wxVScrolledWindow
End Rem
Module wx.wxVScrolledWindow

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
bbdoc: In the name of this type, "V" may stand for "variable" because it can be used for scrolling lines of variable heights; "virtual" because it is not necessary to know the heights of all lines in advance -- only those which are shown on the screen need to be measured; or, even, "vertical" because this class only supports scrolling in one direction currently (this could and probably will change in the future however).
about: In any case, this is a generalization of the wxScrolledWindow class which can be only used when
all lines have the same height. It lacks some other wxScrolledWindow features however, notably there is
currently no support for horizontal scrolling; it can't scroll another window nor only a rectangle of
the window and not its entire client area.
<p>
To use this type, you need to derive from it and implement OnGetLineHeight() pure virtual method. You
also must call SetLineCount to let the base class know how many lines it should display but from that
moment on the scrolling is handled entirely by wxVScrolledWindow, you only need to draw the visible part
of contents in your OnPaint() method as usual. You should use GetFirstVisibleLine() and GetLastVisibleLine()
to select the lines to display. Note that the device context origin is not shifted so the first visible
line always appears at the point (0, 0) in physical as well as logical coordinates.
</p>
End Rem
Type wxVScrolledWindow Extends wxPanel

	Rem
	bbdoc: Constructor.
	End Rem
	Function CreatePanel:wxVScrolledWindow(parent:wxWindow, id:Int = -1, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, ..
			style:Int = wxTAB_TRAVERSAL)
		Return New wxVScrolledWindow.Create(parent, id, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxVScrolledWindow(parent:wxWindow, id:Int = -1, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, ..
			style:Int = wxTAB_TRAVERSAL)

		wxObjectPtr = bmx_wxvscrolledwindow_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		
		OnInit()
		
		Return Self			
	End Method
	
	Rem
	bbdoc: Called during window creation.
	about: Override this method to provide your own initialization, like adding controls etc.
	End Rem
	Method OnInit()
	End Method

	Rem
	bbdoc: Returns the index of the first currently visible line.
	about: This is same as GetVisibleBegin and exists only for symmetry with GetLastVisibleLine.
	End Rem
	Method GetVisibleRowsBegin:Int()
		Return bmx_wxvscrolledwindow_getvisiblerowsbegin(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the index of the last currently visible line.
	End Rem
	Method GetVisibleRowsEnd:Int()
		Return bmx_wxvscrolledwindow_getvisiblerowsend(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Get the number of lines this window contains (previously set by SetLineCount())
	End Rem
	Method GetRowCount:Int()
		Return bmx_wxvscrolledwindow_getrowcount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the index of the first currently visible line.
	End Rem
	Method GetVisibleBegin:Int()
		Return bmx_wxvscrolledwindow_getvisiblebegin(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the index of the first line after the currently visible one.
	about: If the return value is 0 it means that no lines are currently shown (which only happens if the control
	is empty). Note that the index returned by this method is not always a valid index as it may be equal to
	GetLineCount.
	End Rem
	Method GetVisibleEnd:Int()
		Return bmx_wxvscrolledwindow_getvisibleend(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Return the item at the specified (in physical coordinates) position or wxNOT_FOUND if none, i.e. if it is below the last item.
	End Rem
	Method HitTest:Int(x:Int, y:Int)
		Return bmx_wxvscrolledwindow_hittest(wxObjectPtr, x, y)
	End Method
	
	Rem
	bbdoc: Returns True if the given line is (at least partially) visible or False otherwise.
	End Rem
	Method IsVisible:Int(line:Int)
		Return bmx_wxvscrolledwindow_isvisible(wxObjectPtr, line)
	End Method
	
	Rem
	bbdoc: This method must be overridden in the derived type and it should return the height of the given line in pixels.
	End Rem
	Method OnGetRowHeight:Int(n:Int)
		Assert Null, "OnGetRowHeight() should be overriden!"
	End Method
	
	Rem
	bbdoc: This method doesn't have to be overridden but it may be useful to do it if calculating the lines heights is a relatively expensive operation as it gives the user code a possibility to calculate several of them at once.
	about: OnGetLinesHint() is normally called just before OnGetLineHeight() but you shouldn't rely on the latter
	being called for all lines in the interval specified here. It is also possible that OnGetLineHeight() will be
	called for the lines outside of this interval, so this is really just a hint, not a promise.
	<p>
	Finally note that lineMin is inclusive, while lineMax is exclusive, as usual.
	</p>
	End Rem
	Method OnGetRowsHeightHint(lineMin:Int, lineMax:Int)
	End Method
	
	Rem
	bbdoc: Refreshes the specified line -- it will be redrawn during the next main loop iteration.
	End Rem
	Method RefreshRow(line:Int)
		bmx_wxvscrolledwindow_refreshrow(wxObjectPtr, line)
	End Method
	
	Rem
	bbdoc: Refreshes all lines between @fromLine and @toLine, inclusive.
	about: @fromLine should be less than or equal to @toLine.
	End Rem
	Method RefreshRows(fromLine:Int, toLine:Int)
		bmx_wxvscrolledwindow_refreshrows(wxObjectPtr, fromLine, toLine)
	End Method
	
	Rem
	bbdoc: This method completely refreshes the control, recalculating the number of items shown on screen and repainting them.
	about: It should be called when the values returned by OnGetLineHeight change for some reason and the window
	must be updated to reflect this.
	End Rem
	Method RefreshAll()
		bmx_wxvscrolledwindow_refreshall(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Scroll by the specified number of lines which may be positive (to scroll down) or negative (to scroll up).
	about: Returns true if the window was scrolled, false otherwise (for example if we're trying to scroll down
	but we are already showing the last line).
	End Rem
	Method ScrollRows:Int(lines:Int)
		Return bmx_wxvscrolledwindow_scrollrows(wxObjectPtr, lines)
	End Method
	
	Rem
	bbdoc: Scroll by the specified number of pages which may be positive (to scroll down) or negative (to scroll up).
	End Rem
	Method ScrollRowPages:Int(pages:Int)
		Return bmx_wxvscrolledwindow_scrollrowpages(wxObjectPtr, pages)
	End Method
	
	Rem
	bbdoc: Scroll to the specified line: it will become the first visible line in the window.
	about: Returns true if we scrolled the window, false if nothing was done.
	End Rem
	Method ScrollToRow:Int(line:Int)
		Return bmx_wxvscrolledwindow_scrolltorow(wxObjectPtr, line)
	End Method
	
	Rem
	bbdoc: Set the number of lines the window contains.
	about: The derived type must provide the heights for all lines with indices up to the one given here
	in its OnGetLineHeight().
	End Rem
	Method SetRowCount(count:Int)
		bmx_wxvscrolledwindow_setrowcount(wxObjectPtr, count)
	End Method
	
	' callback handler
	Function _OnGetRowHeight:Int(win:Byte Ptr, n:Int)
		Local scrolled:wxVScrolledWindow = wxVScrolledWindow(wxfind(win))
		If Not scrolled Then
			Assert Null, "Error! Could not find derived wxVScrolledWindow object!"
			Return 10
		Else
			Return scrolled.OnGetRowHeight(n)
		End If
	End Function
	
	' callback handler
	Function _OnGetRowsHeightHint(win:Byte Ptr, lineMin:Int, lineMax:Int)
		Local scrolled:wxVScrolledWindow = wxVScrolledWindow(wxfind(win))
		If Not scrolled Then
			Assert Null, "Error! Could not find derived wxVScrolledWindow object!"
		Else
			scrolled.OnGetRowsHeightHint(lineMin, lineMax)
		End If
	End Function

End Type
