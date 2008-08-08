SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local txt:Shapes = Shapes(New Shapes.Create(Null, wxID_ANY, ..
			"Shapes", -1, -1, 350, 300))
		txt.Show(True)
 
		Return True
	End Method

End Type

Type Shapes Extends wxFrame
 
	Method OnInit()
		
		ConnectAny(wxEVT_PAINT, OnPaint)
		Centre()
 
	End Method
	
	Function OnPaint(event:wxEvent)

		Local dc:wxPaintDC = New wxPaintDC.Create(wxWindow(event.parent))
		
		Local lines:Int[] = [ 20, 260, 100, 260, 20, 210, ..
			100, 210 ]
		Local polygon:Int[] = [ 130, 140, 180, 170, 180, 140, ..
			220, 110, 140, 100 ]
		Local splines:Int[] = [ 240, 170, 280, 170, 285, 110, ..
			325, 110 ]
		
		dc.DrawEllipse(20, 20, 90, 60)
		dc.DrawRoundedRectangle(130, 20, 90, 60, 10)
		dc.DrawArc(240, 40, 340, 40, 290, 20)
		
		dc.DrawPolygon(polygon)
		dc.DrawRectangle(20, 120, 80, 50)
		dc.DrawSpline(splines)
		
		dc.DrawLines(lines)
		dc.DrawCircle(170, 230, 35)
		dc.DrawRectangle(250, 200, 60, 60)
	
		dc.Free()
	End Function
	
End Type



