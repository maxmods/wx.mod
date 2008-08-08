SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local txt:Gradient = Gradient(New Gradient.Create(Null, wxID_ANY, ..
			"Gradient", -1, -1, 220, 280))
		txt.Show(True)
 
		Return True
	End Method

End Type

Type Gradient Extends wxFrame
 
	Method OnInit()
		
		ConnectAny(wxEVT_PAINT, OnPaint)
		Centre()
 
	End Method
	
	Function OnPaint(event:wxEvent)

		Local dc:wxPaintDC = New wxPaintDC.Create(wxWindow(event.parent))
		
		Local col1:wxColour = New wxColour.CreateNamedColour("#e12223")
		Local col2:wxColour = New wxColour.CreateNamedColour("#000000")
		
		dc.GradientFillLinear(20, 20, 180, 40, col1, col2, wxNORTH)
		dc.GradientFillLinear(20, 80, 180, 40, col1, col2, wxSOUTH)
		dc.GradientFillLinear(20, 140, 180, 40, col1, col2, wxEAST)
		dc.GradientFillLinear(20, 200, 180, 40, col1, col2, wxWEST)  
	
		dc.Free()
	End Function
	
End Type



