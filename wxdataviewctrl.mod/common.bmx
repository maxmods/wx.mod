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

Import wx.wx
Import wx.wxControl
Import wx.wxDataViewModel
Import BRL.Blitz


' headers :-)
?linux
Import "../lib/linux/wx/include/gtk2-unicode-release-static/*.h"
Import "../include/*.h"
?win32
Import "../lib/win32/mswu/*.h"
Import "../include/*.h"
?macosppc
Import "../lib/macosppc/wx/include/mac-unicode-release-static/*.h"
Import "../include/*.h"
?macosx86
Import "../lib/macosx86/wx/include/mac-unicode-release-static/*.h"
Import "../include/*.h"
?

Import "glue.cpp"

Extern

End Extern

Rem
bbdoc: Single selection mode.
about: This is the default.
End Rem
Const wxDV_SINGLE:Int = $0000
Rem
bbdoc: Multiple selection mode.
End Rem
Const wxDV_MULTIPLE:Int = $0001
Rem
bbdoc: Do not show column headers (which are shown by default).
End Rem
Const wxDV_NO_HEADER:Int = $0002
Rem
bbdoc: Display the separator lines between rows.
End Rem
Const wxDV_HORIZ_RULES:Int = $0004
Rem
bbdoc: Display the separator lines between columns.
End Rem
Const wxDV_VERT_RULES:Int = $0008
Rem
bbdoc: Use alternating colours for rows if supported by platform and theme.
about: Currently only supported by the native GTK and OS X implementations but not by the generic one.
End Rem
Const wxDV_ROW_LINES:Int = $0010
Rem
bbdoc: Allow variable line heights.
about: This can be inefficient when displaying large number of items.
End Rem
Const wxDV_VARIABLE_LINE_HEIGHT:Int = $0020


