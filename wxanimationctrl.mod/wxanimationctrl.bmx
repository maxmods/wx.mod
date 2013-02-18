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
bbdoc: wxAnimationCtrl
End Rem
Module wx.wxAnimationCtrl

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
bbdoc: A static control which displays an animation.
about: wxAnimationCtrl API is as simple as possible and won't give you full control on the animation; if you need it then use wxMediaCtrl.
This control is useful to display a (small) animation while doing a long task (e.g. a "throbber").
End Rem
Type wxAnimationCtrl Extends wxControl

	Function _create:wxAnimationCtrl(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxAnimationCtrl = New wxAnimationCtrl
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Function _xrcNew:wxAnimationCtrl(wxObjectPtr:Byte Ptr)
		Return wxAnimationCtrl._create(wxObjectPtr)
	End Function

	Rem
	bbdoc: 
	End Rem
	Function CreateAnimationCtrl:wxAnimationCtrl(parent:wxWindow, id:Int, anim:wxAnimation = Null, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = wxAC_DEFAULT_STYLE)
		Return New wxAnimationCtrl.Create(parent, id, anim, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxAnimationCtrl(parent:wxWindow, id:Int, anim:wxAnimation = Null, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = wxAC_DEFAULT_STYLE)
		If anim Then
			wxObjectPtr = bmx_wxanimationctrl_create(Self, parent.wxObjectPtr, id, anim.wxObjectPtr, x, y, w, h, style)
		Else
			wxObjectPtr = bmx_wxanimationctrl_create(Self, parent.wxObjectPtr, id, Null, x, y, w, h, style)
		End If
		
		OnInit()
		
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetAnimation:wxAnimation()
		Return wxAnimation._create(bmx_wxanimationctrl_getanimation(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetInactiveBitmap:wxBitmap()
		Return wxBitmap._create(bmx_wxanimationctrl_getinactivebitmap(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsPlaying:Int()
		Return bmx_wxanimationctrl_isplaying(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method LoadFile:Int(file:String, animType:Int = wxANIMATION_TYPE_ANY)
		Return bmx_wxanimationctrl_loadfile(wxObjectPtr, file, animType)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Load:Int(file:Object, animType:Int = wxANIMATION_TYPE_ANY)
		Local res:Int
		
		If TStream(file) Then
			' create a maxInputStream and attempt to load
			Local stream:wxMaxInputStream = New wxMaxInputStream.Create(file)
			res = bmx_wxanimationctrl_load(wxObjectPtr, stream.wxStreamPtr, animType)
			TStream(file).Close()
			
		Else If wxInputStream(file) Then
			' load using this input stream
			res = bmx_wxanimationctrl_load(wxObjectPtr, wxInputStream(file).wxStreamPtr, animType)
		Else
			Local str:String = String(file)
			If str Then
				If str.Find( "::",0 ) > 0 Then
					' Create a stream and load it
					Local stream:TStream = ReadStream(str)
					Local inp:wxMaxInputStream = New wxMaxInputStream.Create(stream)
					res = bmx_wxanimationctrl_load(wxObjectPtr, inp.wxStreamPtr, animType)
					stream.Close()
				Else
					res = False
				End If
			Else
				res = False
			End If
		End If

		Return res
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Play:Int()
		Return bmx_wxanimationctrl_play(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetAnimation(anim:wxAnimation)
		bmx_wxanimationctrl_setanimation(wxObjectPtr, anim.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetInactiveBitmap(bitmap:wxBitmap)
		bmx_wxanimationctrl_setinactivebitmap(wxObjectPtr, bitmap.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Stop()
		bmx_wxanimationctrl_stop(wxObjectPtr)
	End Method

End Type


Type TAnimationCtrlResourceFactory Extends TXMLResourceFactory

	Method AddHandler()
		bmx_wxanimationctrl_addresourcehandler()
	End Method
		
End Type

New TAnimationCtrlResourceFactory
