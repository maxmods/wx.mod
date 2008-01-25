SuperStrict

Framework wx.wxApp
Import wx.wxFrame

Import "tutorial1.bmx"
Import "tutorial2.bmx"
Import "tutorial3.bmx"
Import "tutorial4.bmx"
Import "xmlwrite.bmx"


New MyApp.run()


Type MyApp Extends wxApp

	

	Method OnInit:Int()

		tutorial1()
		tutorial2()
		tutorial3()
		tutorial4()
		
		xmlwrite()
		
		Return False
	
	End Method

End Type
