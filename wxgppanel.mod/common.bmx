' Copyright (c) 2018 Bruce A Henderson
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
Import wx.wxPanel
Import wx.wxToolBar


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

Import "gppanel/include/*.h"

Import "gppanel/gpPanel/areaChartLayer.cpp"
Import "gppanel/gpPanel/barChartLayer.cpp"
Import "gppanel/gpPanel/baseData.cpp"
Import "gppanel/gpPanel/baseXYData.cpp"
Import "gppanel/gpPanel/baseXYMixedData.cpp"
Import "gppanel/gpPanel/CMinMax.cpp"
Import "gppanel/gpPanel/gpLayer.cpp"
Import "gppanel/gpPanel/gpLineLayer.cpp"
Import "gppanel/gpPanel/gpMultiplotLayer.cpp"
Import "gppanel/gpPanel/gpPanel.cpp"
Import "gppanel/gpPanel/gpSeries.cpp"
Import "gppanel/gpPanel/gpSizer.cpp"
Import "gppanel/gpPanel/lineChartLayer.cpp"
Import "gppanel/gpPanel/MixedLineChartLayer.cpp"
Import "gppanel/gpPanel/mpBitmapLayer.cpp"
Import "gppanel/gpPanel/mpCovarianceEllipse.cpp"
Import "gppanel/gpPanel/mpFX.cpp"
Import "gppanel/gpPanel/mpFX2Y.cpp"
Import "gppanel/gpPanel/mpFXY.cpp"
Import "gppanel/gpPanel/mpFXYBar.cpp"
Import "gppanel/gpPanel/mpFXYCandleStick.cpp"
Import "gppanel/gpPanel/mpFXYVector.cpp"
Import "gppanel/gpPanel/mpFY.cpp"
Import "gppanel/gpPanel/mpFYXBar.cpp"
Import "gppanel/gpPanel/mpInfoCoord.cpp"
Import "gppanel/gpPanel/mpInfoLayer.cpp"
Import "gppanel/gpPanel/mpInfoLegend.cpp"
Import "gppanel/gpPanel/mpLayer.cpp"
Import "gppanel/gpPanel/mpMovableObject.cpp"
Import "gppanel/gpPanel/mpNoteLegend.cpp"
Import "gppanel/gpPanel/mpPointLayer.cpp"
Import "gppanel/gpPanel/mpPolygon.cpp"
Import "gppanel/gpPanel/mpPrintout.cpp"
Import "gppanel/gpPanel/mpProfile.cpp"
Import "gppanel/gpPanel/mpScaleX.cpp"
Import "gppanel/gpPanel/mpScaleY.cpp"
Import "gppanel/gpPanel/mpText.cpp"
Import "gppanel/gpPanel/mpWindow.cpp"
Import "gppanel/gpPanel/mpXYArea.cpp"
Import "gppanel/gpPanel/xyMultimapLabel.cpp"
Import "gppanel/gpPanel/YbarChartLayer.cpp"

Import "gppanel/gpPanel/math/Fourier.cpp"
Import "gppanel/gpPanel/math/gpFormula.cpp"
Import "gppanel/gpPanel/math/gpMath.cpp"

Import "gppanel/gpPanel/menu/gpMenu.cpp"
Import "gppanel/gpPanel/menu/gpMenuGroup.cpp"
Import "gppanel/gpPanel/menu/gpPopup.cpp"
Import "gppanel/gpPanel/menu/gpPopupGroup.cpp"

Import "glue.cpp"

