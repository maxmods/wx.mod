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

Import wx.wx
Import wx.wxWindow
Import wx.wxPrintout


' headers :-)
?linuxx86
Import "../lib/linux/wx/include/gtk3-unicode-release-static/*.h"
?linuxx64
Import "../lib/linuxx64/wx/include/gtk3-unicode-release-static/*.h"
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
Import "../lib/raspberrypi/wx/include/gtk3-unicode-release-static/*.h"
?
Import "../include/*.h"

Import "wxmathplot/*.h"
Import "wxmathplot/mathplot.cpp"

Import "glue.cpp"

Extern

	Function bmx_mpwindow_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, x:Int, y:Int, w:Int, h:Int, flags:Int)
	Function bmx_mpwindow_fit(handle:Byte Ptr)
	Function bmx_mpwindow_addlayer:Int(handle:Byte Ptr, layer:Byte Ptr, refreshDisplay:Int)
	Function bmx_mpwindow_dellayer:Int(handle:Byte Ptr, layer:Byte Ptr, alsoDeleteObject:Int, refreshDisplay:Int)
	Function bmx_mpwindow_delalllayers(handle:Byte Ptr, alsoDeleteObject:Int, refreshDisplay:Int)
	Function bmx_mpwindow_getlayer:Byte Ptr(handle:Byte Ptr, position:Int)
	Function bmx_mpwindow_getlayerbyname:Byte Ptr(handle:Byte Ptr, name:String)
	Function bmx_mpwindow_updateall(handle:Byte Ptr)
	Function bmx_mpwindow_getscalex:Double(handle:Byte Ptr)
	Function bmx_mpwindow_getscaley:Double(handle:Byte Ptr)
	Function bmx_mpwindow_getposx:Double(handle:Byte Ptr)
	Function bmx_mpwindow_getposy:Double(handle:Byte Ptr)
	Function bmx_mpwindow_getxscreen:Int(handle:Byte Ptr)
	Function bmx_mpwindow_getyscreen:Int(handle:Byte Ptr)
	Function bmx_mpwindow_setscalex(handle:Byte Ptr, scale:Double)
	Function bmx_mpwindow_setscaley(handle:Byte Ptr, scale:Double)
	Function bmx_mpwindow_setposx(handle:Byte Ptr, pos:Double)
	Function bmx_mpwindow_setposy(handle:Byte Ptr, pos:Double)
	Function bmx_mpwindow_setpos(handle:Byte Ptr, x:Double, y:Double)
	Function bmx_mpwindow_setscreen(handle:Byte Ptr, x:Int, y:Int)
	Function bmx_mpwindow_enablemousepanzoom(handle:Byte Ptr, enabled:Int)
	Function bmx_mpwindow_lockaspect(handle:Byte Ptr, enable:Int)
	Function bmx_mpwindow_isaspectlocked:Int(handle:Byte Ptr)
	Function bmx_mpwindow_fitbounds(handle:Byte Ptr, xMin:Double, xMax:Double, yMin:Double, yMax:Double, printSizeX:Int, printSizeY:Int)
	Function bmx_mpwindow_zoomin(handle:Byte Ptr, centerPointX:Int, centerPointY:Int )
	Function bmx_mpwindow_zoomout(handle:Byte Ptr, centerPointX:Int, centerPointY:Int )
	Function bmx_mpwindow_zoominx(handle:Byte Ptr)
	Function bmx_mpwindow_zoomoutx(handle:Byte Ptr)
	Function bmx_mpwindow_zoominy(handle:Byte Ptr)
	Function bmx_mpwindow_zoomouty(handle:Byte Ptr)
	Function bmx_mpwindow_zoomrect(handle:Byte Ptr, x0:Int, y0:Int, x1:Int, y1:Int)
	Function bmx_mpwindow_countlayers:Int(handle:Byte Ptr)
	Function bmx_mpwindow_countalllayers:Int(handle:Byte Ptr)
	Function bmx_mpwindow_getdesiredxmin:Double(handle:Byte Ptr)
	Function bmx_mpwindow_getdesiredxmax:Double(handle:Byte Ptr)
	Function bmx_mpwindow_getdesiredymin:Double(handle:Byte Ptr)
	Function bmx_mpwindow_getdesiredymax:Double(handle:Byte Ptr)
	Function bmx_mpwindow_getboundingbox(handle:Byte Ptr, bbox:Double Ptr)
	Function bmx_mpwindow_setmpscrollbars(handle:Byte Ptr, status:Int)
	Function bmx_mpwindow_getmpscrollbars:Int(handle:Byte Ptr)
	Function bmx_mpwindow_setmargins(handle:Byte Ptr, top:Int, Right:Int, bottom:Int, Left:Int)
	Function bmx_mpwindow_setmargintop(handle:Byte Ptr, value:Int)
	Function bmx_mpwindow_setmarginright(handle:Byte Ptr, value:Int)
	Function bmx_mpwindow_setmarginbottom(handle:Byte Ptr, value:Int)
	Function bmx_mpwindow_setmarginleft(handle:Byte Ptr, value:Int)
	Function bmx_mpwindow_getmargintop:Int(handle:Byte Ptr)
	Function bmx_mpwindow_getmarginright:Int(handle:Byte Ptr)
	Function bmx_mpwindow_getmarginbottom:Int(handle:Byte Ptr)
	Function bmx_mpwindow_getmarginleft:Int(handle:Byte Ptr)
	Function bmx_mpwindow_isinsideinfolayer:Byte Ptr(handle:Byte Ptr, x:Int, y:Int)
	Function bmx_mpwindow_setlayervisible(handle:Byte Ptr, name:String, viewable:Int)
	Function bmx_mpwindow_islayervisible:Int(handle:Byte Ptr, name:String)
	Function bmx_mpwindow_setlayervisiblepos(handle:Byte Ptr, position:Int, viewable:Int)
	Function bmx_mpwindow_islayervisiblepos:Int(handle:Byte Ptr, position:Int)
	Function bmx_mpwindow_setcolourtheme(handle:Byte Ptr, bgColour:Byte Ptr, drawColour:Byte Ptr, axesColour:Byte Ptr)
	Function bmx_mpwindow_getaxescolour:Byte Ptr(handle:Byte Ptr)

	Function bmx_mplayer_setname(handle:Byte Ptr, name:String)
	Function bmx_mplayer_setfont(handle:Byte Ptr, font:Byte Ptr)
	Function bmx_mplayer_setpen(handle:Byte Ptr, pen:Byte Ptr)
	Function bmx_mplayer_hasbbox:Int(handle:Byte Ptr)
	Function bmx_mplayer_isinfo:Int(handle:Byte Ptr)
	Function bmx_mplayer_getminx:Double(handle:Byte Ptr)
	Function bmx_mplayer_getmaxx:Double(handle:Byte Ptr)
	Function bmx_mplayer_getminy:Double(handle:Byte Ptr)
	Function bmx_mplayer_getmaxy:Double(handle:Byte Ptr)
	Function bmx_mplayer_getname:String(handle:Byte Ptr)
	Function bmx_mplayer_getfont:Byte Ptr(handle:Byte Ptr)
	Function bmx_mplayer_getpen:Byte Ptr(handle:Byte Ptr)
	Function bmx_mplayer_setdrawoutsidemargins(handle:Byte Ptr, drawModeOutside:Int)
	Function bmx_mplayer_getdrawoutsidemargins:Int(handle:Byte Ptr)
	Function bmx_mplayer_getcoloursquare:Byte Ptr(handle:Byte Ptr, side:Int)
	Function bmx_mplayer_getlayertype:Int(handle:Byte Ptr)
	Function bmx_mplayer_isvisible:Int(handle:Byte Ptr)
	Function bmx_mplayer_setvisible(handle:Byte Ptr, show:Int)
	Function bmx_mplayer_getbrush:Byte Ptr(handle:Byte Ptr)
	Function bmx_mplayer_setbrush(handle:Byte Ptr, brush:Byte Ptr)
	Function bmx_mplayer_setcontinuity(handle:Byte Ptr, continuity:Int)
	Function bmx_mplayer_getcontinuity:Int(handle:Byte Ptr)
	Function bmx_mplayer_showname(handle:Byte Ptr, show:Int)

	
	Function bmx_mpfx_create:Byte Ptr(handle:Object, name:String, flags:Int)
	
	Function bmx_mpscalex_create:Byte Ptr(handle:Object, name:String, flags:Int, ticks:Int, layerType:Int)
	Function bmx_mpscalex_setalign(handle:Byte Ptr, align:Int)
	Function bmx_mpscalex_setticks(handle:Byte Ptr, ticks:Int)
	Function bmx_mpscalex_getticks:Int(handle:Byte Ptr)
	Function bmx_mpscalex_getlabelmode:Int(handle:Byte Ptr)
	Function bmx_mpscalex_setlabelmode(handle:Byte Ptr, labelMode:Int)
	Function bmx_mpscalex_setlabelformat(handle:Byte Ptr, format:String)
	Function bmx_mpscalex_getlabelformat:String(handle:Byte Ptr)

	Function bmx_mpscaley_create:Byte Ptr(handle:Object, name:String, flags:Int, ticks:Int)
	Function bmx_mpscaley_setalign(handle:Byte Ptr, align:Int)
	Function bmx_mpscaley_setticks(handle:Byte Ptr, ticks:Int)
	Function bmx_mpscaley_getticks:Int(handle:Byte Ptr)
	Function bmx_mpscaley_setlabelformat(handle:Byte Ptr, format:String)
	Function bmx_mpscaley_getlabelformat:String(handle:Byte Ptr)

	Function bmx_mpfxy_create:Byte Ptr(handle:Object, name:String, flags:Int)

	Function bmx_mpfy_create:Byte Ptr(handle:Object, name:String, flags:Int)
	
	Function bmx_mppolygon_create:Byte Ptr(handle:Object, name:String)
	Function bmx_mppolygon_setpoints(handle:Byte Ptr, pointsXs:Double[], pointsYs:Double[], closedShape:Int)

	Function bmx_mpcovarianceelipse_create:Byte Ptr(handle:Object, cov00:Double, cov11:Double, cov01:Double, quantiles:Double, segments:Int, layerName:String)
	Function bmx_mpcovarianceelipse_getquantiles:Double(handle:Byte Ptr)
	Function bmx_mpcovarianceelipse_setquantiles(handle:Byte Ptr, q:Double)
	Function bmx_mpcovarianceelipse_setsegments(handle:Byte Ptr, segments:Int)
	Function bmx_mpcovarianceelipse_getsegments:Int(handle:Byte Ptr)
	Function bmx_mpcovarianceelipse_setcovariancematrix(handle:Byte Ptr, cov00:Double, cov01:Double, cov11:Double)

	Function bmx_mpbitmaplayer_create:Byte Ptr(handle:Object)
	Function bmx_mpbitmaplayer_getbitmapcopy:Byte Ptr(handle:Byte Ptr)
	Function bmx_mpbitmaplayer_setbitmap(handle:Byte Ptr, image:Byte Ptr, x:Double, y:Double, w:Double, h:Double)
	Function bmx_mpbitmaplayer_setalign(handle:Byte Ptr, align:Int)

	Function bmx_mpmovableobject_getcoordinatebase(handle:Byte Ptr, x:Double Ptr, y:Double Ptr, phi:Double Ptr)
	Function bmx_mpmovableobject_setcoordinatebase(handle:Byte Ptr, x:Double, y:Double, phi:Double)
	Function bmx_mpmovableobject_setalign(handle:Byte Ptr, align:Int)

	Function bmx_mpfxyvector_create:Byte Ptr(handle:Object, name:String, flags:Int)
	Function bmx_mpfxyvector_setdata(handle:Byte Ptr, xs:Double[], ys:Double[])
	Function bmx_mpfxyvector_setdataraw(handle:Byte Ptr, xs:Double Ptr, ys:Double Ptr, length:Int)
	Function bmx_mpfxyvector_clear(handle:Byte Ptr)

	Function bmx_mptext_create:Byte Ptr(handle:Object, name:String, offsetx:Int, offsety:Int)

	Function bmx_mpprofile_create:Byte Ptr(handle:Object, name:String, flags:Int)

	Function bmx_mpprintout_create:Byte Ptr(handle:Object, drawWindow:Byte Ptr, title:String)

	Function bmx_mpinfolayer_getposition(handle:Byte Ptr, x:Int Ptr, y:Int Ptr)
	Function bmx_mpinfolayer_getsize(handle:Byte Ptr, w:Int Ptr, h:Int Ptr)

	Function bmx_mpinfocoords_create:Byte Ptr(handle:Object, x:Int, y:Int, w:Int, h:Int, brush:Byte Ptr)

	Function bmx_mpinfolegend_create:Byte Ptr(handle:Object, x:Int, y:Int, w:Int, h:Int, brush:Byte Ptr)

