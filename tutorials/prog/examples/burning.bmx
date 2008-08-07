SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxSlider
 
Import "widget.bmx"

New MyApp.Run()
 
Const ID_SLIDER:Int = 1
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local open:Burning = Burning(New Burning.Create(Null, ..
			wxID_ANY, "The Burning Widget", -1, -1, 350, 200))
		open.Show(True)
 
		Return True
	End Method

End Type

Type Burning Extends wxFrame
 
	Field m_slider:wxSlider
	Field m_wid:Widget

	Method OnInit()
 
		Local panel:wxPanel = New wxPanel.Create(Self, wxID_ANY)
		Local centerPanel:wxPanel = New wxPanel.Create(panel, wxID_ANY)
		
		m_slider = New wxSlider.Create(centerPanel, ID_SLIDER, 75, 0, 750, -1, -1, ..
			150, -1, wxSL_LABELS)
		
		Local vbox:wxBoxSizer = New wxBoxSizer.Create(wxVERTICAL)
		Local hbox:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
		Local hbox2:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
		Local hbox3:wxBoxSizer = New wxBoxSizer.Create(wxHORIZONTAL)
		
		m_wid = New Widget.Create(panel, wxID_ANY)
		m_wid.SetCurWidth(75)

		hbox.Add(m_wid, 1, wxEXPAND)
		
		hbox2.Add(centerPanel, 1, wxEXPAND)
		hbox3.Add(m_slider, 0, wxTOP | wxLEFT, 35)
		
		centerPanel.SetSizer(hbox3)
		
		vbox.AddSizer(hbox2, 1, wxEXPAND)
		vbox.AddSizer(hbox, 0, wxEXPAND)
		
		panel.SetSizer(vbox)
		m_slider.SetFocus()
		
		Connect(ID_SLIDER, wxEVT_COMMAND_SLIDER_UPDATED, OnScroll)
		
		Centre()
 
	End Method
	
	Function OnScroll(event:wxEvent)
		Local frame:Burning = Burning(event.parent)

		frame.m_wid.SetCurWidth(frame.m_slider.GetValue())
		frame.m_wid.Refresh()
	End Function

End Type