Extern

	Function bmx_wxgppanel_create:Byte Ptr(handle:Object, parent:Byte Ptr, id:Int, x:Int, y:Int, w:Int, h:Int)
	Function bmx_wxgppanel_addlayer:Int(handle:Byte Ptr, layer:Byte Ptr, menuMask:Int)
	Function bmx_wxgppanel_fit(handle:Byte Ptr, layer:Byte Ptr)
	Function bmx_wxgppanel_addlayerhoriz:Int(handle:Byte Ptr, id:Int, layer:Byte Ptr, menuMask:Int, proportion:Int)
	Function bmx_wxgppanel_realizelayers(handle:Byte Ptr)
	Function bmx_wxgppanel_dellayer(handle:Byte Ptr, layer:Byte Ptr)
	Function bmx_wxgppanel_delalllayers(handle:Byte Ptr)
	Function bmx_wxgppanel_fitall(handle:Byte Ptr)
	Function bmx_wxgppanel_fitparams(handle:Byte Ptr, layer:Byte Ptr, xMin:Double, xMax:Double, yMin:Double, yMax:Double, printSizeX:Int Ptr, printSizeY:Int Ptr)
	Function bmx_wxgppanel_lockall(handle:Byte Ptr, lock:Int)
	Function bmx_wxgppanel_lockxaxis(handle:Byte Ptr, layer:Byte Ptr, lock:Int)
	Function bmx_wxgppanel_lockyaxis(handle:Byte Ptr, layer:Byte Ptr, lock:Int)
	Function bmx_wxgppanel_setlayervisible:Int(handle:Byte Ptr, layer:Byte Ptr, viewable:Int)
	Function bmx_wxgppanel_setlayervisiblename:Int(handle:Byte Ptr, layer:String, viewable:Int)
	Function bmx_wxgppanel_setlayervisibleid:Int(handle:Byte Ptr, id:Int, viewable:Int)
	Function bmx_wxgppanel_islayervisible:Int(handle:Byte Ptr, layer:Byte Ptr)
	Function bmx_wxgppanel_islayervisiblename:Int(handle:Byte Ptr, name:String)
	Function bmx_wxgppanel_islayervisibleid:Int(handle:Byte Ptr, id:Int)
	Function bmx_wxgppanel_refresh(handle:Byte Ptr)
	Function bmx_wxgppanel_refreshlayer(handle:Byte Ptr, layer:Byte Ptr)

	Function bmx_gplayer_getname:String(handle:Byte Ptr)
	Function bmx_gplayer_setname(handle:Byte Ptr, name:String)
	Function bmx_gplayer_type:Int(handle:Byte Ptr)
	Function bmx_gplayer_lockchartx(handle:Byte Ptr, value:Int)
	Function bmx_gplayer_lockcharty(handle:Byte Ptr, value:Int)
	Function bmx_gplayer_getlockx:Int(handle:Byte Ptr)
	Function bmx_gplayer_getlocky:Int(handle:Byte Ptr)
	Function bmx_gplayer_setchartboundsenabled(handle:Byte Ptr, value:Int)
	Function bmx_gplayer_setchartbounds(handle:Byte Ptr, xmin:Double, xmax:Double, ymin:Double, ymax:Double)
	Function bmx_gplayer_setboundlocks(handle:Byte Ptr, xmin:Int, xmax:Int, ymin:Int, ymax:Int)
	Function bmx_gplayer_getboundlocks(handle:Byte Ptr, xmin:Int Ptr, xmax:Int Ptr, ymin:Int Ptr, ymax:Int Ptr)
	Function bmx_gplayer_getzoomincrementfactory:Double(handle:Byte Ptr)
	Function bmx_gplayer_iswindowscrollbarsenabled:Int(handle:Byte Ptr)
	Function bmx_gplayer_datapush(handle:Byte Ptr, x:Double, y:Double, z:Double)
	Function bmx_gplayer_dataclear(handle:Byte Ptr)
	Function bmx_gplayer_refreshtooltip(handle:Byte Ptr)
	Function bmx_gplayer_refreshlabels(handle:Byte Ptr)
	Function bmx_gplayer_setxaxistype(handle:Byte Ptr, kind:Int)
	Function bmx_gplayer_setsamplerate(handle:Byte Ptr, d:Double)
	Function bmx_gplayer_setfftlength(handle:Byte Ptr, i:Int)
	Function bmx_gplayer_refreshneeded:Int(handle:Byte Ptr)
	Function bmx_gplayer_refresh(handle:Byte Ptr)
	Function bmx_gplayer_getvisibility:Int(handle:Byte Ptr)
	Function bmx_gplayer_setvisibility(handle:Byte Ptr, value:Int)
	Function bmx_gplayer_getenable:Int(handle:Byte Ptr)
	Function bmx_gplayer_setenable(handle:Byte Ptr, value:Int)
	Function bmx_gplayer_setyxformula(handle:Byte Ptr, formula:String)
	Function bmx_gplayer_setxformula(handle:Byte Ptr, formula:String)
	Function bmx_gplayer_setyformula(handle:Byte Ptr, formula:String)
	Function bmx_gplayer_isyxformula:Int(handle:Byte Ptr)
	Function bmx_gplayer_isxformula:Int(handle:Byte Ptr)
	Function bmx_gplayer_isyformula:Int(handle:Byte Ptr)
	Function bmx_gplayer_getyxformula:String(handle:Byte Ptr)
	Function bmx_gplayer_getxformula:String(handle:Byte Ptr)
	Function bmx_gplayer_getyformula:String(handle:Byte Ptr)
	Function bmx_gplayer_showgrid(handle:Byte Ptr, visibility:Int, mode:Int)
	Function bmx_gplayer_showcornermarkers(handle:Byte Ptr, visibility:Int)
	Function bmx_gplayer_setcontinuousline(handle:Byte Ptr, continuous:Int)
	Function bmx_gplayer_showinfolayer(handle:Byte Ptr, visibility:Int)
	Function bmx_gplayer_addlayer(handle:Byte Ptr, layer:Byte Ptr)
	Function bmx_gplayer_dellayer(handle:Byte Ptr, layer:Byte Ptr)
	Function bmx_gplayer_delalllayers(handle:Byte Ptr)

	Function bmx_gpmenu_getmenuitembyid:Byte Ptr(handle:Byte Ptr, id:Int, menu:Byte Ptr)
	Function bmx_gpmenu_addmenuitem:Int(handle:Byte Ptr, label:String, help:String, kind:Int, checked:Int, toGroup:Int)
	Function bmx_gpmenu_addsubmenuitem:Int(handle:Byte Ptr, label:String, help:String, kind:Int, checked:Int, toGroup:Int)
	Function bmx_gpmenu_newsubmenu(handle:Byte Ptr, label:String)
	Function bmx_gpmenu_appendsubmenu:Int(handle:Byte Ptr, label:String, help:String )
	Function bmx_gpmenu_addid:Int(handle:Byte Ptr, id:Int)
	Function bmx_gpmenu_addnewid:Int(handle:Byte Ptr, primary:Int)
	Function bmx_gpmenu_getprimaryid:Int(handle:Byte Ptr)
	Function bmx_gpmenu_settoolbargroup(handle:Byte Ptr, toolbar:Byte Ptr, group:Int)
	Function bmx_gpmenu_addtoolbaridtogroup(handle:Byte Ptr, group:Int, id:Int)
	Function bmx_gpmenu_checkmenuitem(handle:Byte Ptr, id:Int, checked:Int )
	Function bmx_gpmenu_checkmenugroup(handle:Byte Ptr, group:Int, checked:Int )
	Function bmx_gpmenu_menuidbelongs:Int(handle:Byte Ptr, id:Int)

	Function bmx_gpmultiplotlayer_create:Byte Ptr(label:String, xLabel:String, yLabel:String, plotType:Int)
	Function bmx_gpmultiplotlayer_addserieslayer:Byte Ptr(handle:Byte Ptr, label:String)
	Function bmx_gpmultiplotlayer_settype(handle:Byte Ptr, value:Int)
	Function bmx_gpmultiplotlayer_refreshchart(handle:Byte Ptr)
		
	Function bmx_gpseries_islabel:Int(handle:Byte Ptr, compareLabel:String)
	Function bmx_gpseries_datapush(handle:Byte Ptr, x:Double, y:Double)
	Function bmx_gpseries_refreshchart(handle:Byte Ptr, chartKind:Int, sampleRate:Double, fftLength:Int, customXFormula:String, customYFormula:String, customYXFormula:String, xAxisType:Int, yAxisType:Int)
	Function bmx_gpseries_setcontinuity(handle:Byte Ptr, value:Int)
	Function bmx_gpseries_setvisible(handle:Byte Ptr, value:Int)
	Function bmx_gpseries_showname(handle:Byte Ptr, value:Int)
	Function bmx_gpseries_setpen(handle:Byte Ptr, pen:Byte Ptr)
	Function bmx_gpseries_setbrush(handle:Byte Ptr, brush:Byte Ptr)
	Function bmx_gpseries_dataclear(handle:Byte Ptr)
	Function bmx_gpseries_invert(handle:Byte Ptr, value:Int)

	Function bmx_gplinelayer_create:Byte Ptr(label:String, xLabel:String, yLabel:String)
	
	
	Function bmx_mpfxyvector_create:Byte Ptr(name:String, flags:Int)
	Function bmx_mpfxyvector_setdata(handle:Byte Ptr, xs:Double[], ys:Double[])
	Function bmx_mpfxyvector_clear(handle:Byte Ptr)

	Function bmx_mpfx2y_create:Byte Ptr(handle:Object, name:String, flags:Int)
	
	Function bmx_mpfxy_create:Byte Ptr(handle:Object, name:String, flags:Int)

	Function bmx_mplayer_create:Byte Ptr()

	Function bmx_mplayer_getname:String(handle:Byte Ptr)
	Function bmx_mplayer_getfont:Byte Ptr(handle:Byte Ptr)
	Function bmx_mplayer_getpen:Byte Ptr(handle:Byte Ptr)
	Function bmx_mplayer_setcontinuity(handle:Byte Ptr, value:Int)
	Function bmx_mplayer_getcontinuity:Int(handle:Byte Ptr)
	Function bmx_mplayer_showname(handle:Byte Ptr, value:Int)
	Function bmx_mplayer_setname(handle:Byte Ptr, name:String)
	Function bmx_mplayer_setfont(handle:Byte Ptr, font:Byte Ptr)
	Function bmx_mplayer_setpen(handle:Byte Ptr, pen:Byte Ptr)
	Function bmx_mplayer_setdrawoutsidemargins(handle:Byte Ptr, value:Int)
	Function bmx_mplayer_getdrawoutsidemargins:Int(handle:Byte Ptr)
	Function bmx_mplayer_getcoloursquare:Byte Ptr(handle:Byte Ptr, side:Int)
	Function bmx_mplayer_getlayertype:Int(handle:Byte Ptr)
	Function bmx_mplayer_getpointtype:Int(handle:Byte Ptr)
	Function bmx_mplayer_setpointtype(handle:Byte Ptr, pointType:Int)
	Function bmx_mplayer_isvisible:Int(handle:Byte Ptr)
	Function bmx_mplayer_setvisible(handle:Byte Ptr, value:Int)
	Function bmx_mplayer_getbrush:Byte Ptr(handle:Byte Ptr)
	Function bmx_mplayer_setbrush(handle:Byte Ptr, brush:Byte Ptr)
	Function bmx_mplayer_invert(handle:Byte Ptr, value:Int)
	Function bmx_mplayer_getinvert:Int(handle:Byte Ptr)

	Function bmx_mplayer_hasbbox:Int(handle:Byte Ptr)
	Function bmx_mplayer_isinfo:Int(handle:Byte Ptr)
	Function bmx_mplayer_isinfolegendlayer:Int(handle:Byte Ptr)
	Function bmx_mplayer_ismovablelayer:Int(handle:Byte Ptr)
	Function bmx_mplayer_isscalexlayer:Int(handle:Byte Ptr)
	Function bmx_mplayer_isscaleylayer:Int(handle:Byte Ptr)
	Function bmx_mplayer_ispointlayer:Int(handle:Byte Ptr)
	Function bmx_mplayer_getminx:Double(handle:Byte Ptr)
	Function bmx_mplayer_getmaxx:Double(handle:Byte Ptr)
	Function bmx_mplayer_getminy:Double(handle:Byte Ptr)
	Function bmx_mplayer_getmaxy:Double(handle:Byte Ptr)

