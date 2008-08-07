SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxPanel
Import wx.wxButton
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local btn:Button = Button(New Button.Create(Null, wxID_ANY, ..
			"Button", -1, -1, 270, 150))
		btn.Show(True)
 
		Return True
	End Method

End Type

Type Button Extends wxFrame
 
	Method OnInit()
				
		Local panel:wxPanel = New wxPanel.Create(Self, wxID_ANY)
		
		Local button:wxButton = New wxButton.Create(panel, wxID_EXIT, "Quit", 20, 20)
		
		Connect(wxID_EXIT, wxEVT_COMMAND_BUTTON_CLICKED, OnQuit)
		button.SetFocus()

		Centre()
 
	End Method
	
	Function OnQuit(event:wxEvent)
		wxWindow(event.parent).Close(True)
	End Function
	
End Type


