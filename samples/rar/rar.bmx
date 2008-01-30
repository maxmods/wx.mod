SuperStrict

Framework wx.wxApp
Import wx.wxrarinputstream

New MyApp.run()


Type MyApp Extends wxApp

	Method OnInit:Int()

		Local stream:wxRarInputStream = New wxRarInputStream.Create("some_stuff.rar")
	
		While stream.OpenNextFile()
		
			stream.ExtractFile(".")
		
		Wend
		
	
		Return False
	
	End Method

End Type






