SuperStrict
 
Framework wx.wxApp
Import BRL.StandardIO
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Print wxGetHomeDir()
		Print wxGetOsDescription()
		Print wxGetUserName()
		Print wxGetFullHostName()
 
		Print "Memory: " + wxGetFreeMemory()
 
		Return False
	End Method

End Type


