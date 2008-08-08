SuperStrict
 
Framework wx.wxApp
Import wx.wxDateTime
Import BRL.StandardIO
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local now:wxDateTime = wxDateTime.Now()
 
		Print "   Tokyo: " + now.Format("%a %T", wxDateTime.GMT9)
		Print "  Moscow: " + now.Format("%a %T", wxDateTime.MSD)
		Print "Budapest: " + now.Format("%a %T", wxDateTime.CEST)
		Print "  London: " + now.Format("%a %T", wxDateTime.WEST)
		Print "New York: " + now.Format("%a %T", wxDateTime.EDT)
 
		Return False
	End Method

End Type


