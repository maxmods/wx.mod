SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxPanel
Import wx.wxStaticText
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local mv:Move = Move(New Move.Create(Null, wxID_ANY, ..
			"Move event", -1, -1, 250, 130))
		mv.Show(True)
 
		Return True
	End Method

End Type

Type Move Extends wxFrame

	Field st1:wxStaticText
	Field st2:wxStaticText

	Method OnInit()

		Local panel:wxPanel = New wxPanel.Create(Self, -1)
		
		st1 = New wxStaticText.Create(panel, -1, "", 10, 10)
		st2 = New wxStaticText.Create(panel, -1, "", 10, 30)
		
		ConnectAny(wxEVT_MOVE, OnMove)
	
		Centre()
 
	End Method

	Function OnMove(event:wxEvent)
		Local m:Move = Move(event.parent)
	
		Local x:Int, y:Int
		wxMoveEvent(event).GetPosition(x, y)
		
		m.st1.SetLabel("x: " + x)
		m.st2.SetLabel("y: " + y)
	End Function
	
End Type

