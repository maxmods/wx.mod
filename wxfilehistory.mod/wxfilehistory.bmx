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
bbdoc: wxFileHistory
End Rem
Module wx.wxFileHistory

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
bbdoc: The wxFileHistory encapsulates a user interface convenience, the list of most recently visited files as shown on a menu (usually the File menu).
about: wxFileHistory can manage one or more file menus. More than one menu may be required in an MDI
application, where the file history should appear on each MDI child menu as well as the MDI parent frame.
End Rem
Type wxFileHistory Extends wxObject

	Function CreateFileHistory:wxFileHistory(maxFiles:Int = 9, idBase:Int = wxID_FILE1)
	End Function
	
	Method Create:wxFileHistory(maxFiles:Int = 9, idBase:Int = wxID_FILE1)
	End Method
	
	Method AddFileToHistory(filename:String)
	End Method
	
	Method AddFilesToMenu(menu:wxMenu = Null)
	End Method
	
	Method GetBaseId:Int()
	End Method
	
	Method GetCount:Int()
	End Method
	
	Method GetHistoryFile:String(index:Int)
	End Method
	
	Method GetMaxFiles:Int()
	End Method
	
	Method GetMenus:wxMenu[]()
	End Method
	
	Method Load(config:wxConfigBase)
	End Method
	
	Method RemoveFileFromHistory(index:Int)
	End Method
	
	Method RemoveMenu(menu:wxMenu)
	End Method
	
	Method Save(config:wxConfigBase)
	End Method
	
	Method SetBaseId(id:Int)
	End Method
	
	Method UseMenu(menu:wxMenu)
	End Method
	
End Type

