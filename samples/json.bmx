SuperStrict

Framework wx.wxApp
Import wx.wxJSON
Import BRL.StandardIO

Type MyApp Extends wxApp

	Method OnInit:Int()

		
		Local root:wxJSONValue = New wxJSONValue.Create()
		
		root.Item("key1").SetString("somet text")
		
		Local writer:wxJSONWriter = New wxJSONWriter.Create()
		Local s:String = writer.WriteString( root )
		
		Print s
			
		Return False
	
	End Method

End Type


New MyApp.run()

