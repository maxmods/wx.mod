SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxPanel
Import wx.wxStaticText
Import wx.wxSpinCtrl
Import wx.wxSpinCtrlDouble
Import BRL.StandardIO

Type MyApp Extends wxApp

	Field frame:MyFrame

	Method OnInit:Int()
	
		frame = MyFrame(New MyFrame.Create(,,"Spin"))
		frame.show()
	
		Return True
	
	End Method

End Type

Type MyFrame Extends wxFrame

	Field panel:wxPanel
	
	Field spin:wxSpinCtrl
	Field spinDouble:wxSpinCtrlDouble
	
	Const FILE_QUIT:Int = wxID_EXIT
	Const HELP_ABOUT:Int = wxID_ABOUT

	Method OnInit:Int()

		panel = wxPanel.CreatePanel(Self)

		spin = New wxSpinCtrl.Create(panel, -1, "", 10, 10)
		spinDouble = New wxSpinCtrlDouble.Create(panel, -1, "", 10, 100)
		
		ConnectAny(wxEVT_COMMAND_SPINCTRL_UPDATED, OnSpin)
		ConnectAny(wxEVT_COMMAND_SPINCTRLDOUBLE, OnSpinDouble)
			
	End Method
	
	Function OnSpin(event:wxEvent)
		Print "Spin : " + wxSpinEvent(event).GetPosition()
	End Function
	
	Function OnSpinDouble(event:wxEvent)
		Print "Spin double : " + wxSpinDoubleEvent(event).GetValue()
	End Function
	
End Type

New MyApp.run()




