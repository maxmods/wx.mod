SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxPanel
Import wx.wxButton
Import wx.wxStaticText
 
Const ID_PLUS:Int = 101
Const ID_MINUS:Int = 102

New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local btn:Communicate = Communicate(New Communicate.Create(Null, wxID_ANY, ..
			"Widgets communicate", -1, -1, 290, 150))
		btn.Show(True)
 
		Return True
	End Method

End Type

Type Communicate Extends wxFrame
 
	Field m_lp:LeftPanel
	Field m_rp:RightPanel 
	Field m_parent:wxPanel 

	Method OnInit()
				
		m_parent = New wxPanel.Create(Self, wxID_ANY)

		Local hbox:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
		
		m_lp = LeftPanel(New LeftPanel.Create(m_parent,,,,,,wxBORDER_SUNKEN))
		m_rp = RightPanel(New RightPanel.Create(m_parent,,,,,,wxBORDER_SUNKEN))
		
		hbox.Add(m_lp, 1, wxEXPAND | wxALL, 5)
		hbox.Add(m_rp, 1, wxEXPAND | wxALL, 5)
		
		m_parent.SetSizer(hbox)

		Centre()
 
	End Method
	
	Function OnQuit(event:wxEvent)
		wxWindow(event.parent).Close(True)
	End Function
	
End Type

Type LeftPanel Extends wxPanel

	Field m_plus:wxButton
	Field m_minus:wxButton
	Field m_parent:wxPanel
	Field count:Int
	
	Method OnInit()
		count = 0
		m_parent = wxPanel(GetParent())
		
		m_plus = New wxButton.Create(Self, ID_PLUS, "+", 10, 10)
		m_minus = New wxButton.Create(Self, ID_MINUS, "-", 10, 60)
		
		Connect(ID_PLUS, wxEVT_COMMAND_BUTTON_CLICKED, OnPlus)
		Connect(ID_MINUS, wxEVT_COMMAND_BUTTON_CLICKED, OnMinus)
	End Method

	Function OnPlus(event:wxEvent)
		Local panel:LeftPanel = LeftPanel(event.parent)
		
		panel.count:+ 1

		Local comm:Communicate = Communicate(panel.m_parent.GetParent())
		comm.m_rp.m_text.SetLabel(panel.count)
	End Function

	Function OnMinus(event:wxEvent)
		Local panel:LeftPanel = LeftPanel(event.parent)
		
		panel.count:- 1

		Local comm:Communicate = Communicate(panel.m_parent.GetParent())
		comm.m_rp.m_text.SetLabel(panel.count)
	End Function
	
End Type
	
Type RightPanel Extends wxPanel

	Field m_text:wxStaticText
	
	Method OnInit()
		m_text = New wxStaticText.Create(Self, -1, "0", 40, 60)
	End Method
	
	Function OnSetText(event:wxEvent)
	End Function

End Type
