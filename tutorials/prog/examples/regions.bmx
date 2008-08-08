SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local rgn:Regions = Regions(New Regions.Create(Null, wxID_ANY, ..
			"Regions", -1, -1, 270, 220))
		rgn.Show(True)
 
		Return True
	End Method

End Type

Type Regions Extends wxFrame
 
	Method OnInit()
		
		ConnectAny(wxEVT_PAINT, OnPaint)
		Centre()
 
	End Method
	
	Function OnPaint(event:wxEvent)

		Local dc:wxPaintDC = New wxPaintDC.Create(wxWindow(event.parent))
		
		Local gray:wxColour = New wxColour.CreateNamedColour("#d4d4d4")
		Local white:wxColour = New wxColour.CreateNamedColour("#ffffff")
		Local red:wxColour = New wxColour.CreateNamedColour("#ff0000")
		Local orange:wxColour = New wxColour.CreateNamedColour("#fa8e00")
		Local green:wxColour = New wxColour.CreateNamedColour("#619e1b")
		Local brown:wxColour = New wxColour.CreateNamedColour("#715b33")
		Local blue:wxColour = New wxColour.CreateNamedColour("#0d0060")
		
		dc.SetPen(New wxPen.CreateFromColour(gray))
		
		dc.DrawRectangle(20, 20, 50, 50)
		dc.DrawRectangle(30, 40, 50, 50)
		
		dc.SetBrush(New wxBrush.CreateFromColour(white))
		dc.DrawRectangle(100, 20, 50, 50)
		dc.DrawRectangle(110, 40, 50, 50) 
		Local region1:wxRegion = New wxRegion.Create(100, 20, 50, 50)
		Local region2:wxRegion = New wxRegion.Create(110, 40, 50, 50)
		region1.IntersectRegion(region2)
		Local rect1:wxRect = region1.GetBoxRect()
		dc.SetClippingRegionRegion(region1)
		dc.SetBrush(New wxBrush.CreateFromColour(red))
		dc.DrawRectangleRect(rect1)
		dc.DestroyClippingRegion()
		
		dc.SetBrush(New wxBrush.CreateFromColour(white))
		dc.DrawRectangle(180, 20, 50, 50)
		dc.DrawRectangle(190, 40, 50, 50)
		Local region3:wxRegion = New wxRegion.Create(180, 20, 50, 50)
		Local region4:wxRegion = New wxRegion.Create(190, 40, 50, 50)
		region3.UnionRegion(region4)
		dc.SetClippingRegionRegion(region3)
		Local rect2:wxRect = region3.GetBoxRect()
		dc.SetBrush(New wxBrush.CreateFromColour(orange))
		dc.DrawRectangleRect(rect2)
		dc.DestroyClippingRegion()
		
		dc.SetBrush(New wxBrush.CreateFromColour(white))
		dc.DrawRectangle(20, 120, 50, 50)
		dc.DrawRectangle(30, 140, 50, 50)
		Local region5:wxRegion = New wxRegion.Create(20, 120, 50, 50)
		Local region6:wxRegion = New wxRegion.Create(30, 140, 50, 50)
		region5.XorRegion(region6)
		Local rect3:wxRect = region5.GetBoxRect()
		dc.SetClippingRegionRegion(region5)
		dc.SetBrush(New wxBrush.CreateFromColour(green))
		dc.DrawRectangleRect(rect3)
		dc.DestroyClippingRegion()
		
		dc.SetBrush(New wxBrush.CreateFromColour(white))
		dc.DrawRectangle(100, 120, 50, 50)
		dc.DrawRectangle(110, 140, 50, 50)
		Local region7:wxRegion = New wxRegion.Create(100, 120, 50, 50)
		Local region8:wxRegion = New wxRegion.Create(110, 140, 50, 50)
		region7.SubtractRegion(region8)
		Local rect4:wxRect = region7.GetBoxRect()
		dc.SetClippingRegionRegion(region7)
		dc.SetBrush(New wxBrush.CreateFromColour(brown))
		dc.DrawRectangleRect(rect4)
		dc.DestroyClippingRegion()
		
		dc.SetBrush(New wxBrush.CreateFromColour(white))
		dc.DrawRectangle(180, 120, 50, 50)
		dc.DrawRectangle(190, 140, 50, 50)
		Local region9:wxRegion = New wxRegion.Create(180, 120, 50, 50)
		Local region10:wxRegion = New wxRegion.Create(190, 140, 50, 50)
		region10.SubtractRegion(region9)
		Local rect5:wxRect = region10.GetBoxRect()
		dc.SetClippingRegionRegion(region10)
		dc.SetBrush(New wxBrush.CreateFromColour(blue))
		dc.DrawRectangleRect(rect5)
		dc.DestroyClippingRegion() 
			
		dc.Free()
	End Function
	
End Type



