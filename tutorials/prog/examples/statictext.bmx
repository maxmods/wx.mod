SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxPanel
Import wx.wxStaticText
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local st:StaticText = StaticText(New StaticText.Create(Null, wxID_ANY, ..
			"StaticText", -1, -1, 600, 130))
		st.Show(True)
 
		Return True
	End Method

End Type

Type StaticText Extends wxFrame
 
	Method OnInit()
		
		Local panel:wxPanel = New wxPanel.Create(Self, wxID_ANY)
		Local text:String = "'Cause sometimes you feel tired,~n" + ..
			"feel weak, and when you feel weak, " + ..
			"you feel like you wanna just give up.~n" + ..
			"But you gotta search within you, " + ..
			"you gotta find that inner strength~n" + ..
			"and just pull that shit out of you " + ..
			"and get that motivation to not give up~n" + ..
			"and not be a quitter, " + ..
			"no matter how bad you wanna just fall flat on your face and collapse."
		
		Local st:wxStaticText = New wxStaticText.Create(panel, ..
			wxID_ANY, text, 10, 10, -1, -1, wxALIGN_CENTRE)
		
		Centre()
 
	End Method
	
End Type

