SuperStrict
 
Framework wx.wxApp
Import wx.wxProcess
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
    
		wxShell("ls -l")
 
		Return False

	End Method

End Type


