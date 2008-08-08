SuperStrict
 
Framework wx.wxApp
Import wx.wxDateTime
Import BRL.StandardIO
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local now:wxDateTime = wxDateTime.Now()
		Print now.Format("%B %d %Y")
 
		Local span:wxDateSpan = New wxDateSpan.Create(0, 1)
		Local later:wxDateTime = now.AddDS(span)
 
		Print later.Format("%B %d %Y")
 
		Return False
	End Method

End Type


