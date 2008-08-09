SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxScrolledWindow
Import wx.wxStaticBitmap
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local sim:ScrolledWindow = ScrolledWindow(New ScrolledWindow.Create(Null, wxID_ANY, ..
			"ScrolledWindow", -1, -1, 300, 200))
		sim.Show(True)
 
		Return True
	End Method

End Type

Type ScrolledWindow Extends wxFrame
 
	Method OnInit()
		
		wxImage.AddHandler(New wxJPEGHandler)
		
		Local sw:wxScrolledWindow = New wxScrolledWindow.Create(Self)
		
		Local bmp:wxBitmap = New wxBitmap.CreateFromFile("../media/castle.jpg", wxBITMAP_TYPE_JPEG)
		Local sb:wxStaticBitmap = New wxStaticBitmap.Create(sw, -1, bmp)
		
		Local width:Int = bmp.GetWidth()
		Local height:Int = bmp.GetHeight()
		
		sw.SetScrollbars(10, 10, width/10, height/10)
		sw.Scroll(20, 5)

		Centre()
 
	End Method
	
End Type

