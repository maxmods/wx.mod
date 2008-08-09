SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local tb:Toolbar = Toolbar(New Toolbar.Create(Null, wxID_ANY, ..
			"Toolbar", -1, -1, 280, 180))
		tb.Show(True)
 
		Return True
	End Method

End Type

Type Toolbar Extends wxFrame
 
	Method OnInit()
		
		wxImage.AddHandler( New wxPNGHandler )

		Local bmpExit:wxBitmap = New wxBitmap.CreateFromFile(..
			"../media/exit.png", wxBITMAP_TYPE_PNG)

		Local tbar:wxToolBar = CreateToolBar()
		tbar.AddTool(wxID_CLOSE, "Exit application", bmpExit)
		tbar.Realize()
		
		Connect(wxID_CLOSE, wxEVT_COMMAND_TOOL_CLICKED, OnQuit)
  
		Centre()
 
	End Method
	
	Function OnQuit(event:wxEvent)
		wxWindow(event.parent).Close(True)
	End Function
	
End Type