End Extern

Rem
bbdoc: Layer type undefined
end rem
Const mpLAYER_UNDEF:Int = 0
Rem
bbdoc: Axis type layer
end rem
Const mpLAYER_AXIS:Int = 1
Rem
bbdoc: Plot type layer
end rem
Const mpLAYER_PLOT:Int = 2
Rem
bbdoc: Info box type layer
end rem
Const mpLAYER_INFO:Int = 3
Rem
bbdoc: Bitmap type layer
End Rem
Const mpLAYER_BITMAP:Int = 4
Rem
bbdoc: Point layer
end rem
Const mpLayer_POINT:Int = 5

Const mpCIRCLE:Int = 0
Const mpRECT:Int = 1
Const mpPOINT:Int = 2
Const mpDIAMOND:Int = 3
Const mpSQUARE:Int = 4
Const mpELLIPSE:Int = 5
Const mpARROW_UP:Int = 6
Const mpARROW_DOWN:Int = 7
Const mpARROW_UPDOWN:Int = 8

Const gpLAYER_UNDEFINED:Int = 0
Const gpLAYER_HISTOGRAM:Int = 1
Const gpLAYER_HITS:Int = 2
Const gpLAYER_LINE:Int = 3
Const gpLAYER_TDCRESULT:Int = 4
Const gpLAYER_BAR:Int = 5

