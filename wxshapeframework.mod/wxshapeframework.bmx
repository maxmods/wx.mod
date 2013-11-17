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

Rem
bbdoc: wxShapeFramework
End Rem
Module wx.wxShapeFramework

ModuleInfo "Version: 1.00"
ModuleInfo "License: MIT"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "Copyright: (c) 2009-2013 Bruce A Henderson"


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

ModuleInfo "CC_OPTS: -fexceptions"

Import "common.bmx"

'
' Build notes :
' ScaledDC.h - added const for DoDrawLines() and DoDrawPolygon()
'

Rem
bbdoc: 
End Rem
Type wxSFDiagramManager

	Field wxObjectPtr:Byte Ptr
	
	Function CreateDiagramManager:wxSFDiagramManager()
		Return New wxSFDiagramManager.Create()
	End Function
	
	Method Create:wxSFDiagramManager()
		wxObjectPtr = bmx_wxsfdiagrammanager_create(Self)
		Return Self
	End Method
	
	Method GetVersion:String()
	End Method
	
	Method CreateConnection:wxSFShapeBase(srcId:Int, trgId:Int, saveState:Int = True)
	End Method
	
	Method AddShape:wxSFShapeBase(shapeInfo:String, xPos:Int = -1, yPos:Int = -1, saveState:Int = True)
		Return wxSFShapeBase(bmx_wxsfdiagrammanager_addshape(wxObjectPtr, shapeInfo, xPos, yPos, saveState))
	End Method
	
	Method RemoveShape(shape:wxSFShapeBase, refresh:Int = True)
	End Method
	
	Method Clear()
	End Method
	
	Method SerializeToXml(stream:wxOutputStream)
	End Method
	
	Method DeserializeFromXml(stream:wxInputStream)
	End Method
	
	Method AcceptShape(shapeType:String)
		bmx_wxsfdiagrammanager_acceptshape(wxObjectPtr, shapeType)
	End Method
	
	Method IsShapeAccepted:Int(shapeType:String)
	End Method
	
	Method ClearAcceptedShapes()
	End Method
	
	Method GetAcceptedShapes:String[]()
	End Method
	
	Method FindShape:wxSFShapeBase(id:Int)
	End Method
	
	Method GetAssignedConnections()
	' TODO
	End Method

	

End Type

