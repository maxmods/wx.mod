SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxPanel
Import wx.wxButton
Import BRL.StandardIO
 
Const ID_BUTTON:Int = 1

New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local prop:Propagate = Propagate(New Propagate.Create(Null, wxID_ANY, ..
			"Propagate", -1, -1, 250, 130))
		prop.Show(True)
 
		Return True
	End Method

End Type

Type Propagate Extends wxFrame
 
	Method OnInit()
		
		Local panel:MyPanel = MyPanel(New MyPanel.Create(Self, -1))
		
		New MyButton.Create(panel, ID_BUTTON, "Ok")
		
		Connect(ID_BUTTON, wxEVT_COMMAND_BUTTON_CLICKED, OnClick)
		
		Centre()
 
	End Method

	Function OnClick(event:wxEvent)
		Print "event reached frame type"
		event.Skip()
	End Function
	
End Type

Type MyButton Extends wxButton

	Method OnInit()
		Connect(ID_BUTTON, wxEVT_COMMAND_BUTTON_CLICKED, OnClick)
	End Method
	
	Function OnClick(event:wxEvent)
		Print "event reached button type"
		event.Skip()
	End Function
	
End Type

Type MyPanel Extends wxPanel

	Method OnInit()
		Connect(ID_BUTTON, wxEVT_COMMAND_BUTTON_CLICKED, OnClick)
	End Method

	Function OnClick(event:wxEvent)
		Print "event reached panel type"
		event.Skip()
	End Function

End Type