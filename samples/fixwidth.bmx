SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxFixWidthImportCtrl
Import wx.wxSystemOptions
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		wxSystemOptions.SetOption(wxWINDOW_DEFAULT_VARIANT, wxWINDOW_VARIANT_SMALL)

		Local sim:MyFrame = MyFrame(New MyFrame.Create(Null, wxID_ANY, ..
			"Fix Width import", -1, -1, 800, 600))
		sim.Show(True)
 
		Return True
	End Method

End Type

Type MyFrame Extends wxFrame
 
	Method OnInit()
		
		Local ctrl:wxFixWidthImportCtrl = New wxFixWidthImportCtrl.Create(Self)
		ctrl.LoadFile("media/fixwidth/flatdata.txt")
		
		ctrl.SetValues([12, 15, 23, 31, 37, 50])
		
		Centre()
 
	End Method
	
End Type

