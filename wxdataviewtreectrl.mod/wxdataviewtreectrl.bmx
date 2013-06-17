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
bbdoc: wxDataViewTreeCtrl
End Rem
Module wx.wxDataViewTreeCtrl

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
bbdoc: 
End Rem
Type wxDataViewTreeCtrl Extends wxDataViewCtrl

	Function CreateDataViewTreeCtrl:wxDataViewTreeCtrl(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = wxDV_NO_HEADER | wxDV_ROW_LINES)
		Return New wxDataViewTreeCtrl.Create(parent, id, x, y, w, h, style)
	End Function
	
	Method Create:wxDataViewTreeCtrl(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = wxDV_NO_HEADER | wxDV_ROW_LINES)
		wxObjectPtr = bmx_wxdataviewtreectrl_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Method AppendContainer:wxDataViewItem(parent:wxDataViewItem, text:String, icon:Int = -1, expanded:Int = -1, data:Object = Null)
		Return wxDataViewItem._create(bmx_wxdataviewtreectrl_appendcontainer(wxObjectPtr, parent.wxObjectPtr, text, icon, expanded, data))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method AppendItem:wxDataViewItem(parent:wxDataViewItem, text:String, icon:Int = -1, data:Object = Null)
		Return wxDataViewItem._create(bmx_wxdataviewtreectrl_appenditem(wxObjectPtr, parent.wxObjectPtr, text, icon, data))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DeleteAllItems()
		bmx_wxdataviewtreectrl_deleteallitems(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DeleteChildren(item:wxDataViewItem)
		bmx_wxdataviewtreectrl_deletechildren(wxObjectPtr, item.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DeleteItem(item:wxDataViewItem)
		bmx_wxdataviewtreectrl_deleteitem(wxObjectPtr, item.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetChildCount:Int(parent:wxDataViewItem)
		Return bmx_wxdataviewtreectrl_getchildcount(wxObjectPtr, parent.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetImageList:wxImageList()
		Return wxImageList._create(bmx_wxdataviewtreectrl_getimagelist(wxObjectPtr))
	End Method
	
	Method GetItemData:Object(item:wxDataViewItem)
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetItemExpandedIcon:wxIcon(item:wxDataViewItem)
		Return wxIcon._create(bmx_wxdataviewtreectrl_getitemexpandedicon(wxObjectPtr, item.wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetItemIcon:wxIcon(item:wxDataViewItem)
		Return wxIcon._create(bmx_wxdataviewtreectrl_getitemicon(wxObjectPtr, item.wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetItemText:String(item:wxDataViewItem)
		Return bmx_wxdataviewtreectrl_getitemtext(wxObjectPtr, item.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetNthChild:wxDataViewItem(parent:wxDataViewItem, pos:Int)
		Return wxDataViewItem._create(bmx_wxdataviewtreectrl_getnthchild(wxObjectPtr, parent.wxObjectPtr, pos))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method InsertContainer:wxDataViewItem(parent:wxDataViewItem, previous:wxDataViewItem, text:String, icon:Int = -1, expanded:Int = -1, data:Object = Null)
		Return wxDataViewItem._create(bmx_wxdataviewtreectrl_insertcontainer(wxObjectPtr, parent.wxObjectPtr, previous.wxObjectPtr, text, icon, expanded, data))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method InsertItem:wxDataViewItem(parent:wxDataViewItem, previous:wxDataViewItem, text:String, icon:Int = -1, data:Object = Null)
		Return wxDataViewItem._create(bmx_wxdataviewtreectrl_insertitem(wxObjectPtr, parent.wxObjectPtr, previous.wxObjectPtr, text, icon, data))
	End Method

	Rem
	bbdoc: 
	End Rem
	Method IsContainer:Int(item:wxDataViewItem)
		Return bmx_wxdataviewtreectrl_iscontainer(wxObjectPtr, item.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method PrependContainer:wxDataViewItem(parent:wxDataViewItem, text:String, icon:Int = -1, expanded:Int = -1, data:Object = Null)
		Return wxDataViewItem._create(bmx_wxdataviewtreectrl_prependcontainer(wxObjectPtr, parent.wxObjectPtr, text, icon, expanded, data))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method PrependItem:wxDataViewItem(parent:wxDataViewItem, text:String, icon:Int = -1, data:Object = Null)
		Return wxDataViewItem._create(bmx_wxdataviewtreectrl_prependitem(wxObjectPtr, parent.wxObjectPtr, text, icon, data))
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetImageList(imageList:wxImageList)
		bmx_wxdataviewtreectrl_setimagelist(wxObjectPtr, imageList.wxObjectPtr)
	End Method
	
	Method SetItemData(item:wxDataViewItem, data:Object)
		' TODO
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetItemExpandedIcon(item:wxDataViewItem, icon:wxIcon)
		bmx_wxdataviewtreectrl_setitemexpandedicon(wxObjectPtr, item.wxObjectPtr, icon.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetItemIcon(item:wxDataViewItem, icon:wxIcon)
		bmx_wxdataviewtreectrl_setitemicon(wxObjectPtr, item.wxObjectPtr, icon.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetItemText(item:wxDataViewItem, text:String)
		bmx_wxdataviewtreectrl_setitemtext(wxObjectPtr, item.wxObjectPtr, text)
	End Method
	
End Type

