SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxMathPlot
Import wx.wxTextCtrl

New MyApp.run()


Function ld:Double(x:Double)
	Return Log(x) / Log(2.0)
End Function


Type MyApp Extends wxApp

	Field frame:MyFrame

	Method OnInit:Int()

		frame = MyFrame(New MyFrame.Create(,,"wxWindows mathplot sample - Comparison of Integer Coding Algorithms"))

		frame.show()
		
		Return True
	
End Method

End Type

Type MyFrame Extends wxFrame

	Field mPlot:mpWindow
	Field mLog:wxTextCtrl

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


		Local e:mpLayer = New TElias.Create()
		'Local f:mpLayer = New TFibonacci.Create()
	
		mPlot = New mpWindow.Create(Self, -1, 0, 0, 100, 100, wxSUNKEN_BORDER)
		mPlot.AddLayer(New mpScaleX.CreateLayer("Ganzzahl N"))
		mPlot.AddLayer(New mpScaleY.CreateLayer("Kosten K(N) in Bits"))
		mPlot.AddLayer(New TFixedBitwidth.Create(32))
		mPlot.AddLayer(New TOptimum.Create())
		mPlot.AddLayer(e)
		'mPlot.AddLayer(f)
		
		e.SetPen(wxRED_PEN())
		'f.SetPen(wxGREEN_PEN())
		
		Local topsizer:wxBoxSizer = New wxBoxSizer.Create(wxVERTICAL)
		topsizer.Add( mPlot, 1, wxEXPAND )
		SetAutoLayout(True)
		SetSizer(topsizer)

		Connect(wxID_EXIT, wxEVT_COMMAND_MENU_SELECTED, _OnQuit)
		Connect(wxID_ABOUT, wxEVT_COMMAND_MENU_SELECTED, _OnAbout)
		Connect(mpID_FIT, wxEVT_COMMAND_MENU_SELECTED, _OnFit)

	End Method
	
	Method OnFit()
		mPlot.Fit()
	End Method

	Method OnQuit()
		Close(True)
	End Method
	
	Method OnAbout()
		wxMessageBox("wxWindows mathplot sample~n(c) 2003 David Schalig")
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
	
End Type



Type TOptimum Extends mpFX

	Method Create:TOptimum()
		Return TOptimum(Super.CreateLayer("Optimum ld(N)"))
	End Method

	Method GetY:Double(x:Double)
		If x >= 1 Then
			Return ld(x)
		Else
			Return 0
		End If
	End Method

End Type

Type TELias Extends mpFX

	Method Create:TELias()
		Return TELias(Super.CreateLayer("Elias-Kodes"))
	End Method

	Method GetY:Double(x:Double)
		If x >= 1 Then
			Return Floor(ld(x)) + 2.0 * Floor(ld( 1.0 + Floor(ld(x))))
		Else
			Return 0
		End If
	End Method

End Type

Type TFixedBitwidth Extends mpFX

	Field bitwidth:Int

	Method Create:TFixedBitwidth(bitwidth:Int)
		Self.bitwidth = bitwidth
		Return TFixedBitwidth(Super.CreateLayer("Feste Bitbreite"))
	End Method

	Method GetY:Double(x:Double)
		If x >= 0 Then
			Return bitwidth
		Else
			Return 0
		End If
	End Method

End Type
