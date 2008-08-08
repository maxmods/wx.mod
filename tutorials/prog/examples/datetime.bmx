SuperStrict
 
Framework wx.wxApp
Import wx.wxDateTime
Import BRL.StandardIO
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local now:wxDateTime = wxDateTime.Now()

		Print now.Format()
		Print now.Format("%X")
		Print now.Format("%x")
 
		Return False
	End Method

End Type


