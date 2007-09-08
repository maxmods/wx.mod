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

Import "core.bmx"

Function wxBLACK:wxColour()
	Return wxColour._create(bmx_wxstockgdi_colour_black())
End Function

Function wxBLUE:wxColour()
	Return wxColour._create(bmx_wxstockgdi_colour_blue())
End Function

Function wxCYAN:wxColour()
	Return wxColour._create(bmx_wxstockgdi_colour_cyan())
End Function

Function wxGREEN:wxColour()
	Return wxColour._create(bmx_wxstockgdi_colour_green())
End Function

Function wxLIGHT_GREY:wxColour()
	Return wxColour._create(bmx_wxstockgdi_colour_lightgrey())
End Function

Function wxRED:wxColour()
	Return wxColour._create(bmx_wxstockgdi_colour_red())
End Function

Function wxWHITE:wxColour()
	Return wxColour._create(bmx_wxstockgdi_colour_white())
End Function

Function wxITALIC_FONT:wxFont()
	Return wxFont._create(bmx_wxstockgdi_font_italic())
End Function

Function wxNORMAL_FONT:wxFont()
	Return wxFont._create(bmx_wxstockgdi_font_normal())
End Function

Function wxSMALL_FONT:wxFont()
	Return wxFont._create(bmx_wxstockgdi_font_small())
End Function

Function wxSWISS_FONT:wxFont()
	Return wxFont._create(bmx_wxstockgdi_font_swiss())
End Function


Function wxBLACK_DASHED_PEN:wxPen()
	Return wxPen._create(bmx_wxstockgdi_pen_blackdashed())
End Function

Function wxBLACK_PEN:wxPen()
	Return wxPen._create(bmx_wxstockgdi_pen_black())
End Function

Function wxCYAN_PEN:wxPen()
	Return wxPen._create(bmx_wxstockgdi_pen_cyan())
End Function

Function wxGREEN_PEN:wxPen()
	Return wxPen._create(bmx_wxstockgdi_pen_green())
End Function

Function wxGREY_PEN:wxPen()
	Return wxPen._create(bmx_wxstockgdi_pen_grey())
End Function

Function wxLIGHT_GREY_PEN:wxPen()
	Return wxPen._create(bmx_wxstockgdi_pen_lightgrey())
End Function

Function wxMEDIUM_GREY_PEN:wxPen()
	Return wxPen._create(bmx_wxstockgdi_pen_mediumgrey())
End Function

Function wxRED_PEN :wxPen()
	Return wxPen._create(bmx_wxstockgdi_pen_red())
End Function

Function wxTRANSPARENT_PEN:wxPen()
	Return wxPen._create(bmx_wxstockgdi_pen_transparent())
End Function

Function wxWHITE_PEN:wxPen()
	Return wxPen._create(bmx_wxstockgdi_pen_white())
End Function

Function wxBLACK_BRUSH:wxBrush()
	Return wxBrush._create(bmx_wxstockgdi_brush_black())
End Function

Function wxBLUE_BRUSH:wxBrush()
	Return wxBrush._create(bmx_wxstockgdi_brush_blue())
End Function

Function wxCYAN_BRUSH:wxBrush()
	Return wxBrush._create(bmx_wxstockgdi_brush_cyan())
End Function

Function wxGREEN_BRUSH:wxBrush()
	Return wxBrush._create(bmx_wxstockgdi_brush_green())
End Function

Function wxGREY_BRUSH:wxBrush()
	Return wxBrush._create(bmx_wxstockgdi_brush_grey())
End Function

Function wxLIGHT_GREY_BRUSH:wxBrush()
	Return wxBrush._create(bmx_wxstockgdi_brush_lightgrey())
End Function

Function wxMEDIUM_GREY_BRUSH:wxBrush()
	Return wxBrush._create(bmx_wxstockgdi_brush_mediumgrey())
End Function

Function wxRED_BRUSH:wxBrush()
	Return wxBrush._create(bmx_wxstockgdi_brush_red())
End Function

Function wxTRANSPARENT_BRUSH:wxBrush()
	Return wxBrush._create(bmx_wxstockgdi_brush_transparent())
End Function

Function wxWHITE_BRUSH:wxBrush()
	Return wxBrush._create(bmx_wxstockgdi_brush_white())
End Function

