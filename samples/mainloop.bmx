SuperStrict

Framework wx.wxApp
Import wx.wxFrame

Type MyApp Extends wxAppMain

	Field frame:wxFrame

	Method OnInit:Int()

		frame = wxFrame.CreateFrame(,,"Hello World", 100, 100)
		frame.show()
	
		Return True
	
	End Method
	
	Method MainLoop:Int()
DebugLog "MainLoop..."

		While True
DebugLog "while..."
	
			If Pending() Then
DebugLog "Pending..."
				If Not Dispatch() Then
DebugLog "!Dispatch..."
					Exit
				End If
			End If

	
			While Not Pending() And ProcessIdle()
DebugLog "ProcessIdle..."
			
			Wend
	
			Delay 100

		Wend
	
		Return 0
	
	End Method

End Type


New MyApp.run()



