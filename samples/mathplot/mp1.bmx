SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxMathPlot
Import wx.wxTextCtrl
Import wx.wxPreviewFrame
Import wx.wxPrinter

New MyApp.run()


Const ID_PRINT:Int = 110
Const ID_PRINT_PREVIEW:Int = 111
Const ID_ALIGN_X_AXIS:Int = 112
Const ID_ALIGN_Y_AXIS:Int = 113
Const ID_TOGGLE_GRID:Int = 114
Const ID_TOGGLE_SCROLLBARS:Int = 115
Const ID_TOGGLE_INFO:Int = 116
Const ID_SAVE_SCREENSHOT:Int = 117
Const ID_TOGGLE_LISSAJOUX:Int = 118
Const ID_TOGGLE_SINE:Int = 119
Const ID_TOGGLE_COSINE:Int = 120
Const ID_BLACK_THEME:Int = 121


Type MyApp Extends wxApp

	Field frame:MyFrame

	Method OnInit:Int()

		frame = MyFrame(New MyFrame.Create(,,"wxWindows mathplot sample", -1, -1, 500, 500))

		frame.show()
		
		Return True
	
End Method

End Type

Type MyFrame Extends wxFrame

	Field mPlot:mpWindow
	Field info:mpInfoCoords
	Field mLog:wxTextCtrl

	Field axesPos:Int[2]
	Field ticks:Int

	Method OnInit:Int()

		Local fileMenu:wxMenu = New wxMenu.Create()
		Local viewMenu:wxMenu = New wxMenu.Create()
		Local showMenu:wxMenu = New wxMenu.Create()
		
		fileMenu.Append(ID_PRINT_PREVIEW, "Print Pre&view...")
		fileMenu.Append(ID_PRINT, "&Print...")
		fileMenu.Append(ID_SAVE_SCREENSHOT, "Save screenshot")
		fileMenu.AppendSeparator()
		fileMenu.Append(wxID_ABOUT, "&About..")
		fileMenu.Append(wxID_EXIT,  "E&xit~ttAlt-X")
		
		viewMenu.Append(mpID_FIT,      "&Fit bounding box", "Set plot view to show all items")
		viewMenu.Append(mpID_ZOOM_IN,  "Zoom in",           "Zoom in plot view.")
		viewMenu.Append(mpID_ZOOM_OUT, "Zoom out",          "Zoom out plot view.")
		viewMenu.AppendSeparator()
		viewMenu.Append(ID_ALIGN_X_AXIS, "Switch &X axis align")
		viewMenu.Append(ID_ALIGN_Y_AXIS, "Switch &Y axis align")
		viewMenu.Append(ID_TOGGLE_GRID, "Toggle grid/ticks")
		viewMenu.AppendCheckItem(ID_TOGGLE_SCROLLBARS, "Show Scroll Bars")
		viewMenu.AppendCheckItem(ID_TOGGLE_INFO, "Show overlay info box")
		viewMenu.AppendCheckItem(ID_BLACK_THEME, "Switch to black background theme")

		showMenu.AppendCheckItem(ID_TOGGLE_LISSAJOUX, "Lissajoux")
		showMenu.AppendCheckItem(ID_TOGGLE_SINE, "Sine")
		showMenu.AppendCheckItem(ID_TOGGLE_COSINE, "Cosine")

		' Start with all plots visible
		showMenu.Check(ID_TOGGLE_LISSAJOUX, True)
		showMenu.Check(ID_TOGGLE_SINE, True)
		showMenu.Check(ID_TOGGLE_COSINE, True)
		
		Local menubar:wxMenuBar = New wxMenuBar.Create()
		menubar.Append(fileMenu, "&File")
		menubar.Append(viewMenu, "&View")
		menubar.Append(showMenu, "&Show")
		
		SetMenuBar(menuBar)
		CreateStatusBar(1)

		' Create an mpFXYVector layer
		Local vectorLayer:mpFXYVector = New mpFXYVector.CreateLayer("Vector")
		' Create two arrays for x,y and fill them with data
		Local vx:Double[100]
		Local vy:Double[100]
		Local xcoord:Double
		For Local i:Int = 0 Until 100
			xcoord = (i - 50.0) * 5.0
			vx[i] = xcoord
			vy[i] = 0.0001 * (xcoord ^ 3)
		Next

		vectorLayer.SetData(vx, vy)
		vectorLayer.SetContinuity(True)
		Local vectorpen:wxPen = New wxPen.CreateFromColour(wxBLUE(), 2, wxSOLID)
		vectorLayer.SetPen(vectorpen)
		vectorLayer.SetDrawOutsideMargins(False)

		Local graphFont:wxFont = New wxFont.CreateWithAttribs(11, wxFONTFAMILY_DEFAULT, wxFONTSTYLE_NORMAL, wxFONTWEIGHT_NORMAL)
		mPlot = New mpWindow.Create(Self, -1, 0, 0, 100, 100, wxSUNKEN_BORDER)
		Local xaxis:mpScaleX = New mpScaleX.CreateLayer("X", mpALIGN_BOTTOM, True, mpX_NORMAL)
		Local yaxis:mpScaleY = New mpScaleY.CreateLayer("Y", mpALIGN_LEFT, True)
		xaxis.SetFont(graphFont)
		yaxis.SetFont(graphFont)
		xaxis.SetDrawOutsideMargins(False)
		yaxis.SetDrawOutsideMargins(False)
		
		mPlot.SetMargins(30, 30, 50, 100)
		
		Local layer:mpLayer = New TLissajoux.Create( 125.0 )

		mPlot.AddLayer(xaxis)
		mPlot.AddLayer(yaxis)
		mPlot.AddLayer(New TSin.Create( 10.0, 220.0))

		mPlot.AddLayer(New TCosInverse.Create( 10.0, 100.0))
		mPlot.AddLayer(layer)
		mPlot.AddLayer(vectorLayer)
		mPlot.AddLayer(New mpText.CreateLayer("mpText sample", 10, 10))
		
		'Local hatch:wxBrush = New wxBrush.Create(New wxColour.Create(200,200,200), wxSOLID)

		info = New mpInfoCoords.CreateLayer(80, 20, 10, 10, wxTRANSPARENT_BRUSH())
		mPlot.AddLayer(info)
		info.SetVisible(False)
		'Local hatch2:wxBrush = New wxBrush.Create(New wxColour.Create(163,208,212), wxSOLID)
		Local leg:mpInfoLegend = New mpInfoLegend.CreateLayer(200, 20, 40, 40, wxTRANSPARENT_BRUSH())
		mPlot.AddLayer(leg)
		leg.SetVisible(True)
		
		' set a nice pen for the lissajoux
		Local mypen:wxPen = New wxPen.CreateFromColour(wxRED(), 5, wxSOLID)
		layer.SetPen(mypen)


		Local topsizer:wxBoxSizer = New wxBoxSizer.Create(wxVERTICAL)
		topsizer.Add( mPlot, 1, wxEXPAND )
		SetAutoLayout(True)
		SetSizer(topsizer)
		
		ticks = True

		mPlot.SetMPScrollbars(False)
		mPlot.Fit()

		Connect(wxID_EXIT, wxEVT_COMMAND_MENU_SELECTED, _OnQuit)
		Connect(wxID_ABOUT, wxEVT_COMMAND_MENU_SELECTED, _OnAbout)
		Connect(mpID_FIT, wxEVT_COMMAND_MENU_SELECTED, _OnFit)
		Connect(ID_PRINT_PREVIEW, wxEVT_COMMAND_MENU_SELECTED, _OnPrintPreview)
		Connect(ID_PRINT, wxEVT_COMMAND_MENU_SELECTED, _OnPrint)
		Connect(ID_ALIGN_X_AXIS, wxEVT_COMMAND_MENU_SELECTED, _OnAlignXAxis)
		Connect(ID_ALIGN_Y_AXIS, wxEVT_COMMAND_MENU_SELECTED, _OnAlignYAxis)
		Connect(ID_TOGGLE_GRID, wxEVT_COMMAND_MENU_SELECTED, _OnToggleGrid)
		Connect(ID_TOGGLE_SCROLLBARS, wxEVT_COMMAND_MENU_SELECTED, _OnToggleScrollbars)
		Connect(ID_TOGGLE_INFO, wxEVT_COMMAND_MENU_SELECTED, _OnToggleInfoLayer)
		Connect(ID_SAVE_SCREENSHOT, wxEVT_COMMAND_MENU_SELECTED, _OnSaveScreenshot)
		Connect(ID_BLACK_THEME, wxEVT_COMMAND_MENU_SELECTED, _OnBlackTheme)
		Connect(ID_TOGGLE_LISSAJOUX, wxEVT_COMMAND_MENU_SELECTED, _OnToggleLissajoux)
		Connect(ID_TOGGLE_SINE, wxEVT_COMMAND_MENU_SELECTED, _OnToggleSine)
		Connect(ID_TOGGLE_COSINE, wxEVT_COMMAND_MENU_SELECTED, _OnToggleCosine)

	End Method
	
	Method OnQuit(event:wxCommandEvent)
		Close(True)
	End Method
	
	Method OnAbout(event:wxCommandEvent)
		wxMessageBox("wxWidgets mathplot sample~n(c) 2003 David Schalig~n(c) 2007-2009 Davide Rondini and wxMathPlot team")
	End Method
	
	Method OnPrintPreview( event:wxCommandEvent)
		' Pass two printout objects: for preview, and possible printing
		Local plotPrint:mpPrintout = New mpPrintout.Create(mPlot)
		Local plotPrintPreview:mpPrintout = New mpPrintout.Create(mPlot)
		Local preview:wxPrintPreview  = New wxPrintPreview.Create(plotPrintPreview, plotPrint)
		Local frame:wxPreviewFrame = New wxPreviewFrame.CreatePF(preview, Self, "Print Plot", 100, 100, 600, 650)
		frame.Centre(wxBOTH)
		frame.Initialize()
		frame.Show(True)
	End Method
	
	Method OnPrint( event:wxCommandEvent )
		Local printer:wxPrinter = New wxPrinter.Create()
		Local printout:mpPrintout = New mpPrintout.Create(mPlot, "Plot print")
		printer.Print(Self, printout, True)
	End Method

	Method OnFit( event:wxCommandEvent )
		mPlot.Fit()
	End Method

	Method OnAlignXAxis( event:wxCommandEvent )
		axesPos[0] = (axesPos[0]+1) Mod 5
		
		Local temp:String = "axesPos = " + axesPos[0] + "~n"
		'm_log.AppendText(temp);
		Local xaxis:mpScaleX = mpScaleX(mPlot.GetLayer(0))
		Local yaxis:mpScaleY = mpScaleY(mPlot.GetLayer(1))
		If axesPos[0] = 0 Then
			xaxis.SetAlign(mpALIGN_BORDER_BOTTOM)
			mPlot.SetMarginTop(0)
			mPlot.SetMarginBottom(0)
		End If
		
		If axesPos[0] = 1 Then
			xaxis.SetAlign(mpALIGN_BOTTOM)
			mPlot.SetMarginTop(0)
			mPlot.SetMarginBottom(50)
		End If
		
		If axesPos[0] = 2 Then
			xaxis.SetAlign(mpALIGN_CENTER)
			mPlot.SetMarginTop(0)
			mPlot.SetMarginBottom(0)
		End If
		
		If axesPos[0] = 3 Then
			xaxis.SetAlign(mpALIGN_TOP)
			mPlot.SetMarginTop(50)
			mPlot.SetMarginBottom(0)
		End If
		
		If axesPos[0] = 4 Then
			xaxis.SetAlign(mpALIGN_BORDER_TOP)
			mPlot.SetMarginTop(0)
			mPlot.SetMarginBottom(0)
		End If
		
		mPlot.UpdateAll()
	End Method

	Method OnAlignYAxis( event:wxCommandEvent )
		axesPos[1] = (axesPos[1] + 1) Mod 5

		Local temp:String = "axesPos = " + axesPos[1] + "~n"
		'm_log.AppendText(temp);
		Local xaxis:mpScaleX = mpScaleX(mPlot.GetLayer(0))
		Local yaxis:mpScaleY = mpScaleY(mPlot.GetLayer(1))

		If axesPos[1] = 0 Then
			yaxis.SetAlign(mpALIGN_BORDER_LEFT)
			mPlot.SetMarginLeft(0)
			mPlot.SetMarginRight(0)
		End If
		
		If axesPos[1] = 1
			yaxis.SetAlign(mpALIGN_LEFT)
			mPlot.SetMarginLeft(70)
			mPlot.SetMarginRight(0)
		End If
		
		If axesPos[1] = 2 Then
			yaxis.SetAlign(mpALIGN_CENTER)
			mPlot.SetMarginLeft(0)
			mPlot.SetMarginRight(0)
		End If
		
		If axesPos[1] = 3 Then
			yaxis.SetAlign(mpALIGN_RIGHT)
			mPlot.SetMarginLeft(0)
			mPlot.SetMarginRight(70)
		End If
		
		If axesPos[1] = 4 Then
			yaxis.SetAlign(mpALIGN_BORDER_RIGHT)
			mPlot.SetMarginLeft(0)
			mPlot.SetMarginRight(0)
		End If
		
		mPlot.UpdateAll()
	End Method

	Method OnToggleGrid( event:wxCommandEvent )
		ticks = Not ticks
		mpScaleX(mPlot.GetLayer(0)).SetTicks(ticks)
		mpScaleY(mPlot.GetLayer(1)).SetTicks(ticks)
		mPlot.UpdateAll()
	End Method

	Method OnToggleScrollbars(event:wxCommandEvent)
		If event.IsChecked() Then
			mPlot.SetMPScrollbars(True)
		Else
			mPlot.SetMPScrollbars(False)
		End If
		event.Skip()
	End Method

	Method OnToggleInfoLayer(event:wxCommandEvent)
		If event.IsChecked() Then
			info.SetVisible(True)
		Else
			info.SetVisible(False)
		End If
		mPlot.UpdateAll()
		event.Skip()
	End Method

	Method OnSaveScreenshot(event:wxCommandEvent)
	End Method

	Method OnToggleLissajoux(event:wxCommandEvent)
		mPlot.SetLayerVisible("Lissajoux", event.IsChecked())
	End Method

	Method OnToggleSine(event:wxCommandEvent)
		mPlot.SetLayerVisible("f(x) = SIN(x)", event.IsChecked())
	End Method

	Method OnToggleCosine(event:wxCommandEvent)
		mPlot.SetLayerVisible("g(y) = COS(y)", event.IsChecked())
	End Method

	Method OnBlackTheme(event:wxCommandEvent)
		Local grey:wxColour = New wxColour.Create(96, 96, 96)
		mPlot.SetColourTheme(wxBLACK(), wxWHITE(), grey);
		mPlot.UpdateAll()
	End Method

	Function _OnAbout(event:wxEvent)
		MyFrame(event.parent).OnAbout(wxCommandEvent(event))
	End Function

	Function _OnQuit(event:wxEvent)
		MyFrame(event.parent).OnQuit(wxCommandEvent(event))
	End Function
	
	Function _OnFit(event:wxEvent)
		MyFrame(event.parent).OnFit(wxCommandEvent(event))
	End Function

	Function _OnPrintPreview(event:wxEvent)
		MyFrame(event.parent).OnPrintPreview(wxCommandEvent(event))
	End Function

	Function _OnPrint(event:wxEvent)
		MyFrame(event.parent).OnPrint(wxCommandEvent(event))
	End Function

	Function _OnAlignXAxis(event:wxEvent)
		MyFrame(event.parent).OnAlignXAxis(wxCommandEvent(event))
	End Function

	Function _OnAlignYAxis(event:wxEvent)
		MyFrame(event.parent).OnAlignYAxis(wxCommandEvent(event))
	End Function

	Function _OnToggleGrid(event:wxEvent)
		MyFrame(event.parent).OnToggleGrid(wxCommandEvent(event))
	End Function

	Function _OnToggleScrollbars(event:wxEvent)
		MyFrame(event.parent).OnToggleScrollbars(wxCommandEvent(event))
	End Function

	Function _OnToggleInfoLayer(event:wxEvent)
		MyFrame(event.parent).OnToggleInfoLayer(wxCommandEvent(event))
	End Function

	Function _OnSaveScreenshot(event:wxEvent)
		MyFrame(event.parent).OnSaveScreenshot(wxCommandEvent(event))
	End Function
	
	Function _OnBlackTheme(event:wxEvent)
		MyFrame(event.parent).OnBlackTheme(wxCommandEvent(event))
	End Function
	
	Function _OnToggleLissajoux(event:wxEvent)
		MyFrame(event.parent).OnToggleLissajoux(wxCommandEvent(event))
	End Function
	
	Function _OnToggleSine(event:wxEvent)
		MyFrame(event.parent).OnToggleSine(wxCommandEvent(event))
	End Function
	
	Function _OnToggleCosine(event:wxEvent)
		MyFrame(event.parent).OnToggleCosine(wxCommandEvent(event))
	End Function
	
