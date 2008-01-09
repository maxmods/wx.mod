'
' wxArtProvider sample
'
' 2008 Bruce A Henderson
'
'
SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxGenericDirCtrl
Import wx.wxArtProvider

Import BRL.RamStream ' for incbin support

Incbin "media/artprovider/stock_internet-16.png"
Incbin "media/artprovider/stock_folder-16.png"
Incbin "media/artprovider/stock_new-template-16.png"

New MyApp.run()

Type MyApp Extends wxApp

	Field prov:MyProvider = MyProvider(New MyProvider.Create())
	Field frame:MyFrame

	Method OnInit:Int()
	
		wxInitAllImageHandlers()
		
		wxArtProvider.Push(prov)

		frame = MyFrame(New MyFrame.Create(,,"wxArtProvider sample", 100, 100))

		SetTopWindow(frame)
		
		frame.show()
		
		Return True
	
	End Method

End Type

Type MyFrame Extends wxFrame

	Method OnInit()
	
		New wxGenericDirCtrl.Create(Self, -1)
	
	
	End Method

End Type

Type MyProvider Extends wxArtProvider

	' override CreateBitmap, return wxNullBitmap for those you don't care about.
	Method CreateBitmap:wxBitmap(id:String, client:String, w:Int, h:Int)
		Select id
			Case wxART_HARDDISK
				Return wxBitmap.CreateFromFile("incbin::media/artprovider/stock_internet-16.png", wxBITMAP_TYPE_PNG)
			Case wxART_FOLDER
				Return wxBitmap.CreateFromFile("incbin::media/artprovider/stock_folder-16.png", wxBITMAP_TYPE_PNG)
			Case wxART_NORMAL_FILE
				Return wxBitmap.CreateFromFile("incbin::media/artprovider/stock_new-template-16.png", wxBITMAP_TYPE_PNG)
		End Select
		Return wxNullBitmap
	End Method

End Type