Rem
bbdoc: Default type
End Rem
Const gpCHART_DEFAULT:Int = 0
Rem
bbdoc: x-axis is in frequence
End Rem
Const gpCHART_FFT:Int = 1
Rem
bbdoc: integral nonlinearity
End Rem
Const gpCHART_INL:Int = 2
Rem
bbdoc: differential nonlinearity
End Rem
Const gpCHART_DNL:Int = 3
Rem
bbdoc: Accumulation
End Rem
Const gpCHART_ACCUMULATION:Int = 4
Rem
bbdoc: Custom formula by formula
End Rem
Const gpCHART_CUSTOM:Int = 5

Rem
bbdoc: Default scaling
End Rem
Const gpAXIS_DEFAULT:Int = 0
Rem
bbdoc: Time scaling
End Rem
Const gpAXIS_TIME:Int = 1
Rem
bbdoc: Procent scaling
End Rem
Const gpAXIS_PROCENT:Int = 2
Rem
bbdoc: Distance scaling
End Rem
Const gpAXIS_DISTANCE:Int = 3
Rem
bbdoc: N scaling
End Rem
Const gpAXIS_N:Int = 4
Rem
bbdoc: Custom scaling by formula
End Rem
Const gpAXIS_CUSTOM:Int = 5

Const gpXAXIS:Int = 1
Const gpYAXIS:Int = 2
Const gpWINDOW:Int = 3


