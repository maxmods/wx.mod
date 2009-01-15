' Copyright (c) 2007, 2008 Bruce A Henderson
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
bbdoc: wxGenericDirCtrl
End Rem
Module wx.wxGenericDirCtrl

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
bbdoc: This control can be used to place a directory listing (with optional files) on an arbitrary window.
about: The control contains a wxTreeCtrl window representing the directory hierarchy, and optionally,
a wxChoice window containing a list of filters.
End Rem
Type wxGenericDirCtrl Extends wxControl

	Function _create:wxGenericDirCtrl(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxGenericDirCtrl = New wxGenericDirCtrl
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _find:wxGenericDirCtrl(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxGenericDirCtrl = wxGenericDirCtrl(wxfind(wxObjectPtr))
			If Not window Then
				Return wxGenericDirCtrl._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function

	Function _xrcNew:wxGenericDirCtrl(wxObjectPtr:Byte Ptr)
		Return wxGenericDirCtrl._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: 
	End Rem
	Function CreateGenericDirCtrl:wxGenericDirCtrl(parent:wxWindow, id:Int = -1, dir:String = "/", x:Int = -1, ..
			y:Int = -1, w:Int = -1, h:Int = -1, style:Int = wxDIRCTRL_3D_INTERNAL|wxSUNKEN_BORDER, ..
			filter:String = "", defaultFilter:Int = 0)
		Return New wxGenericDirCtrl.Create(parent, id, dir, x, y, w, h, style, filter, defaultFilter)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxGenericDirCtrl(parent:wxWindow, id:Int = -1, dir:String = "/", x:Int = -1, ..
			y:Int = -1, w:Int = -1, h:Int = -1, style:Int = wxDIRCTRL_3D_INTERNAL|wxSUNKEN_BORDER, ..
			filter:String = "", defaultFilter:Int = 0)
		wxObjectPtr = bmx_wxgenericdirctrl_create(Self, parent.wxObjectPtr, id, dir, x, y, w, h, style, filter, defaultFilter)
		Return Self
	End Method
	
	Rem
	bbdoc: Initializes variables
	End Rem
	Method Init()
		bmx_wxgenericdirctrl_init(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Collapses the entire tree.
	End Rem
	Method CollapseTree()
		bmx_wxgenericdirctrl_collapsetree(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Tries to expand as much of the given path as possible, so that the filename or directory is visible in the tree control.
	End Rem
	Method ExpandPath:Int(path:String)
		Return bmx_wxgenericdirctrl_expandpath(wxObjectPtr, path)
	End Method
	
	Rem
	bbdoc: Collapse the given path.
	End Rem
	Method CollapsePath:Int(path:String)
		Return bmx_wxgenericdirctrl_collapsepath(wxObjectPtr, path)
	End Method
	
	Rem
	bbdoc: Gets the default path.
	End Rem
	Method GetDefaultPath:String()
		Return bmx_wxgenericdirctrl_getdefaultpath(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the currently-selected directory or filename.
	End Rem
	Method GetPath:String()
		Return bmx_wxgenericdirctrl_getpath(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets selected filename path only (else empty string).
	about: This method doesn't count a directory as a selection.
	End Rem
	Method GetFilePath:String()
		Return bmx_wxgenericdirctrl_getfilepath(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the filter string.
	End Rem
	Method GetFilter:String()
		Return bmx_wxgenericdirctrl_getfilter(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the current filter index (zero-based).
	End Rem
	Method GetFilterIndex:Int()
		Return bmx_wxgenericdirctrl_getfilterindex(wxObjectPtr)
	End Method
	
	'Method GetFilterListCtrl()
	'	bmx_wxgenericdirctrl_init(wxObjectPtr)
	'End Method
	
	Rem
	bbdoc: Returns the root id for the tree control.
	End Rem
	Method GetRootId:wxTreeItemId()
		Return wxTreeItemId._create(bmx_wxgenericdirctrl_getrootid(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns a pointer to the tree control.
	End Rem
	Method GetTreeCtrl:wxTreeCtrl()
		Return wxTreeCtrl._find(bmx_wxgenericdirctrl_gettreectrl(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Collapse and expand the tree, thus re-creating it from scratch.
	about: May be used to update the displayed directory content.
	End Rem
	Method ReCreateTree()
		bmx_wxgenericdirctrl_recreatetree(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the default path.
	End Rem
	Method SetDefaultPath(path:String)
		bmx_wxgenericdirctrl_setdefaultpath(wxObjectPtr, path)
	End Method
	
	Rem
	bbdoc: Sets the filter string.
	End Rem
	Method SetFilter(filter:String)
		bmx_wxgenericdirctrl_setfilter(wxObjectPtr, filter)
	End Method
	
	Rem
	bbdoc: Sets the current filter index (zero-based).
	End Rem
	Method SetFilterIndex(index:Int)
		bmx_wxgenericdirctrl_setfilterindex(wxObjectPtr, index)
	End Method
	
	Rem
	bbdoc: Sets the current path.
	End Rem
	Method SetPath(path:String)
		bmx_wxgenericdirctrl_setpath(wxObjectPtr, path)
	End Method
	
	Rem
	bbdoc: Shows or hides hidden folders.
	about: If true, hidden folders and files will be displayed by the control. If false, they will not be displayed.
	End Rem
	Method ShowHidden(show:Int)
		bmx_wxgenericdirctrl_showhidden(wxObjectPtr, show)
	End Method
	
End Type



Type TGenericDirCtrlResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxgenericdirctrl_addresourcehandler()
	End Method
		
End Type

New TGenericDirCtrlResourceFactory
