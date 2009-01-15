SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxGenericDirCtrl
 
New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local frame:MyFrame = MyFrame(New MyFrame.Create(Null, wxID_ANY, ..
			"GenericDirCtrl", -1, -1, 350, 350, wxMINIMIZE_BOX | wxMAXIMIZE_BOX| wxSYSTEM_MENU | wxCAPTION | wxCLOSE_BOX | wxCLIP_CHILDREN))
		frame.Show(True)
 
		Return True
	End Method

End Type

Type MyFrame Extends wxFrame

	Field dirCtrl:wxGenericDirCtrl
	Field tree:wxTreeCtrl

	Method OnInit()
	
		dirCtrl = New wxGenericDirCtrl.Create(Self, wxID_ANY, CurrentDir())

		tree = dirCtrl.GetTreeCtrl()
		
		tree.Connect(tree.GetId(), wxEVT_COMMAND_TREE_ITEM_RIGHT_CLICK, _OnRightClick, Null, Self)
		
		Centre()
 
	End Method
	
	Function _OnRightClick(event:wxEvent)
		MyFrame(event.sink).OnRightClick(wxTreeEvent(event))
	End Function
	
	Method OnRightClick(event:wxTreeEvent)
		DebugLog "item : " + dirCtrl.GetPath()
	End Method
	
End Type

