SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxTextDropTarget
Import wx.wxGenericDirCtrl
Import wx.wxListCtrl
Import wx.wxTreeCtrl
Import wx.wxSplitterWindow
Import wx.wxTextDataObject
Import wx.wxDropSource

New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local td:TextDrop = TextDrop(New TextDrop.Create(Null, wxID_ANY, ..
			"TextDrop", -1, -1, 300, 200))
		td.Show(True)
 
		Return True
	End Method

End Type

Type TextDrop Extends wxFrame
 
	Field m_gdir:wxGenericDirCtrl
	Field m_lc1:wxListCtrl
	Field m_lc2:wxListCtrl

	Method OnInit()
		
		Local spl1:wxSplitterWindow = New wxSplitterWindow.Create(..
			Self, -1)
		Local spl2:wxSplitterWindow = New wxSplitterWindow.Create(..
			spl1, -1)
		m_gdir = New wxGenericDirCtrl.Create(spl1, -1, "../..", ..
			-1, -1, -1, -1, wxDIRCTRL_DIR_ONLY)

		m_lc1 = New wxListCtrl.Create(spl2, -1, -1, -1, -1, -1, wxLC_LIST)
		m_lc2 = New wxListCtrl.Create(spl2, -1, -1, -1, -1, -1, wxLC_LIST)

		Local mdt:MyTextDropTarget = New MyTextDropTarget.CreateTarget(m_lc2)
		m_lc2.SetDropTarget(mdt)

		Connect(m_lc1.GetId(), wxEVT_COMMAND_LIST_BEGIN_DRAG, OnDragInit)

		Local tree:wxTreeCtrl = m_gdir.GetTreeCtrl()

		spl2.SplitHorizontally(m_lc1, m_lc2)
		spl1.SplitVertically(m_gdir, spl2)

		Connect(tree.GetId(), wxEVT_COMMAND_TREE_SEL_CHANGED, OnSelect)

		Centre()
 
	End Method

	Function OnSelect(event:wxEvent)
		Local drop:TextDrop = TextDrop(event.parent)
	
		Local filename:String
		Local path:String = drop.m_gdir.GetPath()
		Local dir:Int = ReadDir(path)
		
		If Not dir Then
			Return
		End If
		
		filename = NextFile(dir)

		Local i:Int
		
		drop.m_lc1.ClearAll()
		drop.m_lc2.ClearAll()
		
		While filename
			If FileType(path + "/" + filename) = FILETYPE_FILE Then
			    drop.m_lc1.InsertStringItem(i, filename)
			End If
		    filename = NextFile(dir)
		    i:+ 1
		Wend
		
		CloseDir(dir)
	End Function
	
	Function OnDragInit(event:wxEvent)
		Local drop:TextDrop = TextDrop(event.parent)
	
		Local text:String = drop.m_lc1.GetItemText(wxListEvent(event).GetIndex())
		 
		Local tdo:wxTextDataObject = New wxTextDataObject.Create(text)
		Local tds:wxDropSource = New wxDropSource.Create(tdo, drop.m_lc1)
		tds.DoDragDrop(wxDrag_CopyOnly)

	End Function
	
End Type

Type MyTextDropTarget Extends wxTextDropTarget

	Field m_owner:wxListCtrl
	
	Method CreateTarget:MyTextDropTarget(owner:wxListCtrl)
		m_owner = owner
		Super.Create()
		Return Self
	End Method

	Method OnDropText:Int(x:Int, y:Int, data:String)
		m_owner.InsertStringItem(0, data)
		Return True
	End Method

End Type

