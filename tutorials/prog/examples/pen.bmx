SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local p:Pen = Pen(New Pen.Create(Null, wxID_ANY, ..
			"Pen", -1, -1, 360, 200))
		p.Show(True)
 
		Return True
	End Method

End Type

Type Pen Extends wxFrame
 
	Method OnInit()
		
		ConnectAny(wxEVT_PAINT, OnPaint)
		Centre()
 
	End Method
	
	Function OnPaint(event:wxEvent)
		Local dc:wxPaintDC = New wxPaintDC.Create(wxWindow(event.parent))
		
		Local col1:wxColour = New wxColour.CreateNamedColour("#0c0c0c")
		Local col2:wxColour = New wxColour.CreateNamedColour("#000000")
		
		Local brush:wxBrush = New wxBrush.CreateFromColour(..
			New wxColour.Create(255, 255, 255), wxTRANSPARENT)
		dc.SetBrush(brush)
		
		dc.SetPen(New wxPen.CreateFromColour(col1, 1, wxSOLID))
		dc.DrawRectangle(10, 15, 90, 60)
		
		dc.SetPen(New wxPen.CreateFromColour(col1, 1, wxDOT))
		dc.DrawRectangle(130, 15, 90, 60)
		
		dc.SetPen(New wxPen.CreateFromColour(col1, 1, wxLONG_DASH))
		dc.DrawRectangle(250, 15, 90, 60)
		
		dc.SetPen(New wxPen.CreateFromColour(col1, 1, wxSHORT_DASH))
		dc.DrawRectangle(10, 105, 90, 60)
		
		dc.SetPen(New wxPen.CreateFromColour(col1, 1, wxDOT_DASH))
		dc.DrawRectangle(130, 105, 90, 60)
		
		dc.SetPen(New wxPen.CreateFromColour(col1, 1, wxTRANSPARENT))
		dc.DrawRectangle(250, 105, 90, 60)
	
		dc.Free()
	End Function
	
End Type




