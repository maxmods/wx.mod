SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxMathPlot
Import wx.wxTextCtrl
Import wx.wxTimer

Const TIMER_ID:Int = 115

New MyApp.run()


Type MyApp Extends wxApp

	Field frame:MyFrame

	Method OnInit:Int()

		frame = MyFrame(New MyFrame.Create(,,"wxWindows mathplot sample #3 - 'mpMovableObject' objects", -1, -1, 500, 500))

		frame.show()
		
		Return True
	
End Method

End Type

Type MyFrame Extends wxFrame

	Field mPlot:mpWindow
	Field mLog:wxTextCtrl
	Field timer:wxTimer

	Method OnInit:Int()

		Local fileMenu:wxMenu = New wxMenu.Create()
		Local viewMenu:wxMenu = New wxMenu.Create()
		
		fileMenu.Append(wxID_ABOUT, "&About..")
		fileMenu.Append(wxID_EXIT,  "E&xit~ttAlt-X")
		
		viewMenu.Append(mpID_FIT,      "&Fit bounding box", "Set plot view to show all items")
		viewMenu.Append(mpID_ZOOM_IN,  "Zoom in",           "Zoom in plot view.")
		viewMenu.Append(mpID_ZOOM_OUT, "Zoom out",          "Zoom out plot view.")
		
		Local menubar:wxMenuBar = New wxMenuBar.Create()
		menubar.Append(fileMenu, "&File")
		menubar.Append(viewMenu, "&View")
		
		SetMenuBar(menuBar)


		mPlot = New mpWindow.Create(Self, -1, 0, 0, 100, 100, wxSUNKEN_BORDER)
		mPlot.SetMargins(0, 0, 50, 70)
		Local xaxis:mpScaleX = New mpScaleX.CreateLayer("x", mpALIGN_BOTTOM, True)
		Local yaxis:mpScaleY = New mpScaleY.CreateLayer("y", mpALIGN_LEFT, True)
		xaxis.SetDrawOutsideMargins(False)
		yaxis.SetDrawOutsideMargins(False)
		mPlot.AddLayer(xaxis)
		mPlot.AddLayer(yaxis)
		
		Local bmpLayer:mpBitmapLayer = New mpBitmapLayer.CreateLayer()
		mPlot.AddLayer(bmpLayer)
		
		wxInitAllImageHandlers()
		Local bmp:wxImage = New wxImage.Create("./gridmap.png", wxBITMAP_TYPE_PNG)
		
		bmp.SetMaskColour(0,0,0)
		
		bmpLayer.SetBitmap(bmp, -40, -40, 120, 120)
		
		mPlot.AddLayer(New mpCovarianceEllipse.CreateLayer(0.4, 0.4, 0.2, 2, 32, "Cov1"))
		mPlot.AddLayer(New mpCovarianceEllipse.CreateLayer(0.2, 0.2, -0.1, 2, 32, "Cov2"))
		
		' Car shape
		Local xs:Double[] = [-0.5, -0.2, -0.2, 0, 0, 0.6, 0.6, 0.8, 0.8, 1.0, 1.0, 0.8, 0.8, 0.6, 0.6, 0, 0, -0.2, -0.2, -0.5]
		Local ys:Double[] = [-0.5, -0.5, -0.6, -0.6, -0.5, -0.5, -0.6, -0.6, -0.5, -0.5, 0.5, 0.5, 0.6, 0.6, 0.5, 0.5, 0.6, 0.6, 0.5, 0.5]

		Local car:mpPolygon = New mpPolygon.CreateLayer("car") 
		mPlot.AddLayer(car)
		car.SetPen( New wxPen.CreateFromColour(wxBLACK(), 3, wxSOLID))
		car.setPoints( xs, ys, True )

		mPlot.GetLayerByName("Cov1").SetPen(New wxPen.CreateFromColour(wxRED(), 2, wxSOLID))
		mPlot.GetLayerByName("Cov2").SetPen(New wxPen.CreateFromColour(wxBLUE(), 2, wxSOLID))
		
		
		Local obj:mpMovableObject = mpMovableObject(mPlot.GetLayerByName("Cov2"))
		obj.SetCoordinateBase(12, 7, 0)
		
		obj = mpMovableObject(mPlot.GetLayerByName("Cov1"))
		obj.SetCoordinateBase(-4, -4, 1)
		
		
		Local topsizer:wxBoxSizer = New wxBoxSizer.Create(wxVERTICAL)
		topsizer.Add( mPlot, 1, wxEXPAND )
		SetAutoLayout(True)
		SetSizer(topsizer)

		timer = New wxTimer.Create(Self, TIMER_ID)
		timer.Start(25)

		Connect(wxID_EXIT, wxEVT_COMMAND_MENU_SELECTED, _OnQuit)
		Connect(wxID_ABOUT, wxEVT_COMMAND_MENU_SELECTED, _OnAbout)
		Connect(mpID_FIT, wxEVT_COMMAND_MENU_SELECTED, _OnFit)
		Connect(TIMER_ID, wxEVT_TIMER , _OnTimer)

	End Method
	
	Method OnFit()
		mPlot.Fit()
	End Method

	Method OnQuit()
		timer.Stop()
		Close(True)
	End Method
	
	Method OnAbout()
		wxMessageBox("wxWidgets mathplot sample #3~n(c) 2007 David Schalig, Davide Rondini, Jose Luis Blanco, 2018 Bruce A Henderson")
	End Method
	
	Method OnTimer()
		Local obj:mpMovableObject = mpMovableObject(mPlot.GetLayerByName("car"))
		If obj Then
			Local x:Double
			Local y:Double
			Local phi:Double
			Local v:Double
			Local w:Double
			Local At:Double = timer.GetInterval() * 0.001
			
			obj.GetCoordinateBase(x, y, phi)
		
			If x <= 5 And x >= 0 Then
				v = 5
				w = 0
			Else
				v = 4
				w = 1
			End If
		
			x :+ Cos(phi * 57.29) * v * At
			y :+ Sin(phi * 57.29) * v * At
			phi :+ w * At
		
			obj.SetCoordinateBase(x, y, phi)
			mPlot.UpdateAll()
		End If
	End Method
	
	Function _OnAbout(event:wxEvent)
		MyFrame(event.parent).OnAbout()
	End Function

	Function _OnQuit(event:wxEvent)
		MyFrame(event.parent).OnQuit()
	End Function
	
	Function _OnFit(event:wxEvent)
		MyFrame(event.parent).OnFit()
	End Function

	Function _OnTimer(event:wxEvent)
		MyFrame(event.parent).OnTimer()
	End Function
	
End Type


