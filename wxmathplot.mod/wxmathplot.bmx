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

Rem
bbdoc: 
End Rem
Module wx.wxMathplot

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

'
' Notes :
'
' Changes to wxmathplot.h/.cpp
'    Changed mpPrintout ctor to take wxString instead of wxChar*
'

Rem
bbdoc: Canvas for plotting mpLayer implementations.
about: This type defines a zoomable and moveable 2D plot canvas. Any number
    of mpLayer implementations (scale rulers, function plots, ...) can be
    attached using mpWindow::AddLayer.
The canvas window provides a context menu with actions for navigating the view.
The context menu can be retrieved with mpWindow::GetPopupMenu, e.g. for extending it externally.
End Rem
Type mpWindow Extends wxWindow

	Rem
	bbdoc: 
	End Rem
	Method Create:mpWindow(parent:wxWindow, id:Int = -1, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, flags:Int = 0)
		wxObjectPtr = bmx_mpwindow_create(Self, parent.wxObjectPtr, id, x, y, w, h, flags)
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetPopupMenu:wxMenu()
		' TODO
	End Method
	
	Rem
	bbdoc: Adds a plot layer to the canvas.
	End Rem
	Method AddLayer:Int(layer:mpLayer, refreshDisplay:Int = True)
		Return bmx_mpwindow_addlayer(wxObjectPtr, layer.wxObjectPtr, refreshDisplay)
	End Method
	
	Rem
	bbdoc: Removes a plot layer from the canvas.
	End Rem
	Method DelLayer:Int(layer:mpLayer, alsoDeleteObject:Int = False, refreshDisplay:Int = True)
		Return bmx_mpwindow_dellayer(wxObjectPtr, layer.wxObjectPtr, alsoDeleteObject, refreshDisplay)
	End Method
	
	Rem
	bbdoc: Removes all layers from the plot.
	End Rem
	Method DelAllLayers(alsoDeleteObject:Int, refreshDisplay:Int = True)
		bmx_mpwindow_delalllayers(wxObjectPtr, alsoDeleteObject, refreshDisplay)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetLayer:mpLayer(position:Int)
		Local layerPtr:Byte Ptr = bmx_mpwindow_getlayer(wxObjectPtr, position)
		Local layer:Object = wxfind(layerPtr)
		If layer Then
			Return mpLayer(layer)
		End If
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetLayerByName:mpLayer(name:String)
		Local layerPtr:Byte Ptr = bmx_mpwindow_getlayerbyname(wxObjectPtr, name)
		Local layer:Object = wxfind(layerPtr)
		If layer Then
			Return mpLayer(layer)
		End If
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetScaleX:Double()
		Return bmx_mpwindow_getscalex(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetScaleY:Double()
		Return bmx_mpwindow_getscaley(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetPosX:Double()
		Return bmx_mpwindow_getposx(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetPosY:Double()
		Return bmx_mpwindow_getposy(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetXScreen:Int()
		Return bmx_mpwindow_getxscreen(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetYScreen:Int()
		Return bmx_mpwindow_getyscreen(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetScaleX(scale:Double)
		bmx_mpwindow_setscalex(wxObjectPtr, scale)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetScaleY(scale:Double)
		bmx_mpwindow_setscaley(wxObjectPtr, scale)
	End Method
	
	Method SetPosX(pos:Double)
		bmx_mpwindow_setposx(wxObjectPtr, pos)
	End Method
	
	Method SetPosY(pos:Double)
		bmx_mpwindow_setposy(wxObjectPtr, pos)
	End Method
	
	Method SetPos(x:Double, y:Double)
		bmx_mpwindow_setpos(wxObjectPtr, x, y)
	End Method
	
	Method SetScreen(x:Int, y:Int)
		bmx_mpwindow_setscreen(wxObjectPtr, x, y)
	End Method
	
	Method EnableMousePanZoom(enabled:Int)
		bmx_mpwindow_enablemousepanzoom(wxObjectPtr, enabled)
	End Method
	
	Method LockAspect(enable:Int = True)
		bmx_mpwindow_lockaspect(wxObjectPtr, enable)
	End Method
	
	Method IsAspectLocked:Int()
		Return bmx_mpwindow_isaspectlocked(wxObjectPtr)
	End Method
	
	Method Fit()
		bmx_mpwindow_fit(wxObjectPtr)
	End Method
	
	Method FitBounds(xMin:Double, xMax:Double, yMin:Double, yMax:Double, printSizeX:Int = -1, printSizeY:Int = -1)
		bmx_mpwindow_fitbounds(wxObjectPtr, xMin, xMax, yMin, yMax, printSizeX, printSizeY)
	End Method
	
	Method ZoomIn(centerPointX:Int = -1, centerPointY:Int = -1)
		bmx_mpwindow_zoomin(wxObjectPtr, centerPointX, centerPointY)
	End Method
	
	Method ZoomOut(centerPointX:Int = -1, centerPointY:Int = -1)
		bmx_mpwindow_zoomout(wxObjectPtr, centerPointX, centerPointY)
	End Method
	
	Method ZoomInX()
		bmx_mpwindow_zoominx(wxObjectPtr)
	End Method
	
	Method ZoomOutX()
		bmx_mpwindow_zoomoutx(wxObjectPtr)
	End Method
	
	Method ZoomInY()
		bmx_mpwindow_zoominy(wxObjectPtr)
	End Method
	
	Method ZoomOutY()
		bmx_mpwindow_zoomouty(wxObjectPtr)
	End Method
	
	Method ZoomRect(x0:Int, y0:Int, x1:Int, y1:Int)
		bmx_mpwindow_zoomrect(wxObjectPtr, x0, y0, x1, y1)
	End Method
	
	Method UpdateAll()
		bmx_mpwindow_updateall(wxObjectPtr)
	End Method
	
	Method CountLayers:Int()
		Return bmx_mpwindow_countlayers(wxObjectPtr)
	End Method
	
	Method CountAllLayers:Int()
		Return bmx_mpwindow_countalllayers(wxObjectPtr)
	End Method
	
	Method GetDesiredXmin:Double()
		Return bmx_mpwindow_getdesiredxmin(wxObjectPtr)
	End Method
	
	Method GetDesiredXmax:Double()
		Return bmx_mpwindow_getdesiredxmax(wxObjectPtr)
	End Method
	
	Method GetDesiredYmin:Double()
		Return bmx_mpwindow_getdesiredymin(wxObjectPtr)
	End Method
	
	Method GetDesiredYmax:Double()
		Return bmx_mpwindow_getdesiredymax(wxObjectPtr)
	End Method
	
	Method GetBoundingBox(bbox:Double Ptr)
		bmx_mpwindow_getboundingbox(wxObjectPtr, bbox)
	End Method
	
	Method SetMPScrollbars(status:Int)
		bmx_mpwindow_setmpscrollbars(wxObjectPtr, status)
	End Method
	
	Method GetMPScrollbars:Int()
		Return bmx_mpwindow_getmpscrollbars(wxObjectPtr)
	End Method
	
	Method SetMargins(top:Int, Right:Int, bottom:Int, Left:Int)
		bmx_mpwindow_setmargins(wxObjectPtr, top, Right, bottom, Left)
	End Method
	
	Method SetMarginTop(value:Int)
		bmx_mpwindow_setmargintop(wxObjectPtr, value)
	End Method
	
	Method SetMarginRight(value:Int)
		bmx_mpwindow_setmarginright(wxObjectPtr, value)
	End Method
	
	Method SetMarginBottom(value:Int)
		bmx_mpwindow_setmarginbottom(wxObjectPtr, value)
	End Method
	
	Method SetMarginLeft(value:Int)
		bmx_mpwindow_setmarginleft(wxObjectPtr, value)
	End Method
	
	Method GetMarginTop:Int()
		Return bmx_mpwindow_getmargintop(wxObjectPtr)
	End Method
	
	Method GetMarginRight:Int()
		Return bmx_mpwindow_getmarginright(wxObjectPtr)
	End Method
	
	Method GetMarginBottom:Int()
		Return bmx_mpwindow_getmarginbottom(wxObjectPtr)
	End Method
	
	Method GetMarginLeft:Int()
		Return bmx_mpwindow_getmarginleft(wxObjectPtr)
	End Method
	
	Method IsInsideInfoLayer:mpInfoLayer(x:Int, y:Int)
		Local layerPtr:Byte Ptr = bmx_mpwindow_isinsideinfolayer(wxObjectPtr, x, y)
		Local layer:Object = wxfind(layerPtr)
		If layer Then
			Return mpInfoLayer(layer)
		End If
	End Method
	
	Method SetLayerVisible(name:String, viewable:Int)
		bmx_mpwindow_setlayervisible(wxObjectPtr, name, viewable)
	End Method
	
	Method IsLayerVisible:Int(name:String)
		Return bmx_mpwindow_islayervisible(wxObjectPtr, name)
	End Method
	
	Method SetLayerVisiblePos(position:Int, viewable:Int)
		bmx_mpwindow_setlayervisiblepos(wxObjectPtr, position, viewable)
	End Method
	
	Method IsLayerVisiblePos:Int(position:Int)
		Return bmx_mpwindow_islayervisiblepos(wxObjectPtr, position)
	End Method
	
	Method SetColourTheme(bgColour:wxColour, drawColour:wxColour, axesColour:wxColour)
		bmx_mpwindow_setcolourtheme(wxObjectPtr, bgColour.wxObjectPtr, drawColour.wxObjectPtr, axesColour.wxObjectPtr)
	End Method
	
	Method GetAxesColour:wxColour()
		Return wxColour._create(bmx_mpwindow_getaxescolour(wxObjectPtr))
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type mpLayer Extends wxObject

	Method HasBBox:Int()
		Return bmx_mplayer_hasbbox(wxObjectPtr)
	End Method
	
	Method IsInfo:Int()
		Return bmx_mplayer_isinfo(wxObjectPtr)
	End Method
	
	Method GetMinX:Double()
		Return bmx_mplayer_getminx(wxObjectPtr)
	End Method
	
	Method GetMaxX:Double()
		Return bmx_mplayer_getmaxx(wxObjectPtr)
	End Method
	
	Method GetMinY:Double()
		Return bmx_mplayer_getminy(wxObjectPtr)
	End Method
	
	Method GetMaxY:Double()
		Return bmx_mplayer_getmaxy(wxObjectPtr)
	End Method
	
	Method GetName:String()
		Return bmx_mplayer_getname(wxObjectPtr)
	End Method
	
	Method GetFont:wxFont()
		Return wxFont._create(bmx_mplayer_getfont(wxObjectPtr))
	End Method
	
	Method GetPen:wxPen()
		Return wxPen._create(bmx_mplayer_getpen(wxObjectPtr))
	End Method
	
	Method SetContinuity(continuity:Int)
		bmx_mplayer_setcontinuity(wxObjectPtr, continuity)
	End Method
	
	Method GetContinuity:Int()
		Return bmx_mplayer_getcontinuity(wxObjectPtr)
	End Method
	
	Method ShowName(show:Int)
		bmx_mplayer_showname(wxObjectPtr, show)
	End Method
	
	Method SetName(name:String)
		bmx_mplayer_setname(wxObjectPtr, name)
	End Method
	
	Method SetFont(font:wxFont)
		bmx_mplayer_setfont(wxObjectPtr, font.wxObjectPtr)
	End Method
	
	Method SetPen(pen:wxPen)
		bmx_mplayer_setpen(wxObjectPtr, pen.wxObjectPtr)
	End Method
	
	Method SetDrawOutsideMargins(drawModeOutside:Int)
		bmx_mplayer_setdrawoutsidemargins(wxObjectPtr, drawModeOutside)
	End Method
	
	Method GetDrawOutsideMargins:Int()
		Return bmx_mplayer_getdrawoutsidemargins(wxObjectPtr)
	End Method
	
	Method GetColourSquare:wxBitmap(side:Int = 16)
		Return wxBitmap._create(bmx_mplayer_getcoloursquare(wxObjectPtr, side))
	End Method
	
	Method GetLayerType:Int()
		Return bmx_mplayer_getlayertype(wxObjectPtr)
	End Method
	
	Method IsVisible:Int()
		Return bmx_mplayer_isvisible(wxObjectPtr)
	End Method
	
	Method SetVisible(show:Int)
		bmx_mplayer_setvisible(wxObjectPtr, show)
	End Method
	
	Method GetBrush:wxBrush()
		Return wxBrush._create(bmx_mplayer_getbrush(wxObjectPtr))
	End Method
	
	Method SetBrush(brush:wxBrush)
		bmx_mplayer_setbrush(wxObjectPtr, brush.wxObjectPtr)
	End Method
	
End Type

Type mpInfoLayer Extends mpLayer

	'Method CreateLayer:mpInfoLayer

	Method GetPosition(x:Int Var, y:Int Var)
		bmx_mpinfolayer_getposition(wxObjectPtr, Varptr x, Varptr y)
	End Method
	
	Method GetSize(w:Int Var, h:Int Var)
		bmx_mpinfolayer_getsize(wxObjectPtr, Varptr w, Varptr h)
	End Method
	
End Type

Rem
bbdoc: Implements an overlay box which shows the mouse coordinates in plot units.
End Rem
Type mpInfoCoords Extends mpInfoLayer

	Method CreateLayer:mpInfoCoords(x:Int, y:Int, w:Int, h:Int, brush:wxBrush = Null)
		If brush Then
			wxObjectPtr = bmx_mpinfocoords_create(Self, x, y, w, h, brush.wxObjectPtr)
		Else
			wxObjectPtr = bmx_mpinfocoords_create(Self, x, y, w, h, Null)
		End If
		Return Self
	End Method
	
End Type

Type mpInfoLegend Extends mpInfoLayer

	Method CreateLayer:mpInfoLegend(x:Int, y:Int, w:Int, h:Int, brush:wxBrush = Null)
		If brush Then
			wxObjectPtr = bmx_mpinfolegend_create(Self, x, y, w, h, brush.wxObjectPtr)
		Else
			wxObjectPtr = bmx_mpinfolegend_create(Self, x, y, w, h, Null)
		End If
		Return Self
	End Method
End Type

Rem
bbdoc: Abstract base class providing plot and labeling functionality for functions F:X->Y.
about: Override mpFX::GetY to implement a function.
End Rem
Type mpFX Extends mpLayer

	Rem
	bbdoc: 
	End Rem
	Method CreateLayer:mpFX(name:String = Null, flags:Int = mpALIGN_RIGHT)
		wxObjectPtr = bmx_mpfx_create(Self, name, flags)
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetY:Double(s:Double) Abstract

	Function _GetY:Double(mp:mpFX, s:Double) { nomangle }
		Return mp.GetY(s)
	End Function

	Rem
	bbdoc: 
	End Rem
	Method GetMinY:Double()
		Return -1
	End Method

	Function _GetMinY:Double(mp:mpFX) { nomangle }
		Return mp.GetMinY()
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method GetMaxY:Double()
		Return 1
	End Method

	Function _GetMaxY:Double(mp:mpFX) { nomangle }
		Return mp.GetMaxY()
	End Function
	
End Type

Rem
bbdoc: 
End Rem
Type mpFY Extends mpLayer

	Rem
	bbdoc: 
	End Rem
	Method CreateLayer:mpFY(name:String = Null, flags:Int = mpALIGN_TOP)
		wxObjectPtr = bmx_mpfy_create(Self, name, flags)
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetX:Double(s:Double) Abstract

	Function _GetX:Double(mp:mpFY, s:Double) { nomangle }
		Return mp.GetX(s)
	End Function

	Rem
	bbdoc: 
	End Rem
	Method GetMinX:Double()
		Return -1
	End Method

	Function _GetMinX:Double(mp:mpFY) { nomangle }
		Return mp.GetMinX()
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method GetMaxX:Double()
		Return 1
	End Method

	Function _GetMaxX:Double(mp:mpFY) { nomangle }
		Return mp.GetMaxX()
	End Function

End Type

Rem
bbdoc: 
End Rem
Type mpFXY Extends mpLayer

	Rem
	bbdoc: 
	End Rem
	Method CreateLayer:mpFXY(name:String = Null, flags:Int = mpALIGN_NE)
		wxObjectPtr = bmx_mpfxy_create(Self, name, flags)
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Method Rewind() Abstract
	
	Function _Rewind(mp:mpFXY) { nomangle }
		mp.Rewind()
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method GetNextXY:Int(x:Double Var, y:Double Var) Abstract

	Function _GetNextXY:Int(mp:mpFXY, x:Double Var, y:Double Var) { nomangle }
		Return mp.GetNextXY(x, y)
	End Function

	Rem
	bbdoc: 
	End Rem
	Method GetMinX:Double()
		Return -1
	End Method

	Function _GetMinX:Double(mp:mpFX) { nomangle }
		Return mp.GetMinX()
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method GetMaxX:Double()
		Return 1
	End Method

	Function _GetMaxX:Double(mp:mpFX) { nomangle }
		Return mp.GetMaxX()
	End Function

	Rem
	bbdoc: 
	End Rem
	Method GetMinY:Double()
		Return -1
	End Method

	Function _GetMinY:Double(mp:mpFX) { nomangle }
		Return mp.GetMinY()
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method GetMaxY:Double()
		Return 1
	End Method

	Function _GetMaxY:Double(mp:mpFX) { nomangle }
		Return mp.GetMaxY()
	End Function

End Type

Rem
bbdoc: Abstract base type providing plot and labeling functionality for functions F:Y->X.
about: Override mpProfile::GetX to implement a function.
This type is similar to mpFY, but the Plot method is different. The plot is
in fact represented by lines instead of points, which gives best rendering of
rapidly-varying functions, and in general, data which are not so close one to another.
End Rem
Type mpProfile Extends mpLayer

	Rem
	bbdoc: 
	End Rem
	Method CreateLayer:mpProfile(name:String = Null, flags:Int = mpALIGN_TOP)
		wxObjectPtr = bmx_mpprofile_create(Self, name, flags)
		Return Self
	End Method

	Rem
	bbdoc: Get function value for argument.
    about: Override this method in your implementation.
	End Rem
	Method GetY:Double(x:Double) Abstract
	
	Function _GetY:Double(mp:mpProfile, x:Double) { nomangle }
		Return mp.GetY(x)
	End Function

End Type

Rem
bbdoc: Plot layer implementing a x-scale ruler.
about: The ruler is fixed at Y=0 in the coordinate system. A label is plotted at the bottom-right hand of the ruler.
The scale numbering automatically adjusts to view and zoom factor.
End Rem
Type mpScaleX Extends mpLayer

	Rem
	bbdoc: 
	End Rem
	Method CreateLayer:mpScaleX(name:String = Null, flags:Int = mpALIGN_CENTER, ticks:Int = True, layerType:Int = mpX_NORMAL)
		wxObjectPtr = bmx_mpscalex_create(Self, name, flags, ticks, layerType)
		Return Self
	End Method
	
	Method SetAlign(align:Int)
		bmx_mpscalex_setalign(wxObjectPtr, align)
	End Method
	
	Method SetTicks(ticks:Int)
		bmx_mpscalex_setticks(wxObjectPtr, ticks)
	End Method
	
	Method GetTicks:Int()
		Return bmx_mpscalex_getticks(wxObjectPtr)
	End Method
	
	Method GetLabelMode:Int()
		Return bmx_mpscalex_getlabelmode(wxObjectPtr)
	End Method
	
	Method SetLabelMode(labelMode:Int)
		bmx_mpscalex_setlabelmode(wxObjectPtr, labelMode)
	End Method
	
	Method SetLabelFormat(format:String)
		bmx_mpscalex_setlabelformat(wxObjectPtr, format)
	End Method
	
	Method GetLabelFormat:String()
		Return bmx_mpscalex_getlabelformat(wxObjectPtr)
	End Method
	
End Type

Rem
bbdoc: Plot layer implementing a y-scale ruler.
about: If align is set to mpALIGN_CENTER, the ruler is fixed at X=0 in the coordinate system.
If the align is set to mpALIGN_TOP or mpALIGN_BOTTOM, the axis is always drawn respectively at top or bottom of the window.
A label is plotted at the top-right hand of the ruler. The scale numbering automatically adjusts to view and zoom factor.
End Rem
Type mpScaleY Extends mpLayer

	Rem
	bbdoc: 
	End Rem
	Method CreateLayer:mpScaleY(name:String = Null, flags:Int = mpALIGN_CENTER, ticks:Int = True)
		wxObjectPtr = bmx_mpscaley_create(Self, name, flags, ticks)
		Return Self
	End Method

	Method SetAlign(align:Int)
		bmx_mpscaley_setalign(wxObjectPtr, align)
	End Method
	
	Method SetTicks(ticks:Int)
		bmx_mpscaley_setticks(wxObjectPtr, ticks)
	End Method
	
	Method GetTicks:Int()
		Return bmx_mpscaley_getticks(wxObjectPtr)
	End Method
	
	Method SetLabelFormat(format:String)
		bmx_mpscaley_setlabelformat(wxObjectPtr, format)
	End Method
	
	Method GetLabelFormat:String()
		Return bmx_mpscaley_getlabelformat(wxObjectPtr)
	End Method
	
End Type

Rem
bbdoc: A type providing graphs functionality for a 2D plot (either continuous or a set of points), from vectors of data.
about: This type can be used directly, the user does not need to derive any new type. Simply pass the data as two arrays
with the same length containing the X and Y coordinates to the method #SetData().
End Rem
Type mpFXYVector Extends mpFXY

	Rem
	bbdoc: 
	End Rem
	Method CreateLayer:mpFXYVector(name:String = Null, flags:Int = mpALIGN_NE)
		wxObjectPtr = bmx_mpfxyvector_create(Self, name, flags)
		Return Self
	End Method

	Rem
	bbdoc: Changes the internal data: the set of points to draw.
    about: Both arrays MUST be of the same length. This method DOES NOT refresh the mpWindow; do it manually.
	End Rem
	Method SetData(xs:Double[], ys:Double[])
		bmx_mpfxyvector_setdata(wxObjectPtr, xs, ys)
	End Method
	
	Rem
	bbdoc: Changes the internal data: the set of points to draw.
	End Rem
	Method SetDataRaW(xs:Double Ptr, ys:Double Ptr, length:Int)
		bmx_mpfxyvector_setdataraw(wxObjectPtr, xs, ys, length)
	End Method
	
	Rem
	bbdoc: Clears all the data, leaving the layer empty.
	End Rem
	Method Clear()
		bmx_mpfxyvector_clear(wxObjectPtr)
	End Method
	
	Method Rewind()
'		bmx_mpfxyvector_rewind(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetNextXY:Int(x:Double Var, y:Double Var)
'		Return bmx_mpfxyvector_getnextxy(wxObjectPtr, x, y)
	End Method

End Type

Rem
bbdoc: Plot layer implementing a text string.
about: The text is plotted using a percentage system 0-100%, so the actual
coordinates for the location are not required, and the text stays
on the plot reguardless of the other layers location and scaling factors.
End Rem
Type mpText Extends mpLayer

	Method CreateLayer:mpText(name:String = "Title", offsetx:Int = 5, offsety:Int = 50)
		wxObjectPtr = bmx_mptext_create(Self, name, offsetx, offsety)
		Return Self
	End Method
	
End Type

Rem
bbdoc: Printout class used by mpWindow to draw in the objects to be printed.
about: The object itself can then used by the default wxWidgets printing system to print mpWindow objects.
End Rem
Type mpPrintout Extends wxPrintout

	Method Create:mpPrintout(drawWindow:mpWindow, title:String = "wxMathPlot print output")
		wxObjectPtr = bmx_mpprintout_create(Self, drawWindow.wxObjectPtr, title)
		Return Self
	End Method

End Type

Rem
bbdoc: 
End Rem
Type mpMovableObject Extends mpLayer Abstract

	Method GetCoordinateBase(x:Double Var, y:Double Var, phi:Double Var)
		bmx_mpmovableobject_getcoordinatebase(wxObjectPtr, Varptr x, Varptr y, Varptr phi)
	End Method
	
	Method SetCoordinateBase(x:Double, y:Double, phi:Double)
		bmx_mpmovableobject_setcoordinatebase(wxObjectPtr, x, y, phi)
	End Method
	
	Method SetAlign(align:Int)
		bmx_mpmovableobject_setalign(wxObjectPtr, align)
	End Method
	
End Type

Rem
bbdoc: A 2D ellipse, described by a 2x2 covariance matrix.
End Rem
Type mpCovarianceEllipse Extends mpMovableObject

	Method CreateLayer:mpCovarianceEllipse(cov00:Double = 1, cov11:Double = 1, cov01:Double = 0, quantiles:Double = 2, segments:Int = 32, layerName:String = Null)
		wxObjectPtr = bmx_mpcovarianceelipse_create(Self, cov00, cov11, cov01, quantiles, segments, layerName)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetQuantiles:Double()
		Return bmx_mpcovarianceelipse_getquantiles(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetQuantiles(q:Double)
		bmx_mpcovarianceelipse_setquantiles(wxObjectPtr, q)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetSegments(segments:Int)
		bmx_mpcovarianceelipse_setsegments(wxObjectPtr, segments)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetSegments:Int()
		Return bmx_mpcovarianceelipse_getsegments(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetCovarianceMatrix(cov00:Double, cov01:Double, cov11:Double)
		bmx_mpcovarianceelipse_setcovariancematrix(wxObjectPtr, cov00, cov01, cov11)
	End Method
	
End Type

Rem
bbdoc: An arbitrary polygon, descendant of mpMovableObject.
about: Use #SetPoints() to set the list of N points. This class also can draw non-closed polygons by
passing the appropriate parameters to #SetPoints(). To draw a point-cloud, call #SetContinuity(false).
End Rem
Type mpPolygon Extends mpMovableObject

	Rem
	bbdoc: 
	End Rem
	Method CreateLayer:mpPolygon(name:String = Null)
		wxObjectPtr = bmx_mppolygon_create(Self, name)
		Return Self
	End Method

	Rem
	bbdoc: Sets the points in the polygon.
	End Rem
	Method SetPoints(pointsXs:Double[], pointsYs:Double[], closedShape:Int = True)
		bmx_mppolygon_setpoints(wxObjectPtr, pointsXs, pointsYs, closedShape)
	End Method

End Type

Rem
bbdoc: 
End Rem
Type mpBitmapLayer Extends mpLayer

	Rem
	bbdoc: 
	End Rem
	Method CreateLayer:mpBitmapLayer()
		wxObjectPtr = bmx_mpbitmaplayer_create(Self)
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetBitmapCopy:wxImage()
		Return wxImage._create(bmx_mpbitmaplayer_getbitmapcopy(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetBitmap(image:wxImage, x:Double, y:Double, w:Double, h:Double)
		bmx_mpbitmaplayer_setbitmap(wxObjectPtr, image.wxObjectPtr, x, y, w, h)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetAlign(align:Int)
		bmx_mpbitmaplayer_setalign(wxObjectPtr, align)
	End Method
	
End Type



