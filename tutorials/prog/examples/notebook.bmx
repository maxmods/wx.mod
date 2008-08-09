SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxNotebook
Import wx.wxSheet
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local sim:Notebook = Notebook(New Notebook.Create(Null, wxID_ANY, ..
			"Notebook", -1, -1, 400, 350))
		sim.Show(True)
 
		Return True
	End Method

End Type

Type Notebook Extends wxFrame
 
	Method OnInit()
		
		Local nb:wxNotebook = New wxNotebook.Create(Self, -1, ..
			-1, -1, -1, -1, wxNB_BOTTOM)
		
		Local menubar:wxMenuBar = New wxMenuBar.Create()
		Local file:wxMenu = New wxMenu.Create()
		file.Append(wxID_CLOSE, "Quit", "")
		menubar.Append(file, "&File")
		SetMenuBar(menubar)
		
		ConnectAny(wxEVT_COMMAND_MENU_SELECTED, OnQuit)
		
		Local sheet1:MySheet = MySheet(New MySheet.Create(nb, -1))
		Local sheet2:MySheet = MySheet(New MySheet.Create(nb, -1))
		Local sheet3:MySheet = MySheet(New MySheet.Create(nb, -1))
		
		nb.AddPage(sheet1, "Sheet1")
		nb.AddPage(sheet2, "Sheet2")
		nb.AddPage(sheet3, "Sheet3")
		
		CreateStatusBar()
		
		Centre()
 
	End Method
	
	Function OnQuit(event:wxEvent)
		wxWindow(event.parent).Close(True)
	End Function
	
End Type

Type MySheet Extends wxSheet

	Method OnInit()
		CreateGrid(30, 30)
		SetRowLabelWidth(50)
		SetColLabelHeight(25)
		Local attr:wxSheetCellAttr = GetDefaultRowLabelAttr()
		attr.SetAlignmentHV(wxALIGN_RIGHT, wxALIGN_CENTRE)
		attr.SetFont(New wxFont.CreateWithAttribs(9, ..
			wxFONTFAMILY_DEFAULT, wxFONTSTYLE_NORMAL, wxFONTWEIGHT_BOLD))
		
		For Local i:Int = 0 Until 30
		    SetRowHeight(i, 25)
		Next
	End Method

End Type