' Copyright (c) 2007-2018 Bruce A Henderson
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

Module wx.wxStockPreferencesPage

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2007-2018 Bruce A Henderson"


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
bbdoc: Specialization of wxPreferencesPage useful for certain commonly used preferences page.
about: On OS X, preferences pages named "General" and "Advanced" are commonly used in apps and the OS provides stock icons
for them that should be used. Instead of reimplementing this behaviour yourself, you can inherit from #wxStockPreferencesPage and get correct title and icon.

> Notice that this class only implements #GetName() and #GetLargeIcon(), you still have to provide the rest of the #wxPreferencesPage implementation.
End Rem
Type wxStockPreferencesPage Extends wxPreferencesPage

	Rem
	bbdoc: 
	End Rem
	Method CreateStock:wxStockPreferencesPage(kind:Int)
		pagePtr = bmx_wxstockpreferencespage_create(Self, kind)
		Return Self
	End Method

	Method GetKind:Int()
		Return bmx_wxstockpreferencespage_getkind(pagePtr)
	End Method
	
	Method GetName:String()
		Return bmx_wxstockpreferencespage_getname(pagePtr)
	End Method
	
	Method GetLargeIcon:wxBitmap()
		Return wxBitmap._create(bmx_wxstockpreferencespage_getlargeicon(pagePtr))
	End Method
	
	Method CreateWindow:wxWindow(parent:wxWindow) Abstract

	Function _OnCreateWindow:Byte Ptr(page:wxPreferencesPage, parent:Byte Ptr) { nomangle }
		Return page.CreateWindow(wxWindow(wxWindow._find(parent))).wxObjectPtr
	End Function

End Type
