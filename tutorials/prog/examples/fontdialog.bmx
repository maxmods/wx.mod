SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxPanel
Import wx.wxStaticText
Import wx.wxFontDialog
 
Const ID_FONTDIALOG:Int = 1
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
    
		Local change:ChangeFont = ChangeFont(New ChangeFont.Create(Null, ..
			wxID_ANY, "Change font", -1, -1, 300, 200))
		change.Show(True)
 
		Return True
	End Method

End Type
 
Type ChangeFont Extends wxFrame
 
	Field st:wxStaticText
	
	Method OnInit()

		Local panel:wxPanel = New wxPanel.Create(Self, -1)
 
		Local menubar:wxMenuBar = New wxMenuBar.Create()
		Local file:wxMenu = New wxMenu.Create()
 
		file.Append(ID_FONTDIALOG, "&Change font")
		menubar.Append(file, "&File")
		SetMenuBar(menubar)
 
		Connect(ID_FONTDIALOG, wxEVT_COMMAND_MENU_SELECTED, OnOpen)
 
		st = New wxStaticText.Create(panel, wxID_ANY, "The Agoge", 20, 20)
 
		Center()
 
	End Method
	
	Function OnOpen(event:wxEvent)
		Local frame:ChangeFont = ChangeFont(event.parent)
	
		Local fontDialog:wxFontDialog = wxFontDialog.CreateFontDialog(frame)
 
		If fontDialog.ShowModal() = wxID_OK Then
			frame.st.SetFont(fontDialog.GetFontData().GetChosenFont())
		End If
 
	End Function

End Type
