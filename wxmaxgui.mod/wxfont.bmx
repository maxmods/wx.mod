' Copyright (c) 2013-2015 Bruce A Henderson
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


Import "wxcommon.bmx"

Type TwxGuiFont Extends TGuiFont

	Field font:wxFont
	'Field metrics:QFontMetrics
	
	Method Create:TwxGuiFont(font:wxFont)
		Self.font = font
		
		name = font.GetFaceName()
		style = styleFromFont(font)
		size = font.GetPointSize()
		
		If size = -1 Then
			size = font.GetPointSize()
		End If
		
		Return Self
	End Method

	Method CharWidth:Int(charcode:Int)
		' TODO : perhaps use a wxMemoryDC and font extents to calculate this.
	

		'If Not metrics Then
		'	metrics = New QFontMetrics.Create(font)
		'End If
		
		'Return metrics.width(Chr(charcode))
	End Method

	Function styleFromFont:Int(font:wxFont)
		Local style:Int = FONT_NORMAL
		
		If font.GetWeight() >= wxFONTWEIGHT_BOLD Then
			style :| FONT_BOLD
		End If

		If font.GetStyle() <> wxFONTSTYLE_NORMAL Then
			style :| FONT_ITALIC
		End If

		If font.GetUnderlined() Then
			style :| FONT_UNDERLINE
		End If

		If font.GetStrikethrough() Then
			style :| FONT_STRIKETHROUGH
		End If
		
		Return style
	End Function
	
End Type


