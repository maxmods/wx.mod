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
bbdoc: wxPanel
End Rem
Module wx.wxPanel

ModuleInfo "Version: 1.00"
ModuleInfo "License:"
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
bbdoc: A panel is a window on which controls are placed.
about: It is usually placed within a frame. It contains minimal extra functionality over and above its parent
class wxWindow; its main purpose is to be similar in appearance and functionality to a dialog, but with the
flexibility of having any window as a parent.
<p>
Note: if not all characters are being intercepted by your OnKeyDown or OnChar handler, it may be because
you are using the wxTAB_TRAVERSAL style, which grabs some keypresses for use by child controls.
</p>
End Rem
Type wxPanel Extends wxWindow

	Rem
	bbdoc: Constructor.
	End Rem
	Function CreatePanel:wxPanel(parent:wxWindow, id:Int = -1, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, ..
			style:Int = wxTAB_TRAVERSAL)
		Return New wxPanel.Create(parent, id, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxPanel(parent:wxWindow, id:Int = -1, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, ..
			style:Int = wxTAB_TRAVERSAL)

		wxObjectPtr = bmx_wxpanel_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		
		OnInit()
		
		Return Self			
	End Method
	
	Rem
	bbdoc: Called during panel creation.
	about: Override this method to provide your own initialization, like adding controls etc.
	End Rem
	Method OnInit()
	End Method

	Rem
	bbdoc: Sends a wxInitDialogEvent, which in turn transfers data to the dialog via validators.
	End Rem
	Method InitDialog()
		bmx_wxpanel_initdialog(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Overrides wxWindow::SetFocus.
	about: This method uses the (undocumented) mix-in class wxControlContainer which manages the focus and TAB logic
	for controls which usually have child controls. In practice, if you call this method and the control has at
	least one child window, the focus will be given to the child window.
	End Rem
	Method SetFocus()
		bmx_wxpanel_setfocus(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: In contrast to wxPanel::SetFocus this will set the focus to the panel even of there are child windows in the panel.
	about: This is only rarely needed.
	End Rem
	Method SetFocusIgnoringChildren()
		bmx_wxpanel_setfocusignoringchildren(wxObjectPtr)
	End Method
	
End Type

