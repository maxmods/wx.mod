SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxImage
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		wxImage.AddHandler( New wxPNGHandler )
	
		Local ic:Icon = Icon(New Icon.Create(Null, wxID_ANY, ..
			"Icon", -1, -1, 250, 150))
		ic.Show(True)
 
		Return True
	End Method

End Type

Type Icon Extends wxFrame
 
	Method OnInit()
				
		SetIcon(wxIcon.CreateFromFile("../media/world.png", wxBITMAP_TYPE_PNG))

		Centre()
 
	End Method
	
End Type

