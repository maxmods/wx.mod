SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxImage
Import wx.wxStream
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

		Local stream:wxMaxInputStream = New wxMaxInputStream.Create("media/rotate/duck.png")
		
		Local image:wxImage = wxImage.CreateFromStream(stream, wxBITMAP_TYPE_PNG)
		Local bitmap:wxBitmap = wxBitmap.CreateFromImage(image)
		New wxBitmapButton.Create(panel, -1, bitmap, 10, 10)
		New wxStaticText.Create(panel, -1,"Stream", 50, 140)

		stream = New wxMaxInputStream.Create("incbin::media/rotate/duck.png")
		image = wxImage.CreateFromStream(stream, wxBITMAP_TYPE_PNG)
		bitmap = wxBitmap.CreateFromImage(image)
		
		New wxBitmapButton.Create(panel, -1, bitmap, 200, 10)
		New wxStaticText.Create(panel, -1,"IncBin Stream", 240, 140)
	
	End Method
	
End Type

New MyApp.run()



