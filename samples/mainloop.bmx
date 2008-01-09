'
' mainloop sample
'
' Initial hack, Bruce A Henderson
' Fixed by Si Dunford (Scaremonger) ;-)
'
'
SuperStrict

Framework wx.wxApp
Import wx.wxFrame

Type MyApp Extends wxAppMain
	Field frame:wxFrame
	Global shouldExit:Int = False
	
	Method OnInit:Int()

		frame = wxFrame.CreateFrame(,,"Hello World", 100, 100)
		frame.show()
	
		'# Connect exit event
		frame.Connect(, wxEVT_CLOSE,onQuit)

	Return True
	End Method
	
	Method MainLoop:Int() 
		While True
			While Not Pending() And ProcessIdle() ; Wend
			While Pending()
				If Not Dispatch() Then
					shouldExit = True
					Exit
				End If
			Wend
			If shouldExit Then
				While pending() 
					dispatch() 
				Wend
				Return 0
			End If
DebugLog "While loop"
		Wend
	End Method
	
	Function OnQuit(event:wxEvent) 
		MyApp.shouldExit = True
	End Function

End Type

New MyApp.run()
