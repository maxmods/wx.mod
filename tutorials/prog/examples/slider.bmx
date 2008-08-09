SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxPanel
Import wx.wxSlider
 
Const ID_SLIDER:Int = 100

New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local sim:Slider = Slider(New Slider.Create(Null, wxID_ANY, ..
			"Slider", -1, -1, 270, 210))
		sim.Show(True)
 
		Return True
	End Method

End Type

Type Slider Extends wxFrame
 
	Field panel:MyPanel
	
	Method OnInit()
		panel = MyPanel(New MyPanel.Create(Self))
		
		Centre()
 
	End Method
	
End Type

Type MyPanel Extends wxPanel

    Field slider:wxSlider
    Field fill:Int

	Method OnInit()
		fill = 0
		slider = New wxSlider.Create(Self, ID_SLIDER, 0, 0, 140, ..
			50, 30, -1, 140, wxSL_VERTICAL)
		
		Connect(ID_SLIDER, wxEVT_COMMAND_SLIDER_UPDATED, OnScroll)  
		ConnectAny(wxEVT_PAINT, OnPaint)
	End Method

	Function OnScroll(event:wxEvent)
		Local panel:MyPanel = MyPanel(event.parent)
		
		panel.fill = panel.slider.GetValue()
		panel.Refresh()
	End Function
	
	Function OnPaint(event:wxEvent)
		Local panel:MyPanel = MyPanel(event.parent)

		Local dc:wxPaintDC = New wxPaintDC.Create(panel)
		
		Local col1:wxColour = New wxColour.Create(212, 212, 212)
		dc.SetPen(New wxPen.CreateFromColour(col1))
		
		dc.DrawRectangle(140, 30, 80, 140)
		
		Local col2:wxColour = New wxColour.Create(197, 108, 0)
		dc.SetBrush(New wxBrush.CreateFromColour(col2))
		
		dc.DrawRectangle(140, 30, 80, panel.fill)
		
		dc.Free()
	End Function

End Type
