' Copyright (c) 2007,2008 Bruce A Henderson
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
Import wx.wxPrintData
Import wx.wxImage
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

Import "include/*.h"

Import "src/pdfannotation.cpp"
Import "src/pdfbarcode.cpp"
Import "src/pdfcolor.cpp"
Import "src/pdfdecode.cpp"
Import "src/pdfdoc.cpp"
Import "src/pdfencrypt.cpp"
Import "src/pdffont.cpp"
Import "src/pdfform.cpp"
Import "src/pdfgraphics.cpp"
Import "src/pdfimage.cpp"
Import "src/pdfkernel.cpp"
Import "src/pdfobjects.cpp"
Import "src/pdfparser.cpp"
Import "src/pdfrijndael.cpp"
Import "src/pdftemplate.cpp"
Import "src/pdftruetype.cpp"
Import "src/pdfxml.cpp"


Import "glue.cpp"

Extern

	Function bmx_wxpdfdocument_free(handle:Byte Ptr)


	Function bmx_wxpdfdocument_create:Byte Ptr(handle:Object, orientation:Int, unit:String, format:Int)
	Function bmx_wxpdfdocument_addpage(handle:Byte Ptr, orientation:Int)
	Function bmx_wxpdfdocument_setfont(handle:Byte Ptr, family:String, style:String, size:Double)
	Function bmx_wxpdfdocument_cell(handle:Byte Ptr, w:Double, h:Double, txt:String, border:Int, ln:Int, align:Int, fill:Int, link:Byte Ptr)
	Function bmx_wxpdfdocument_saveasfile(handle:Byte Ptr, name:String)

	Function bmx_wxpdfdocument_addspotcolor(handle:Byte Ptr, name:String, cyan:Double, magenta:Double, yellow:Double, black:Double)
	Function bmx_wxpdfdocument_aliasnbpages(handle:Byte Ptr, _alias:String)
	Function bmx_wxpdfdocument_arrow(handle:Byte Ptr, x1:Double, y1:Double, x2:Double, y2:Double, lineWidth:Double, height:Double, width:Double)
	Function bmx_wxpdfdocument_circle(handle:Byte Ptr, x0:Double, y0:Double, r:Double, astart:Double, afinish:Double, style:Int, nSeg:Int)
	Function bmx_wxpdfdocument_curve(handle:Byte Ptr, x0:Double, y0:Double, x1:Double, y1:Double, x2:Double, y2:Double, x3:Double, y3:Double, style:Int)
	Function bmx_wxpdfdocument_ellipse(handle:Byte Ptr, x0:Double, y0:Double, rx:Double, ry:Double, angle:Double, astart:Double, afinish:Double, style:Int, nSeg:Int)
	Function bmx_wxpdfdocument_image:Int(handle:Byte Ptr, file:String, x:Double, y:Double, w:Double, h:Double, mimeType:String, link:Byte Ptr, maskImage:Int)
	Function bmx_wxpdfdocument_ln(handle:Byte Ptr, h:Double)
	Function bmx_wxpdfdocument_sety(handle:Byte Ptr, y:Double)
	Function bmx_wxpdfdocument_pageno:Int(handle:Byte Ptr)

	Function bmx_wxpdfdocument_setx(handle:Byte Ptr, x:Double)
	Function bmx_wxpdfdocument_settitle(handle:Byte Ptr, title:String)
	Function bmx_wxpdfdocument_setdrawcolor(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxpdfdocument_setfillcolor(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxpdfdocument_settextcolor(handle:Byte Ptr, colour:Byte Ptr)
	Function bmx_wxpdfdocument_getstringwidth:Double(handle:Byte Ptr, text:String)
	Function bmx_wxpdfdocument_setlinewidth(handle:Byte Ptr, width:Double)
	Function bmx_wxpdfdocument_setauthor(handle:Byte Ptr, author:String)
	Function bmx_wxpdfdocument_settextcolorgrayscale(handle:Byte Ptr, grayscale:Int)
	Function bmx_wxpdfdocument_multicell:Int(handle:Byte Ptr, w:Double, h:Double, txt:String, border:Int, align:Int, fill:Int, maxline:Int)

	Function bmx_wxpdfdocument_acceptpagebreak:Int(handle:Byte Ptr)

	Function bmx_wxpdfdocument_addfont:Int(handle:Byte Ptr, family:String, style:String, file:String)
	Function bmx_wxpdfdocument_addfontcjk:Int(handle:Byte Ptr, family:String)
	Function bmx_wxpdfdocument_addlink:Int(handle:Byte Ptr)
	Function bmx_wxpdfdocument_annotate(handle:Byte Ptr, x:Double, y:Double, text:String)
	Function bmx_wxpdfdocument_appendjavascript(handle:Byte Ptr, javascript:String)
	Function bmx_wxpdfdocument_axialgradient:Int(handle:Byte Ptr, col1:Byte Ptr, col2:Byte Ptr, x1:Double, y1:Double, x2:Double, y2:Double, intexp:Double)
	Function bmx_wxpdfdocument_begintemplate:Int(handle:Byte Ptr, x:Double, y:Double, width:Double, height:Double)
	Function bmx_wxpdfdocument_bookmark(handle:Byte Ptr, txt:String, level:Int, y:Double)
	Function bmx_wxpdfdocument_setimagescale(handle:Byte Ptr, scale:Double)
	Function bmx_wxpdfdocument_setkeywords(handle:Byte Ptr, keywords:String)
	Function bmx_wxpdfdocument_setleftmargin(handle:Byte Ptr, margin:Double)
	Function bmx_wxpdfdocument_setlineheight(handle:Byte Ptr, height:Double)
	Function bmx_wxpdfdocument_setlinestyle(handle:Byte Ptr, style:Byte Ptr)
	Function bmx_wxpdfdocument_gettopmargin:Double(handle:Byte Ptr)
	Function bmx_wxpdfdocument_getx:Double(handle:Byte Ptr)
	Function bmx_wxpdfdocument_gety:Double(handle:Byte Ptr)
	Function bmx_wxpdfdocument_getbreakmargin:Double(handle:Byte Ptr)
	Function bmx_wxpdfdocument_getcellmargin:Double(handle:Byte Ptr)
	Function bmx_wxpdfdocument_getfontfamily:String(handle:Byte Ptr)
	Function bmx_wxpdfdocument_getfontpath:String(handle:Byte Ptr)
	Function bmx_wxpdfdocument_getfontsize:Double(handle:Byte Ptr)
	Function bmx_wxpdfdocument_getfontstyle:String(handle:Byte Ptr)
	Function bmx_wxpdfdocument_getfontsubsetting:Int(handle:Byte Ptr)
	Function bmx_wxpdfdocument_getimagescale:Double(handle:Byte Ptr)
	Function bmx_wxpdfdocument_getleftmargin:Double(handle:Byte Ptr)
	Function bmx_wxpdfdocument_getlineheight:Double(handle:Byte Ptr)
	Function bmx_wxpdfdocument_getlinewidth:Double(handle:Byte Ptr)

	Function bmx_wxpdfdocument_writexml(handle:Byte Ptr, txt:String)

	Function bmx_wxpdfdocument_translate(handle:Byte Ptr, tx:Double, ty:Double)
	Function bmx_wxpdfdocument_translatex(handle:Byte Ptr, tx:Double)
	Function bmx_wxpdfdocument_translatey(handle:Byte Ptr, ty:Double)
	Function bmx_wxpdfdocument_unsetclipping(handle:Byte Ptr)
	Function bmx_wxpdfdocument_usetemplate(handle:Byte Ptr, templateId:Int, x:Double, y:Double, width:Double, height:Double)
	Function bmx_wxpdfdocument_write(handle:Byte Ptr, h:Double, txt:String, link:Byte Ptr)
	Function bmx_wxpdfdocument_writecell(handle:Byte Ptr, h:Double, txt:String, border:Int, fill:Int, link:Byte Ptr)
	Function bmx_wxpdfdocument_textfield(handle:Byte Ptr, name:String, width:Double, height:Double, value:String, multiline:Int)
	Function bmx_wxpdfdocument_textfieldxy(handle:Byte Ptr, name:String, x:Double, y:Double, width:Double, height:Double, value:String, multiline:Int)
	Function bmx_wxpdfdocument_stoptransform(handle:Byte Ptr)
	Function bmx_wxpdfdocument_text(handle:Byte Ptr, x:Double, y:Double, txt:String)
	Function bmx_wxpdfdocument_textbox:Int(handle:Byte Ptr, w:Double, h:Double, txt:String, halign:Int, valign:Int, border:Int, fill:Int)
	Function bmx_wxpdfdocument_checkbox(handle:Byte Ptr, name:String, width:Double, checked:Int)
	Function bmx_wxpdfdocument_checkboxxy(handle:Byte Ptr, name:String, x:Double, y:Double, width:Double, checked:Int)
	Function bmx_wxpdfdocument_combobox(handle:Byte Ptr, name:String, width:Double, height:Double, values:String[])
	Function bmx_wxpdfdocument_comboboxxy(handle:Byte Ptr, name:String, x:Double, y:Double, width:Double, height:Double, values:String[])
	Function bmx_wxpdfdocument_clippedcell(handle:Byte Ptr, w:Double, h:Double, txt:String, border:Int, ln:Int, align:Int, fill:Int, link:Byte Ptr)
	Function bmx_wxpdfdocument_clippingellipse(handle:Byte Ptr, x:Double, y:Double, rx:Double, ry:Double, outline:Int)
	Function bmx_wxpdfdocument_clippingpath(handle:Byte Ptr)
	Function bmx_wxpdfdocument_clippingpathshape(handle:Byte Ptr, shape:Byte Ptr, style:Int)
	Function bmx_wxpdfdocument_clippingpolygon(handle:Byte Ptr, x:Double[], y:Double[], outline:Int)
	Function bmx_wxpdfdocument_clippingrect(handle:Byte Ptr, x:Double, y:Double, w:Double, h:Double, outline:Int)
	Function bmx_wxpdfdocument_clippingtext(handle:Byte Ptr, x:Double, y:Double, txt:String, outline:Int)
	Function bmx_wxpdfdocument_closepath(handle:Byte Ptr, style:Int)

	Function bmx_wxpdfdocument_setalpha:Int(handle:Byte Ptr, lineAlpha:Double, fillAlpha:Double, blendMode:Int)
	Function bmx_wxpdfdocument_rect(handle:Byte Ptr, x:Double, y:Double, w:Double, h:Double, style:Int)
	Function bmx_wxpdfdocument_imagemask:Int(handle:Byte Ptr, file:String, mimeType:String)
	Function bmx_wxpdfdocument_starttransform(handle:Byte Ptr)
	Function bmx_wxpdfdocument_settopmargin(handle:Byte Ptr, margin:Double)
	Function bmx_wxpdfdocument_setviewerpreferences(handle:Byte Ptr, preferences:Int)
	Function bmx_wxpdfdocument_setxy(handle:Byte Ptr, x:Double, y:Double)
	Function bmx_wxpdfdocument_skew:Int(handle:Byte Ptr, xAngle:Double, yAngle:Double, x:Double, y:Double)
	Function bmx_wxpdfdocument_skewx:Int(handle:Byte Ptr, xAngle:Double, x:Double, y:Double)
	Function bmx_wxpdfdocument_skewy:Int(handle:Byte Ptr, yAngle:Double, x:Double, y:Double)
	Function bmx_wxpdfdocument_starpolygon(handle:Byte Ptr, x0:Double, y0:Double, r:Double, ..
			nv:Int, nr:Int, angle:Double, circle:Int, style:Int, circleStyle:Int, circleLineStype:Byte Ptr, circleFillColor:Byte Ptr)
	Function bmx_wxpdfdocument_shape(handle:Byte Ptr, shape:Byte Ptr, style:Int)
	Function bmx_wxpdfdocument_shapedtext(handle:Byte Ptr, shape:Byte Ptr, text:String, mode:Int)
	Function bmx_wxpdfdocument_setlink:Int(handle:Byte Ptr, link:Int, y:Double, page:Int)
	Function bmx_wxpdfdocument_getpageheight:Double(handle:Byte Ptr)
	Function bmx_wxpdfdocument_getpagewidth:Double(handle:Byte Ptr)
	Function bmx_wxpdfdocument_getrightmargin:Double(handle:Byte Ptr)
	Function bmx_wxpdfdocument_getscalefactor:Double(handle:Byte Ptr)
	Function bmx_wxpdfdocument_getsourceinfo:Int(handle:Byte Ptr, info:Byte Ptr)
	Function bmx_wxpdfdocument_coonspatchgradient:Int(handle:Byte Ptr, mesh:Byte Ptr, minCoord:Double, maxCoord:Double)
	Function bmx_wxpdfdocument_curveto(handle:Byte Ptr, x1:Double, y1:Double, x2:Double, y2:Double, x3:Double, y3:Double)
	Function bmx_wxpdfdocument_endtemplate:Int(handle:Byte Ptr)

	Function bmx_wxpdfdocument_getdrawcolor:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxpdfdocument_getfillcolor:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxpdfdocument_getfontdescription:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxpdfdocument_getlinestyle:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxpdfdocument_gettemplatebbox(handle:Byte Ptr, templateId:Int, x:Double Ptr, y:Double Ptr, width:Double Ptr, height:Double Ptr)
	Function bmx_wxpdfdocument_gettemplatessize(handle:Byte Ptr, templateId:Int, width:Double Ptr, height:Double Ptr)
	Function bmx_wxpdfdocument_gettextcolor:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxpdfdocument_imageimage:Int(handle:Byte Ptr, name:String, _image:Byte Ptr, x:Double, y:Double, w:Double, h:Double, link:Byte Ptr, maskImage:Int)
	Function bmx_wxpdfdocument_imagemaskimage:Int(handle:Byte Ptr, name:String, _image:Byte Ptr)
	Function bmx_wxpdfdocument_importpage:Int(handle:Byte Ptr, page:Int)
	Function bmx_wxpdfdocument_isinfooter:Int(handle:Byte Ptr)
	Function bmx_wxpdfdocument_line(handle:Byte Ptr, x1:Double, y1:Double, x2:Double, y2:Double)
	Function bmx_wxpdfdocument_lineargradient:Int(handle:Byte Ptr, col1:Byte Ptr, col2:Byte Ptr, gradientType:Int)
	Function bmx_wxpdfdocument_linecount:Int(handle:Byte Ptr, w:Double, txt:String)
	Function bmx_wxpdfdocument_lineto(handle:Byte Ptr, x:Double, y:Double)
	Function bmx_wxpdfdocument_link(handle:Byte Ptr, x:Double, y:Double, w:Double, h:Double, _link:Byte Ptr)
	Function bmx_wxpdfdocument_marker(handle:Byte Ptr, x:Double, y:Double, markerType:Int, size:Double)
	Function bmx_wxpdfdocument_midaxialgradient(handle:Byte Ptr, col1:Byte Ptr, col2:Byte Ptr, x1:Double, y1:Double, x2:Double, y2:Double, midpoint:Double, intexp:Double)
	Function bmx_wxpdfdocument_mirrorh(handle:Byte Ptr, x:Double)
	Function bmx_wxpdfdocument_mirrorv(handle:Byte Ptr, y:Double)
	Function bmx_wxpdfdocument_moveto(handle:Byte Ptr, x:Double, y:Double)
	Function bmx_wxpdfdocument_polygon(handle:Byte Ptr, x:Double[], y:Double[], style:Int)
	Function bmx_wxpdfdocument_pushbutton(handle:Byte Ptr, name:String, width:Double, height:Double, caption:String, action:String)
	Function bmx_wxpdfdocument_pushbuttonxy(handle:Byte Ptr, name:String, x:Double, y:Double, width:Double, height:Double, caption:String, action:String)
	Function bmx_wxpdfdocument_radialgradient:Int(handle:Byte Ptr, col1:Byte Ptr, col2:Byte Ptr, x1:Double, y1:Double, r1:Double, x2:Double, y2:Double, r2:Double, intexp:Double)
	Function bmx_wxpdfdocument_radiobutton(handle:Byte Ptr, group:String, name:String, width:Double)
	Function bmx_wxpdfdocument_radiobuttonxy(handle:Byte Ptr, group:String, name:String, x:Double, y:Double, width:Double)
	Function bmx_wxpdfdocument_settextcolorpdf(handle:Byte Ptr, pdfColour:Byte Ptr)
	Function bmx_wxpdfdocument_settextcolorrgb(handle:Byte Ptr, red:Int, green:Int, blue:Int)
	Function bmx_wxpdfdocument_settextcolorcmyk(handle:Byte Ptr, cyan:Double, magenta:Double, yellow:Double, black:Double)
	Function bmx_wxpdfdocument_settextcolorname(handle:Byte Ptr, name:String, tint:Double)
	Function bmx_wxpdfdocument_setdrawcolorpdf(handle:Byte Ptr, pdfColour:Byte Ptr)
	Function bmx_wxpdfdocument_setdrawcolorrgb(handle:Byte Ptr, red:Int, green:Int, blue:Int)
	Function bmx_wxpdfdocument_setdrawcolorcmyk(handle:Byte Ptr, cyan:Double, magenta:Double, yellow:Double, black:Double)
	Function bmx_wxpdfdocument_setdrawcolorname(handle:Byte Ptr, name:String, tint:Double)
	Function bmx_wxpdfdocument_setfillcolorpdf(handle:Byte Ptr, pdfColour:Byte Ptr)
	Function bmx_wxpdfdocument_setfillcolorrgb(handle:Byte Ptr, red:Int, green:Int, blue:Int)
	Function bmx_wxpdfdocument_setfillcolorcmyk(handle:Byte Ptr, cyan:Double, magenta:Double, yellow:Double, black:Double)
	Function bmx_wxpdfdocument_setfillcolorname(handle:Byte Ptr, name:String, tint:Double)

	Function bmx_wxpdfdocument_rotate(handle:Byte Ptr, angle:Double, x:Double, y:Double)
	Function bmx_wxpdfdocument_rotatedtext(handle:Byte Ptr, x:Double, y:Double, txt:String, angle:Double)
	Function bmx_wxpdfdocument_roundedrect(handle:Byte Ptr, x:Double, y:Double, w:Double, h:Double, r:Double, roundCorner:Int, style:Int)
	Function bmx_wxpdfdocument_scale:Int(handle:Byte Ptr, sx:Double, sy:Double, x:Double, y:Double)
	Function bmx_wxpdfdocument_scalex:Int(handle:Byte Ptr, sx:Double, x:Double, y:Double)
	Function bmx_wxpdfdocument_scaley:Int(handle:Byte Ptr, sy:Double, x:Double, y:Double)
	Function bmx_wxpdfdocument_scalexy:Int(handle:Byte Ptr, s:Double, x:Double, y:Double)
	Function bmx_wxpdfdocument_setdrawcolorgrayscale(handle:Byte Ptr, grayscale:Int)
	Function bmx_wxpdfdocument_setfillcolorgrayscale(handle:Byte Ptr, grayscale:Int)
	Function bmx_wxpdfdocument_setsourcefile:Int(handle:Byte Ptr, filename:String, password:String)

	Function bmx_wxpdfdocument_setsubject(handle:Byte Ptr, subject:String)
	Function bmx_wxpdfdocument_settemplatebbox(handle:Byte Ptr, templateId:Int, x:Double, y:Double, width:Double, height:Double)
	Function bmx_wxpdfdocument_setmargins(handle:Byte Ptr, marginLeft:Double, marginTop:Double, marginRight:Double)
	Function bmx_wxpdfdocument_setprotection(handle:Byte Ptr, permissions:Int, userPassword:String, ownerPassword:String, encryptionMethod:Int, keyLength:Int)
	Function bmx_wxpdfdocument_setrightmargin(handle:Byte Ptr, margin:Double)
	Function bmx_wxpdfdocument_setfontpath(handle:Byte Ptr, fontPath:String)
	Function bmx_wxpdfdocument_setfontsize(handle:Byte Ptr, size:Double)
	Function bmx_wxpdfdocument_setfontsubsetting(handle:Byte Ptr, fontSubsetting:Int)
	Function bmx_wxpdfdocument_setformborderstyle(handle:Byte Ptr, borderStyle:Int, borderWidth:Int)
	Function bmx_wxpdfdocument_setformcolors(handle:Byte Ptr, borderColor:Byte Ptr, backgroundColor:Byte Ptr, textColor:Byte Ptr)
	Function bmx_wxpdfdocument_setfillgradient(handle:Byte Ptr, x:Double, y:Double, w:Double, h:Double, gradient:Int)
	Function bmx_wxpdfdocument_setautopagebreak(handle:Byte Ptr, autoPageBreak:Int, margin:Double)
	Function bmx_wxpdfdocument_setcellmargin(handle:Byte Ptr, margin:Double)
	Function bmx_wxpdfdocument_setcompression(handle:Byte Ptr, compress:Int)
	Function bmx_wxpdfdocument_setcreator(handle:Byte Ptr, creator:String)
	Function bmx_wxpdfdocument_setdisplaymode(handle:Byte Ptr, zoom:Int, layout:Int, zooomFactor:Double)
	Function bmx_wxpdfdocument_setalphastate(handle:Byte Ptr, state:Int)
	Function bmx_wxpdfdocument_sector(handle:Byte Ptr, x0:Double, y0:Double, r:Double, astart:Double, afinish:Double, style:Int, clockwise:Int, origin:Double)
	Function bmx_wxpdfdocument_regularpolygon(handle:Byte Ptr, x0:Double, y0:Double, r:Double, ns:Int, angle:Double, circle:Int, style:Int, circleStyle:Int, circleLineStyle:Byte Ptr, circleFillColor:Byte Ptr)
	Function bmx_wxpdfdocument_rotatedimage(handle:Byte Ptr, file:String, x:Double, y:Double, w:Double, h:Double, angle:Double, imgType:String, link:Byte Ptr, maskImage:Int)

	Function bmx_wxpdfcolour_createforname:Byte Ptr(name:String)
	Function bmx_wxpdfcolour_delete(handle:Byte Ptr)
	Function bmx_wxpdfcolour_create:Byte Ptr(r:Int, g:Int, b:Int)
	Function bmx_wxpdfcolour_creategrayscalecolour:Byte Ptr(grayscale:Int)
	Function bmx_wxpdfcolour_createfromcolour:Byte Ptr(colour:Byte Ptr)
	Function bmx_wxpdfcolour_createcmykcolour:Byte Ptr(cyan:Double, magenta:Double, yellow:Double, black:Double)
	Function bmx_wxpdfcolour_getcolortype:Int(handle:Byte Ptr)

	Function bmx_wxpdfinfo_create:Byte Ptr()
	Function bmx_wxpdfinfo_gettitle:String(handle:Byte Ptr)
	Function bmx_wxpdfinfo_getauthor:String(handle:Byte Ptr)
	Function bmx_wxpdfinfo_getsubject:String(handle:Byte Ptr)
	Function bmx_wxpdfinfo_getkeywords:String(handle:Byte Ptr)
	Function bmx_wxpdfinfo_getcreator:String(handle:Byte Ptr)
	Function bmx_wxpdfinfo_getproducer:String(handle:Byte Ptr)
	Function bmx_wxpdfinfo_getcreationdate:String(handle:Byte Ptr)
	Function bmx_wxpdfinfo_getmoddate:String(handle:Byte Ptr)
	Function bmx_wxpdfinfo_delete(handle:Byte Ptr)

	Function bmx_wxpdflink_create:Byte Ptr(linkRef:Int)
	Function bmx_wxpdflink_createurl:Byte Ptr(linkURL:String)
	Function bmx_wxpdflink_delete(handle:Byte Ptr)

	Function bmx_wxpdflinestyle_create:Byte Ptr(width:Double, cap:Int, join:Int, dash:Double[], phase:Double, colour:Byte Ptr)
	Function bmx_wxpdflinestyle_delete(handle:Byte Ptr)

	Function bmx_wxpdfbarcodecreator_create:Byte Ptr(document:Byte Ptr)
	Function bmx_wxpdfbarcodecreator_free(handle:Byte Ptr)
	Function bmx_wxpdfbarcodecreator_ean13:Int(handle:Byte Ptr, x:Double, y:Double, barcode:String, w:Double, h:Double)
	Function bmx_wxpdfbarcodecreator_upc_a:Int(handle:Byte Ptr, x:Double, y:Double, barcode:String, w:Double, h:Double)
	Function bmx_wxpdfbarcodecreator_code39:Int(handle:Byte Ptr, x:Double, y:Double, code:String, ext:Int, cks:Int, w:Double, h:Double, wide:Int)
	Function bmx_wxpdfbarcodecreator_I25:Int(handle:Byte Ptr, x:Double, y:Double, code:String, basewidth:Double, height:Double)
	Function bmx_wxpdfbarcodecreator_postnet:Int(handle:Byte Ptr, x:Double, y:Double, zipcode:String)

	Function bmx_wxpdfshape_create:Byte Ptr()
	Function bmx_wxpdfshape_moveto(handle:Byte Ptr, x:Double, y:Double)
	Function bmx_wxpdfshape_lineto(handle:Byte Ptr, x:Double, y:Double)
	Function bmx_wxpdfshape_curveto(handle:Byte Ptr, x1:Double, y1:Double, x2:Double, y2:Double, x3:Double, y3:Double)
	Function bmx_wxpdfshape_closepath(handle:Byte Ptr)
	Function bmx_wxpdfshape_getsegmentcount:Int(handle:Byte Ptr)
	Function bmx_wxpdfshape_delete(handle:Byte Ptr)

End Extern

' Border options
Const wxPDF_BORDER_NONE:Int = $0000
Const wxPDF_BORDER_LEFT:Int = $0001
Const wxPDF_BORDER_RIGHT:Int = $0002
Const wxPDF_BORDER_TOP:Int = $0004
Const wxPDF_BORDER_BOTTOM:Int = $0008
Const wxPDF_BORDER_FRAME:Int = $000F

' Corner options
Const wxPDF_CORNER_NONE:Int = $0000
Const wxPDF_CORNER_TOP_LEFT:Int = $0001
Const wxPDF_CORNER_TOP_RIGHT:Int = $0002
Const wxPDF_CORNER_BOTTOM_LEFT:Int = $0004
Const wxPDF_CORNER_BOTTOM_RIGHT:Int = $0008
Const wxPDF_CORNER_ALL:Int = $000F

' Style options
Const wxPDF_STYLE_NOOP:Int = $0000
Const wxPDF_STYLE_DRAW:Int = $0001
Const wxPDF_STYLE_FILL:Int = $0002
Const wxPDF_STYLE_FILLDRAW:Int = $0003
Const wxPDF_STYLE_DRAWCLOSE:Int = $0004
Const wxPDF_STYLE_MASK:Int = $0007

' Font decoration options
Const wxPDF_FONT_NORMAL:Int = $0000
Const wxPDF_FONT_UNDERLINE:Int = $0001
Const wxPDF_FONT_OVERLINE:Int = $0002
Const wxPDF_FONT_STRIKEOUT:Int = $0004
Const wxPDF_FONT_DECORATION:Int = $0007 ' Mask all possible decorations

' Permission options
Const wxPDF_PERMISSION_NONE:Int = $0000  '< Allow nothing
Const wxPDF_PERMISSION_PRINT:Int = $0004  '< Allow printing
Const wxPDF_PERMISSION_MODIFY:Int = $0008  '< Allow modifying
Const wxPDF_PERMISSION_COPY:Int = $0010  '< Allow text copying
Const wxPDF_PERMISSION_ANNOT:Int = $0020  '< Allow annotations
Const wxPDF_PERMISSION_ALL:Int = $003C  '< Allow anything

' Encryption methods
Const wxPDF_ENCRYPTION_RC4V1:Int = 0
Const wxPDF_ENCRYPTION_RC4V2:Int = 1
Const wxPDF_ENCRYPTION_AESV2:Int = 2

' Color types
Const wxPDF_COLOURTYPE_UNKNOWN:Int = 0
Const wxPDF_COLOURTYPE_GRAY:Int = 1
Const wxPDF_COLOURTYPE_RGB:Int = 2
Const wxPDF_COLOURTYPE_CMYK:Int = 3
Const wxPDF_COLOURTYPE_SPOT:Int = 4

' Form Field border styles
Const wxPDF_BORDER_SOLID:Int = 0
Const wxPDF_BORDER_DASHED:Int = 1
Const wxPDF_BORDER_BEVELED:Int = 2
Const wxPDF_BORDER_INSET:Int = 3
Const wxPDF_BORDER_UNDERLINE:Int = 4

' Alignment options
Const wxPDF_ALIGN_LEFT:Int = 0
Const wxPDF_ALIGN_CENTER:Int = 1
Const wxPDF_ALIGN_RIGHT:Int = 2
Const wxPDF_ALIGN_JUSTIFY:Int = 3
Const wxPDF_ALIGN_TOP:Int = wxPDF_ALIGN_LEFT
Const wxPDF_ALIGN_MIDDLE:Int = wxPDF_ALIGN_CENTER
Const wxPDF_ALIGN_BOTTOM:Int = wxPDF_ALIGN_RIGHT

' Zoom options
Const wxPDF_ZOOM_FULLPAGE:Int = 0
Const wxPDF_ZOOM_FULLWIDTH:Int = 1
Const wxPDF_ZOOM_REAL:Int = 2
Const wxPDF_ZOOM_DEFAULT:Int = 3
Const wxPDF_ZOOM_FACTOR:Int = 4

' Layout options
Const wxPDF_LAYOUT_CONTINUOUS:Int = 0
Const wxPDF_LAYOUT_SINGLE:Int = 1
Const wxPDF_LAYOUT_TWO:Int = 2
Const wxPDF_LAYOUT_DEFAULT:Int = 3

' Viewer preferences
Const wxPDF_VIEWER_HIDETOOLBAR:Int = $0001
Const wxPDF_VIEWER_HIDEMENUBAR:Int = $0002
Const wxPDF_VIEWER_HIDEWINDOWUI:Int = $0004
Const wxPDF_VIEWER_FITWINDOW:Int = $0008
Const wxPDF_VIEWER_CENTERWINDOW:Int = $0010
Const wxPDF_VIEWER_DISPLAYDOCTITLE:Int = $0020

' Line Cap options
Const wxPDF_LINECAP_NONE:Int = -1
Const wxPDF_LINECAP_BUTT:Int = 0
Const wxPDF_LINECAP_ROUND:Int = 1
Const wxPDF_LINECAP_SQUARE:Int = 2

' Line join options
Const wxPDF_LINEJOIN_NONE:Int = -1
Const wxPDF_LINEJOIN_MITER:Int = 0
Const wxPDF_LINEJOIN_ROUND:Int = 1
Const wxPDF_LINEJOIN_BEVEL:Int = 2

' Marker symbols
Const wxPDF_MARKER_CIRCLE:Int = 0
Const wxPDF_MARKER_SQUARE:Int = 1
Const wxPDF_MARKER_TRIANGLE_UP:Int = 2
Const wxPDF_MARKER_TRIANGLE_DOWN:Int = 3
Const wxPDF_MARKER_TRIANGLE_LEFT:Int = 4
Const wxPDF_MARKER_TRIANGLE_RIGHT:Int = 5
Const wxPDF_MARKER_DIAMOND:Int = 6
Const wxPDF_MARKER_PENTAGON_UP:Int = 7
Const wxPDF_MARKER_PENTAGON_DOWN:Int = 8
Const wxPDF_MARKER_PENTAGON_LEFT:Int = 9
Const wxPDF_MARKER_PENTAGON_RIGHT:Int = 10
Const wxPDF_MARKER_STAR:Int = 11
Const wxPDF_MARKER_STAR4:Int = 12
Const wxPDF_MARKER_PLUS:Int = 13
Const wxPDF_MARKER_CROSS:Int = 14
Const wxPDF_MARKER_SUN:Int = 15
Const wxPDF_MARKER_BOWTIE_HORIZONTAL:Int = 16
Const wxPDF_MARKER_BOWTIE_VERTICAL:Int = 17
Const wxPDF_MARKER_ASTERISK:Int = 18

' Linear gradient types
Const wxPDF_LINEAR_GRADIENT_HORIZONTAL:Int = 0
Const wxPDF_LINEAR_GRADIENT_VERTICAL:Int = 1
Const wxPDF_LINEAR_GRADIENT_MIDHORIZONTAL:Int = 2
Const wxPDF_LINEAR_GRADIENT_MIDVERTICAL:Int = 3
Const wxPDF_LINEAR_GRADIENT_REFLECTION_LEFT:Int = 4
Const wxPDF_LINEAR_GRADIENT_REFLECTION_RIGHT:Int = 5
Const wxPDF_LINEAR_GRADIENT_REFLECTION_TOP:Int = 6
Const wxPDF_LINEAR_GRADIENT_REFLECTION_BOTTOM:Int = 7

Const wxPDF_BLENDMODE_NORMAL:Int = 0
Const wxPDF_BLENDMODE_MULTIPLY:Int = 1
Const wxPDF_BLENDMODE_SCREEN:Int = 2
Const wxPDF_BLENDMODE_OVERLAY:Int = 3
Const wxPDF_BLENDMODE_DARKEN:Int = 4
Const wxPDF_BLENDMODE_LIGHTEN:Int = 5
Const wxPDF_BLENDMODE_COLORDODGE:Int = 6
Const wxPDF_BLENDMODE_COLORBURN:Int = 7
Const wxPDF_BLENDMODE_HARDLIGHT:Int = 8
Const wxPDF_BLENDMODE_SOFTLIGHT:Int = 9
Const wxPDF_BLENDMODE_DIFFERENCE:Int = 10
Const wxPDF_BLENDMODE_EXCLUSION:Int = 11
Const wxPDF_BLENDMODE_HUE:Int = 12
Const wxPDF_BLENDMODE_SATURATION:Int = 12
Const wxPDF_BLENDMODE_COLOR:Int = 13
Const wxPDF_BLENDMODE_LUMINOSITY:Int = 14


Const wxPDF_SHAPEDTEXTMODE_ONETIME:Int = 0
Const wxPDF_SHAPEDTEXTMODE_STRETCHTOFIT:Int = 1
Const wxPDF_SHAPEDTEXTMODE_REPEAT:Int = 2


