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
bbdoc: wxToolBar
End Rem
Module wx.wxToolBar

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
bbdoc: The toolbar allows an application to use toolbars in a variety of configurations and styles.
about: The toolbar is a popular user interface component and contains a set of bitmap buttons or toggles.
A toolbar gives faster access to an application's facilities than menus, which have to be popped up
and selected rather laboriously.
<p>
A toolbar might appear as a single row of images under the menubar, or it might be in a separate
frame layout in several rows and columns. The class handles the layout of the images, unless explicit
positioning is requested.
</p>
<p>
A tool is a bitmap which can either be a button (there is no 'state', it just generates an event when
clicked) or it can be a toggle. If a toggle, a second bitmap can be provided to depict the 'on' state;
if the second bitmap is omitted, either the inverse of the first bitmap will be used (for
monochrome displays) or a thick border is drawn around the bitmap (for colour displays where
inverting will not have the desired result).
</p>
<p>
The Windows-specific toolbar classes expect 16-colour bitmaps that are 16 pixels wide and 15 pixels high.
If you want to use a different size, call SetToolBitmapSize as the demo shows, before adding tools to
the button bar. Don't supply more than one bitmap for each tool, because the toolbar generates all
three images (normal, depressed and checked) from the single bitmap you give it.
</p>
End Rem
Type wxToolBar Extends wxControl

	Rem
	bbdoc: 
	End Rem
	Function CreateToolBar:wxToolBar(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxTB_HORIZONTAL | wxNO_BORDER)
			
		Return New wxToolBar.Create(parent, id, x, y, w, h, style)

	End Function
	
	Rem
	bbdoc: Creation method, for two-step construction. For details see CreateToolBar.
	End Rem
	Method Create:wxToolBar(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, ..
			w:Int = -1, h:Int = -1, style:Int = wxTB_HORIZONTAL | wxNO_BORDER)
			
		wxObjectPtr = bmx_wxtoolbar_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		
		Return Self
	End Method

	Rem
	bbdoc: Adds any control to the toolbar, typically e.g. a combobox.
	End Rem
	Method AddControl:Int(control:wxControl)
		Return bmx_wxtoolbar_addcontrol(wxObjectPtr, control.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Adds a separator for spacing groups of tools.
	End Rem
	Method AddSeparator()
		bmx_wxtoolbar_addseparator(wxObjectPtr)
	End Method
	
	Method AddTool(toolId:Int, label:String, bitmap1:wxBitmap, bitmap2:wxBitmap = Null, kind:Int = wxITEM_NORMAL, ..
			shortHelpString:String = "", longHelpString:String = "", clientData:Object = Null)
	
		If bitmap2 Then
			If clientData Then
				bmx_wxtoolbar_addtool(wxObjectPtr, toolId, label, bitmap1.wxObjectPtr, bitmap2.wxObjectPtr, kind, ..
					shortHelpString, longHelpString, clientData)
			Else
				bmx_wxtoolbar_addtool(wxObjectPtr, toolId, label, bitmap1.wxObjectPtr, bitmap2.wxObjectPtr, kind, ..
					shortHelpString, longHelpString, Null)
			End If
		Else
			If clientData Then
				bmx_wxtoolbar_addtool(wxObjectPtr, toolId, label, bitmap1.wxObjectPtr, Null, kind, ..
					shortHelpString, longHelpString, clientData)
			Else
				bmx_wxtoolbar_addtool(wxObjectPtr, toolId, label, bitmap1.wxObjectPtr, Null, kind, ..
					shortHelpString, longHelpString, Null)
			End If
		End If
	
	End Method
	
	Rem
	bbdoc: This method should be called after you have added tools.
	End Rem
	Method Realize:Int()
		Return bmx_wxtoolbar_realize(wxObjectPtr)
	End Method

	Rem
	bbdoc: Sets the default size of each tool bitmap.
	about: The default bitmap size is 16 by 15 pixels.
	End Rem
	Method SetToolBitmapSize(width:Int, height:Int)
		bmx_wxtoolbar_settoolbitmapsize(wxObjectPtr, width, height)
	End Method
	
End Type


Type TToolBarEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		Select evt.eventType
			Case wxEVT_COMMAND_TOOL_CLICKED, ..
					wxEVT_COMMAND_TOOL_RCLICKED, ..
					wxEVT_COMMAND_TOOL_ENTER
				Return wxCommandEvent.create(wxEventPtr, evt)
		End Select
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_COMMAND_TOOL_CLICKED, ..
				wxEVT_COMMAND_TOOL_RCLICKED, ..
				wxEVT_COMMAND_TOOL_ENTER
			Return bmx_wxtoolbar_geteventtype(eventType)
		End Select
	End Method
		
End Type

New TToolBarEventFactory