End Type



Type TSin Extends mpFX

	Field freq:Double
	Field amp:Double

	Method Create:TSin(freq:Double, amp:Double)
		Self.freq = freq
		Self.amp = amp
		Super.CreateLayer("f(x) = SIN(x)", mpALIGN_LEFT)
		SetDrawOutsideMargins(False)
		Return Self
	End Method

	Method GetY:Double(x:Double)
		Return amp * Sin((x / 6.283185 / freq) * 57)
	End Method

	Method GetMinY:Double()
		Return -amp
	End Method
	
	Method GetMaxY:Double()
		Return amp
	End Method
	
End Type

Type TCosInverse Extends mpFY

	Field freq:Double
	Field amp:Double

	Method Create:TCosInverse(freq:Double, amp:Double)
		Self.freq = freq
		Self.amp = amp
		Super.CreateLayer("g(y) = COS(y)", mpALIGN_BOTTOM)
		SetDrawOutsideMargins(False)
		Return Self
	End Method

	Method GetX:Double(y:Double)
		Return amp * Cos((y / 6.283185 / freq) * 57)
	End Method

	Method GetMinX:Double()
		Return -amp
	End Method
	
	Method GetMaxX:Double()
		Return amp
	End Method
	
End Type

Type TLissajoux Extends mpFXY

	Field rad:Double
	Field index:Int

	Method Create:TLissajoux(rad:Double)
		Self.rad = rad
		Super.CreateLayer("Lissajoux")
		SetDrawOutsideMargins(False)
		Return Self
	End Method

	Method Rewind()
		index = 0
	End Method
	
	Method GetNextXY:Int(x:Double Var, y:Double Var)
		If index < 360 Then
			x = rad * Cos(index / 6.283185 * 360)
			y = rad * Sin(index / 6.283185 * 360)
			index :+ 1
			Return True
		Else
			Return False
		End If
	End Method
	
	Method GetMinX:Double()
		Return -rad
	End Method
	
	Method GetMaxX:Double()
		Return rad
	End Method
	
	Method GetMinY:Double()
		Return -rad
	End Method
	
	Method GetMaxY:Double()
		Return rad
	End Method
	
End Type
