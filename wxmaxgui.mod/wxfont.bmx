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


