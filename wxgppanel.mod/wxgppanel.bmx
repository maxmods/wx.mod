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

Rem
bbdoc: 
End Rem
Module wx.wxgpPanel

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2018 Bruce A Henderson"

ModuleInfo "CC_OPTS: -std=c++11"

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
?deprecated
Import "common.bmx"

Rem
bbdoc: 
End Rem
Type gpPanel Extends wxPanel

	Function _create:gpPanel(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:gpPanel = New gpPanel
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function
	
	Function _find:Object(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:Object = wxfind(wxObjectPtr)
			If Not this Then
				Return gpPanel._create(wxObjectPtr)
			End If
			Return this
		End If
	End Function

	Rem
	bbdoc: TODO
	End Rem
	Function CreategpPanel:gpPanel(parent:wxWindow = Null, id:Int = -1, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1)
		Return New gpPanel.Create(parent, id, x, y, w, h)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:gpPanel(parent:wxWindow = Null, id:Int = -1, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1)
		If parent Then
			wxObjectPtr = bmx_wxgppanel_create(Self, parent.wxObjectPtr, id, x, y, w, h)
		Else
			wxObjectPtr = bmx_wxgppanel_create(Self, Null, id, x, y, w, h)
		End If
		
		OnInit()
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Method AddLayer:Int(layer:gpLayer, menuMask:Int = 0)
		Return bmx_wxgppanel_addlayer(wxObjectPtr, layer.wxObjectPtr, menuMask)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method AddLayerHoriz:Int(id:Int, layer:gpLayer, menuMask:Int, proportion:Int = 1)
		Return bmx_wxgppanel_addlayerhoriz(wxObjectPtr, id, layer.wxObjectPtr, menuMask, proportion)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method RealizeLayers()
		bmx_wxgppanel_realizelayers(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DelLayer(layer:gpLayer)
		bmx_wxgppanel_dellayer(wxObjectPtr, layer.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DelAllLayers()
		bmx_wxgppanel_delalllayers(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method FitAll()
		bmx_wxgppanel_fitall(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Fit(layer:gpLayer)
		bmx_wxgppanel_fit(wxObjectPtr, layer.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method FitParams(layer:gpLayer, xMin:Double, xMax:Double, yMin:Double, yMax:Double, printSizeX:Int Var, printSizeY:Int Var)
		bmx_wxgppanel_fitparams(wxObjectPtr, layer.wxObjectPtr, xMin, xMax, yMin, yMax, Varptr printSizeX, Varptr printSizeY)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method LockAll(lock:Int = True)
		bmx_wxgppanel_lockall(wxObjectPtr, lock)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method LockXAxis(layer:gpLayer, lock:Int = True)
		bmx_wxgppanel_lockxaxis(wxObjectPtr, layer.wxObjectPtr, lock)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method LockYAxis(layer:gpLayer, lock:Int = True)
		bmx_wxgppanel_lockyaxis(wxObjectPtr, layer.wxObjectPtr, lock)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetLayerVisible:Int(layer:gpLayer, viewable:Int)
		bmx_wxgppanel_setlayervisible(wxObjectPtr, layer.wxObjectPtr, viewable)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetLayerVisibleName:Int(layer:String, viewable:Int)
		bmx_wxgppanel_setlayervisiblename(wxObjectPtr, layer, viewable)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetLayerVisibleId:Int(id:Int, viewable:Int)
		bmx_wxgppanel_setlayervisibleid(wxObjectPtr, id, viewable)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsLayerVisible:Int(layer:gpLayer)
		Return bmx_wxgppanel_islayervisible(wxObjectPtr, layer.wxObjectPtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method IsLayerVisibleName:Int(name:String)
		Return bmx_wxgppanel_islayervisiblename(wxObjectPtr, name)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method IsLayerVisibleId:Int(id:Int)
		Return bmx_wxgppanel_islayervisibleid(wxObjectPtr, id)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method Refresh()
		bmx_wxgppanel_refresh(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method RefreshLayer(layer:gpLayer)
		bmx_wxgppanel_refreshlayer(wxObjectPtr, layer.wxObjectPtr)
	End Method
	
End Type


Rem
bbdoc: 
End Rem
Type gpLayer Extends gpMenu Abstract

	Rem
	bbdoc: 
	End Rem
	Method GetName:String()
		Return bmx_gplayer_getname(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetName(name:String)
		bmx_gplayer_setname(wxObjectPtr, name)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method gpType:Int()
		Return bmx_gplayer_type(wxObjectPtr)
	End Method
	
	'Method GetLayer:mpLayer()
	'End Method
	
	Rem
	bbdoc: 
	End Rem
	Method LockChartX(value:Int)
		bmx_gplayer_lockchartx(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method LockChartY(value:Int)
		bmx_gplayer_lockcharty(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetLockX:Int()
		Return bmx_gplayer_getlockx(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetLockY:Int()
		Return bmx_gplayer_getlocky(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetChartBoundsEnabled(value:Int)
		bmx_gplayer_setchartboundsenabled(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetChartBounds(xmin:Double, xmax:Double, ymin:Double, ymax:Double)
		bmx_gplayer_setchartbounds(wxObjectPtr, xmin, xmax, ymin, ymax)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetBoundLocks(xmin:Int, xmax:Int, ymin:Int, ymax:Int)
		bmx_gplayer_setboundlocks(wxObjectPtr, xmin, xmax, ymin, ymax)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetBoundLocks(xmin:Int Var, xmax:Int Var, ymin:Int Var, ymax:Int Var)
		bmx_gplayer_getboundlocks(wxObjectPtr, Varptr xmin, Varptr xmax, Varptr ymin, Varptr ymax)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetZoomIncrementFactory:Double()
		Return bmx_gplayer_getzoomincrementfactory(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsWindowScrollbarsEnabled:Int()
		Return bmx_gplayer_iswindowscrollbarsenabled(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DataPush(x:Double, y:Double, z:Double = 0)
		bmx_gplayer_datapush(wxObjectPtr, x, y, z)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DataClear()
		bmx_gplayer_dataclear(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method RefreshChart() Abstract
	
	Rem
	bbdoc: 
	End Rem
	Method RefreshToolTip()
		bmx_gplayer_refreshtooltip(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method RefreshLabels()
		bmx_gplayer_refreshlabels(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetXAxisType(kind:Int)
		bmx_gplayer_setxaxistype(wxObjectPtr, kind)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetSamplerate(d:Double)
		bmx_gplayer_setsamplerate(wxObjectPtr, d)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetFftLength(i:Int)
		bmx_gplayer_setfftlength(wxObjectPtr, i)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method RefreshNeeded:Int()
		Return bmx_gplayer_refreshneeded(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Refresh()
		bmx_gplayer_refresh(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetVisibility:Int()
		Return bmx_gplayer_getvisibility(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetVisibility(value:Int)
		bmx_gplayer_setvisibility(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetEnable:Int()
		Return bmx_gplayer_getenable(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetEnable(value:Int)
		bmx_gplayer_setenable(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetYXFormula(formula:String)
		bmx_gplayer_setyxformula(wxObjectPtr, formula)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetXFormula(formula:String)
		bmx_gplayer_setxformula(wxObjectPtr, formula)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetYFormula(formula:String)
		bmx_gplayer_setyformula(wxObjectPtr, formula)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsYXFormula:Int()
		Return bmx_gplayer_isyxformula(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsXFormula:Int()
		Return bmx_gplayer_isxformula(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsYFormula:Int()
		Return bmx_gplayer_isyformula(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetYXFormula:String()
		Return bmx_gplayer_getyxformula(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetXFormula:String()
		Return bmx_gplayer_getxformula(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetYFormula:String()
		Return bmx_gplayer_getyformula(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ShowGrid(visibility:Int, mode:Int = gpXAXIS | gpYAXIS)
		bmx_gplayer_showgrid(wxObjectPtr, visibility, mode)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ShowCornerMarkers(visibility:Int)
		bmx_gplayer_showcornermarkers(wxObjectPtr, visibility)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetContinuousLine(continuous:Int)
		bmx_gplayer_setcontinuousline(wxObjectPtr, continuous)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ShowInfoLayer(visibility:Int)
		bmx_gplayer_showinfolayer(wxObjectPtr, visibility)
	End Method	
	
	Method SelectXAxisScale:Int(kind:Int)
		Return bmx_gplayer_selectxaxisscale(wxObjectPtr, kind)
	End Method
	
	Method SelectYAxisScale:Int(kind:Int)
		Return bmx_gplayer_selectyaxisscale(wxObjectPtr, kind)
	End Method
	
	Method SetChartKind:Int(kind:Int)
		Return bmx_gplayer_setchartkind(wxObjectPtr, kind)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method AddLayer(layer:mpLayer)
		bmx_gplayer_addlayer(wxObjectPtr, layer.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DelLayer(layer:mpLayer)
		bmx_gplayer_dellayer(wxObjectPtr, layer.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method DelAllLayers()
		bmx_gplayer_delalllayers(wxObjectPtr)
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type gpLineLayer Extends gpLayer

	Method Create:gpLineLayer(label:String, xLabel:String, yLabel:String)
		wxObjectPtr = bmx_gplinelayer_create(label, xLabel, yLabel)
		Return Self
	End Method

	Method GetPointCount:Int()
	End Method
	

End Type

Rem
bbdoc: 
End Rem
Type gpMultiPlotLayer Extends gpLayer

	Const TYPE_BAR:Int = 0
	Const TYPE_LINE:Int = 1
	Const TYPE_AREA:Int = 2
	Const TYPE_POINT:Int = 3
	
	Rem
	bbdoc: 
	End Rem
	Method Create:gpMultiPlotLayer(label:String, xLabel:String, yLabel:String, plotType:Int = TYPE_LINE)
		wxObjectPtr = bmx_gpmultiplotlayer_create(label, xLabel, yLabel, plotType)
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetType(value:Int)
		bmx_gpmultiplotlayer_settype(wxObjectPtr, value)
	End Method
	
	Method InvertYScale(value:Int)
		bmx_gpmultiplotlayer_invertyscale(wxObjectPtr, value)
	End Method
	
	Method MyDataPush(x:Double, y:Double, seriesLabel:String)
		bmx_gpmultiplotlayer_mydatapush(wxObjectPtr, x, y, seriesLabel)
	End Method
	
	Method DataClearLabel(seriesLabel:String)
		bmx_gpmultiplotlayer_dataclearlabel(wxObjectPtr, seriesLabel)
	End Method

	Method RefreshChart()
		bmx_gpmultiplotlayer_refreshchart(wxObjectPtr)
	End Method
	
	Method AddSeriesLayer:gpSeries(label:String)
		Return gpSeries._create(bmx_gpmultiplotlayer_addserieslayer(wxObjectPtr, label))
	End Method
	
	Method SetPen(pen:wxPen, seriesLabel:String)
		bmx_gpmultiplotlayer_setpen(wxObjectPtr, pen.wxObjectPtr, seriesLabel)
	End Method
	
	Method DeleteSeries(seriesLabel:String)
		bmx_gpmultiplotlayer_deleteseries(wxObjectPtr, seriesLabel)
	End Method
	
	Method AddLegendInfo(x:Int = 200, y:Int = 20)
		bmx_gpmultiplotlayer_addlegendinfo(wxObjectPtr, x, y)
	End Method
	
	Method AddCoordInfo(x:Int = 80, y:Int = 20)
		bmx_gpmultiplotlayer_addcoordinfo(wxObjectPtr, x, y)
	End Method
	
	Method getMinY:Double()
		Return bmx_gpmultiplotlayer_getminy(wxObjectPtr)
	End Method
	
	Method GetChartKind:Int()
		Return bmx_gpmultiplotlayer_getchartkind(wxObjectPtr)
	End Method
	
	

End Type

Rem
bbdoc: Handles gpLayer menu.
about: User can add menu items to gpLayer and get MenuItemList for adding main menu.
End Rem
Type gpMenu Extends wxToolTip

	Rem
	bbdoc: 
	End Rem
	Method GetMenuItemById:wxMenuItem(id:Int, menu:wxMenu = Null)
		If menu Then
			Return wxMenuItem._create(bmx_gpmenu_getmenuitembyid(wxObjectPtr, id, menu.wxObjectPtr))
		Else
			Return wxMenuItem._create(bmx_gpmenu_getmenuitembyid(wxObjectPtr, id, Null))
		End If
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method AddMenuItem:Int(label:String, help:String = Null, kind:Int = wxITEM_NORMAL, checked:Int = True, toGroup:Int = 0)
		Return bmx_gpmenu_addmenuitem(wxObjectPtr, label, help, kind, checked, toGroup)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method AddSubMenuItem:Int(label:String, help:String = Null, kind:Int = wxITEM_NORMAL, checked:Int = True, toGroup:Int = 0)
		Return bmx_gpmenu_addsubmenuitem(wxObjectPtr, label, help, kind, checked, toGroup)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method NewSubMenu(label:String = Null)
		bmx_gpmenu_newsubmenu(wxObjectPtr, label)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method AppendSubMenu:Int(label:String, help:String = Null)
		Return bmx_gpmenu_appendsubmenu(wxObjectPtr, label, help)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method AddId:Int(id:Int)
		Return bmx_gpmenu_addid(wxObjectPtr, id)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method AddNewId:Int(primary:Int = False)
		Return bmx_gpmenu_addnewid(wxObjectPtr, primary)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetPrimaryId:Int()
		Return bmx_gpmenu_getprimaryid(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetToolBarGroup(toolbar:wxToolBar, group:Int)
		bmx_gpmenu_settoolbargroup(wxObjectPtr, toolbar.wxObjectPtr, group)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method AddToolBarIdToGroup(group:Int, id:Int)
		bmx_gpmenu_addtoolbaridtogroup(wxObjectPtr, group, id)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CheckMenuItem(id:Int, checked:Int = True)
		bmx_gpmenu_checkmenuitem(wxObjectPtr, id, checked)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method CheckMenuGroup(group:Int, checked:Int = True)
		bmx_gpmenu_checkmenugroup(wxObjectPtr, group, checked)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method MenuIdBelongs:Int(id:Int)
		Return bmx_gpmenu_menuidbelongs(wxObjectPtr, id)
	End Method
	
	Method GetMenuItems:wxMenuItem[]()
		' TODO
	End Method
	
	Method GetMenu:wxMenu()
		' TODO
	End Method

End Type

Rem
bbdoc: 
End Rem
Type gpSeries

	Field seriesPtr:Byte Ptr

	Function _create:gpSeries(seriesPtr:Byte Ptr)
		If seriesPtr Then
			Local this:gpSeries = New gpSeries
			this.seriesPtr = seriesPtr
			Return this
		End If
	End Function

	Method IsLabel:Int(compareLabel:String)
		Return bmx_gpseries_islabel(seriesPtr, compareLabel)
	End Method
	
	Method DataPush(x:Double, y:Double)
		bmx_gpseries_datapush(seriesPtr, x, y)
	End Method
	
	Rem
	gpCHART_KIND gpChart_kind, double samplerate,
		int fftlenght, wxString customXFormula, wxString customYFormula,
		wxString customYXFormula, gpAXIS_SCALE gpXaxis_type,
		gpAXIS_SCALE gpYaxis_type
		End Rem
	Method RefreshChart(chartKind:Int, sampleRate:Double, fftLength:Int, customXFormula:String, customYFormula:String, customYXFormula:String, xAxisType:Int, yAxisType:Int)
		bmx_gpseries_refreshchart(seriesPtr, chartKind, sampleRate, fftLength, customXFormula, customYFormula, customYXFormula, xAxisType, yAxisType)
	End Method
	
	Method SetContinuity(value:Int)
		bmx_gpseries_setcontinuity(seriesPtr, value)
	End Method
	
	Method SetVisible(value:Int)
		bmx_gpseries_setvisible(seriesPtr, value)
	End Method
	
	Method ShowName(value:Int)
		bmx_gpseries_showname(seriesPtr, value)
	End Method
	
	Method SetPen(pen:wxPen)
		bmx_gpseries_setpen(seriesPtr, pen.wxObjectPtr)
	End Method
	
	Method SetBrush(brush:wxBrush)
		bmx_gpseries_setbrush(seriesPtr, brush.wxObjectPtr)
	End Method
	
	Method DataClear()
		bmx_gpseries_dataclear(seriesPtr)
	End Method
	
	Method Invert(value:Int)
		bmx_gpseries_invert(seriesPtr, value)
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type mpLayer Extends wxObject

	Rem
	bbdoc: 
	End Rem
	Method Create:mpLayer()
		wxObjectPtr = bmx_mplayer_create()
		Return Self
	End Method

	Rem
	bbdoc: 
	End Rem
	Method HasBBox:Int()
		Return bmx_mplayer_hasbbox(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsInfo:Int()
		Return bmx_mplayer_isinfo(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsInfoLegendLayer:Int()
		Return bmx_mplayer_isinfolegendlayer(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsMovableLayer:Int()
		Return bmx_mplayer_ismovablelayer(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsScaleXLayer:Int()
		Return bmx_mplayer_isscalexlayer(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsScaleYLayer:Int()
		Return bmx_mplayer_isscaleylayer(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsPointLayer:Int()
		Return bmx_mplayer_ispointlayer(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetMinX:Double()
		Return bmx_mplayer_getminx(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetMaxX:Double()
		Return bmx_mplayer_getmaxx(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetMinY:Double()
		Return bmx_mplayer_getminy(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetMaxY:Double()
		Return bmx_mplayer_getmaxy(wxObjectPtr)
	End Method
	
	
	
	Rem
	bbdoc: 
	End Rem
	Method GetName:String()
		Return bmx_mplayer_getname(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetFont:wxFont()
		Return wxFont._create(bmx_mplayer_getfont(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetPen:wxPen()
		Return wxPen._create(bmx_mplayer_getpen(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetContinuity(value:Int)
		bmx_mplayer_setcontinuity(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetContinuity:Int()
		Return bmx_mplayer_getcontinuity(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method ShowName(value:Int)
		bmx_mplayer_showname(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetName(name:String)
		bmx_mplayer_setname(wxObjectPtr, name)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetFont(font:wxFont)
		bmx_mplayer_setfont(wxObjectPtr, font.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetPen(pen:wxPen)
		bmx_mplayer_setpen(wxObjectPtr, pen.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetDrawOutsideMargins(value:Int)
		bmx_mplayer_setdrawoutsidemargins(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetDrawOutsideMargins:Int()
		Return bmx_mplayer_getdrawoutsidemargins(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetColourSquare:wxBitmap(side:Int = 16)
		Return wxBitmap._create(bmx_mplayer_getcoloursquare(wxObjectPtr, side))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetLayerType:Int()
		Return bmx_mplayer_getlayertype(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetPointType:Int()
		Return bmx_mplayer_getpointtype(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetPointType(pointType:Int)
		bmx_mplayer_setpointtype(wxObjectPtr, pointType)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method IsVisible:Int()
		Return bmx_mplayer_isvisible(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetVisible(value:Int)
		bmx_mplayer_setvisible(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetBrush:wxBrush()
		Return wxBrush._create(bmx_mplayer_getbrush(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method SetBrush(brush:wxBrush)
		bmx_mplayer_setbrush(wxObjectPtr, brush.wxObjectPtr)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Invert(value:Int)
		bmx_mplayer_invert(wxObjectPtr, value)
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetInvert:Int()
		Return bmx_mplayer_getinvert(wxObjectPtr)
	End Method

	' callback
	Function _HasBBox:Int(obj:mpLayer) { nomangle }
		Return obj.HasBBox()
	End Function

	' callback
	Function _IsInfo:Int(obj:mpLayer) { nomangle }
		Return obj.IsInfo()
	End Function
	
	' callback
	Function _IsInfoLegendLayer:Int(obj:mpLayer) { nomangle }
		Return obj.IsInfoLegendLayer()
	End Function
	
	' callback
	Function _IsMovableLayer:Int(obj:mpLayer) { nomangle }
		Return obj.IsMovableLayer()
	End Function
	
	' callback
	Function _IsScaleXLayer:Int(obj:mpLayer) { nomangle }
		Return obj.IsScaleXLayer()
	End Function
	
	' callback
	Function _IsScaleYLayer:Int(obj:mpLayer) { nomangle }
		Return obj.IsScaleYLayer()
	End Function
	
	' callback
	Function _IsPointLayer:Int(obj:mpLayer) { nomangle }
		Return obj.IsPointLayer()
	End Function
	
	' callback
	Function _GetMinX:Double(obj:mpLayer) { nomangle }
		Return obj.GetMinX()
	End Function
	
	' callback
	Function _GetMaxX:Double(obj:mpLayer) { nomangle }
		Return obj.GetMaxX()
	End Function
	
	' callback
	Function _GetMinY:Double(obj:mpLayer) { nomangle }
		Return obj.GetMinY()
	End Function
	
	' callback
	Function _GetMaxY:Double(obj:mpLayer) { nomangle }
		Return obj.GetMaxY()
	End Function

End Type

Type mpScaleX Extends mpLayer

End Type

Type mpScaleY Extends mpLayer

End Type

Type mpFXYCandleStick Extends mpLayer

End Type

Type mpBitmapLayer Extends mpLayer

End Type

Type mpFXYBar Extends mpLayer

End Type

Rem
bbdoc: Double line with middle value
End Rem
Type mpFX2Y Extends mpLayer

	Method Create:mpFX2Y(name:String = Null, flags:Int = mpALIGN_NE)
		wxObjectPtr = bmx_mpfx2y_create(Self, name, flags)
		Return Self
	End Method

	Rem
	bbdoc: Rewind value enumeration with mpFX2Y::GetNextX2Y.
	about: Override this method in your implementation
	End Rem
	Method Rewind()
	End Method
	
	Rem
	bbdoc: Get locus value for next N.
	about: Override this method in your implementation.
	End Rem
	Method GetNextX2Y:Int(x:Double Var, y1:Double Var, y2:Double Var)
	End Method

	' callback
	Function _Rewind(obj:mpFX2Y) { nomangle }
		obj.Rewind()
	End Function
	
	' callback
	Function _GetNextX2Y:Int(obj:mpFX2Y, x:Double Var, y1:Double Var, y2:Double Var) { nomangle }
		Return obj.GetNextX2Y(x, y1, y2)
	End Function

End Type

Rem
bbdoc: Provides plot and labeling functionality for a locus plot F:N->X,Y.
about: Locus argument N is assumed to be in range 0 .. MAX_N, and implicitly derived by enumerating
all locus values. Override mpFXY::Rewind and mpFXY::GetNextXY to implement a locus.
If the layer name is empty, no label will be plotted.
End Rem
Type mpFXY Extends mpLayer

	Method Create:mpFXY(name:String = Null, flags:Int = mpALIGN_NE)
		wxObjectPtr = bmx_mpfxy_create(Self, name, flags)
		Return Self
	End Method
	
	Rem
	bbdoc: 
	End Rem
	Method Rewind()
	End Method

	'Method CurrentBounds(xmin:Double, ymin:Double)
	'End Method
	
	Rem
	bbdoc: 
	End Rem
	Method GetNextXY:Int(x:Double Var, y:Double Var)
	End Method

	' callback
	Function _Rewind(obj:mpFXY) { nomangle }
		obj.Rewind()
	End Function

	' callback
	Function _GetNextXY:Int(obj:mpFXY, x:Double Var, y:Double Var) { nomangle }
		Return obj.GetNextXY(x, y)
	End Function

End Type

Rem
bbdoc: 
End Rem
Type mpFXYVector Extends mpFXY

	Method Create:mpFXYVector(name:String = Null, flags:Int = mpALIGN_NE)
		wxObjectPtr = bmx_mpfxyvector_create(name, flags)
		Return Self
	End Method
	
	Method SetData(xs:Double[], ys:Double[])
		bmx_mpfxyvector_setdata(wxObjectPtr, xs, ys)
	End Method
	
	Method Clear()
		bmx_mpfxyvector_clear(wxObjectPtr)
	End Method

End Type
?