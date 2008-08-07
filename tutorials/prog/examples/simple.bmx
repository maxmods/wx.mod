SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local sim:Simple = Simple(New Simple.Create(Null, wxID_ANY, ..
			"Simple", -1, -1, 250, 150))
		sim.Show(True)
 
		Return True
	End Method

End Type

Type Simple Extends wxFrame
 
	Method OnInit()
		
		Centre()
 
	End Method
	
End Type
