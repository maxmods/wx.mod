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
bbdoc: wxAnimation
End Rem
Module wx.wxAnimation

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
bbdoc: Encapsulates the concept of a platform-dependent animation.
about: An animation is a sequence of frames of the same size. Sound is not supported by wxAnimation.
<p>
Note that on wxGTK wxAnimation is capable of loading the formats supported by the internally-used gdk-pixbuf library (typically this means only wxANIMATION_TYPE_GIF).
On other platforms wxAnimation is always capable of loading both GIF and ANI formats (i.e. both wxANIMATION_TYPE_GIF and wxANIMATION_TYPE_ANI).
</p>
End Rem
Type wxAnimation Extends wxObject

	Function _create:wxAnimation(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxAnimation = New wxAnimation
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Creates an animation from a file.
	about: @name can be a filename, TStream, wxInputStream, or BlitzMax protocol-based stream (::).
	End Rem
	Method Create:wxAnimation(name:Object, animType:Int = wxANIMATION_TYPE_ANY)

		Local str:String = String(name)
		If Not str Or (str And str.Find( "::",0 ) > 0) Then	
			wxObjectPtr = bmx_wxanimation_createnull()

			If name Then			
				Load(name, animType)
			End If
		Else
			wxObjectPtr = bmx_wxanimation_create(str, animType)
		End If
		
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the delay for the given frame in milliseconds.
	End Rem
	Method GetDelay:Int(frame:Int)
		Return bmx_wxanimation_getdelay(wxObjectPtr, frame)
	End Method
	
	Rem
	bbdoc: Returns the given frame as a wxImage. 
	End Rem
	Method GetFrame:wxImage(frame:Int)
		Return wxImage._create(bmx_wxanimation_getframe(wxObjectPtr, frame))
	End Method
	
	Rem
	bbdoc: Returns the number of frames for this animation.
	End Rem
	Method GetFrameCount:Int()
		Return bmx_wxanimation_getframecount(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the size of the animation.
	End Rem
	Method GetSize(w:Int Var, h:Int Var)
		bmx_wxanimation_getsize(wxObjectPtr, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: Returns True if animation data is present. 
	End Rem
	Method IsOk:Int()
		Return bmx_wxanimation_isok(wxObjectPtr)
	End Method

	Rem
	bbdoc: Loads an animation from the given TStream, wxInputStream, or BlitzMax protocol-based stream (::).
	End Rem
	Method Load:Int(name:Object, animType:Int = wxANIMATION_TYPE_ANY)
		Local res:Int
		
		If TStream(name) Then
			' create a maxInputStream and attempt to load
			Local stream:wxMaxInputStream = New wxMaxInputStream.Create(name)
			res = bmx_wxanimation_loadfromstream(wxObjectPtr, stream.wxStreamPtr, animType)
			TStream(name).Close()
			
		Else If wxInputStream(name) Then
			' load using this input stream
			res = bmx_wxanimation_loadfromstream(wxObjectPtr, wxInputStream(name).wxStreamPtr, animType)
		Else
			Local str:String = String(name)
			If str Then
				If str.Find( "::",0 ) > 0 Then
					' Create a stream and load it
					Local stream:TStream = ReadStream(str)
					Local inp:wxMaxInputStream = New wxMaxInputStream.Create(stream)
					res = bmx_wxanimation_loadfromstream(wxObjectPtr, inp.wxStreamPtr, animType)
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
	bbdoc: Loads an animation from the named file. 
	End Rem
	Method LoadFile:Int(name:String, animType:Int = wxANIMATION_TYPE_ANY)
		Return bmx_wxanimation_loadfile(wxObjectPtr, name, animType)
	End Method

	Method Delete()
		If wxObjectPtr Then
			bmx_wxanimation_free(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
End Type
