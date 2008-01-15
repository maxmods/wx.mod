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
bbdoc: wxBookCtrlBase
End Rem
Module wx.wxBookCtrlBase

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
bbdoc: Common base type for book controls
End Rem
Type wxBookCtrlBase Extends wxControl

	Function _create:wxBookCtrlBase(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxBookCtrlBase = New wxBookCtrlBase
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function


	Rem
	bbdoc: Adds a new page.
	returns: True if successful, False otherwise.
	about: The call to this method may generate the page changing events.
	<p>
	Do not delete the page, it will be deleted by the notebook.
	</p>
	End Rem
	Method AddPage:Int(page:wxWindow, text:String, selected:Int = False, imageId:Int = -1)
		Return bmx_wxbookctrlbase_addpage(wxObjectPtr, page.wxObjectPtr, text, selected, imageId)
	End Method

	Rem
	bbdoc: Inserts a new page at the specified position.
	returns: True if successful, False otherwise.
	End Rem
	Method InsertPage:Int(index:Int, page:wxWindow, text:String, selected:Int = False, imageId:Int = -1)
		Return bmx_wxbookctrlbase_insertpage(wxObjectPtr, index, page.wxObjectPtr, text, selected, imageId)
	End Method

	Rem
	bbdoc: Cycles through the tabs.
	about: The call to this function generates the page changing events.
	End Rem
	Method AdvanceSelection(forward:Int = True)
		bmx_wxbookctrlbase_advanceselection(wxObjectPtr, forward)
	End Method
	
	Rem
	bbdoc: Sets the image list for the page control and takes ownership of the list.
	End Rem
	Method AssignImageList(imageList:wxImageList)
		bmx_wxbookctrlbase_assignimagelist(wxObjectPtr, imageList.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Deletes all pages.
	End Rem
	Method DeleteAllPages:Int()
		Return bmx_wxbookctrlbase_deleteallpages(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Deletes the specified page, and the associated window.
	about: The call to this method generates the page changing events.
	End Rem
	Method DeletePage:Int(page:Int)
		Return bmx_wxbookctrlbase_deletepage(wxObjectPtr, page)
	End Method
	
	Rem
	bbdoc: Returns the currently selected notebook page or Null.
	End Rem
	Method GetCurrentPage:wxWindow()
		Return wxWindow._find(bmx_wxbookctrlbase_getcurrentpage(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Returns the associated image list.
	End Rem
	Method GetPage:wxWindow(page:Int)
		Return wxWindow._find(bmx_wxbookctrlbase_getpage(wxObjectPtr, page))
	End Method
	
	Rem
	bbdoc: Returns the window at the given page position.
	End Rem
	Method GetPageCount:Int()
		Return bmx_wxbookctrlbase_getpagecount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the number of pages in the notebook control.
	End Rem
	Method GetPageImage:Int(page:Int)
		Return bmx_wxbookctrlbase_getpageimage(wxObjectPtr, page)
	End Method
	
	Rem
	bbdoc: Returns the string for the given page.
	End Rem
	Method GetPageText:String(page:Int)
		Return bmx_wxbookctrlbase_getpagetext(wxObjectPtr, page)
	End Method
	
	Rem
	bbdoc: Returns the currently selected page, or -1 if none was selected.
	about: Note that this method may return either the previously or newly selected page when called from
	the wxEVT_NOTEBOOK_PAGE_CHANGED handler depending on the platform and so wxNotebookEvent::GetSelection should
	be used instead in this case.
	End Rem
	Method GetSelection:Int()
		Return bmx_wxbookctrlbase_getselection(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the index of the tab at the specified position or wxNOT_FOUND if none.
	returns: The zero-based tab index or wxNOT_FOUND if there is no tab is at the specified position.
	about: @flags returns the position of the point inside the tab is returned as well, which can be one of the
	following values :
	<table width="90%" align="center">
	<tr><th>Constant</th><th>Description</th></tr>
	<tr><td>wxBK_HITTEST_NOWHERE</td><td>There was no tab under this point. </td></tr>
	<tr><td>wxBK_HITTEST_ONICON</td><td>The point was over an icon (currently wxMSW only). </td></tr>
	<tr><td>wxBK_HITTEST_ONLABEL</td><td>The point was over a label (currently wxMSW only). </td></tr>
	<tr><td>wxBK_HITTEST_ONITEM</td><td>The point was over an item, but not on the label or icon. </td></tr>
	<tr><td>wxBK_HITTEST_ONPAGE</td><td>The point was over a currently selected page, not over any tab. Note
	that this flag is present only if wxNOT_FOUND is returned. </td></tr>
	</table>
	End Rem
	Method HitTest:Int(x:Int, y:Int, flags:Int Var)
		Return bmx_wxbookctrlbase_hittest(wxObjectPtr, x, y, Varptr flags)
	End Method
	
	Rem
	bbdoc: Deletes the specified page, without deleting the associated window.
	End Rem
	Method RemovePage:Int(page:Int)
		Return bmx_wxbookctrlbase_removepage(wxObjectPtr, page)
	End Method
	
	Rem
	bbdoc: Sets the image list for the page control.
	about: It does not take ownership of the image list, you must delete it yourself.
	End Rem
	Method SetImageList(imageList:wxImageList)
		bmx_wxbookctrlbase_setimagelist(wxObjectPtr, imageList.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the width and height of the pages.
	about: NB: This method is currently not implemented for wxGTK.
	End Rem
	Method SetPageSize(width:Int, height:Int)
		bmx_wxbookctrlbase_setpagesize(wxObjectPtr, width, height)
	End Method
	
	Rem
	bbdoc: Sets the image index for the given page.
	about: @image is an index into the image list which was set with wxNotebook::SetImageList.
	End Rem
	Method SetPageImage:Int(page:Int, image:Int)
		Return bmx_wxbookctrlbase_setpageimage(wxObjectPtr, page, image)
	End Method
	
	Rem
	bbdoc: Sets the text for the given page.
	End Rem
	Method SetPageText:Int(page:Int, text:String)
		Return bmx_wxbookctrlbase_setpagetext(wxObjectPtr, page, text)
	End Method
	
	Rem
	bbdoc: Sets the selection for the given page, returning the previous selection.
	about: The call to this method generates the page changing events.
	<p>
	This method is deprecated and should not be used in new code. Please use the ChangeSelection
	method instead.
	</p>
	End Rem
	Method SetSelection:Int(page:Int)
		Return bmx_wxbookctrlbase_setselection(wxObjectPtr, page)
	End Method
	
	Rem
	bbdoc: Changes the selection for the given page, returning the previous selection.
	about: The call to this method does not generate the page changing events. This is the only
	difference with SetSelection. See this topic for more info.
	End Rem
	Method ChangeSelection:Int(page:Int)
		Return bmx_wxbookctrlbase_changeselection(wxObjectPtr, page)
	End Method
	

End Type


