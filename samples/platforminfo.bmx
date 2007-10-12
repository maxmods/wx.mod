SuperStrict

Framework wx.wxApp
Import BRL.StandardIO
Import wx.wxPlatformInfo


New MyApp.run()


Type MyApp Extends wxApp

	Method OnInit:Int()

		Print "Architecture : " + wxPlatformInfo.GetArchName()
		Print "Endianness   : " + wxPlatformInfo.GetEndiannessName()
		Print ""
		Print "OS Family    : " + wxPlatformInfo.GetOperatingSystemFamilyName()
		Print "OS Id Name   : " + wxPlatformInfo.GetOperatingSystemIdName()
		Print ""
		Print "Port Id Name : " + wxPlatformInfo.GetPortIdName()
		Print "Port Short   : " + wxPlatformInfo.GetPortIdShortName()
	
		Return False
	
	End Method

End Type

