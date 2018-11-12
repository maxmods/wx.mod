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

Module wx.wxFontMetrics

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
bbdoc: Font metrics.
End Rem
Type wxFontMetrics

	Field metricsPtr:Byte Ptr

	Function _create:wxFontMetrics(metricsPtr:Byte Ptr)
		If metricsPtr Then
			Local this:wxFontMetrics = New wxFontMetrics
			this.metricsPtr = metricsPtr
			Return this
		End If
	End Function

	Rem
	bbdoc: Returns the total character height.
	End Rem
	Method GetHeight:Int()
		Return bmx_wxfontmetrics_getheight(metricsPtr)
	End Method
	
	Rem
	bbdoc: Gets the part of the height above the baseline.
	End Rem
	Method GetAscent:Int()
		Return bmx_wxfontmetrics_getascent(metricsPtr)
	End Method
	
	Rem
	bbdoc: Gets the part of the height below the baseline.
	End Rem
	Method GetDescent:Int()
		Return bmx_wxfontmetrics_getdescent(metricsPtr)
	End Method
	
	Rem
	bbdoc: Gets the intra-line spacing
	End Rem
	Method GetInternalLeading:Int()
		Return bmx_wxfontmetrics_getinternalleading(metricsPtr)
	End Method
	
	Rem
	bbdoc: Gets the inter-line spacing.
	End Rem
	Method GetExternalLeading:Int()
		Return bmx_wxfontmetrics_getexternalleading(metricsPtr)
	End Method
	
	Rem
	bbdoc: Gets the average font width, a.k.a. "x-width".
	End Rem
	Method GetAverageWidth:Int()
		Return bmx_wxfontmetrics_getaveragewidth(metricsPtr)
	End Method

	Method Delete()
		If metricsPtr Then
			bmx_wxfontmetrics_free(metricsPtr)
			metricsPtr = Null
		End If
	End Method

End Type
