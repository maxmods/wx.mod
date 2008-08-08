SuperStrict
 
Framework wx.wxApp
Import wx.wxDialog
Import wx.wxStaticLine
Import wx.wxStaticText
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local sl:Staticline = Staticline(New Staticline.Create_(Null, wxID_ANY, ..
			"The Central Europe", -1, -1, 360, 350))
		sl.ShowModal()
		sl.Destroy()
 
		Return True
	End Method

End Type

Type Staticline Extends wxDialog
 
	Method OnInit()
		
		Local font:wxFont = New wxFont.CreateWithAttribs(10, ..
			wxDEFAULT, wxNORMAL, wxBOLD)
		Local heading:wxStaticText = New wxStaticText.Create(Self, ..
			wxID_ANY, "The Central Europe", 30, 15)
		heading.SetFont(font)
		
		Local sl1:wxStaticLine = New wxStaticLine.Create(Self, ..
			wxID_ANY, 25, 50, 300,1)
		
		Local st1:wxStaticText = New wxStaticText.Create(Self, ..
			wxID_ANY, "Slovakia", 25, 80)
		Local st2:wxStaticText = New wxStaticText.Create(Self, ..
			wxID_ANY, "Hungary", 25, 100)
		Local st3:wxStaticText = New wxStaticText.Create(Self, ..
			wxID_ANY, "Poland", 25, 120)
		Local st4:wxStaticText = New wxStaticText.Create(Self, ..
			wxID_ANY, "Czech Republic", 25, 140)
		Local st5:wxStaticText = New wxStaticText.Create(Self, ..
			wxID_ANY, "Germany", 25, 160)
		Local st6:wxStaticText = New wxStaticText.Create(Self, ..
			wxID_ANY, "Slovenia", 25, 180)
		Local st7:wxStaticText = New wxStaticText.Create(Self, ..
			wxID_ANY, "Austria", 25, 200)
		Local st8:wxStaticText = New wxStaticText.Create(Self, ..
			wxID_ANY, "Switzerland", 25, 220)
		
		
		Local st9:wxStaticText = New wxStaticText.Create(Self, ..
			wxID_ANY, "5 379 000", 220, 80, 90, -1, wxALIGN_RIGHT)
		Local st10:wxStaticText = New wxStaticText.Create(Self, ..
			wxID_ANY, "10 084 000", 220, 100, 90, -1, wxALIGN_RIGHT)
		Local st11:wxStaticText = New wxStaticText.Create(Self, ..
			wxID_ANY, "38 635 000", 220, 120, 90, -1, wxALIGN_RIGHT)
		Local st12:wxStaticText = New wxStaticText.Create(Self, ..
			wxID_ANY, "10 240 000", 220, 140, 90, -1, wxALIGN_RIGHT)
		Local st13:wxStaticText = New wxStaticText.Create(Self, ..
			wxID_ANY, "82 443 000", 220, 160, 90, -1, wxALIGN_RIGHT)
		Local st14:wxStaticText = New wxStaticText.Create(Self, ..
			wxID_ANY, "2 001 000",  220, 180, 90, -1, wxALIGN_RIGHT)
		Local st15:wxStaticText = New wxStaticText.Create(Self, ..
			wxID_ANY, "8 032 000",  220, 200, 90, -1, wxALIGN_RIGHT)
		Local st16:wxStaticText = New wxStaticText.Create(Self, ..
			wxID_ANY, "7 288 000",  220, 220, 90, -1, wxALIGN_RIGHT)
		
		Local sl2:wxStaticLine = New wxStaticLine.Create(Self, ..
			wxID_ANY, 25, 260, 300, 1)
		
		Local sum:wxStaticText = New wxStaticText.Create(Self, ..
			wxID_ANY, "164 102 000", 220, 280)

		Local sum_font:wxFont = sum.GetFont()
		sum_font.SetWeight(wxBOLD)
		sum.SetFont(sum_font)

		Centre()
 
	End Method
	
End Type