End Extern


Rem
bbdoc: Aligns label to the right.
about: For use with mpFX.
End Rem
Const mpALIGN_RIGHT:Int = $00
Rem
bbdoc: Aligns label to the center.
about: For use with mpFX and mpFY.
End Rem
Const mpALIGN_CENTER:Int = $01
Rem
bbdoc: Aligns label to the left.
about: For use with mpFX.
End Rem
Const mpALIGN_LEFT:Int = $02
Rem
bbdoc: Aligns label to the top.
about: For use with mpFY.
End Rem
Const mpALIGN_TOP:Int = mpALIGN_RIGHT
Rem
bbdoc: Aligns label to the bottom.
about: For use with mpFY.
End Rem
Const mpALIGN_BOTTOM:Int = mpALIGN_LEFT
Rem
bbdoc: Aligns X axis to bottom border.
about: For mpScaleX
End Rem
Const mpALIGN_BORDER_BOTTOM:Int = $04
Rem
bbdoc: Aligns X axis to top border.
about: For mpScaleX
End Rem
Const mpALIGN_BORDER_TOP:Int = $05
Rem
bbdoc: Set label for X axis in normal mode
End Rem
Const mpX_NORMAL:Int = $00
Rem
bbdoc: Set label for X axis in time mode: the value is represented as minutes:seconds.milliseconds if time is less than 2 minutes, hours:minutes:seconds otherwise.
end rem
Const mpX_TIME:Int = $01
Rem
bbdoc: Set label for X axis in hours mode: the value is always represented as hours:minutes:seconds.
end rem
Const mpX_HOURS:Int = $02
Rem
bbdoc: Set label for X axis in date mode: the value is always represented as yyyy-mm-dd.
end rem
Const mpX_DATE:Int = $03
Rem
bbdoc: Set label for X axis in datetime mode: the value is always represented as yyyy-mm-ddThh:mm:ss.
end rem
Const mpX_DATETIME:Int = $04
Rem
bbdoc: Aligns Y axis to left border.
about: For mpScaleY
End Rem
Const mpALIGN_BORDER_LEFT:Int = mpALIGN_BORDER_BOTTOM
Rem
bbdoc: Aligns Y axis to right border.
about: For mpScaleY
End Rem
Const mpALIGN_BORDER_RIGHT:Int = mpALIGN_BORDER_TOP
Rem
bbdoc: Aligns label to north-east.
about: For use with mpFXY.
End Rem
Const mpALIGN_NE:Int = $00
Rem
bbdoc: Aligns label to north-west.
about: For use with mpFXY.
End Rem
Const mpALIGN_NW:Int = $01
Rem
bbdoc: Aligns label to south-west.
about: For use with mpFXY.
End Rem
Const mpALIGN_SW:Int = $02
Rem
bbdoc: Aligns label to south-east.
about: For use with mpFXY.
End Rem
Const mpALIGN_SE:Int = $03


Rem
bbdoc: Fit view to match bounding box of all layers
end rem
Const mpID_FIT:Int = 2000
Rem
bbdoc: Zoom into view at clickposition / window center
end rem
Const mpID_ZOOM_IN:Int = 2001
Rem
bbdoc: Zoom out
end rem
Const mpID_ZOOM_OUT:Int = 2002
Rem
bbdoc: Center view on click position
end rem
Const mpID_CENTER:Int = 2003
Rem
bbdoc: Lock x/y scaling aspect
end rem
Const mpID_LOCKASPECT:Int = 2004
Rem
bbdoc: Shows information about the mouse commands
end rem
Const mpID_HELP_MOUSE:Int = 2005