Rem
bbdoc: 
End Rem
Type wxSFShapeCanvas Extends wxScrolledWindow

	Rem
	bbdoc: The shape canvas is in ready state (no operation is pending)
	end rem
	Const modeREADY:Int = 0
	Rem
	bbdoc:  Some shape handle is dragged
	end rem
	Const modeHANDLEMOVE:Int = 1
	Rem
	bbdoc:  Handle of multiselection tool is dragged
	end rem
	Const modeMULTIHANDLEMOVE:Int = 2
	Rem
	bbdoc:  Some shape/s is/are dragged
	end rem
	Const modeSHAPEMOVE:Int = 3
	Rem
	bbdoc:  Multiple shape selection is in progess
	end rem
	Const modeMULTISELECTION:Int = 4
	Rem
	bbdoc:  Interactive connection creation is in progress
	end rem
	Const modeCREATECONNECTION:Int = 5
	Rem
	bbdoc:  Canvas is in the Drag&Drop mode
	end rem
	Const modeDND:Int = 6
	
	Const valignNONE:Int = 0
	Const valignTOP:Int = 1
	Const valignMIDDLE:Int = 2
	Const valignBOTTOM:Int = 3

	
	Const halignNONE:Int = 0
	Const halignLEFT:Int = 1
	Const halignCENTER:Int = 2
	Const halignRIGHT:Int = 3
	
	Rem
	bbdoc: Search for selected shapes only
	end rem
	Const searchSELECTED:Int = 0
	Rem
	bbdoc: Search for unselected shapes only
	end rem
	Const searchUNSELECTED:Int = 1
	Rem
	bbdoc: Search for both selected and unselected shapes
	end rem
	Const searchBOTH:Int = 2
	Rem
	bbdoc: Allow multiselection box.
	end rem
	Const sfsMULTI_SELECTION:Int = 1
	Rem
	bbdoc: Allow shapes' size change done via the multiselection box.
	end rem
	Const sfsMULTI_SIZE_CHANGE:Int = 2
	Rem
	bbdoc: Show grid.
	end rem
	Const sfsGRID_SHOW:Int = 4
	Rem
	bbdoc: Use grid.
	end rem
	Const sfsGRID_USE:Int = 8
	Rem
	bbdoc: Enable Drag & Drop operations.
	end rem
	Const sfsDND:Int = 16
	Rem
	bbdoc: Enable Undo/Redo operations.
	end rem
	Const sfsUNDOREDO:Int = 32
	Rem
	bbdoc: Enable the clipboard.
	end rem
	Const sfsCLIPBOARD:Int = 64
	Rem
	bbdoc: Enable mouse hovering
	end rem
	Const sfsHOVERING:Int = 128
	Rem
	bbdoc: Enable highligting of shapes able to accept dragged shape(s).
	end rem
	Const sfsHIGHLIGHTING:Int = 256
	Rem
	bbdoc: Use gradient color for the canvas background.
	end rem
	Const sfsGRADIENT_BACKGROUND:Int = 512
	Rem
	bbdoc: Print also canvas background.
	end rem
	Const sfsPRINT_BACKGROUND:Int = 1024
	Rem
	bbdoc: Default canvas style.
	end rem
	Const sfsDEFAULT_CANVAS_STYLE:Int = sfsMULTI_SELECTION | sfsMULTI_SIZE_CHANGE | sfsDND | sfsUNDOREDO | sfsCLIPBOARD | sfsHOVERING | sfsHIGHLIGHTING
	
	
	Rem
	bbdoc: Show/hide shadow under topmost shapes only.
	end rem
	Const shadowTOPMOST:Int = 0
	Rem
	bbdoc: Show/hide shadow under all shapes in the diagram.
	end rem
	Const shadowALL:Int = 1
	
	Rem
	bbdoc: This sets the user scale and origin of the DC so that the image fits
	* within the paper rectangle (but the edges could be cut off by printers
	* that can't print to the edges of the paper -- which is most of them. Use
	* this if your image already has its own margins.
	end rem
	Const prnFIT_TO_PAPER:Int = 0
	Rem
	bbdoc: This sets the user scale and origin of the DC so that the image fits
	* within the page rectangle, which is the printable area on Mac and MSW
	* and is the entire page on other platforms.
	end rem
	Const prnFIT_TO_PAGE:Int = 1
	Rem
	bbdoc: This sets the user scale and origin of the DC so that the image fits
	* within the page margins as specified by g_PageSetupData, which you can
	* change (on some platforms, at least) in the Page Setup dialog. Note that
	* on Mac, the native Page Setup dialog doesn't let you change the margins
	* of a wxPageSetupDialogData object, so you'll have to write your own dialog or
	* use the Mac-only wxMacPageMarginsDialog, as we do in this program.
	end rem
	Const prnFIT_TO_MARGINS:Int = 2
	Rem
	bbdoc: This sets the user scale and origin of the DC so that you could map the
	* screen image to the entire paper at the same size as it appears on screen.
	end rem
	Const prnMAP_TO_PAPER:Int = 3
	Rem
	bbdoc: This sets the user scale and origin of the DC so that the image appears
	* on the paper at the same size that it appears on screen (i.e., 10-point
	* type on screen is 10-point on the printed page).
	end rem
	Const prnMAP_TO_PAGE:Int = 4
	Rem
	bbdoc: This sets the user scale and origin of the DC so that you could map the
	* screen image to the page margins specified by the native Page Setup dialog at the same
	* size as it appears on screen.
	end rem
	Const prnMAP_TO_MARGINS:Int = 5
	Rem
	bbdoc: This sets the user scale and origin of the DC so that you can to do you own
	* scaling in order to draw objects at full native device resolution.
	end rem
	Const prnMAP_TO_DEVICE:Int = 6

	Rem
	bbdoc: Default constructor.
	End Rem
	Function CreateScrolledWindow:wxSFShapeCanvas(parent:wxWindow, id:Int = -1, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, ..
			style:Int = wxHSCROLL | wxVSCROLL)
		Return New wxSFShapeCanvas.Create(parent, id, x, y, w, h, style)
	End Function
	
	Rem
	bbdoc: 
	End Rem
	Method Create:wxSFShapeCanvas(parent:wxWindow, id:Int = -1, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, ..
			style:Int = wxHSCROLL | wxVSCROLL)

		wxObjectPtr = bmx_wxsfshapecanvas_create(Self, parent.wxObjectPtr, id, x, y, w, h, style)
		
		OnInit()
		
		Return Self
	End Method
	
	Method GetDiagramManager:wxSFDiagramManager()
	End Method
	
	Method SetDiagramManager(manager:wxSFDiagramManager)
		bmx_wxsfshapecanvas_setdiagrammanager(wxObjectPtr, manager.wxObjectPtr)
	End Method
	
	Method LoadCanvas(file:String)
	End Method
	
	Method SaveCanvas(file:String)
	End Method
	
	Method StartInteractiveConnection()
	' TODO
	End Method

	Method AbortInteractiveConnection()
	End Method
	
	Method SelectAll()
		bmx_wxsfshapecanvas_selectall(wxObjectPtr)
	End Method
	
	Method DeselectAll()
		bmx_wxsfshapecanvas_deselectall(wxObjectPtr)
	End Method
	
	Method HideAllHandles()
		bmx_wxsfshapecanvas_hideallhandles(wxObjectPtr)
	End Method
	
	Method RefreshCanvas(erase:Int, x:Int, y:Int, w:Int, h:Int)
	End Method
	
	Method RefreshCanvasRect(erase:Int, rect:wxRect)
	End Method
	
	Method ShowShadows(show:Int, style:Int)
	End Method
	
	Method DoDragDrop()
	' TODO
	End Method
	
	Method Copy()
		bmx_wxsfshapecanvas_copy(wxObjectPtr)
	End Method

	Method Cut()
		bmx_wxsfshapecanvas_cut(wxObjectPtr)
	End Method

	Method Paste()
		bmx_wxsfshapecanvas_paste(wxObjectPtr)
	End Method

	Method Undo()
		bmx_wxsfshapecanvas_undo(wxObjectPtr)
	End Method

	Method Redo()
		bmx_wxsfshapecanvas_redo(wxObjectPtr)
	End Method

	Method CanCopy:Int()
		Return bmx_wxsfshapecanvas_cancopy(wxObjectPtr)
	End Method

	Method CanCut:Int()
		Return bmx_wxsfshapecanvas_cancut(wxObjectPtr)
	End Method

	Method CanPaste:Int()
		Return bmx_wxsfshapecanvas_canpaste(wxObjectPtr)
	End Method

	Method CanUndo:Int()
		Return bmx_wxsfshapecanvas_canundo(wxObjectPtr)
	End Method

	Method CanRedo:Int()
		Return bmx_wxsfshapecanvas_canredo(wxObjectPtr)
	End Method

	Method CanAlignSelected:Int()
		Return bmx_wxsfshapecanvas_canalignselected(wxObjectPtr)
	End Method

	Method SaveCanvasState()
		bmx_wxsfshapecanvas_savecanvasstate(wxObjectPtr)
	End Method

	Method ClearCanvasHistory()
		bmx_wxsfshapecanvas_clearcanvashistory(wxObjectPtr)
	End Method

	Method Print(prompt:Int = True)
	End Method

	Method PrintPreview()
		bmx_wxsfshapecanvas_printpreview(wxObjectPtr)
	End Method
	
	Method PageSetup()
		bmx_wxsfshapecanvas_pagesetup(wxObjectPtr)
	End Method
	
	Method DP2LP(x:Int, y:Int, lx:Int Var, ly:Int Var)
	End Method

	Method LP2DP(x:Int, y:Int, px:Int Var, py:Int Var)
	End Method
	
	Method GetShapeUnderCursor:wxSFShapeBase(Mode:Int = searchBOTH)
	End Method
	
	
	
	Method AddStyle(style:Int)
		bmx_wxsfshapecanvas_addstyle(wxObjectPtr, style)
	End Method
	
	

End Type


Rem
bbdoc: 
End Rem
Type xsSerializable Extends wxObject
End Type

Rem
bbdoc: 
End Rem
Type wxSFArrowBase Extends xsSerializable

	' soft linking
	Function _create:wxSFArrowBase(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxSFArrowBase = New wxSFArrowBase
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _find:wxSFArrowBase(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxSFArrowBase = wxSFArrowBase(wxfind(wxObjectPtr))
			If Not window Then
				Return wxSFArrowBase._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function

	Method SetParentShape(parent:wxSFShapeBase)
	' TODO
	End Method
	
	Method GetParentShape:wxSFShapeBase()
	' TODO
	End Method
	
End Type

Rem
bbdoc: Encapsulates an arrow shape consisting of single two lines leading from the end of the parent line shape.
End Rem
Type wxSFOpenArrow Extends wxSFArrowBase

	' soft linking
	Function _create:wxSFOpenArrow(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxSFOpenArrow = New wxSFOpenArrow
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _find:wxSFOpenArrow(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxSFOpenArrow = wxSFOpenArrow(wxfind(wxObjectPtr))
			If Not window Then
				Return wxSFOpenArrow._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function

End Type

Rem
bbdoc: Encapsulates an arrow shape consisting of a solid triangle pointing to the end of the parent line shape.
End Rem
Type wxSFSolidArrow Extends wxSFOpenArrow

	' soft linking
	Function _create:wxSFSolidArrow(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local this:wxSFSolidArrow = New wxSFSolidArrow
			this.wxObjectPtr = wxObjectPtr
			Return this
		End If
	End Function

	Function _find:wxSFSolidArrow(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxSFSolidArrow = wxSFSolidArrow(wxfind(wxObjectPtr))
			If Not window Then
				Return wxSFSolidArrow._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function

	Method SetArrowFill(brush:wxBrush)
	' TODO
	End Method
	
	Method GetArrowFill:wxBrush()
	' TODO
	End Method

End Type

Rem
bbdoc: 
End Rem
Type wxSFCanvasSettings Extends xsSerializable

End Type

Rem
bbdoc: Base Type for all shapes providing fundamental functionality
about: Shape objects derived from this type use hierarchical approach. It means that every shape must have defined parent shape
(can be NULL for topmost shapes). An absolute shape position is then calculated as a sumation of all relative positions of all
parent shapes. Also the size of the parent shape can be limited be a boundind box of all children shapes.
End Rem
Type wxSFShapeBase Extends xsSerializable

	Const bbSELF:Int = 1
	Const bbCHILDREN:Int = 2
	Const bbCONNECTIONS:Int = 4
	Const bbSHADOW:Int = 8
	Const bbALL:Int = 15


	Const lineSTARTING:Int = 0
	Const lineENDING:Int = 1
	Const lineBOTH:Int = 2
	
	Const valignNONE:Int = 0
	Const valignTOP:Int = 1
	Const valignMIDDLE:Int = 2
	Const valignBOTTOM:Int = 3
	Const valignEXPAND:Int = 4


	Const halignNONE:Int = 0
	Const halignLEFT:Int = 1
	Const halignCENTER:Int = 2
	Const halignRIGHT:Int = 3
	Const halignEXPAND:Int = 4


	Const sfsPARENT_CHANGE:Int = 1
	Const sfsPOSITION_CHANGE:Int = 2
	Const sfsSIZE_CHANGE:Int = 4
	Const sfsHOVERING:Int = 8
	Const sfsHIGHLIGHTING:Int = 16
	Const sfsALWAYS_INSIDE:Int = 32
	Const sfsDELETE_USER_DATA:Int = 64
	Const sfsPROCESS_DEL:Int = 128
	Const sfsSHOW_HANDLES:Int = 256
	Const sfsSHOW_SHADOW:Int = 512
	Const sfsDEFAULT_SHAPE_STYLE:Int = sfsPARENT_CHANGE | sfsPOSITION_CHANGE | sfsSIZE_CHANGE | sfsHOVERING | sfsHIGHLIGHTING | sfsSHOW_HANDLES | sfsALWAYS_INSIDE | sfsDELETE_USER_DATA


	Method ClearAcceptedChilds()
		bmx_wxsfshapebase_clearacceptedchilds(wxObjectPtr)
	End Method
	
	Method Refresh()
	End Method
	

End Type


Rem
bbdoc: 
End Rem
Type wxSFLineShape Extends wxSFShapeBase

	' soft linking
	Function _create:wxSFLineShape(wxObjectPtr:Byte Ptr, bind:Int = False)
		If wxObjectPtr Then
			Local this:wxSFLineShape = New wxSFLineShape
			this.wxObjectPtr = wxObjectPtr
			If bind Then
				bmx_xsserializable_bind(this.wxObjectPtr, this)
			End If
			Return this
		End If
	End Function

	Function _find:wxSFLineShape(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxSFLineShape = wxSFLineShape(wxfind(wxObjectPtr))
			If Not window Then
				Return wxSFLineShape._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function

	Method SetSrcShapeId(id:Int)
	End Method
	 
	Method GetSrcShapeId:Int()
	End Method
	 
	Method SetTrgShapeId(id:Int)
	End Method
	 
	Method GetTrgShapeId:Int()
	End Method
	 
	Method GetSrcPoint(x:Double Var, y:Double Var)
	End Method
	 
	Method GetTrgPoint(x:Double Var, y:Double Var)
	End Method
	 
	Method GetDirectLine(x0:Double Var, y0:Double Var, x1:Double Var, y1:Double Var)
	End Method
	 
	Method SetTrgArrow:wxSFArrowBase(arrow:Object)
	End Method
	
	Method SetSrcArrow:wxSFArrowBase(arrow:Object)
	End Method
	
	Method GetSrcArrow:wxSFArrowBase()
	End Method
	 
	Method GetTrgArrow:wxSFArrowBase()
	End Method
	 
	Method SetLinePen(pen:wxPen)
	End Method
	
	Method GetLinePen:wxPen()
	End Method
	 
	Method SetDockPoint(index:Int)
	End Method
	 
	Method GetDockPoint:Int()
	End Method
	 
	Method GetControlPoints:Double[]()
	End Method
	 
	Method GetDockPointPosition(x:Double Var, y:Double Var)
	End Method


End Type

Rem
bbdoc: 
End Rem
Type wxSFCurveShape Extends wxSFLineShape

	' soft linking
	Function _create:wxSFCurveShape(wxObjectPtr:Byte Ptr, bind:Int = False)
		If wxObjectPtr Then
			Local this:wxSFCurveShape = New wxSFCurveShape
			this.wxObjectPtr = wxObjectPtr
			If bind Then
				bmx_xsserializable_bind(this.wxObjectPtr, this)
			End If
			Return this
		End If
	End Function

	Function _find:wxSFCurveShape(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxSFCurveShape = wxSFCurveShape(wxfind(wxObjectPtr))
			If Not window Then
				Return wxSFCurveShape._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function

End Type

Rem
bbdoc: 
End Rem
Type wxSFRectShape Extends wxSFShapeBase

	' soft linking
	Function _create:wxSFRectShape(wxObjectPtr:Byte Ptr, bind:Int = False)
		If wxObjectPtr Then
			Local this:wxSFRectShape = New wxSFRectShape
			this.wxObjectPtr = wxObjectPtr
			If bind Then
				bmx_xsserializable_bind(this.wxObjectPtr, this)
			End If
			Return this
		End If
	End Function

	Function _find:wxSFRectShape(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxSFRectShape = wxSFRectShape(wxfind(wxObjectPtr))
			If Not window Then
				Return wxSFRectShape._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function

	Method GetBoundingBox:wxRect()
	End Method
	
	Method GetBorderPoint(x0:Double, y0:Double, x1:Double, y1:Double, intX:Double Var, intY:Double Var)
	End Method
	
	Method FitToChildren()
	End Method
	
	Method Scale(x:Double, y:Double, chidren:Int = True)
	End Method
	
	Method SetFill(brush:wxBrush)
	End Method
	
	Method GetFill:wxBrush()
	End Method
	
	Method SetBorder(pen:wxPen)
	End Method
	
	Method GetBorder:wxPen()
	End Method
	
	Method SetRectSize(w:Double, h:Double)
	End Method
	
	Method GetRectSize(w:Double Var, h:Double Var)
	End Method
	
End Type

Rem
bbdoc: 
End Rem
Type wxSFBitmapShape Extends wxSFRectShape

	' soft linking
	Function _create:wxSFBitmapShape(wxObjectPtr:Byte Ptr, bind:Int = False)
		If wxObjectPtr Then
			Local this:wxSFBitmapShape = New wxSFBitmapShape
			this.wxObjectPtr = wxObjectPtr
			If bind Then
				bmx_xsserializable_bind(this.wxObjectPtr, this)
			End If
			Return this
		End If
	End Function

	Function _find:wxSFBitmapShape(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxSFBitmapShape = wxSFBitmapShape(wxfind(wxObjectPtr))
			If Not window Then
				Return wxSFBitmapShape._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function
	
	Method GetBitmapPath:String()
	End Method
	
	Method EnableScale(canScale:Int)
	End Method
	
	Method CanScale:Int()
	End Method
	
	Method CreateFromFile:Int(file:String, bitmapType:Int = wxBITMAP_TYPE_BMP)
	End Method
	
	Method CreateFromXPM:Int(bits:Byte Ptr)
	End Method
	
	Method Scale(x:Double, y:Double, children:Int = True)
	End Method

End Type

Rem
bbdoc: 
End Rem
Type wxSFControlShape Extends wxSFRectShape

	Rem
	bbdoc: Event isn't processed.
	End Rem
	Const evtNONE:Int = 0
	Rem
	bbdoc: Keyboard events are processed by the GUI control.
	End Rem
	Const evtKEY2GUI:Int = 1
	Rem
	bbdoc: Keyboard events are send to a shape canvas.
	End Rem
	Const evtKEY2CANVAS:Int = 2
	Rem
	bbdoc: Mouse events are processed by the GUI control.
	End Rem
	Const evtMOUSE2GUI:Int = 4 
	Rem
	bbdoc: Mouse events are send to a shape canvas.
	End Rem
	Const evtMOUSE2CANVAS:Int = 8 


	' soft linking
	Function _create:wxSFControlShape(wxObjectPtr:Byte Ptr, bind:Int = False)
		If wxObjectPtr Then
			Local this:wxSFControlShape = New wxSFControlShape
			this.wxObjectPtr = wxObjectPtr
			If bind Then
				bmx_xsserializable_bind(this.wxObjectPtr, this)
			End If
			Return this
		End If
	End Function

	Function _find:wxSFControlShape(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxSFControlShape = wxSFControlShape(wxfind(wxObjectPtr))
			If Not window Then
				Return wxSFControlShape._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function

	Rem
	bbdoc: Set managed GUI control.
	End Rem
	Method SetControl(ctrl:wxWindow, fit:Int = True)
		bmx_wxsfcontrolshape_setcontrol(wxObjectPtr, ctrl.wxObjectPtr, fit)
	End Method
	
	Rem
	bbdoc: Returns reference to managed GUI control.
	End Rem
	Method GetControl:wxWindow()
		Return wxWindow._find(bmx_wxsfcontrolshape_getcontrol(wxObjectPtr))
	End Method
	
	Rem
	bbdoc: Set a way how GUI control's events are processed.
	about: One of evtNONE, evtKEY2GUI, evtKEY2CANVAS, evtMOUSE2GUI or evtMOUSE2CANVAS.
	End Rem
	Method SetEventProcessing(mask:Int)
		bmx_wxsfcontrolshape_seteventprocessing(wxObjectPtr, mask)
	End Method
	
	Rem
	bbdoc: Get a way how GUI control's events are processed.
	about: Returns one of evtNONE, evtKEY2GUI, evtKEY2CANVAS, evtMOUSE2GUI or evtMOUSE2CANVAS.
	End Rem
	Method GetEventProcessing:Int()
		Return bmx_wxsfcontrolshape_geteventprocessing(wxObjectPtr)
	End Method
	
	Rem
	bbdoc: Set control shape's offset (a gap between the shape's border and managed GUI control).
	End Rem
	Method SetControlOffset(offset:Int)
		bmx_wxsfcontrolshape_setcontroloffset(wxObjectPtr, offset)
	End Method
	
	Rem
	bbdoc: Get control shape's offset (a gap between the shape's border and managed GUI control).
	End Rem
	Method GetControlOffset:Int()
		Return bmx_wxsfcontrolshape_getcontroloffset(wxObjectPtr)
	End Method
	
	Method SetModFill(brush:wxBrush)
	' TODO
	End Method
	
	Method GetModFill:wxBrush()
	' TODO
	End Method

	Method SetModBorder(pen:wxPen)
	' TODO
	End Method
	
	Method GetModBorder:wxPen()
	' TODO
	End Method

End Type

Rem
bbdoc: 
End Rem
Type wxSFEllipseShape Extends wxSFRectShape

	' soft linking
	Function _create:wxSFEllipseShape(wxObjectPtr:Byte Ptr, bind:Int = False)
		If wxObjectPtr Then
			Local this:wxSFEllipseShape = New wxSFEllipseShape
			this.wxObjectPtr = wxObjectPtr
			If bind Then
				bmx_xsserializable_bind(this.wxObjectPtr, this)
			End If
			Return this
		End If
	End Function

	Function _find:wxSFEllipseShape(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxSFEllipseShape = wxSFEllipseShape(wxfind(wxObjectPtr))
			If Not window Then
				Return wxSFEllipseShape._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function

End Type

Rem
bbdoc: 
End Rem
Type wxSFGridShape Extends wxSFRectShape

	' soft linking
	Function _create:wxSFGridShape(wxObjectPtr:Byte Ptr, bind:Int = False)
		If wxObjectPtr Then
			Local this:wxSFGridShape = New wxSFGridShape
			this.wxObjectPtr = wxObjectPtr
			If bind Then
				bmx_xsserializable_bind(this.wxObjectPtr, this)
			End If
			Return this
		End If
	End Function

	Function _find:wxSFGridShape(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxSFGridShape = wxSFGridShape(wxfind(wxObjectPtr))
			If Not window Then
				Return wxSFGridShape._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function

End Type

Rem
bbdoc: 
End Rem
Type wxSFFlexGridShape Extends wxSFGridShape

	' soft linking
	Function _create:wxSFFlexGridShape(wxObjectPtr:Byte Ptr, bind:Int = False)
		If wxObjectPtr Then
			Local this:wxSFFlexGridShape = New wxSFFlexGridShape
			this.wxObjectPtr = wxObjectPtr
			If bind Then
				bmx_xsserializable_bind(this.wxObjectPtr, this)
			End If
			Return this
		End If
	End Function

	Function _find:wxSFFlexGridShape(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxSFFlexGridShape = wxSFFlexGridShape(wxfind(wxObjectPtr))
			If Not window Then
				Return wxSFFlexGridShape._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function

End Type

Rem
bbdoc: 
End Rem
Type wxSFMultiSelRect Extends wxSFRectShape

	' soft linking
	Function _create:wxSFMultiSelRect(wxObjectPtr:Byte Ptr, bind:Int = False)
		If wxObjectPtr Then
			Local this:wxSFMultiSelRect = New wxSFMultiSelRect
			this.wxObjectPtr = wxObjectPtr
			If bind Then
				bmx_xsserializable_bind(this.wxObjectPtr, this)
			End If
			Return this
		End If
	End Function

	Function _find:wxSFMultiSelRect(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxSFMultiSelRect = wxSFMultiSelRect(wxfind(wxObjectPtr))
			If Not window Then
				Return wxSFMultiSelRect._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function

End Type

Rem
bbdoc: 
End Rem
Type wxSFPolygonShape Extends wxSFRectShape

	' soft linking
	Function _create:wxSFPolygonShape(wxObjectPtr:Byte Ptr, bind:Int = False)
		If wxObjectPtr Then
			Local this:wxSFPolygonShape = New wxSFPolygonShape
			this.wxObjectPtr = wxObjectPtr
			If bind Then
				bmx_xsserializable_bind(this.wxObjectPtr, this)
			End If
			Return this
		End If
	End Function

	Function _find:wxSFPolygonShape(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxSFPolygonShape = wxSFPolygonShape(wxfind(wxObjectPtr))
			If Not window Then
				Return wxSFPolygonShape._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function

End Type

Rem
bbdoc: 
End Rem
Type wxSFDiamondShape Extends wxSFPolygonShape

	' soft linking
	Function _create:wxSFDiamondShape(wxObjectPtr:Byte Ptr, bind:Int = False)
		If wxObjectPtr Then
			Local this:wxSFDiamondShape = New wxSFDiamondShape
			this.wxObjectPtr = wxObjectPtr
			If bind Then
				bmx_xsserializable_bind(this.wxObjectPtr, this)
			End If
			Return this
		End If
	End Function

	Function _find:wxSFDiamondShape(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxSFDiamondShape = wxSFDiamondShape(wxfind(wxObjectPtr))
			If Not window Then
				Return wxSFDiamondShape._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function

End Type

Rem
bbdoc: 
End Rem
Type wxSFRoundRectShape Extends wxSFRectShape

	' soft linking
	Function _create:wxSFRoundRectShape(wxObjectPtr:Byte Ptr, bind:Int = False)
		If wxObjectPtr Then
			Local this:wxSFRoundRectShape = New wxSFRoundRectShape
			this.wxObjectPtr = wxObjectPtr
			If bind Then
				bmx_xsserializable_bind(this.wxObjectPtr, this)
			End If
			Return this
		End If
	End Function

	Function _find:wxSFRoundRectShape(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxSFRoundRectShape = wxSFRoundRectShape(wxfind(wxObjectPtr))
			If Not window Then
				Return wxSFRoundRectShape._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function

End Type

Rem
bbdoc: 
End Rem
Type wxSFSquareShape Extends wxSFRectShape

	' soft linking
	Function _create:wxSFSquareShape(wxObjectPtr:Byte Ptr, bind:Int = False)
		If wxObjectPtr Then
			Local this:wxSFSquareShape = New wxSFSquareShape
			this.wxObjectPtr = wxObjectPtr
			If bind Then
				bmx_xsserializable_bind(this.wxObjectPtr, this)
			End If
			Return this
		End If
	End Function

	Function _find:wxSFSquareShape(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxSFSquareShape = wxSFSquareShape(wxfind(wxObjectPtr))
			If Not window Then
				Return wxSFSquareShape._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function

End Type

Rem
bbdoc: 
End Rem
Type wxSFCircleShape Extends wxSFSquareShape

	' soft linking
	Function _create:wxSFCircleShape(wxObjectPtr:Byte Ptr, bind:Int = False)
		If wxObjectPtr Then
			Local this:wxSFCircleShape = New wxSFCircleShape
			this.wxObjectPtr = wxObjectPtr
			If bind Then
				bmx_xsserializable_bind(this.wxObjectPtr, this)
			End If
			Return this
		End If
	End Function

	Function _find:wxSFCircleShape(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxSFCircleShape = wxSFCircleShape(wxfind(wxObjectPtr))
			If Not window Then
				Return wxSFCircleShape._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function

End Type

Rem
bbdoc: 
End Rem
Type wxSFTextShape Extends wxSFRectShape

	' soft linking
	Function _create:wxSFTextShape(wxObjectPtr:Byte Ptr, bind:Int = False)
		If wxObjectPtr Then
			Local this:wxSFTextShape = New wxSFTextShape
			this.wxObjectPtr = wxObjectPtr
			If bind Then
				bmx_xsserializable_bind(this.wxObjectPtr, this)
			End If
			Return this
		End If
	End Function

	Function _find:wxSFTextShape(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxSFTextShape = wxSFTextShape(wxfind(wxObjectPtr))
			If Not window Then
				Return wxSFTextShape._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function

End Type

Rem
bbdoc: 
End Rem
Type wxSFEditTextShape Extends wxSFTextShape

	' soft linking
	Function _create:wxSFEditTextShape(wxObjectPtr:Byte Ptr, bind:Int = False)
		If wxObjectPtr Then
			Local this:wxSFEditTextShape = New wxSFEditTextShape
			this.wxObjectPtr = wxObjectPtr
			If bind Then
				bmx_xsserializable_bind(this.wxObjectPtr, this)
			End If
			Return this
		End If
	End Function

	Function _find:wxSFEditTextShape(wxObjectPtr:Byte Ptr)
		If wxObjectPtr Then
			Local window:wxSFEditTextShape = wxSFEditTextShape(wxfind(wxObjectPtr))
			If Not window Then
				Return wxSFEditTextShape._create(wxObjectPtr)
			End If
			Return window
		End If
	End Function

End Type


