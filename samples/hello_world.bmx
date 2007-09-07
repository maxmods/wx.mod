SuperStrict

Framework wx.wxApp
Import wx.wxFrame

Type MyApp Extends wxApp

	Field frame:wxFrame

	Method OnInit:Int()

		frame = wxFrame.CreateFrame("Hello World", 100, 100)
		frame.show()
	
		Return True
	
	End Method

End Type


New MyApp.run()


