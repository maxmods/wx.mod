SuperStrict

Framework wx.wxApp
Import wx.wxPanel
Import wx.wxFrame
Import wx.wxButton
Import wx.wxMouseEvent

New MyApp.run()

Type MyApp Extends wxApp

	Field frame:MyFrame

	Method OnInit:Int()

		frame = MyFrame(New MyFrame.Create(Null, -1, "Button Mouse/Event Test", 200, 200))
		
		SetTopWindow(frame)
		
		frame.show()
	
		Return True
	
	End Method

End Type

Type MyFrame Extends wxFrame

	Const BUTTON1:Int = 101

	Method OnInit()

		' a panel
		Local panel:wxPanel = wxPanel.CreatePanel(Self)

		' add buttons to the panel
		New MyButton.Create(panel, BUTTON1, "Button &1", 50, 30, 100, 30)

	End Method
	
End Type

Type MyButton Extends wxButton

	Method OnInit()
	
		ConnectAny(wxEVT_LEFT_DOWN, OnMouseDown)

	End Method

	Function OnMouseDown(event:wxEvent)
		DebugLog "down!"
		
		event.Skip()
	End Function


End Type

