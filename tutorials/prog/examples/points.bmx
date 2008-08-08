SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import BRL.Random
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local pts:Points = Points(New Points.Create(Null, wxID_ANY, ..
			"Points", -1, -1, 250, 150))
		pts.Show(True)
 
		Return True
	End Method

End Type

Type Points Extends wxFrame
 
	Method OnInit()
		
		SeedRnd(MilliSecs())
		ConnectAny(wxEVT_PAINT, OnPaint)
		Centre()
 
	End Method
	
	Function OnPaint(event:wxEvent)
		Local this:Points = Points(event.parent)

		Local dc:wxPaintDC = New wxPaintDC.Create(this)
		
		Local x:Int = 0
		Local y:Int = 0
		
		Local width:Int, height:Int
		this.GetSize(width, height)
		
		For Local i:Int = 0 Until 1000
		    x = Rand(0, width) + 1
		    y = Rand(0, height) + 1
		    dc.DrawPoint(x, y)
		Next
	
		dc.Free()
	End Function
	
End Type



