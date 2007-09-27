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
bbdoc: wxSheet
End Rem
Module wx.wxSheet

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
bbdoc: 
End Rem
Type wxSheet Extends wxWindow

End Type

Rem
bbdoc: 
End Rem
Type wxSheetTable Extends wxObject

	Rem
	bbdoc: 
	End Rem
	Method GetView:wxSheet()

	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetView(sheet:wxSheet)
		bmx_wxsheettable_setview(wxObjectPtr, sheet.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetNumberRows:Int()
		Return bmx_wxsheettable_getnumberrows(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetNumberCols:Int()
		Return bmx_wxsheettable_getnumbercols(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ContainsGridRow:Int(row:Int)
		Return bmx_wxsheettable_containsgridrow(wxObjectPtr, row)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ContainsGridCol:Int(col:Int)
		Return bmx_wxsheettable_containsgridcol(wxObjectPtr, col)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method ContainsGridCell:Int(row:Int, col:Int)
		Return bmx_wxsheettable_containsgridcell(wxObjectPtr, row, col)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetValue:String(row:Int, col:Int)
		Return bmx_wxsheettable_getvalue(wxObjectPtr, row, col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetValue(row:Int, col:Int, value:String)
		bmx_wxsheettable_setvalue(wxObjectPtr, row, col, value)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method HasValue:Int(row:Int, col:Int)
		Return bmx_wxsheettable_hasvalue(wxObjectPtr, row, col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetFirstNonEmptyColToLeft:Int(row:Int, col:Int)
		Return bmx_wxsheettable_getfirstnonemptycoltoleft(wxObjectPtr, row, col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ClearValues(update:Int = wxSHEET_UpdateValues)
		bmx_wxsheettable_clearvalues(wxObjectPtr, update)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDefaultRowLabelValue:String(row:Int)
		Return bmx_wxsheettable_getdefaultrowlabelvalue(wxObjectPtr, row)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDefaultColLabelValue:String(col:Int)
		Return bmx_wxsheettable_getdefaultcollabelvalue(wxObjectPtr, col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetValueAsInt:Int(row:Int, col:Int)
		Return bmx_wxsheettable_getvalueasint(wxObjectPtr, row, col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetValueAsDouble:Double(row:Int, col:Int)
		Return bmx_wxsheettable_getvalueasdouble(wxObjectPtr, row, col)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetValueAsBool:Int(row:Int, col:Int)
		Return bmx_wxsheettable_getvalueasbool(wxObjectPtr, row, col)
	End Method
	
	
End Type
