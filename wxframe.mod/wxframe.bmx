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

Rem
bbdoc: wxFrame
End Rem
Module wx.wxFrame

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
bbdoc: A frame is a window whose size and position can (usually) be changed by the user.
about: It usually has thick borders and a title bar, and can optionally contain a menu bar, toolbar and
status bar. A frame can contain any window that is not a frame or dialog.
<p>
A frame that has a status bar and toolbar created via the CreateStatusBar/CreateToolBar functions manages
these windows, and adjusts the value returned by GetClientSize to reflect the remaining size available
to application windows.
</p>
End Rem
Type wxFrame Extends wxTopLevelWindow

	Field menuBar:wxMenuBar
	'Field statusBar:wxStatusBar
	
	Rem
	bbdoc: TODO
	End Rem
	Function CreateFrame:wxFrame(parent:wxWindow = Null, id:Int = -1, title:String = "", x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxDEFAULT_FRAME_STYLE)
	
		Return New wxFrame.Create(parent, id, title, x, y, w, h, style)
		
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxFrame(parent:wxWindow = Null, id:Int = -1, title:String = "", x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxDEFAULT_FRAME_STYLE)
	
		If parent Then
			wxObjectPtr = bmx_wxframe_create(Self, parent.wxObjectPtr, id, title, x, y, w, h, style)
		Else
			wxObjectPtr = bmx_wxframe_create(Self, Null, id, title, x, y, w, h, style)
		End If
		
		OnInit()
		Return Self
	End Method
	
	Rem
	bbdoc: Called during frame creation.
	about: Override this method to provide your own initialization, like adding menus, controls etc.
	End Rem
	Method OnInit()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetMenuBar(menuBar:wxMenuBar)

		If Not self.menuBar Then
			self.menuBar = menuBar
			bmx_wxframe_setmenubar(wxObjectPtr, menuBar.wxObjectPtr)
		End If
		
	End Method
	
	Rem
	bbdoc: Creates a status bar at the bottom of the frame.
	End Rem
	Method CreateStatusBar:wxStatusBar(number:Int = 1, style:Int = 0, id:Int = -1)
		Local sb:wxStatusBar = wxStatusBar._create(bmx_wxframe_createstatusbar(wxObjectPtr, number, style, id))
		sb.injectSelf()
		Return sb
	End Method
	
	Rem
	bbdoc: Sets the status bar text and redraws the status bar.
	about: 
	End Rem
	Method SetStatusText(text:String, number:Int = 0)
		bmx_wxframe_setstatustext(wxObjectPtr, text, number)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetMenuBar:wxMenuBar()
		Return wxMenuBar(wxfind(bmx_wxframe_getmenubar(wxObjectPtr)))
	End Method
	
	Rem
	bbdoc: Associates a status bar with the frame.
	End Rem
	Method SetStatusBar(statusbar:wxStatusBar)
		If statusbar Then
			bmx_wxframe_setstatusbar(wxObjectPtr, statusbar.wxObjectPtr)
		Else
			bmx_wxframe_setstatusbar(wxObjectPtr, Null)
		End If
	End Method
	
	Rem
	bbdoc: Returns the status bar currently associated with the frame (if any).
	End Rem
	Method GetStatusBar:wxStatusBar()
		Local sbPtr:Byte Ptr = bmx_wxframe_getstatusbar(wxObjectPtr)
		If sbptr Then
			Local sb:wxStatusBar = wxStatusBar(wxfind(sbPtr))
			If Not sb Then
				sb = wxStatusBar._create(sbPtr)
			End If
			Return sb
		End If
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method PositionStatusBar()
		bmx_wxframe_positionstatusbar(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Set the status bar pane used to display menu and toolbar help.
	about: Using -1 disables help display.
	End Rem
	Method SetStatusBarPane(n:Int)
	End Method
	
	Rem
	bbdoc: Creates a toolbar at the top or left of the frame
	End Rem
	Method CreateToolBar:wxToolBar(style:Int = wxNO_BORDER | wxTB_HORIZONTAL, id:Int = -1)
		Local tb:wxToolBar = wxToolBar._create(bmx_wxframe_createtoolbar(wxObjectPtr, style, id))
		tb.injectSelf()
		Return tb
	End Method
	
	Rem
	bbdoc: Returns the toolbar currently associated with the frame (if any).
	End Rem
	Method GetToolBar:wxToolBar()
		Local tbPtr:Byte Ptr = bmx_wxframe_gettoolbar(wxObjectPtr)
		If tbptr Then
			Local tb:wxToolBar = wxToolBar(wxfind(tbPtr))
			If Not tb Then
				tb = wxToolBar._create(tbPtr)
			End If
			Return tb
		End If
	End Method
	
	Rem
	bbdoc: Associates a toolbar with the frame.
	End Rem
	Method SetToolBar(toolbar:wxToolBar)
		bmx_wxframe_settoolbar(wxObjectPtr, toolbar.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ProcessCommand(id:Int)
	End Method
	
	Rem
	bbdoc: This method sends a dummy size event to the frame forcing it to reevaluate its children positions.
	about: It is sometimes useful to call this function after adding or deleting a children after the frame
	creation or if a child size changes.
	<p>
	Note that if the frame is using either sizers or constraints for the children layout, it is enough to call
	Layout() directly and this function should not be used in this case.
	</p>
	End Rem
	Method SendSizeEvent()
		bmx_wxframe_sendsizeevent(wxObjectPtr)
	End Method
	
	
	Method Delete()
	End Method
End Type

