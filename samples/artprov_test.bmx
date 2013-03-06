'
' Default wxArtProvider test
'
' 2013 Bruce A Henderson
'
'
SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxArtProvider
Import wx.wxListCtrl
Import BRL.LinkedList

New MyApp.run()

Type MyApp Extends wxApp

	Field frame:MyFrame

	Method OnInit:Int()
	
		wxInitAllImageHandlers()

		frame = MyFrame(New MyFrame.Create(,,"wxArtProvider test", 100, 100))

		SetTopWindow(frame)
		
		frame.show()
		
		Return True
	
	End Method

End Type

Type MyFrame Extends wxFrame

	Field artProvider:wxArtProvider
	Field imageList:wxImageList
	Field listCtrl:wxListCtrl
	
	Field list:TList = New TList

	Method OnInit()

		artProvider = New wxArtProvider.Create()
	
		imageList = New wxImageList.Create(16, 16, True)
		
		addIcon(wxART_DEL_BOOKMARK)
		addIcon(wxART_HELP_SIDE_PANEL)
		addIcon(wxART_HELP_SETTINGS)
		addIcon(wxART_HELP_BOOK)
		addIcon(wxART_HELP_FOLDER)
		addIcon(wxART_HELP_PAGE)
		addIcon(wxART_GO_BACK)
		addIcon(wxART_GO_FORWARD)
		addIcon(wxART_GO_UP)
		addIcon(wxART_GO_DOWN)
		addIcon(wxART_GO_TO_PARENT)
		addIcon(wxART_GO_HOME)
		addIcon(wxART_FILE_OPEN)
		addIcon(wxART_FILE_SAVE)
		addIcon(wxART_FILE_SAVE_AS)
		addIcon(wxART_PRINT)
		addIcon(wxART_HELP)
		addIcon(wxART_TIP)
		addIcon(wxART_REPORT_VIEW)
		addIcon(wxART_LIST_VIEW)
		addIcon(wxART_NEW_DIR)
		addIcon(wxART_HARDDISK)
		addIcon(wxART_FLOPPY)
		addIcon(wxART_CDROM)
		addIcon(wxART_REMOVABLE)
		addIcon(wxART_FOLDER)
		addIcon(wxART_FOLDER_OPEN)
		addIcon(wxART_GO_DIR_UP)
		addIcon(wxART_EXECUTABLE_FILE)
		addIcon(wxART_NORMAL_FILE)
		addIcon(wxART_TICK_MARK)
		addIcon(wxART_CROSS_MARK)
		addIcon(wxART_ERROR)
		addIcon(wxART_QUESTION)
		addIcon(wxART_WARNING)
		addIcon(wxART_INFORMATION)
		addIcon(wxART_MISSING_IMAGE)
		addIcon(wxART_COPY)
		addIcon(wxART_CUT)
		addIcon(wxART_PASTE)
		addIcon(wxART_DELETE)
		addIcon(wxART_NEW)
		addIcon(wxART_UNDO)
		addIcon(wxART_REDO)
		addIcon(wxART_QUIT)
		addIcon(wxART_FIND)
		addIcon(wxART_FIND_AND_REPLACE)

		listctrl = New wxListCtrl.Create(Self, -1,,,,, wxLC_REPORT | wxLC_SINGLE_SEL)
		
		listctrl.AssignImageList(imageList, wxIMAGE_LIST_SMALL)
	
	
		listctrl.InsertColumn(0, "Icons")
		listctrl.SetColumnWidth(0, 200)
		
		Local i:Int = 0
		For Local icon:String = EachIn list

			Local item:wxListItem = New wxListItem.Create()
			item.SetId(i)
			item.SetText(icon)
			item.SetImage(i)
			
			listCtrl.InsertItem(item)

			i :+ 1
		Next
	End Method
	
	Method addIcon(icon:String)
	
		Local bitmap:wxBitmap = artProvider.GetBitmap(icon)

		If bitmap.IsOK() Then
			Local image:wxImage = bitmap.ConvertToImage()
		
			' images must be the same size for an imagelist (apparently)
			If image.GetWidth() <> 16 Or image.GetHeight() <>16 Then
				image.Rescale(16, 16)
			End If
		
			imageList.Add(wxBitmap.CreateFromImage(image))
			
			list.addLast(icon)
		End If
		
	End Method

End Type



