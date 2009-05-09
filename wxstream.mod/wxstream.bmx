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
bbdoc: wxStream
End Rem
Module wx.wxStream

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
bbdoc: 
End Rem
Type wxMaxInputStream Extends wxInputStream

	Field _stream:TStream
	Field _lastRead:Int

	Rem
	bbdoc: 
	End Rem
	Function CreateMaxInputStream:wxMaxInputStream(stream:Object)
		Return New wxMaxInputStream.Create(stream)
	End Function

	Rem
	bbdoc: 
	End Rem
	Method Create:wxMaxInputStream(stream:Object)
		If TStream(stream) Then
			_stream = TStream(stream)
		Else
			_stream = ReadStream(stream)
		End If
		wxStreamPtr = bmx_wxmaxinputstream_create(Self)
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Method CanRead:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetC:Int()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Eof:Int()
		Return _stream.Eof()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method LastRead:Int()
		Return _lastRead
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Peek:Byte()
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Read:wxMaxInputStream(buffer:Byte Ptr, size:Int)
		_lastRead = _stream.Read( buffer, size )
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SeekI:Int(pos:Int, mode:Int = wxFromStart)
		Select mode
			Case wxFromStart
				_stream.Seek(0)
				Return _stream.Seek(pos)
			Case wxFromCurrent
				Return _stream.Seek(_stream.Pos() + pos)
			Case wxFromEnd
				Return _stream.Seek(_stream.Size() - pos)
		End Select
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method TellI:Int()
		Return _stream.Pos()
	End Method

	Method Delete()
		If _stream Then
			_stream.Close()
		End If
		If wxStreamPtr Then
			bmx_wxmaxinputstream_delete(wxStreamPtr)
			wxStreamPtr = Null
		End If
	End Method
	
	' CALLBACK functions
	
	Function _eof:Int(obj:Object)
		Return wxMaxInputStream(obj).Eof()
	End Function
	
	Function _read:Byte Ptr(obj:Object, buffer:Byte Ptr, size:Int)
		Return wxMaxInputStream(obj).Read(buffer, size).wxStreamPtr
	End Function

	Function _sysread:Int(obj:Object, buffer:Byte Ptr, size:Int)
		wxMaxInputStream(obj).Read(buffer, size)
		Return wxMaxInputStream(obj)._lastread
	End Function

	Function _seeki:Int(obj:Object, pos:Int, mode:Int)
		Return wxMaxInputStream(obj).SeekI(pos, mode)
	End Function

	Function _sysseek:Int(obj:Object, pos:Int, mode:Int)
		Return wxMaxInputStream(obj).SeekI(pos, mode)
	End Function
	
	Function _systell:Int(obj:Object)
		Return wxMaxInputStream(obj).TellI()
	End Function

	Function _telli:Int(obj:Object)
		Return wxMaxInputStream(obj).TellI()
	End Function
	
End Type


