SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxgpPanel

New MyApp.run()


Type MyApp Extends wxApp

	Field frame:MyFrame

	Method OnInit:Int()

		frame = MyFrame(New MyFrame.Create(,,"wxWidgets Demo", 50, 50, 850, 640))

		gpTest(frame)
		
		frame.show()
		
		Return True
	
	End Method
	
	Method gpTest(parent:wxWindow)
		
		' A panel is a container for one or more charts
		Local graphPanel:gpPanel = New gpPanel.Create(parent, -1, 240, 336)
		Local multiLayer:gpMultiPlotLayer = New gpMultiPlotLayer.Create("Bar Chart Layer", "sample number", "y")
		
		' prec datas
		multiLayer.SetType(gpMultiPlotLayer.TYPE_LINE)
		Local sb:gpSeries = multiLayer.AddSeriesLayer("S")
		sb.Invert(False)
		sb.SetPen(wxBLUE_PEN())
		sb.SetBrush(wxBLUE_BRUSH())
		
		sb.DataPush(0, 0.0)
		sb.DataPush(0.980, 5.660)
		sb.DataPush(5.540, 47.260)
		sb.DataPush(21.340, 277.390)
		
		' VOL
		multiLayer.SetType(gpMultiPlotLayer.TYPE_POINT)
		Local sq:gpSeries = multiLayer.AddSeriesLayer("Q")
		sq.Invert(False)
		sq.SetPen(wxRED_PEN())
		sq.SetBrush(wxRED_BRUSH())
		
		sq.DataPush(0, 0.0)
		sq.DataPush(0.980, 5.660)
		sq.DataPush(5.540, 47.260)
		sq.DataPush(21.340, 277.390)
		
		graphPanel.AddLayer(multiLayer)
		multiLayer.RefreshChart()
		graphPanel.Fit(multiLayer)
	End Method

End Type

Type MyFrame Extends wxFrame

	Method OnInit:Int()
	
		' create a menu bar
	
		Local fileMenu:wxMenu = wxMenu.CreateMenu()
		
		' the "About" item should be in the help menu
		Local helpMenu:wxMenu = wxMenu.CreateMenu()
		
		helpMenu.Append(wxID_ABOUT, "&About...~tF1", "Show about dialog")
		
		fileMenu.Append(wxID_EXIT, "&Quit~tAlt-Q", "Quit this program")
		
		' now append the freshly created menu to the menu bar...
		Local menuBar:wxMenuBar = wxMenuBar.CreateMenuBar()
		menuBar.Append(fileMenu, "&File")
		menuBar.Append(helpMenu, "&Help")

		SetMenuBar(menuBar)
		
		' create a status bar just for fun
		CreateStatusBar()
		SetStatusText("gpPanel sample app")
		
		Connect(wxID_EXIT, wxEVT_COMMAND_MENU_SELECTED, OnQuit)
		Connect(wxID_ABOUT, wxEVT_COMMAND_MENU_SELECTED, OnAbout)
		
	End Method

	Function OnQuit(event:wxEvent)
		' true is to force the frame to close
		wxWindow(event.parent).Close(True)
	End Function
	
	Function OnAbout(event:wxEvent)
		
		wxMessageBox("This is a wxWidgets' gpPanel sample", ..
                 "About gpPanel Sample", ..
                 wxOK | wxICON_INFORMATION, wxWindow(event.parent))
		
	End Function
	
End Type
