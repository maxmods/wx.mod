SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local ln:Line = Line(New Line.Create(Null, wxID_ANY, ..
			"Line", -1, -1, 280, 180))
		ln.Show(True)
 
		Return True
	End Method

End Type

Type Line Extends wxFrame
 
	Method OnInit()
		
		ConnectAny(wxEVT_PAINT, OnPaint)
		Centre()
 
	End Method
	
	Function OnPaint(event:wxEvent)

		Local dc:wxPaintDC = New wxPaintDC.Create(wxWindow(event.parent))
		
		Local x1:Int = 50,  y1:Int = 60
		Local x2:Int = 190, y2:Int = 60
		
		dc.DrawLine(x1, y1, x2, y2)
		
		dc.Free()
	End Function
	
End Type

