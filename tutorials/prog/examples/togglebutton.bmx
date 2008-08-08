SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxToggleButton
Import wx.wxPanel
 
Const ID_TGBUTTON1:Int = 101
Const ID_TGBUTTON2:Int = 102
Const ID_TGBUTTON3:Int = 103
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local toggle:ToggleButton = ToggleButton(New ToggleButton.Create(Null, ..
			wxID_ANY, "ToggleButton", -1, -1, 280, 180))
		toggle.Centre() 
		toggle.Show(True)
		
		Return True
	End Method

End Type

Type ToggleButton Extends wxFrame
 
	Field m_tgbutton1:wxToggleButton
	Field m_tgbutton2:wxToggleButton
	Field m_tgbutton3:wxToggleButton

	Field m_panel:wxPanel
	Field colour:wxColour

	Method OnInit()
		
		Local panel:wxPanel = New wxPanel.Create(Self, wxID_ANY)
		
		colour = New wxColour.Create(0, 0, 0)
		
		m_tgbutton1 = New wxToggleButton.Create(panel, ..
			ID_TGBUTTON1, "Red", 20, 20)
		m_tgbutton2 = New wxToggleButton.Create(panel, ..
			ID_TGBUTTON2, "Green", 20, 70)
		m_tgbutton3 = New wxToggleButton.Create(panel, ..
			ID_TGBUTTON3, "Blue", 20, 120)
		
		Connect(ID_TGBUTTON1, wxEVT_COMMAND_TOGGLEBUTTON_CLICKED, ..
			OnToggleRed)
		Connect(ID_TGBUTTON2, wxEVT_COMMAND_TOGGLEBUTTON_CLICKED, ..
			OnToggleGreen)
		Connect(ID_TGBUTTON3, wxEVT_COMMAND_TOGGLEBUTTON_CLICKED, ..
			OnToggleBlue)
		
		m_panel = New wxPanel.Create(panel, wxID_NEW, 150, 20, ..
			110, 110, wxSUNKEN_BORDER)
		m_panel.SetBackgroundColour(colour)

 
	End Method

	Function OnToggleRed(event:wxEvent)
		Local tog:ToggleButton = ToggleButton(event.parent)
	
		Local green:Int = tog.colour.Green()
		Local blue:Int = tog.colour.Blue()
		
		If tog.colour.Red() Then
			tog.colour.Set(0, green, blue)
		Else
			tog.colour.Set(255, green, blue)
		End If
		
		tog.m_panel.SetBackgroundColour(tog.colour)
	End Function
	
	Function OnToggleGreen(event:wxEvent)
		Local tog:ToggleButton = ToggleButton(event.parent)
	
		Local red:Int = tog.colour.Red()
		Local blue:Int = tog.colour.Blue()
		
		If tog.colour.Green() Then
			tog.colour.Set(red, 0, blue)
		Else
			tog.colour.Set(red, 255, blue)
		End If
		
		tog.m_panel.SetBackgroundColour(tog.colour)
	End Function

	Function OnToggleBlue(event:wxEvent)
		Local tog:ToggleButton = ToggleButton(event.parent)
	
		Local red:Int = tog.colour.Red()
		Local green:Int = tog.colour.Green()
		
		If tog.colour.Blue() Then
			tog.colour.Set(red, green, 0)
		Else
			tog.colour.Set(red, green, 255)
		End If
		
		tog.m_panel.SetBackgroundColour(tog.colour)
	End Function

	
End Type