Rem
bbdoc: Aligns label to the right. For use with mpFX. 
End Rem
Const mpALIGN_RIGHT:Int = $00
Rem
bbdoc: Aligns label to the center. For use with mpFX and mpFY. 
End Rem
Const mpALIGN_CENTER:Int = $01
Rem
bbdoc: Aligns label to the left. For use with mpFX. 
End Rem
Const mpALIGN_LEFT:Int = $02
Rem
bbdoc: Aligns label to the top. For use with mpFY. 
End Rem
Const mpALIGN_TOP:Int = mpALIGN_RIGHT
Rem
bbdoc: Aligns label to the bottom. For use with mpFY. 
End Rem
Const mpALIGN_BOTTOM:Int = mpALIGN_LEFT
Rem
bbdoc: Aligns X axis to bottom border. For mpScaleX 
End Rem
Const mpALIGN_BORDER_BOTTOM:Int = $04
Rem
bbdoc: Aligns X axis to top border. For mpScaleX 
End Rem
Const mpALIGN_BORDER_TOP:Int = $05
Rem
bbdoc: Set label for X axis in normal mode 
End Rem
Const mpX_NORMAL:Int = $00
Rem
bbdoc: Set label for X axis in time mode: the value is represented as minutes:seconds.milliseconds if time is less than 2 minutes, hours:minutes:seconds otherwise
End Rem
Const mpX_TIME:Int = $01
Rem
bbdoc: Set label for X axis in hours mode: the value is always represented as hours:minutes:seconds
End Rem
Const mpX_HOURS:Int = $02
Rem
bbdoc: Set label for X axis in date mode: the value is always represented as yyyy-mm-dd. 
End Rem
Const mpX_DATE:Int = $03
Rem
bbdoc: Set label for X axis in datetime mode: the value is always represented as yyyy-mm-ddThh:mm:ss. 
End Rem
Const mpX_DATETIME:Int = $04
Rem
bbdoc: Set label for X axis in logarithmic mode
End Rem
Const mpX_LOGARITHMIC:Int = $05
Rem
bbdoc: Aligns Y axis to left border. For mpScaleY 
End Rem
Const mpALIGN_BORDER_LEFT:Int = mpALIGN_BORDER_BOTTOM
Rem
bbdoc: Aligns Y axis to right border. For mpScaleY 
End Rem
Const mpALIGN_BORDER_RIGHT:Int = mpALIGN_BORDER_TOP
Rem
bbdoc: Aligns label to north-east. For use with mpFXY. 
End Rem
Const mpALIGN_NE:Int = $00
Rem
bbdoc: Aligns label to north-west. For use with mpFXY. 
End Rem
Const mpALIGN_NW:Int = $01
Rem
bbdoc: Aligns label to south-west. For use with mpFXY. 
End Rem
Const mpALIGN_SW:Int = $02
Rem
bbdoc: Aligns label to south-east. For use with mpFXY. 
End Rem
Const mpALIGN_SE:Int = $03
