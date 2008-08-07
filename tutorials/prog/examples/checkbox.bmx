SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxCheckBox
Import wx.wxPanel
 
Const ID_CHECKBOX:Int = 100
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local cb:CheckBox = CheckBox(New CheckBox.Create(Null, ..
			wxID_ANY, "CheckBox", -1, -1, 270, 150))
		cb.Show(True)
 
		Return True
	End Method

End Type

Type CheckBox Extends wxFrame
 
	Field m_cb:wxCheckBox
	
	Method OnInit()
 
		Local panel:wxPanel = New wxPanel.Create(Self, wxID_ANY)
 
		m_cb = New wxCheckBox.Create(panel, ID_CHECKBOX, "Show title", 20, 20)
		m_cb.SetValue(True)
 
		Connect(ID_CHECKBOX, wxEVT_COMMAND_CHECKBOX_CLICKED, OnToggle)
 
		Centre()
 
	End Method
	
	Function OnToggle(event:wxEvent)
		Local frame:CheckBox = CheckBox(event.parent)
	 
		If frame.m_cb.GetValue() Then
			frame.SetTitle("CheckBox")
		Else
			frame.SetTitle("")
		End If
 

	End Function

End Type
