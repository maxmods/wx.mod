SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxMouseEvent
Import brl.standardio
Import wx.wxButton

New MyApp.run()

Type MyApp Extends wxApp

	Field frame:myframe

	Method OnInit:Int()

		frame = myframe(New myframe.Create(,,"Hello World", 100, 100))
		frame.show()
	
		Return True
	
	End Method

End Type

Type myframe Extends wxFrame

	Method OnInit()
	
		Local control:mybutton = mybutton(New mybutton.Create(Self, 100))
	
	
	End Method

End Type

' implementation of a custom control
Type mybutton Extends customcontrol

	Method OnInit()
		Super.OnInit()
		ConnectAny(wxEVT_COMMAND_BUTTON_CLICKED, clicked)
	End Method
	
	Function clicked(event:wxEvent)
		Print "Clicked!"
	End Function

End Type

' a custom control
Type customcontrol Extends wxControl

	Method Create:customcontrol(parent:wxWindow, id:Int, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1, style:Int = 0)
		Super.CreateControl(parent, id, x, y, w, h, style)
		Return Self
	End Method

	Method OnInit()
		
		ConnectAny(wxEVT_LEFT_UP, click)
	End Method
	
	Function click(event:wxEvent)
		Local evt:wxCommandEvent = wxCommandEvent.CreateEvent(wxEVT_COMMAND_BUTTON_CLICKED, event.GetId())
		wxWindow(Event.parent).GetEventHandler().ProcessEvent(evt)
	End Function

End Type



