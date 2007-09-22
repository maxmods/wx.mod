SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxImage
'Import wx.wxStream
Import wx.wxPanel
Import wx.wxBitmapButton
Import wx.wxStaticText

Import BRL.RamStream

Incbin "media/rotate/duck.png"

Type MyApp Extends wxApp

	Field frame:MyFrame

	Method OnInit:Int()
	
		wxImage.AddHandler(New wxPNGHandler)

		frame = MyFrame(New MyFrame.Create(,,"Image text"))
		frame.show()
	
		Return True
	
	End Method

End Type

Type MyFrame Extends wxFrame

	Field panel:wxPanel
	
	Const FILE_QUIT:Int = wxID_EXIT
	Const HELP_ABOUT:Int = wxID_ABOUT

	Method OnInit()

		panel = wxPanel.CreatePanel(Self)

		Local bitmap:wxBitmap = wxBitmap.CreateFromFile("media/rotate/duck.png", wxBITMAP_TYPE_PNG)
		New wxBitmapButton.Create(panel, -1, bitmap, 10, 10)
		New wxStaticText.Create(panel, -1,"Normal", 50, 140)

		bitmap = wxBitmap.CreateFromFile("incbin::media/rotate/duck.png", wxBITMAP_TYPE_PNG)
		
		New wxBitmapButton.Create(panel, -1, bitmap, 200, 10)
		New wxStaticText.Create(panel, -1,"IncBin Stream", 240, 140)
	
	End Method
	
End Type

New MyApp.run()



