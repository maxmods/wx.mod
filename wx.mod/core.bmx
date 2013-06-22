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

Import "events.bmx"
Import "fonts.bmx"
Import "xrc.bmx"

Rem
bbdoc: A colour is an object representing a combination of Red, Green, and Blue (RGB) intensity values, and is used to determine drawing colours.
about: See the entry for wxColourDatabase for how a pointer to a predefined, named colour may be returned
instead of creating a new colour.
<p>
Valid RGB values are in the range 0 to 255.
</p>
<p>
You can retrieve the current system colour settings with wxSystemSettings.
</p>
End Rem
Type wxColour Extends wxObject

	Rem
	bbdoc: 
	End Rem
	Function CreateColour:wxColour(r:Int, g:Int, b:Int, a:Int = wxALPHA_OPAQUE)
		Return New wxColour.Create(r, g, b, a)
	End Function
	
	Rem
	bbdoc: Constructs a colour from red, green, blue and alpha values.
	End Rem
	Method Create:wxColour(r:Int, g:Int, b:Int, a:Int = wxALPHA_OPAQUE)
		wxObjectPtr = bmx_wxcolour_create(r, g, b, a)
		Return Self
	End Method
	
	Rem
	bbdoc: Constructs a colour using the given string.
	End Rem
	Method CreateNamedColour:wxColour(name:String)
		wxObjectPtr = bmx_wxcolour_createnamedcolour(name)
		Return Self
	End Method

	Function _create:wxColour(wxObjectPtr:Byte Ptr)
		Local this:wxColour = New wxColour
		
		this.wxObjectPtr = wxObjectPtr
		
		Return this
	End Function
	
	Rem
	bbdoc: Returns the alpha value.
	End Rem
	Method Alpha:Int()
		Return bmx_wxcolour_alpha(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the blue intensity.
	End Rem
	Method Blue:Int()
		Return bmx_wxcolour_blue(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Converts this colour to a String using the given @flags.
	about: The supported flags are wxC2S_NAME, to obtain the colour name (e.g. wxColour(255,0,0) -&gt; "red"),
	wxC2S_CSS_SYNTAX, to obtain the colour in the "rgb(r,g,b)" syntax (e.g. wxColour(255,0,0) -&gt;
	"rgb(255,0,0)"), and wxC2S_HTML_SYNTAX, to obtain the colour as "#" followed by 6 hexadecimal
	digits (e.g. wxColour(255,0,0) -&gt; "#FF0000").
	<p>
	This method never fails and always returns a non-empty string.
	</p>
	End Rem
	Method GetAsString:String(flags:Int)
		Return bmx_wxcolour_getasstring(wxObjectPtr, flags)
	End Method
	
	Rem
	bbdoc: Returns the green intensity.
	End Rem
	Method Green:Int()
		Return bmx_wxcolour_green(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if the colour object is valid (the colour has been initialised with RGB values).
	End Rem
	Method IsOk:Int()
		Return bmx_wxcolour_isok(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns the red intensity.
	End Rem
	Method Red:Int()
		Return bmx_wxcolour_red(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Sets the RGB intensity values using the given values.
	End Rem
	Method Set(red:Int, green:Int, blue:Int, alpha:Int = wxALPHA_OPAQUE)
		bmx_wxcolour_set(wxObjectPtr, red, green, blue, alpha)
	End Method
	
	Rem
	bbdoc: Sets the RGB intensity values using the given string.
	returns: True if the conversion was successful, False otherwise.
	about: Accepts - colour names (those listed in wxTheColourDatabase), the CSS-like "RGB(r,g,b)"
	syntax (case insensitive) and the HTML-like syntax (i.e. "#" followed by 6 hexadecimal digits for
	red, green, blue components).
	End Rem
	Method SetAsNamedColour:Int(name:String)
		Return bmx_wxcolour_setasnamedcolour(wxObjectPtr, name)
	End Method
	
	Method Equals:Int(colour:wxColour)
		Return bmx_wxcolour_equals(wxObjectPtr, colour.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Retrieves the RGB values of the colour.
	End Rem
	Method GetRGB(red:Int Var, green:Int Var, blue:Int Var)
		bmx_wxcolour_getrgb(wxObjectPtr, Varptr red, Varptr green, Varptr blue)
	End Method

	Rem
	bbdoc: Retrieves the RGBA values of the colour.
	End Rem
	Method GetRGBA(red:Int Var, green:Int Var, blue:Int Var, alpha:Int Var)
		bmx_wxcolour_getrgba(wxObjectPtr, Varptr red, Varptr green, Varptr blue, Varptr alpha)
	End Method
	
	Rem
	bbdoc: Copies colour, returning a new wxColour object.
	End Rem
	Method Copy:wxColour()
		Return _create(bmx_wxcolour_copy(wxObjectPtr))
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxcolour_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method

End Type

Rem
bbdoc: Null colour
End Rem
Global wxNullColour:wxColour = wxColour._create(bmx_wxcolour_null())

Rem
bbdoc: This type is the base type of most stream related types in wxWidgets.
about: It must not be used directly.
End Rem
Type wxStreamBase

	Field wxStreamPtr:Byte Ptr
	
	Function _create:wxStreamBase(wxStreamPtr:Byte Ptr)
		If wxStreamPtr Then
			Local this:wxStreamBase = New wxStreamBase
			this.wxStreamPtr = wxStreamPtr
			Return this
		End If
	End Function
	
	Rem
	bbdoc: Returns the length of the stream in bytes.
	about: If the length cannot be determined (this is always the case for socket streams for
	example), returns wxInvalidOffset.
	End Rem
	Method GetLength:Long()
		Local value:Long
		bmx_wxstreambase_getlength(wxStreamPtr, Varptr value)
		Return value
	End Method
	
	Rem
	bbdoc: This method returns the last error.
	End Rem
	Method GetLastError:Int()
		Return bmx_wxstreambase_getlasterror(wxStreamPtr)
	End Method
	
	Rem
	bbdoc: This method returns the size of the stream.
	about: For example, for a file it is the size of the file.
	<p>
	<b>Warning</b> - There are streams which do not have size by definition, such as socket streams.
	In that cases, GetSize returns 0 so you should always test its return value.
	</p>
	End Rem
	Method GetSize:Int()
		Return bmx_wxstreambase_getsize(wxStreamPtr)
	End Method
	
	Rem
	bbdoc: Returns True if no error occurred on the stream.
	End Rem
	Method IsOk:Int()
		Return bmx_wxstreambase_isok(wxStreamPtr)
	End Method
	
	Rem
	bbdoc: Returns True if the streams supports seeking to arbitrary offsets.
	End Rem
	Method IsSeekable:Int()
		Return bmx_wxstreambase_isseekable(wxStreamPtr)
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxInputStream Extends wxStreamBase

	Function _create:wxInputStream(wxStreamPtr:Byte Ptr)
		If wxStreamPtr Then
			Local this:wxInputStream = New wxInputStream
			this.wxStreamPtr = wxStreamPtr
			Return this
		End If
	End Function

	Method CanRead:Int()
		Return bmx_wxinputstream_canread(wxStreamPtr)
	End Method
	
	Method GetC:Int()
	End Method
	
	Method Eof:Int()
		Return bmx_wxinputstream_eof(wxStreamPtr)
	End Method
	
	Method LastRead:Int()
		Return bmx_wxinputstream_lastread(wxStreamPtr)
	End Method
	
	Method Peek:Byte()
	End Method
	
	Method Read:wxInputStream(buffer:Byte Ptr, size:Int)
		bmx_wxinputstream_read(wxStreamPtr, buffer, size)
		Return Self
	End Method
	
	Method SeekI:Int(pos:Int, Mode:Int = wxFromStart)
	End Method
	
	Method TellI:Int()
	End Method

	Method Free()
	End Method

'	Method Delete()
'		If wxStreamPtr Then
'			bmx_wxmaxinputstream_delete(wxStreamPtr)
'			wxStreamPtr = Null
'		End If
'	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxOutputStream Extends wxStreamBase

	Function _create:wxOutputStream(wxStreamPtr:Byte Ptr)
		If wxStreamPtr Then
			Local this:wxOutputStream = New wxOutputStream
			this.wxStreamPtr = wxStreamPtr
			Return this
		End If
	End Function

	Method Close:Int()
		Return bmx_wxoutputstream_close(wxStreamPtr)
	End Method
	
	Method LastWrite:Int()
		Return bmx_wxoutputstream_lastwrite(wxStreamPtr)
	End Method
	
	Method PutC(c:Int)
	End Method
	
	Method SeekO:Int(pos:Int, Mode:Int = wxFromStart)
	End Method
	
	Method TellO:Int()
	End Method
	
	Method Write:wxOutputStream(buffer:Byte Ptr, size:Int)
		bmx_wxoutputstream_write(wxStreamPtr, buffer, size)
		Return Self
	End Method
	
	Method Free()
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxFilterInputStream Extends wxInputStream

	Function _create:wxFilterInputStream(wxStreamPtr:Byte Ptr)
		If wxStreamPtr Then
			Local this:wxFilterInputStream = New wxFilterInputStream
			this.wxStreamPtr = wxStreamPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Frees the stream object.
	End Rem
	Method Free()
		If wxStreamPtr Then
			bmx_wxfilterinputstream_free(wxStreamPtr)
			wxStreamPtr = Null
		End If
	End Method
	
	Method Delete()
		Free()
	End Method

End Type

Rem
bbdoc: 
End Rem
Type wxFilterOutputStream Extends wxOutputStream

End Type

Rem
bbdoc: Represents data written to a file.
about: Note that SeekO() can seek beyond the end of the stream (file) and will thus not return wxInvalidOffset for that.
End Rem
Type wxFileOutputStream Extends wxOutputStream

	Rem
	bbdoc: Creates a new file with @filename name and initializes the stream in write-only mode. 
	End Rem
	Function CreateFileOutputStream:wxFileOutputStream(filename:String)
		Return New wxFileOutputStream.Create(filename)
	End Function
	
	Rem
	bbdoc: Creates a new file with @filename name and initializes the stream in write-only mode. 
	End Rem
	Method Create:wxFileOutputStream(filename:String)
		wxStreamPtr = bmx_wxfileoutputstream_create(filename)
		Return Self
	End Method

	Rem
	bbdoc: Returns true if the stream is initialized and ready.
	End Rem
	Method IsOk:Int()
		Return bmx_wxfileoutputstream_isok(wxStreamPtr)
	End Method
	
	Rem
	bbdoc: Frees the stream object.
	End Rem
	Method Free()
		If wxStreamPtr Then
			bmx_wxfileoutputstream_free(wxStreamPtr)
			wxStreamPtr = Null
		End If
	End Method
	
	Method Delete()
		Free()
	End Method

End Type

Rem
bbdoc: 
End Rem
Type wxFileInputStream Extends wxInputStream

	Rem
	bbdoc: Opens the specified file using its @filename name in read-only mode. 
	End Rem
	Function CreateFileInputStream:wxFileInputStream(filename:String)
		Return New wxFileInputStream.Create(filename)
	End Function
	
	Rem
	bbdoc: Opens the specified file using its @filename name in read-only mode. 
	End Rem
	Method Create:wxFileInputStream(filename:String)
		wxStreamPtr = bmx_wxfileinputstream_create(filename)
		Return Self
	End Method

	Rem
	bbdoc: Returns true if the stream is initialized and ready.
	End Rem
	Method IsOk:Int()
		Return bmx_wxfileinputstream_isok(wxStreamPtr)
	End Method
	
	Rem
	bbdoc: Frees the stream object.
	End Rem
	Method Free()
		If wxStreamPtr Then
			bmx_wxfileinputstream_free(wxStreamPtr)
			wxStreamPtr = Null
		End If
	End Method
	
	Method Delete()
		Free()
	End Method

End Type

Rem
bbdoc: This type provides functions that read text datas using an input stream.
about: So, you can read text floats, integers.
<p>
The wxTextInputStream correctly reads text files (or streams) in DOS, Macintosh and Unix
formats and reports a single newline char as a line ending.
</p>
End Rem
Type wxTextInputStream

	Field wxStreamPtr:Byte Ptr

	Rem
	bbdoc: 
	End Rem
	Function CreateTextInputStream:wxTextInputStream(stream:wxInputStream, separators:String = " ~t")
		Return New wxTextInputStream.Create(stream, separators)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxTextInputStream(stream:wxInputStream, separators:String = " ~t")
		wxStreamPtr = bmx_wxtextinputstream_create(stream.wxStreamPtr, separators)
		Return Self
	End Method

	Rem
	bbdoc: Reads a single unsigned byte from the stream, given in base base.
	about: The value of base must be comprised between 2 and 36, inclusive, or be a
	special value 0 which means that the usual rules of C numbers are applied: if the
	number starts with 0x it is considered to be in base 16, if it starts with 0 - in
	base 8 and in base 10 otherwise. Note that you may not want to specify the base 0
	if you are parsing the numbers which may have leading zeroes as they can yield
	unexpected (to the user not familiar with C) results.
	End Rem
	Method Read8:Int(base:Int = 10)
		Return bmx_wxtextinputstream_read8(wxStreamPtr, base)
	End Method
	
	Rem
	bbdoc: Reads a single signed byte from the stream.
	about: See wxTextInputStream::Read8 for the description of the base parameter.
	End Rem
	Method Read8S:Int(base:Int = 10)
		Return bmx_wxtextinputstream_read8s(wxStreamPtr, base)
	End Method
	
	Rem
	bbdoc: Reads a unsigned 16 bit integer from the stream.
	about: See wxTextInputStream::Read8 for the description of the base parameter.
	End Rem
	Method Read16:Int(base:Int = 10)
		Return bmx_wxtextinputstream_read16(wxStreamPtr, base)
	End Method

	Rem
	bbdoc: Reads a signed 16 bit integer from the stream.
	about: See wxTextInputStream::Read8 for the description of the base parameter.
	End Rem
	Method Read16S:Int(base:Int = 10)
		Return bmx_wxtextinputstream_read16s(wxStreamPtr, base)
	End Method

	Rem
	bbdoc: Reads a 32 bit unsigned integer from the stream.
	about: See wxTextInputStream::Read8 for the description of the base parameter.
	End Rem
	Method Read32:Int(base:Int = 10)
		Return bmx_wxtextinputstream_read32(wxStreamPtr, base)
	End Method

	Rem
	bbdoc: Reads a 32 bit signed integer from the stream.
	about: See wxTextInputStream::Read8 for the description of the base parameter.
	End Rem
	Method Read32S:Int(base:Int = 10)
		Return bmx_wxtextinputstream_read32s(wxStreamPtr, base)
	End Method

	Rem
	bbdoc: Reads a character, returns 0 if there are no more characters in the stream.
	End Rem
	Method GetChar:Int()
		Return bmx_wxtextinputstream_getchar(wxStreamPtr)
	End Method
	
	Rem
	bbdoc: Reads a double (IEEE encoded) from the stream.
	End Rem
	Method ReadDouble:Double()
		Return bmx_wxtextinputstream_readdouble(wxStreamPtr)
	End Method
	
	Rem
	bbdoc: Reads a line from the input stream and returns it (without the end of line character).
	End Rem
	Method ReadLine:String()
		Return bmx_wxtextinputstream_readline(wxStreamPtr)
	End Method
	
	Rem
	bbdoc: Reads a word (a sequence of characters until the next separator) from the input stream.
	End Rem
	Method ReadWord:String()
		Return bmx_wxtextinputstream_readword(wxStreamPtr)
	End Method
	
	Rem
	bbdoc: Sets the characters which are used to define the word boundaries in ReadWord.
	about: The default separators are the space and TAB characters.
	End Rem
	Method SetStringSeparators(separators:String)
		bmx_wxtextinputstream_setstringseparators(wxStreamPtr, separators)
	End Method
	
	Method Free()
		If wxStreamPtr Then
			bmx_wxtextinputstream_delete(wxStreamPtr)
			wxStreamPtr = Null
		End If
	End Method

	Method Delete()
		Free()
	End Method
		
End Type

Rem
bbdoc: This type provides functions that write text datas using an output stream.
about: So, you can write text floats, integers.
End Rem
Type wxTextOutputStream

	Field wxStreamPtr:Byte Ptr

	Rem
	bbdoc: Constructs a text stream object associated to the given output stream.
	End Rem
	Function CreateTextOutputStream:wxTextOutputStream(stream:wxOutputStream, Mode:Int = wxEOL_NATIVE)
		Return New wxTextOutputStream.Create(stream, Mode)
	End Function
	
	Rem
	bbdoc: Constructs a text stream object associated to the given output stream.
	End Rem
	Method Create:wxTextOutputStream(stream:wxOutputStream, Mode:Int = wxEOL_NATIVE)
		wxStreamPtr = bmx_wxtextoutputstream_create(stream.wxStreamPtr, Mode)
		Return Self
	End Method
	
	Rem
	bbdoc: Returns the end-of-line mode.
	about: One of wxEOL_DOS, wxEOL_MAC and wxEOL_UNIX.
	End Rem
	Method GetMode:Int()
		Return bmx_wxtextoutputstream_getmode(wxStreamPtr)
	End Method
	
	Rem
	bbdoc: Set the end-of-line mode.
	about: One of wxEOL_NATIVE, wxEOL_DOS, wxEOL_MAC and wxEOL_UNIX.
	End Rem
	Method SetMode(Mode:Int = wxEOL_NATIVE)
		bmx_wxtextoutputstream_setmode(wxStreamPtr, Mode)
	End Method
	
	Rem
	bbdoc: Writes a single byte to the stream.
	End Rem
	Method Write8(value:Int)
		bmx_wxtextoutputstream_write8(wxStreamPtr, value)
	End Method
	
	Rem
	bbdoc: Writes a 16 bit short to the stream.
	End Rem
	Method Write16(value:Int)
		bmx_wxtextoutputstream_write16(wxStreamPtr, value)
	End Method
	
	Rem
	bbdoc: Writes an integer to the stream.
	End Rem
	Method Write32(value:Int)
		bmx_wxtextoutputstream_write32(wxStreamPtr, value)
	End Method
	
	Rem
	bbdoc: Writes a double to the stream using the IEEE format.
	End Rem
	Method WriteDouble(value:Double)
		bmx_wxtextoutputstream_writedouble(wxStreamPtr, value)
	End Method
	
	Rem
	bbdoc: Writes string as a line.
	about: Depending on the end-of-line mode the end of line ('\n') characters in the string
	are converted to the correct line ending terminator.
	End Rem
	Method WriteString(value:String)
		bmx_wxtextoutputstream_writestring(wxStreamPtr, value)
	End Method

	Method Free()
		If wxStreamPtr Then
			bmx_wxtextoutputstream_delete(wxStreamPtr)
			wxStreamPtr = Null
		End If
	End Method

	Method Delete()
		Free()
	End Method

End Type

Rem
bbdoc: A type for manipulating rectangles.
End Rem
Type wxRect Extends wxObject

	Function _create:wxRect(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxRect = New wxRect
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Rem
	bbdoc: Creates a wxRect object from x, y, width and height values.
	End Rem
	Function CreateRect:wxRect(x:Int, y:Int, width:Int, height:Int)
		Return New wxRect.Create(x, y, width, height)
	End Function
	
	Rem
	bbdoc: Creates a wxRect object from x, y, width and height values.
	End Rem
	Method Create:wxRect(x:Int, y:Int, width:Int, height:Int)
		wxObjectPtr = bmx_wxrect_create(x, y, width, height)
		Return Self
	End Method

	Rem
	bbdoc: Returns the rectangle having the same size as this one but centered relatively to the given rectangle r.
	about: By default, rectangle is centred in both directions but if dir includes only wxVERTICAL or only
	wxHORIZONTAL flag, then it is only centered in this direction while the other component of its position
	remains unchanged.
	End Rem
	Method CentreIn:wxRect(rect:wxRect, dir:Int = wxBOTH)
		Return _create(bmx_wxrect_centrein(wxObjectPtr, rect.wxObjectPtr, dir))
	End Method
	
	Rem
	bbdoc: Returns the rectangle having the same size as this one but centered relatively to the given rectangle r.
	about: By default, rectangle is centred in both directions but if dir includes only wxVERTICAL or only
	wxHORIZONTAL flag, then it is only centered in this direction while the other component of its position
	remains unchanged.
	End Rem
	Method CenterIn:wxRect(rect:wxRect, dir:Int = wxBOTH)
		Return _create(bmx_wxrect_centerin(wxObjectPtr, rect.wxObjectPtr, dir))
	End Method
	
	Rem
	bbdoc: Returns true if the given point is inside the rectangle (or on its boundary) and false otherwise.
	End Rem
	Method Contains:Int(x:Int, y:Int)
		Return bmx_wxrect_contains(wxObjectPtr, x, y)
	End Method

	Rem
	bbdoc: Returns true if the given rectangle is completely inside this rectangle (or touches its boundary) and false otherwise.
	End Rem
	Method ContainsRect:Int(rect:wxRect)
		Return bmx_wxrect_containsrect(wxObjectPtr, rect.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Decrease the rectangle size.
	about: This method is the opposite from Inflate: Deflate(a, b) is equivalent to Inflate(-a, -b). Please
	refer to Inflate for full description.
	End Rem
	Method Deflate(dx:Int, dy:Int)
		bmx_wxrect_deflate(wxObjectPtr, dx, dy)
	End Method
	
	Rem
	bbdoc: Gets the bottom point of the rectangle.
	End Rem
	Method GetBottom:Int()
		Return bmx_wxrect_getbottom(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the height member.
	End Rem
	Method GetHeight:Int()
		Return bmx_wxrect_getheight(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the left point of the rectangle (the same as wxRect::GetX).
	End Rem
	Method GetLeft:Int()
		Return bmx_wxrect_getleft(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the position.
	End Rem
	Method GetPosition(x:Int Var, y:Int Var)
		bmx_wxrect_getposition(wxObjectPtr, Varptr x, Varptr y)
	End Method
	
	Rem
	bbdoc: Gets the position of the top left corner of the rectangle, same as GetPosition.
	End Rem
	Method GetTopLeft(x:Int Var, y:Int Var)
		bmx_wxrect_gettopleft(wxObjectPtr, Varptr x, Varptr y)
	End Method
	
	Rem
	bbdoc: Gets the position of the top right corner.
	End Rem
	Method GetTopRight(x:Int Var, y:Int Var)
		bmx_wxrect_gettopright(wxObjectPtr, Varptr x, Varptr y)
	End Method
	
	Rem
	bbdoc: Gets the position of the bottom left corner.
	End Rem
	Method GetBottomLeft(x:Int Var, y:Int Var)
		bmx_wxrect_getbottomleft(wxObjectPtr, Varptr x, Varptr y)
	End Method
	
	Rem
	bbdoc: Gets the position of the bottom right corner.
	End Rem
	Method GetBottomRight(x:Int Var, y:Int Var)
		bmx_wxrect_getbottomright(wxObjectPtr, Varptr x, Varptr y)
	End Method
	
	Rem
	bbdoc: Gets the right point of the rectangle.
	End Rem
	Method GetRight:Int()
		Return bmx_wxrect_getright(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the size.
	End Rem
	Method GetSize(w:Int Var, h:Int Var)
		bmx_wxrect_getsize(wxObjectPtr, Varptr w, Varptr h)
	End Method
	
	Rem
	bbdoc: Gets the top point of the rectangle (the same as wxRect::GetY).
	End Rem
	Method GetTop:Int()
		Return bmx_wxrect_gettop(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the width member.
	End Rem
	Method GetWidth:Int()
		Return bmx_wxrect_getwidth(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the x member.
	End Rem
	Method GetX:Int()
		Return bmx_wxrect_getx(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Gets the y member.
	End Rem
	Method GetY:Int()
		Return bmx_wxrect_gety(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Increases the size of the rectangle.
	about: The left border is moved farther left and the right border is moved farther right by dx. The upper
	border is moved farther up and the bottom border is moved farther down by dy. (Note the the width and height
	of the rectangle thus change by 2*dx and 2*dy, respectively.) If one or both of dx and dy are negative, the
	opposite happens: the rectangle size decreases in the respective direction.
	<p>
	Inflating and deflating behaves "naturally''. Defined more precisely, that means: 
	<ol>
	<li>"Real'' inflates (that is, dx and/or dy &gt;= 0) are not constrained. Thus inflating a rectangle can cause
	its upper left corner to move into the negative numbers. (the versions prior to 2.5.4 forced the top left
	coordinate to not fall below (0, 0), which implied a forced move of the rectangle.)</li>
	<li>Deflates are clamped to not reduce the width or height of the rectangle below zero. In such cases, the
	top-left corner is nonetheless handled properly. For example, a rectangle at (10, 10) with size (20, 40)
	that is inflated by (-15, -15) will become located at (20, 25) at size (0, 10). Finally, observe that the
	width and height are treated independently. In the above example, the width is reduced by 20, whereas the
	height is reduced by the full 30 (rather than also stopping at 20, when the width reached zero). </li>
	</ol>
	</p>
	End Rem
	Method Inflate(dx:Int, dy:Int)
		bmx_wxrect_inflate(wxObjectPtr, dx, dy)
	End Method
	
	Rem
	bbdoc: Returns true if this rectangle has a non-empty intersection with the rectangle rect and false otherwise.
	End Rem
	Method Intersects:Int(rect:wxRect)
		Return bmx_wxrect_intersects(wxObjectPtr, rect.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Returns true if this rectangle has a width or height less than or equal to 0 and false otherwise.
	End Rem
	Method IsEmpty:Int()
		Return bmx_wxrect_isempty(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Moves the rectangle by the specified offset.
	about: If dx is positive, the rectangle is moved to the right, if dy is positive, it is moved to the bottom,
	otherwise it is moved to the left or top respectively.
	End Rem
	Method Offset(dx:Int, dy:Int)
		bmx_wxrect_offset(wxObjectPtr, dx, dy)
	End Method
	
	Rem
	bbdoc: Sets the height.
	End Rem
	Method SetHeight(height:Int)
		bmx_wxrect_setheight(wxObjectPtr, height)
	End Method
	
	Rem
	bbdoc: Sets the size.
	End Rem
	Method SetSize(w:Int, h:Int)
		bmx_wxrect_setsize(wxObjectPtr, w, h)
	End Method
	
	Rem
	bbdoc: Sets the width.
	End Rem
	Method SetWidth(width:Int)
		bmx_wxrect_setwidth(wxObjectPtr, width)
	End Method
	
	Rem
	bbdoc: Sets the x position.
	End Rem
	Method SetX(x:Int)
		bmx_wxrect_setx(wxObjectPtr, x)
	End Method
	
	Rem
	bbdoc: Sets the y position.
	End Rem
	Method SetY(y:Int)
		bmx_wxrect_sety(wxObjectPtr, y)
	End Method
	
	Rem
	bbdoc: Returns a new rectangle containing the bounding box of this rectangle and the one passed in as parameter.
	End Rem
	Method Union:wxRect(rect:wxRect)
		Return _create(bmx_wxrect_union(wxObjectPtr, rect.wxObjectPtr))
	End Method
	
	Method Delete()
		If wxObjectPtr Then
			bmx_wxrect_delete(wxObjectPtr)
			wxObjectPtr = Null
		End If
	End Method
	
End Type

Rem
bbdoc: Returns the string containing the description of the current platform in a user-readable form.
about: For example, this function may return strings like Windows NT Version 4.0 or Linux 2.2.2 i386.
End Rem
Function wxGetOsDescription:String()
	Return bmx_wxgetosdescription()
End Function

Rem
bbdoc: Gets the users email address by concatenating the values returned by wxGetFullHostName and wxGetUserId.
End Rem
Function wxGetEmailAddress:String()
	Return bmx_wxgetemailaddress()
End Function

Rem
bbdoc: Returns the amount of free memory in bytes under environments which support it, and -1 if not supported or failed to perform measurement.
End Rem
Function wxGetFreeMemory:Long()
	Local mem:Long
	bmx_wxgetfreememory(Varptr mem)
	Return mem
End Function

Rem
bbdoc: Returns the amount of free memory in bytes under environments which support it, and -1 if not supported or failed to perform measurement.
End Rem
Function wxGetFullHostName:String()
	Return bmx_wxgetfullhostname()
End Function

Rem
bbdoc: Return the (current) user's home directory.
End Rem
Function wxGetHomeDir:String()
	Return bmx_wxgethomedir()
End Function

Rem
bbdoc: Returns the hostname if successful or an empty string otherwise.
End Rem
Function wxGetHostName:String()
	Return bmx_wxgethostname()
End Function

Rem
bbdoc: Gets the version and the operating system ID for currently running OS.
about: See wxPlatformInfo for more details about the returned Id.
End Rem
Function wxGetOsVersion:Int(major:Int Var, minor:Int Var)
	Return bmx_wxgetosversion(Varptr major, Varptr minor)
End Function

Rem
bbdoc: Returns true if the current platform is little endian (instead of big endian).
about: The check is performed at run-time.
End Rem
Function wxIsPlatformLittleEndian:Int()
	Return bmx_wxisplatformlittleendian()
End Function

Rem
bbdoc: Returns true if the operating system the program is running under is 64 bit.
about: The check is performed at run-time and may differ from the value available at compile-time (at compile-time
you can just check if sizeof(void*)==8) since the program could be running in emulation mode or in a mixed 32/64 bit
system (bi-architecture operating system).
<p>
Very important: this function is not 100% reliable on some systems given the fact that there isn't always a
standard way to do a reliable check on the OS architecture.
</p>
End Rem
Function wxIsPlatform64Bit:Int()
	Return bmx_wxisplatform64bit()
End Function

Rem
bbdoc: Returns the home directory for the given user.
about: If the username is empty (default value), this function behaves like wxGetHomeDir.
End Rem
Function wxGetUserHome:String(user:String = "")
	Return bmx_wxgetuserhome(user)
End Function

Rem
bbdoc: This function returns the "user id" also known as "login name" under Unix i.e. something like "jsmith".
about: It uniquely identifies the current user (on this system).
End Rem
Function wxGetUserId:String()
	Return bmx_wxgetuserid()
End Function

Rem
bbdoc: This function returns the full user name (something like "Mr. John Smith").
End Rem
Function wxGetUserName:String()
	Return bmx_wxgetusername()
End Function

Rem
bbdoc: Initializes all available image handlers.
about: For a list of available handlers, see wxImage.
End Rem
Function wxInitAllImageHandlers()
	bmx_wxinitallimagehandlers()
End Function

Rem
bbdoc: Open the url in user's default browser.
returns: True if the application was successfully launched.
about: If flags parameter contains wxBROWSER_NEW_WINDOW flag, a new window is opened for the URL
(currently this is only supported under Windows).
<p>
Note that for some configurations of the running user, the application which is launched to open the given
URL may be URL-dependent (e.g. a browser may be used for local URLs while another one may be used for
remote URLs).
</p>
End Rem
Function wxLaunchDefaultBrowser:Int(url:String, flags:Int = 0)
	Return bmx_wxlaunchdefaultbrowser(url, flags)
End Function

Rem
bbdoc: Returns the dimensions of the work area on the display.
about: On Windows this means the area not covered by the taskbar, etc. Other platforms are currently defaulting
to the whole display until a way is found to provide this info for all window managers, etc.
End Rem
Function wxGetClientDisplayRect:wxRect()
	Return wxRect._create(bmx_gdi_wxgetclientdisplayrect())
End Function

Rem
bbdoc: Generates an integer identifier unique to this run of the program.
End Rem
Function wxNewId:Int()
	Return bmx_wxnewid()
End Function

Rem
bbdoc: Ensures that ids subsequently generated by NewId do not clash with the given id.
End Rem
Function wxRegisterId(id:Int)
	bmx_wxregisterid(id)
End Function

Rem
bbdoc: This function enables or disables all top level windows.
about: It is used by wxSafeYield.
End Rem
Function wxEnableTopLevelWindows(enable:Int = True)
	bmx_wxenabletoplevelwindows(enable)
End Function

Rem
bbdoc: Returns the mouse position in screen coordinates.
End Rem
Function wxGetMousePosition(x:Int Var, y:Int Var)
	bmx_wxgetmouseposition(Varptr x, Varptr y)
End Function

Rem
bbdoc: Gets the time in milliseconds since the last ::wxStartTimer.
about: If resetTimer is true (the default), the timer is reset to zero by this call.
<p>
See also wxTimer.
</p>
End Rem
'Function wxGetElapsedTime:Int(resetTimer:Int = True)
'	Return bmx_wxgetelapsedtime(resetTimer)
'End Function

Rem
bbdoc: Returns the number of seconds since local time 00:00:00 Jan 1st 1970.
End Rem
Function wxGetLocalTime:Int()
	Return bmx_wxgetlocaltime()
End Function

Rem
bbdoc: Returns the number of milliseconds since local time 00:00:00 Jan 1st 1970.
End Rem
Function wxGetLocalTimeMillis:Long()
	Local time:Long
	bmx_wxgetlocaltimemillis(Varptr time)
	Return time
End Function

Rem
bbdoc: Returns the number of seconds since GMT 00:00:00 Jan 1st 1970.
End Rem
Function wxGetUTCTime:Int()
	Return bmx_wxgetutctime()
End Function

Rem
bbdoc: Sleeps for the specified number of microseconds.
about: The microsecond resolution may not, in fact, be available on all platforms (currently only Unix platforms
with nanosleep(2) may provide it) in which case this is the same as wxMilliSleep(microseconds/1000).
End Rem
Function wxMicroSleep(microseconds:Int)
	bmx_wxmicrosleep(microseconds)
End Function

Rem
bbdoc: Sleeps for the specified number of milliseconds.
about: Notice that usage of this function is encouraged instead of calling usleep(3) directly because the standard
usleep() function is not MT safe.
End Rem
Function wxMilliSleep(milliseconds:Int)
	bmx_wxmillisleep(milliseconds)
End Function

Rem
bbdoc: Returns a string representing the current date and time.
End Rem
Function wxNow:String()
	Return bmx_wxnow()
End Function

Rem
bbdoc: Sleeps for the specified number of seconds.
End Rem
Function wxSleep(secs:Int)
	bmx_wxsleep(secs)
End Function

Rem
bbdoc: Calls wxAppConsole::Yield
End Rem
Function wxYield:Int()
	Return bmx_wxyield()
End Function

Rem
bbdoc: Ring the system bell.
End Rem
Function wxBell()
	bmx_wxbell()
End Function

Rem
bbdoc: Starts a stopwatch
about: Use ::wxGetElapsedTime to get the elapsed time.
<p>
See also wxTimer.
</p>
End Rem
'Function wxStartTimer()
'	bmx_wxstarttimer()
'End Function

Rem
bbdoc: 
End Rem
Function wxIsalnum:Int(keycode:Int)
	Return bmx_wxisalnum(keycode)
End Function

Function wxIsprint:Int(keycode:Int)
	Return bmx_wxisprint(keycode)
End Function

Type TCoreEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
	
		' TODO: determine the correct event, and return that type....
		Select evt.eventType
			Case wxEVT_COMMAND_MENU_SELECTED, ..
					wxEVT_COMMAND_SCROLLBAR_UPDATED, ..
					wxEVT_COMMAND_SLIDER_UPDATED, ..
					wxEVT_COMMAND_ENTER
				Return wxCommandEvent.Create(wxEventPtr, evt)
			Case wxEVT_MOVE
				Return wxMoveEvent.Create(wxEventPtr, evt)
			Case wxEVT_PAINT
				Return wxPaintEvent.Create(wxEventPtr, evt)
			Case wxEVT_SIZE
				Return wxSizeEvent.Create(wxEventPtr, evt)
			Case wxEVT_SCROLLWIN_TOP, ..
					wxEVT_SCROLLWIN_BOTTOM, ..
					wxEVT_SCROLLWIN_LINEUP, ..
					wxEVT_SCROLLWIN_LINEDOWN, ..
					wxEVT_SCROLLWIN_PAGEUP, ..
					wxEVT_SCROLLWIN_PAGEDOWN, ..
					wxEVT_SCROLLWIN_THUMBTRACK, ..
					wxEVT_SCROLLWIN_THUMBRELEASE
				Return wxScrollWinEvent.Create(wxEventPtr, evt)
			Case wxEVT_SCROLL_TOP, ..
					wxEVT_SCROLL_BOTTOM, ..
					wxEVT_SCROLL_LINEUP, ..
					wxEVT_SCROLL_LINEDOWN, ..
					wxEVT_SCROLL_PAGEUP, ..
					wxEVT_SCROLL_PAGEDOWN, ..
					wxEVT_SCROLL_THUMBTRACK, ..
					wxEVT_SCROLL_THUMBRELEASE, ..
					wxEVT_SCROLL_CHANGED
				Return wxScrollEvent.Create(wxEventPtr, evt)
			Case wxEVT_CONTEXT_MENU
				Return wxContextMenuEvent.Create(wxEventPtr, evt)
			Case wxEVT_CHAR, ..
					wxEVT_KEY_DOWN, ..
					wxEVT_KEY_UP
				Return wxKeyEvent.Create(wxEventPtr, evt)
			Case wxEVT_INIT_DIALOG
				Return wxInitDialogEvent.Create(wxEventPtr, evt)
			Case wxEVT_ACTIVATE_APP, ..
					wxEVT_ACTIVATE
				Return wxActivateEvent.Create(wxEventPtr, evt)
			Case wxEVT_ICONIZE
				Return wxIconizeEvent.Create(wxEventPtr, evt)
			Case wxEVT_POWER_SUSPENDING, ..
					wxEVT_POWER_SUSPENDED, ..
					wxEVT_POWER_SUSPEND_CANCEL, ..
					wxEVT_POWER_RESUME
				Return wxPowerEvent.Create(wxEventPtr, evt)


		End Select
		
		Return Null
	End Method
	
	Method GetEventType:Int(eventType:Int)
		Select eventType
			Case wxEVT_COMMAND_MENU_SELECTED, ..
					wxEVT_COMMAND_SCROLLBAR_UPDATED, ..
					wxEVT_COMMAND_SLIDER_UPDATED, ..
					wxEVT_COMMAND_ENTER, ..
					wxEVT_MOVE, ..
					wxEVT_PAINT, ..
					wxEVT_SIZE, ..
					wxEVT_SCROLLWIN_TOP, ..
					wxEVT_SCROLLWIN_BOTTOM, ..
					wxEVT_SCROLLWIN_LINEUP, ..
					wxEVT_SCROLLWIN_LINEDOWN, ..
					wxEVT_SCROLLWIN_PAGEUP, ..
					wxEVT_SCROLLWIN_PAGEDOWN, ..
					wxEVT_SCROLLWIN_THUMBTRACK, ..
					wxEVT_SCROLLWIN_THUMBRELEASE, ..
					wxEVT_SCROLL_TOP, ..
					wxEVT_SCROLL_BOTTOM, ..
					wxEVT_SCROLL_LINEUP, ..
					wxEVT_SCROLL_LINEDOWN, ..
					wxEVT_SCROLL_PAGEUP, ..
					wxEVT_SCROLL_PAGEDOWN, ..
					wxEVT_SCROLL_THUMBTRACK, ..
					wxEVT_SCROLL_THUMBRELEASE, ..
					wxEVT_SCROLL_CHANGED, ..
					wxEVT_CONTEXT_MENU, ..
					wxEVT_CHAR, ..
					wxEVT_KEY_DOWN, ..
					wxEVT_KEY_UP, ..
					wxEVT_INIT_DIALOG, ..
					wxEVT_ACTIVATE_APP, ..
					wxEVT_ACTIVATE, ..
					wxEVT_ICONIZE, ..
					wxEVT_POWER_SUSPENDING, ..
					wxEVT_POWER_SUSPENDED, ..
					wxEVT_POWER_SUSPEND_CANCEL, ..
					wxEVT_POWER_RESUME
				Return bmx_eventtype_value(eventType)
		End Select
	End Method
	
End Type

New TCoreEventFactory


Type TCustomEventFactory Extends TEventFactory

	Method CreateEvent:wxEvent(wxEventPtr:Byte Ptr, evt:TEventHandler)
		Return Null
	End Method
	
	Method GetEventType:Int(eventType:Int)
		If eventType >= wxEVT_USER_FIRST Then
			Return _GetCustomEventType(eventType)
		End If
	End Method
	
End Type
