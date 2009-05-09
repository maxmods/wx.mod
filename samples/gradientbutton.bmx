SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxGradientButton
Import wx.wxTextCtrl
Import wx.wxStaticText
Import wx.wxListBox
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local sim:MyFrame = MyFrame(New MyFrame.Create(Null, wxID_ANY, ..
			"wxGradientButton sample", -1, -1, 250, 150))
		sim.Show(True)
 
		Return True
	End Method

End Type

Const ID_WXTESTMAINFRAME:Int = 10000
Const ID_TEXTCTRL:Int = 10001
Const ID_GRADIENTBUTTON:Int = 10003
Const ID_GRADIENTBUTTON1:Int = 10005
Const ID_GRADIENTBUTTON2:Int = 10006
Const ID_GRADIENTBUTTON3:Int = 10007
Const ID_GRADIENTBUTTON4:Int = 10008
Const ID_GRADIENTBUTTON5:Int = 10009
Const ID_GRADIENTBUTTON6:Int = 10010
Const ID_GRADIENTBUTTON7:Int = 10011
Const ID_GRADIENTBUTTON8:Int = 10012
Const ID_GRADIENTBUTTON9:Int = 10013
Const ID_GRADIENTBUTTON10:Int = 10014
Const ID_GRADIENTBUTTON11:Int = 10015
Const ID_GRADIENTBUTTON12:Int = 10002
Const ID_LISTBOX:Int = 10004


