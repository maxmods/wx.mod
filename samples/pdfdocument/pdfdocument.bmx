SuperStrict

Framework wx.wxApp
Import wx.wxFrame

Import "tutorial1.bmx"
Import "tutorial2.bmx"
Import "tutorial3.bmx"


New MyApp.run()


Type MyApp Extends wxApp

	

	Method OnInit:Int()

		tutorial1()
		tutorial2()
		tutorial3()
		
		Return False
	
	End Method

End Type
