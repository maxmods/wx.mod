SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxTextCtrl
Import wx.wxFileDialog
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local open:FileOpen = FileOpen(New FileOpen.Create(Null, ..
			wxID_ANY, "Openfile", -1, -1, 300, 200))
		open.Show(True)
 
		Return True
	End Method

End Type

Type FileOpen Extends wxFrame
 
	Field tc:wxTextCtrl
	
	Method OnInit()
 
		Local menubar:wxMenuBar = New wxMenuBar.Create()
		Local file:wxMenu = New wxMenu.Create()
 
		file.Append(wxID_OPEN, "&Open")
		menubar.Append(file, "&File")
		SetMenuBar(menubar)
 
		Connect(wxID_OPEN, wxEVT_COMMAND_MENU_SELECTED, OnOpen)
 
		tc = New wxTextCtrl.Create(Self, wxID_ANY, "", ,, ,, wxTE_MULTILINE)
 
		Center()
 
	End Method
	
	Function OnOpen(event:wxEvent)
		Local frame:FileOpen = FileOpen(event.parent)
	
		Local openFileDialog:wxFileDialog = New wxFileDialog.Create(frame)
 
		If openFileDialog.ShowModal() = wxID_OK Then
			frame.tc.LoadFile(openFileDialog.GetPath())
		End If
 
	End Function

End Type

