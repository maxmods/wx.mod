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
bbdoc: wxStaticBoxSizer
End Rem
Module wx.wxStaticBoxSizer

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
bbdoc: wxStaticBoxSizer is a sizer derived from wxBoxSizer but adds a static box around the sizer.
about: This static box may be either created independently or the sizer may create it itself as a
convenience. In any case, the sizer owns the wxStaticBox control and will delete it if it is deleted.
End Rem
Type wxStaticBoxSizer Extends wxBoxSizer

	Rem
	bbdoc: Creates a new static box with the given label and parent window.
	End Rem
	Function CreateStaticBoxSizer:wxStaticBoxSizer(orient:Int, parent:wxWindow, label:String = "")
		Return New wxStaticBoxSizer.CreateSizer(orient, parent, label)
	End Function

	Rem
	bbdoc: Creates a wxStaticBoxSizer using the associated static box and the orientation orient, which can be either wxVERTICAL or wxHORIZONTAL as parameters.
	End Rem
	Function CreateStaticBoxSizerWithBox:wxStaticBoxSizer(box:wxStaticBox, orient:Int)
		Return New wxStaticBoxSizer.CreateSizerWithBox(box, orient)
	End Function
	
	Rem
	bbdoc: Creates a new static box with the given label and parent window.
	End Rem
	Method CreateSizer:wxStaticBoxSizer(orient:Int, parent:wxWindow, label:String = "")
		wxSizerPtr = bmx_wxstaticboxsizer_createsizer(Self, orient, parent.wxObjectPtr, label)
		Return Self
	End Method

	Rem
	bbdoc: Creates a wxStaticBoxSizer using the associated static box and the orientation orient, which can be either wxVERTICAL or wxHORIZONTAL as parameters.
	End Rem
	Method CreateSizerWithBox:wxStaticBoxSizer(box:wxStaticBox, orient:Int)
		wxSizerPtr = bmx_wxstaticboxsizer_createsizerwithbox(Self, box.wxObjectPtr, orient)
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the static box associated with the sizer.
	End Rem
	Method GetStaticBox:wxStaticBox()
		Return wxStaticBox._find(bmx_wxstaticboxsizer_getstaticbox(wxSizerPtr))
	End Method
	
End Type


