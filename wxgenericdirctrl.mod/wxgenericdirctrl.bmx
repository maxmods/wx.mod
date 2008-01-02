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

	Function CreateGenericDirCtrl:wxGenericDirCtrl()
	End Function
	
	Method Create:wxGenericDirCtrl()
	End Method
	
	Method Init()
	End Method
	
	Method CollapseTree()
	End Method
	
	Method ExpandPath:Int(path:String)
	End Method
	
	Method CollapsePath:Int(path:String)
	End Method
	
	Method GetDefaultPath:String()
	End Method
	
	Method GetPath:String()
	End Method
	
	Method GetFilePath:String()
	End Method
	
	Method GetFilter:String()
	End Method
	
	Method GetFilterIndex:Int()
	End Method
	
	Method GetFilterListCtrl()
	End Method
	
	Method GetRootId:wxTreeItemId()
	End Method
	
	Method GetTreeCtrl:wxTreeCtrl()
	End Method
	
	Method ReCreateTree()
	End Method
	
	Method SetDefaultPath(path:String)
	End Method
	
	Method SetFilter(filter:String)
	End Method
	
	Method SetFilterIndex(index:Int)
	End Method
	
	Method SetPath(path:String)
	End Method
	
	Method ShowHidden(show:Int)
	End Method
	
End Type
