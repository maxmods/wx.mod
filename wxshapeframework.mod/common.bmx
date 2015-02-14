' Copyright (c) 2009-2015 Bruce A Henderson
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
Import wx.wxScrolledWindow
Import BRL.Blitz


' headers :-)
?linuxx86
Import "../lib/linux/wx/include/gtk2-unicode-release-static/*.h"
?linuxx64
Import "../lib/linuxx64/wx/include/gtk2-unicode-release-static/*.h"
?win32x86
Import "../lib/win32/mswu/*.h"
?win32x64
Import "../lib/win32x64/mswu/*.h"
?macosppc
Import "../lib/macosppc/wx/include/mac-unicode-release-static/*.h"
?macosx86
Import "../lib/macosx86/wx/include/mac-unicode-release-static/*.h"
?macosx64
Import "../lib/macosx64/wx/include/mac-unicode-release-static/*.h"
?raspberrypi
Import "../lib/raspberrypi/wx/include/gtk2-unicode-release-static/*.h"
?
Import "../include/*.h"

Import "include/*.h"
Import "src/*.h"

Import "src/ArrowBase.cpp"
Import "src/AutoLayout.cpp"
Import "src/wx_pch.cpp"
Import "src/BitmapShape.cpp"
Import "src/BitmapShapeXml.cpp"
Import "src/CanvasHistory.cpp"
Import "src/CanvasState.cpp"
Import "src/CircleArrow.cpp"
Import "src/CircleShape.cpp"
Import "src/CommonFcn.cpp"
Import "src/ControlShape.cpp"
Import "src/CurveShape.cpp"
Import "src/DiagramManager.cpp"
Import "src/DiamondArrow.cpp"
Import "src/DiamondShape.cpp"
Import "src/EditTextShape.cpp"
Import "src/EllipseShape.cpp"
Import "src/FixedRectShape.cpp"
Import "src/FlexGridShape.cpp"
Import "src/GridShape.cpp"
Import "src/LineShape.cpp"
Import "src/MultiSelRect.cpp"
Import "src/OpenArrow.cpp"
Import "src/OrthoShape.cpp"
Import "src/PolygonShape.cpp"
Import "src/PolygonShapeXml.cpp"
Import "src/Printout.cpp"
Import "src/RectShape.cpp"
Import "src/RoundOrthoShape.cpp"
Import "src/RoundRectShape.cpp"
Import "src/ScaledDC.cpp"
Import "src/SFEvents.cpp"
Import "src/ShapeBase.cpp"
Import "src/ShapeBaseXml.cpp"
Import "src/ShapeCanvas.cpp"
Import "src/ShapeDataObject.cpp"
Import "src/ShapeDockpoint.cpp"
Import "src/ShapeHandle.cpp"
Import "src/SolidArrow.cpp"
Import "src/TextShape.cpp"
Import "src/TextShapeXml.cpp"
Import "src/Thumbnail.cpp"

Import "src/wxxmlserializer/PropertyIO.cpp"
Import "src/wxxmlserializer/XmlSerializer.cpp"

Import "glue.cpp"

Extern

	Function bmx_xsserializable_bind(handle:Byte Ptr, obj:Object)

	Function bmx_wxsfshapecanvas_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, x:Int, y:Int, w:Int, h:Int, style:Int)
	Function bmx_wxsfshapecanvas_addstyle(handle:Byte Ptr, style:Int)
	Function bmx_wxsfshapecanvas_setdiagrammanager(handle:Byte Ptr, manager:Byte Ptr)
	Function bmx_wxsfshapecanvas_selectall(handle:Byte Ptr)
	Function bmx_wxsfshapecanvas_deselectall(handle:Byte Ptr)
	Function bmx_wxsfshapecanvas_hideallhandles(handle:Byte Ptr)
	Function bmx_wxsfshapecanvas_copy(handle:Byte Ptr)
	Function bmx_wxsfshapecanvas_cut(handle:Byte Ptr)
	Function bmx_wxsfshapecanvas_paste(handle:Byte Ptr)
	Function bmx_wxsfshapecanvas_undo(handle:Byte Ptr)
	Function bmx_wxsfshapecanvas_redo(handle:Byte Ptr)
	Function bmx_wxsfshapecanvas_cancopy:Int(handle:Byte Ptr)
	Function bmx_wxsfshapecanvas_cancut:Int(handle:Byte Ptr)
	Function bmx_wxsfshapecanvas_canpaste:Int(handle:Byte Ptr)
	Function bmx_wxsfshapecanvas_canundo:Int(handle:Byte Ptr)
	Function bmx_wxsfshapecanvas_canredo:Int(handle:Byte Ptr)
	Function bmx_wxsfshapecanvas_canalignselected:Int(handle:Byte Ptr)
	Function bmx_wxsfshapecanvas_savecanvasstate(handle:Byte Ptr)
	Function bmx_wxsfshapecanvas_clearcanvashistory(handle:Byte Ptr)
	Function bmx_wxsfshapecanvas_printpreview(handle:Byte Ptr)
	Function bmx_wxsfshapecanvas_pagesetup(handle:Byte Ptr)

	Function bmx_wxsfdiagrammanager_create:Byte Ptr(handle:Object)
	Function bmx_wxsfdiagrammanager_addshape:Object(handle:Byte Ptr, shapeInfo:String, xPos:Int, yPos:Int, saveState:Int)
	Function bmx_wxsfdiagrammanager_acceptshape(handle:Byte Ptr, shapeType:String)

	Function bmx_wxsfcontrolshape_setcontrol(handle:Byte Ptr, ctrl:Byte Ptr, fit:Int)
	Function bmx_wxsfcontrolshape_getcontrol:Byte Ptr(handle:Byte Ptr)
	Function bmx_wxsfcontrolshape_seteventprocessing(handle:Byte Ptr, mask:Int)
	Function bmx_wxsfcontrolshape_geteventprocessing:Int(handle:Byte Ptr)
	Function bmx_wxsfcontrolshape_setcontroloffset(handle:Byte Ptr, offset:Int)
	Function bmx_wxsfcontrolshape_getcontroloffset:Int(handle:Byte Ptr)

	Function bmx_wxsfshapebase_clearacceptedchilds(handle:Byte Ptr)


End Extern


Const wxEVT_SF_LINE_DONE:Int = 7770
Const wxEVT_SF_TEXT_CHANGE:Int = 7771
Const wxEVT_SF_ON_DROP:Int = 7772
Const wxEVT_SF_ON_PASTE:Int = 7773

