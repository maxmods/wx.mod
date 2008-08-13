SuperStrict

Framework wx.wxApp
Import wx.wxXmlResource

New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		wxXmlResource.Get().InitAllHandlers()
		wxXmlResource.Get().Load("helloworld.xrc")
		
		Local frame:wxFrame = wxXmlResource.Get().LoadFrame(Null, "MyFrame1")
		frame.Show(True)
 
		Return True
	End Method

End Type