Type MyFrame Extends wxFrame
 
	Method OnInit()
	
		SetBackgroundColour(New wxColour.Create(87, 87, 87))
		
		Local menuBar:wxMenuBar = New wxMenuBar.Create()
		Local itemMenu3:wxMenu = New wxMenu.Create()
		itemMenu3.Append(wxID_EXIT, "Exit~tAlt+F4", "", wxITEM_NORMAL)
		menuBar.Append(itemMenu3, "File")
		SetMenuBar(menuBar)
		
		Local itemBoxSizer5:wxBoxSizer = New wxBoxSizer.Create(wxVERTICAL)
		SetSizer(itemBoxSizer5)
		
		Local itemTextCtrl6:wxTextCtrl = New wxTextCtrl.Create(Self, ID_TEXTCTRL, "", -1, -1, -1, -1, 0)
		'itemTextCtrl6.SetFont(New wxFont.CreateWithAttribs(12, wxSWISS, wxNORMAL, wxNORMAL, False, "Tahoma"))
		itemBoxSizer5.Add(itemTextCtrl6, 0, wxGROW|wxLEFT|wxRIGHT|wxTOP, 5)
		
		Local itemGridBagSizer7:wxGridBagSizer = New wxGridBagSizer.CreateGB(5, 3)
		itemGridBagSizer7.AddGrowableCol(0)
		itemGridBagSizer7.AddGrowableCol(1)
		itemGridBagSizer7.AddGrowableCol(2)
		itemGridBagSizer7.SetEmptyCellSize(10, 20)
		itemBoxSizer5.AddSizer(itemGridBagSizer7, 0, wxGROW|wxLEFT|wxRIGHT|wxTOP, 5)
		
		Local itemButton8:wxGradientButton = New wxGradientButton.Create(Self, ID_GRADIENTBUTTON, "1", -1, -1, -1, -1, 0 )
		itemGridBagSizer7.AddGB(itemButton8, 0, 0, 1, 1, wxGROW, 2)
		
		Local itemButton9:wxGradientButton = New wxGradientButton.Create(Self, ID_GRADIENTBUTTON1, "2", -1, -1, -1, -1, 0 )
		itemGridBagSizer7.AddGB(itemButton9, 0, 1, 1, 1, wxGROW, 2)
		
		Local itemButton10:wxGradientButton = New wxGradientButton.Create(Self, ID_GRADIENTBUTTON2, "3", -1, -1, -1, -1, 0 )
		itemGridBagSizer7.AddGB(itemButton10, 0, 2, 1, 1, wxGROW, 2)
		
		Local itemButton11:wxGradientButton = New wxGradientButton.Create(Self, ID_GRADIENTBUTTON3, "4", -1, -1, -1, -1, 0 )
		itemGridBagSizer7.AddGB(itemButton11, 1, 0, 1, 1, wxGROW, 2)
		
		Local itemButton12:wxGradientButton = New wxGradientButton.Create(Self, ID_GRADIENTBUTTON4, "5", -1, -1, -1, -1, 0 )
		itemGridBagSizer7.AddGB(itemButton12, 1, 1, 1, 1, wxGROW, 2)
		
		Local itemButton13:wxGradientButton = New wxGradientButton.Create(Self, ID_GRADIENTBUTTON5, "6", -1, -1, -1, -1, 0 )
		itemGridBagSizer7.AddGB(itemButton13, 1, 2, 1, 1, wxGROW, 2)
		
		Local itemButton14:wxGradientButton = New wxGradientButton.Create(Self, ID_GRADIENTBUTTON6, "7", -1, -1, -1, -1, 0 )
		itemGridBagSizer7.AddGB(itemButton14, 2, 0, 1, 1, wxGROW, 2)
		
		Local itemButton15:wxGradientButton = New wxGradientButton.Create(Self, ID_GRADIENTBUTTON7, "8", -1, -1, -1, -1, 0 )
		itemGridBagSizer7.AddGB(itemButton15, 2, 1, 1, 1, wxGROW, 2)
		
		Local itemButton16:wxGradientButton = New wxGradientButton.Create(Self, ID_GRADIENTBUTTON8, "9", -1, -1, -1, -1, 0 )
		itemGridBagSizer7.AddGB(itemButton16, 2, 2, 1, 1, wxGROW, 2)
		
		Local itemButton17:wxGradientButton = New wxGradientButton.Create(Self, ID_GRADIENTBUTTON9, "*", -1, -1, -1, -1, 0 )
		itemGridBagSizer7.AddGB(itemButton17, 3, 0, 1, 1, wxGROW, 2)
		
		Local itemButton18:wxGradientButton = New wxGradientButton.Create(Self, ID_GRADIENTBUTTON10, "0", -1, -1, -1, -1, 0 )
		itemGridBagSizer7.AddGB(itemButton18, 3, 1, 1, 1, wxGROW, 2)
		
		Local itemButton19:wxGradientButton = New wxGradientButton.Create(Self, ID_GRADIENTBUTTON11, "#", -1, -1, -1, -1, 0 )
		itemGridBagSizer7.AddGB(itemButton19, 3, 2, 1, 1, wxGROW, 2)
		
		Local itemButton20:wxGradientButton = New wxGradientButton.Create(Self, ID_GRADIENTBUTTON12, "Dial", -1, -1, -1, -1, 0 )
		itemGridBagSizer7.AddGB(itemButton20, 4, 0, 1, 3, wxGROW, 2)
		
		Local itemStaticText21:wxStaticText = New wxStaticText.Create(Self, wxID_STATIC, "Recent calls:", -1, -1, -1, -1, 0 )
		itemStaticText21.SetForegroundColour(New wxColour.Create(255, 255, 255))
		'itemStaticText21.SetFont(New wxFont.CreateWithAttribs(8, wxSWISS, wxNORMAL, wxBOLD, False, "Tahoma"))
		itemBoxSizer5.Add(itemStaticText21, 0, wxALIGN_LEFT|wxLEFT|wxRIGHT|wxTOP, 5)
		
		Local itemListBox22:wxListBox = New wxListBox.Create(Self, ID_LISTBOX, Null, -1, -1, -1, -1, wxLB_SINGLE )
		itemBoxSizer5.Add(itemListBox22, 1, wxGROW|wxALL, 5)

		SetSizerAndFit(itemBoxSizer5)
		
		Center()
 
	End Method
	
End Type

