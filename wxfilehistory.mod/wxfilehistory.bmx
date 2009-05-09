' Copyright (c) 2007-2009 Bruce A Henderson
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
bbdoc: wxFileHistory
End Rem
Module wx.wxFileHistory

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2009 Bruce A Henderson"


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
bbdoc: The wxFileHistory encapsulates a user interface convenience, the list of most recently visited files as shown on a menu (usually the File menu).
about: wxFileHistory can manage one or more file menus. More than one menu may be required in an MDI
application, where the file history should appear on each MDI child menu as well as the MDI parent frame.
End Rem
Type wxFileHistory Extends wxObject

	' soft linking
	Function _create:wxFileHistory(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxFileHistory = New wxFileHistory
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _find:wxFileHistory(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxFileHistory = wxFileHistory(wxfind(wxObjectPtr))
			If Not window Then
				Return wxFileHistory._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function

	Rem
	bbdoc: Constructor.
	about: Pass the maximum number of files that should be stored and displayed.
	<p>
	@idBase defaults to wxID_FILE1 and represents the id given to the first history menu item. Since menu items
	can't share the same ID you should change idBase (to one of your own defined IDs) when using more than one
	wxFileHistory in your application.
	</p>
	End Rem
	Function CreateFileHistory:wxFileHistory(maxFiles:Int = 9, idBase:Int = wxID_FILE1)
		Return New wxFileHistory.Create(maxFiles, idBase)
	End Function
	
	Rem
	bbdoc: Constructor.
	about: Pass the maximum number of files that should be stored and displayed.
	<p>
	@idBase defaults to wxID_FILE1 and represents the id given to the first history menu item. Since menu items
	can't share the same ID you should change idBase (to one of your own defined IDs) when using more than one
	wxFileHistory in your application.
	</p>
	End Rem
	Method Create:wxFileHistory(maxFiles:Int = 9, idBase:Int = wxID_FILE1)
		wxObjectPtr = bmx_wxfilehistory_create(Self, maxFiles, idBase)
		Return Self
	End Method
	
	Rem
	bbdoc: Adds a file to the file history list, if the object points to an appropriate file menu.
	End Rem
	Method AddFileToHistory(filename:String)
		bmx_wxfilehistory_addfiletohistory(wxObjectPtr, filename)
	End Method
	
	Rem
	bbdoc: Appends the files in the history list, to the given menu only, or if Null, to all menus managed by the file history object..
	End Rem
	Method AddFilesToMenu(menu:wxMenu = Null)
		If menu Then
			bmx_wxfilehistory_addfilestomenu(wxObjectPtr, menu.wxObjectPtr)
		Else
			bmx_wxfilehistory_addfilestomenu(wxObjectPtr, Null)
		End If
	End Method
	
	Rem
	bbdoc: Returns the base identifier for the range used for appending items.
	End Rem
	Method GetBaseId:Int()
		Return bmx_wxfilehistory_getbaseid(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the number of files currently stored in the file history.
	End Rem
	Method GetCount:Int()
		Return bmx_wxfilehistory_getcount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the file at this index (zero-based).
	End Rem
	Method GetHistoryFile:String(index:Int)
		Return bmx_wxfilehistory_gethistoryfile(wxObjectPtr, index)
	End Method
	
	Rem
	bbdoc: Returns the maximum number of files that can be stored.
	End Rem
	Method GetMaxFiles:Int()
		Return bmx_wxfilehistory_getmaxfiles(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the list of menus that are managed by this file history object.
	End Rem
	Method GetMenus:wxMenu[]()
		Return bmx_wxfilehistory_getmenus(wxObjectPtr)
	End Method
	
	Function _makeMenus:wxMenu[](size:Int)
		Return New wxMenu[size]
	End Function
	
	Function _addMenu(menus:wxMenu[], index:Int, menu:Byte Ptr)
		menus[index] = wxMenu._create(menu)
	End Function
	
	Rem
	bbdoc: Loads the file history from the given config object.
	about: This method should be called explicitly by the application.
	End Rem
	Method Load(config:wxConfigBase)
		bmx_wxfilehistory_load(wxObjectPtr, config.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Removes the specified file from the history.
	End Rem
	Method RemoveFileFromHistory(index:Int)
		bmx_wxfilehistory_removefilefromhistory(wxObjectPtr, index)
	End Method
	
	Rem
	bbdoc: Removes this menu from the list of those managed by this object.
	End Rem
	Method RemoveMenu(menu:wxMenu)
		bmx_wxfilehistory_removemenu(wxObjectPtr, menu.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Saves the file history into the given config object.
	about: This must be called explicitly by the application.
	End Rem
	Method Save(config:wxConfigBase)
		bmx_wxfilehistory_save(wxObjectPtr, config.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the base identifier for the range used for appending items.
	End Rem
	Method SetBaseId(id:Int)
		bmx_wxfilehistory_setbaseid(wxObjectPtr, id)
	End Method
	
	Rem
	bbdoc: Adds this menu to the list of those menus that are managed by this file history object.
	about: Also see AddFilesToMenu() for initializing the menu with filenames that are already in the history when
	this function is called, as this is not done automatically.
	End Rem
	Method UseMenu(menu:wxMenu)
		bmx_wxfilehistory_usemenu(wxObjectPtr, menu.wxObjectPtr)
	End Method
	
End Type

