' Copyright (c) 2007-2013 Bruce A Henderson
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
bbdoc: wxTreebook
End Rem
Module wx.wxTreebook

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

Rem
bbdoc: This type is an extension of the Notebook class that allows a tree structured set of pages to be shown in a control.
about: A classic example is a netscape preferences dialog that shows a tree of preference sections on the left
and select section page on the right.
<p>
To use the treebook simply create it and populate with pages using InsertPage, InsertSubPage, AddPage, AddSubPage.
</p>
<p>
If your tree is no more than 1 level in depth then you could simply use AddPage and AddSubPage to sequentially
populate your tree by adding at every step a page or a subpage to the end of the tree.
</p>
End Rem
Type wxTreebook Extends wxBookCtrlBase

	Function _create:wxTreebook(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxTreebook = New wxTreebook
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Function _xrcNew:wxTreebook(wxObjectPtr:Byte Ptr)
		Return wxTreebook._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: 
	End Rem
	Function CreateTreebook:wxTreebook(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = wxBK_DEFAULT)
		Return New wxTreebook.Create(parent, id, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxTreebook(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = wxBK_DEFAULT)
		wxObjectPtr = bmx_wxtreebook_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method
	
	Rem
	bbdoc: Adds a new page.
	about: The page is placed at the topmost level after all other pages. NULL could be specified for page to create an empty page.
	End Rem
	Method AddPage:Int(page:wxWindow, text:String, selected:Int = False, imageId:Int = -1)
		If page Then
			Return bmx_wxtreebook_addpage(wxObjectPtr, page.wxObjectPtr, text, selected, imageId)
		Else
			Return bmx_wxtreebook_addpage(wxObjectPtr, Null, text, selected, imageId)
		End If
	End Method
	
	Rem
	bbdoc: Adds a new child-page to the last top-level page.
	about: NULL could be specified for page to create an empty page.
	End Rem
	Method AddSubPage:Int(page:wxWindow, text:String, selected:Int = False, imageId:Int = -1)
		If page Then
			Return bmx_wxtreebook_addsubpage(wxObjectPtr, page.wxObjectPtr, text, selected, imageId)
		Else
			Return bmx_wxtreebook_addsubpage(wxObjectPtr, Null, text, selected, imageId)
		End If
	End Method

	Rem
	bbdoc: Inserts a new page just before the page indicated by pagePos.
	about: The new page is placed before @index page and on the same level. NULL could be specified for page to create an empty page.
	End Rem
	Method InsertPage:Int(index:Int, page:wxWindow, text:String, selected:Int = False, imageId:Int = -1)
		If page Then
			Return bmx_wxtreebook_insertpage(wxObjectPtr, index, page.wxObjectPtr, text, selected, imageId)
		Else
			Return bmx_wxtreebook_insertpage(wxObjectPtr, index, Null, text, selected, imageId)
		End If
	End Method
	
	Rem
	bbdoc: Inserts a sub page under the specified page.
	about: NULL could be specified for page to create an empty page.
	End Rem
	Method InsertSubPage:Int(index:Int, page:wxWindow, text:String, selected:Int = False, imageId:Int = -1)
		If page Then
			Return bmx_wxtreebook_insertsubpage(wxObjectPtr, index, page.wxObjectPtr, text, selected, imageId)
		Else
			Return bmx_wxtreebook_insertsubpage(wxObjectPtr, index, Null, text, selected, imageId)
		End If
	End Method
	
	Rem
	bbdoc: Shortcut for ExpandNode(pageId, false).
	End Rem
	Method CollapseNode:Int(pageId:Int)
		Return bmx_wxtreebook_collapsenode(wxObjectPtr, pageId)
	End Method
	
	Rem
	bbdoc: Expands (collapses) the pageId node.
	returns: The previous state.
	about: May generate page changing events (if selected page is under the collapsed branch, then its parent
	is autoselected).
	End Rem
	Method ExpandNode:Int(pageId:Int, expand:Int = True)
		Return bmx_wxtreebook_expandnode(wxObjectPtr, pageId, expand)
	End Method
	
	Rem
	bbdoc: Gets the page node state -- node is expanded or collapsed
	End Rem
	Method IsNodeExpanded:Int(pos:Int)
		Return bmx_wxtreebook_isnodeexpanded(wxObjectPtr, pos)
	End Method
	
	Rem
	bbdoc: Returns the parent page of the given one or wxNOT_FOUND if this is a top-level page.
	End Rem
	Method GetPageParent:Int(pos:Int)
		Return bmx_wxtreebook_getpageparent(wxObjectPtr, pos)
	End Method
	
	Rem
	bbdoc: Returns the underlying treectrl.
	End Rem
	Method GetTreeCtrl:wxTreeCtrl()
		Return wxTreeCtrl._create(bmx_wxtreebook_gettreectrl(wxObjectPtr))
	End Method

End Type

Rem
bbdoc: This type represents the events generated by a treebook control: currently, there are four of them.
about: The wxEVT_COMMAND_TREEBOOK_PAGE_CHANGING and wxEVT_COMMAND_TREEBOOK_PAGE_CHANGED - have exactly the same
behaviour as wxNotebookEvent.
<p>
The other two wxEVT_COMMAND_TREEBOOK_NODE_COLLAPSED and wxEVT_COMMAND_TREEBOOK_NODE_EXPANDED are triggered when page
node in the tree control is collapsed/expanded. The page index could be retreived by calling wxTreebookEvent::GetSelection.
</p>
End Rem
Type wxTreebookEvent Extends wxBookCtrlEvent

	Function Create:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Local this:wxTreebookEvent = New wxTreebookEvent
		
		this.init(wxEventPtr, evt)
		
		Return this
	End Function
	
End Type

Type TTreebookEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		Select evt.eventType
			Case wxEVT_COMMAND_TREEBOOK_PAGE_CHANGED, ..
					wxEVT_COMMAND_TREEBOOK_PAGE_CHANGING, ..
					wxEVT_COMMAND_TREEBOOK_NODE_COLLAPSED, ..
					wxEVT_COMMAND_TREEBOOK_NODE_EXPANDED
				Return wxTreebookEvent.Create(wxEventPtr, evt)
		End Select
		
		Return Null
	End Method

	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_COMMAND_TREEBOOK_PAGE_CHANGED, ..
					wxEVT_COMMAND_TREEBOOK_PAGE_CHANGING
				Return bmx_wxbookctrlbase_geteventtype(eventType)
			Case wxEVT_COMMAND_TREEBOOK_NODE_COLLAPSED, ..
					wxEVT_COMMAND_TREEBOOK_NODE_EXPANDED
				Return bmx_wxtreebook_geteventtype(eventType)
		End Select
	End Method

End Type

New TTreebookEventFactory


Type TTreebookResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxtreebook_addresourcehandler()
	End Method
		
End Type

New TTreebookResourceFactory

