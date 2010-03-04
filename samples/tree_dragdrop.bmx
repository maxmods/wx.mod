SuperStrict
 
Framework wx.wxApp
Import wx.wxFrame
Import wx.wxTreeCtrl
Import wx.wxTextDropTarget
Import wx.wxTextDataObject
Import wx.wxDropSource

New MyApp.Run()
 
Type MyApp Extends wxApp

	Method OnInit:Int()
	
		Local sz:MyFrame = MyFrame(New MyFrame.Create(Null, wxID_ANY, "Drag Drop Example", -1, -1, 250, 280))
		sz.Show(True)
 
		Return True
	End Method

End Type

Type MyFrame Extends wxFrame
 
	Field treectrl:wxTreeCtrl
	Field dragItem:wxTreeItemId
	
	Method OnInit()
		
		treectrl = New wxTreeCtrl.Create(Self, -1)
		
		Local root:wxTreeItemId = treeCtrl.AddRoot("Root")
		For Local i:Int = 1 To 10
			treectrl.AppendItem(root, "Node Number " + i)
		Next
		
		treeCtrl.ExpandAll()
		
		Centre()
 
		Local target:MyTextDropTarget = New MyTextDropTarget.CreateTarget(Self)
		treeCtrl.SetDropTarget(target)

		treeCtrl.ConnectAny(wxEVT_COMMAND_TREE_BEGIN_DRAG, _OnDrag, Null, Self)

	End Method
	
	Function _OnDrag(event:wxEvent)
		MyFrame(event.sink).OnDrag(wxTreeEvent(event))
	End Function
	
	Method OnDrag(event:wxTreeEvent)

		dragItem = event.GetItem()
		
		If Not dragItem.Equals(treectrl.GetRootItem()) Then
		
			Local tdo:wxTextDataObject = New wxTextDataObject.Create(treectrl.getItemText(dragItem))
			Local tds:wxDropSource = New wxDropSource.Create(tdo, treectrl)
			tds.DoDragDrop(wxDrag_AllowMove)
			
		End If

	End Method
	
End Type


Type MyTextDropTarget Extends wxTextDropTarget

	Field s:MyFrame
	Field ctrl:wxTreeCtrl
	
	Method CreateTarget:MyTextDropTarget(owner:MyFrame)
		s = owner
		ctrl = s.treectrl
		Super.Create()
		Return Self
	End Method

	Method OnDropText:Int(x:Int, y:Int, data:String)
	
		Local flags:Int
		
		' find the item we drop onto
		Local item:wxTreeItemId = ctrl.HitTest(x, y, flags)

		' everything is okay to do the drop?
		'  - source is okay
		'  - target is okay
		'  - target <> source
		'  - target <> root
		If s.dragItem And s.dragItem.isOk() And item.isOk() And Not item.Equals(s.dragItem) And Not item.Equals(ctrl.GetRootItem()) Then
			
			' create a new item
			Local newItem:wxTreeItemId = Ctrl.InsertItem(ctrl.GetItemParent(item), item, data)
			' copy its user data, if any
			ctrl.SetItemData(newItem, ctrl.GetItemData(s.dragItem))
			
			' remove the original item
			ctrl.DeleteItem(s.dragItem)
		
			' select the 'moved' item
			ctrl.SelectItem(newItem)
		End If

		Return False
	End Method

End Type

