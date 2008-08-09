SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local tb:Toolbars = Toolbars(New Toolbars.Create(Null, wxID_ANY, ..
			"Toolbars", -1, -1, 280, 180))
		tb.Show(True)
 
		Return True
	End Method

End Type

Type Toolbars Extends wxFrame
 
	Field toolbar1:wxToolBar
	Field toolbar2:wxToolBar

	Method OnInit()
		
		wxImage.AddHandler( New wxPNGHandler )

		Local bmpExit:wxBitmap = New wxBitmap.CreateFromFile(..
			"../media/exit.png", wxBITMAP_TYPE_PNG)
		Local bmpNew:wxBitmap = New wxBitmap.CreateFromFile(..
			"../media/new.png", wxBITMAP_TYPE_PNG)
		Local bmpOpen:wxBitmap = New wxBitmap.CreateFromFile(..
			"../media/open.png", wxBITMAP_TYPE_PNG)
		Local bmpSave:wxBitmap = New wxBitmap.CreateFromFile(..
			"../media/save.png", wxBITMAP_TYPE_PNG)

		Local vbox:wxBoxSizer = New wxBoxSizer.Create(wxVERTICAL)
		
		toolbar1 = New wxToolBar.Create(Self, wxID_ANY)
		toolbar1.AddTool(wxID_ANY, "", bmpNew)
		toolbar1.AddTool(wxID_ANY, "", bmpOpen)
		toolbar1.AddTool(wxID_ANY, "", bmpSave)
		toolbar1.Realize();
		
		toolbar2 = New wxToolBar.Create(Self, wxID_ANY)
		toolbar2.AddTool(wxID_CLOSE, "Exit application", bmpExit)
		toolbar2.Realize()
		
		vbox.Add(toolbar1, 0, wxEXPAND)
		vbox.Add(toolbar2, 0, wxEXPAND)
		
		SetSizer(vbox);

		
		Connect(wxID_CLOSE, wxEVT_COMMAND_TOOL_CLICKED, OnQuit)
  
		Centre()
 
	End Method
	
	Function OnQuit(event:wxEvent)
		wxWindow(event.parent).Close(True)
	End Function
	
End Type


