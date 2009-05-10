'
' wxGoogleTranslate sample
'
'
SuperStrict

Framework wx.wxApp
Import wx.wxGoogleTranslate
Import BRL.StandardIO

New MyApp.Run()

Type MyApp Extends wxApp


	Method OnInit:Int()

		Local source:String = "Hello World!"
		Local result:String
		Local details:String
		Local errorCode:Int

		If wxGoogleTranslate.Translate(source, result, wxGoogleTranslate.GetLanguageCode("ENGLISH"), ..
				wxGoogleTranslate.GetLanguageCode("GERMAN"), details, errorCode) Then
		
			Print source + " = " + result
		Else
			Print details
		End If
	
		Return False
	
	End Method

End Type

