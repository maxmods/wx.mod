SuperStrict

Framework wx.wxApp
Import wx.wxTreeListCtrl
Import wx.wxFrame
Import wx.wxPanel
Import wx.wxLocale
Import wx.wxNumberEntryDialog
Import wx.wxTextEntryDialog
Import wx.wxColourDialog
Import wx.wxFontDialog
Import wx.wxLog
Import wx.wxSystemOptions

New App.Run()

Type App Extends wxApp

	Field frame:AppFrame

	Method OnInit:Int()

?macos
		' make the default Mac font for controls not so big
		wxSystemOptions.SetOption(wxWINDOW_DEFAULT_VARIANT, wxWINDOW_VARIANT_SMALL)
?

		frame = AppFrame(New AppFrame.Create(,, "TreeListCtrl Sample", -1, -1, 760, 560))
		frame.Center()
		frame.show()
	
		Return True
	
	End Method

End Type

Type AppFrame Extends wxFrame

	Field alignment:Int
	Field imageSize:Int
	Field vetoEvent:Int
	Field treelist:MyTreeListCtrl
	Field logOld:wxLog
	
	Method OnInit()
		' Create menu
		CreateMenu()
		
		' set image size
		alignment = wxALIGN_LEFT
		imageSize = -1
		vetoEvent = False
		
		Local panel:wxPanel = New wxPanel.Create(Self, wxID_ANY)
		Local sizerTop:wxSizer = New wxBoxSizer.Create(wxVERTICAL)
		panel.SetSizer(sizerTop)

		Local logWin:wxTextCtrl = New wxTextCtrl.Create(panel, wxID_ANY, "", -1, -1, -1, -1, wxTE_MULTILINE)
		Local logger:wxLogTextCtrl = New wxLogTextCtrl.Create(logWin)
		' now that everything is created we can redirect Log messages
		logOld = wxLog.SetActiveTarget(logger)
		'wxLogNull *log_disabler = New wxLogNull();


		' create tree
		treelist = MyTreeListCtrl(New MyTreeListCtrl.Create(panel, wxID_ANY, -1, -1, -1, -1, wxBORDER_THEME))  ' border theme used To cause flicker
		sizerTop.Add(treelist, 1, wxEXPAND, 5)
		CheckStyle(myID_BUTTONSNORMAL, wxTR_HAS_BUTTONS)
		CheckStyle(myID_BUTTONSTWISTER, wxTR_TWIST_BUTTONS)
		CheckStyle(myID_HIDEROOT, wxTR_HIDE_ROOT)
		CheckStyle(myID_LINESATROOT, wxTR_LINES_AT_ROOT)
		CheckStyle(myID_LINESCONNECT, wxTR_NO_LINES)
		CheckStyle(myID_COLUMNLINES, wxTR_COLUMN_LINES)
		CheckStyle(myID_ROWLINES, wxTR_ROW_LINES)
		CheckStyle(myID_ITEMHIGHLIGHT, wxTR_FULL_ROW_HIGHLIGHT)
		CheckStyle(myID_ITEMVARHEIGHT, wxTR_HAS_VARIABLE_ROW_HEIGHT)
		CheckStyle(myID_ITEMEDIT, wxTR_EDIT_LABELS)
		CheckStyle(myID_ITEMVIRTUAL, wxTR_VIRTUAL)
		CheckStyle(myID_SELECTMULTIPLE, wxTR_MULTIPLE)
		CheckStyle(myID_SELECTEXTENDED, wxTR_EXTENDED)
		
		' initialize tree
		treelist.SetBackgroundColour(New wxColour.Create(240,240,192))
		Local k:Int = 250
		treelist.AddColumn("Main", k - 32, wxALIGN_LEFT)
		treelist.SetColumnEditable(0, True)
		treelist.AddColumn("Second", k, wxALIGN_LEFT)
		treelist.SetColumnEditable(1, True)
		treelist.SetColumnAlignment(1, wxALIGN_LEFT)
		treelist.AddColumn("Third", k, wxALIGN_CENTER)
		treelist.SetColumnEditable(2, True)
		treelist.SetColumnAlignment(2, wxALIGN_CENTER)
		
		FillTree()
		
		' common events
		ConnectAny(wxEVT_CLOSE, _OnClose)
		' file events
		Connect(wxID_EXIT, wxEVT_COMMAND_MENU_SELECTED, _OnExit)


		Connect(wxID_ABOUT, wxEVT_COMMAND_MENU_SELECTED, _OnAbout)
		' edit events
		Connect(myID_DELETE_TREE, wxEVT_COMMAND_MENU_SELECTED, _OnDeleteTree)
		Connect(myID_REBUILD_TREE, wxEVT_COMMAND_MENU_SELECTED, _OnRebuildTree)
		Connect(myID_ADDITEM, wxEVT_COMMAND_MENU_SELECTED, _OnAddItem)
		Connect(myID_INSERTAT, wxEVT_COMMAND_MENU_SELECTED, _OnInsertItem)
		Connect(myID_DELETE, wxEVT_COMMAND_MENU_SELECTED, _OnDelete)
		Connect(myID_FINDFULL, wxEVT_COMMAND_MENU_SELECTED, _OnFindItem)
		Connect(myID_FINDEXPANDED, wxEVT_COMMAND_MENU_SELECTED, _OnFindItem)
		Connect(myID_FINDLEVEL, wxEVT_COMMAND_MENU_SELECTED, _OnFindItem)
		Connect(myID_FINDVISIBLE, wxEVT_COMMAND_MENU_SELECTED, _OnFindItem)
		Connect(myID_GOTO, wxEVT_COMMAND_MENU_SELECTED, _OnGotoItem)
		' view events
		Connect(myID_ATTRTEXTCOLOUR, wxEVT_COMMAND_MENU_SELECTED, _OnAttrTextColour)
		Connect(myID_ATTRBACKCOLOUR, wxEVT_COMMAND_MENU_SELECTED, _OnAttrBackColour)
		Connect(myID_ATTRBOLDFONT, wxEVT_COMMAND_MENU_SELECTED, _OnBoldFont)
		Connect(myID_ATTRFONTSTYLE, wxEVT_COMMAND_MENU_SELECTED, _OnFontStyle)
		Connect(myID_ATTRITEMIMAGE, wxEVT_COMMAND_MENU_SELECTED, _OnItemImage)
		Connect(myID_SETALIGNLEFT, wxEVT_COMMAND_MENU_SELECTED, _OnAlignment)
		Connect(myID_SETALIGNCENTER, wxEVT_COMMAND_MENU_SELECTED, _OnAlignment)
		Connect(myID_SETALIGNRIGHT, wxEVT_COMMAND_MENU_SELECTED, _OnAlignment)
		Connect(myID_BUTTONSNORMAL, wxEVT_COMMAND_MENU_SELECTED, _OnButtonsNormals)
		Connect(myID_BUTTONSTWISTER, wxEVT_COMMAND_MENU_SELECTED, _OnButtonsTwister)
		Connect(myID_BUTTONSIMAGE, wxEVT_COMMAND_MENU_SELECTED, _OnButtonsImage)
		Connect(myID_HIDEROOT, wxEVT_COMMAND_MENU_SELECTED, _OnHideRoot)
		Connect(myID_LINESATROOT, wxEVT_COMMAND_MENU_SELECTED, _OnLinesAtRoot)
		Connect(myID_LINESCONNECT, wxEVT_COMMAND_MENU_SELECTED, _OnLinesConnect)
		Connect(myID_COLUMNLINES, wxEVT_COMMAND_MENU_SELECTED, _OnColumnLines)
		Connect(myID_ROWLINES, wxEVT_COMMAND_MENU_SELECTED, _OnRowLines)
		Connect(myID_ITEMHIGHLIGHT, wxEVT_COMMAND_MENU_SELECTED, _OnItemHighlight)
		Connect(myID_ITEMVARHEIGHT, wxEVT_COMMAND_MENU_SELECTED, _OnItemVarHeight)
		Connect(myID_SHOWIMAGES, wxEVT_COMMAND_MENU_SELECTED, _OnShowImages)
		Connect(myID_ITEMEDIT, wxEVT_COMMAND_MENU_SELECTED, _OnItemEditMode)
		Connect(myID_ITEMVIRTUAL, wxEVT_COMMAND_MENU_SELECTED, _OnItemVirtualMode)
		Connect(myID_SELECTMULTIPLE, wxEVT_COMMAND_MENU_SELECTED, _OnSelectMultiple)
		Connect(myID_SELECTEXTENDED, wxEVT_COMMAND_MENU_SELECTED, _OnSelectExtended)
		' extra events
		Connect(myID_GETCOUNT, wxEVT_COMMAND_MENU_SELECTED, _OnGetCount)
		Connect(myID_GETCHILDREN, wxEVT_COMMAND_MENU_SELECTED, _OnGetChildren)
		Connect(myID_LISTALL, wxEVT_COMMAND_MENU_SELECTED, _OnListAll)
		Connect(myID_LISTCHILDREN, wxEVT_COMMAND_MENU_SELECTED, _OnListChildren)
		Connect(myID_LISTSELECTED, wxEVT_COMMAND_MENU_SELECTED, _OnListSelected)
		Connect(myID_SETINDENT, wxEVT_COMMAND_MENU_SELECTED, _OnSetIndent)
		Connect(myID_SETIMAGESIZE, wxEVT_COMMAND_MENU_SELECTED, _OnSetImageSize)
		Connect(myID_VETOEVENT, wxEVT_COMMAND_MENU_SELECTED, _OnVetoEvent)
		Connect(myID_GETNEXT, wxEVT_COMMAND_MENU_SELECTED, _OnGetNext)
		Connect(myID_GETPREV, wxEVT_COMMAND_MENU_SELECTED, _OnGetPrev)


		ConnectAny(wxEVT_COMMAND_TREE_BEGIN_DRAG, _OnTreeGeneric)  ' Begin dragging with the left mouse button.
		ConnectAny(wxEVT_COMMAND_TREE_BEGIN_RDRAG, _OnTreeGeneric)  ' Begin dragging with the right mouse button.
		ConnectAny(wxEVT_COMMAND_TREE_END_DRAG, _OnTreeGeneric)
		ConnectAny(wxEVT_COMMAND_TREE_BEGIN_LABEL_EDIT, _OnVetoingEvent)  ' Begin editing a label. This can be prevented by calling Veto().
		ConnectAny(wxEVT_COMMAND_TREE_END_LABEL_EDIT, _OnVetoingEvent)  ' Finish editing a label. This can be prevented by calling Veto().
		ConnectAny(wxEVT_COMMAND_TREE_DELETE_ITEM, _OnTreeGeneric)  ' Delete an item.
		ConnectAny(wxEVT_COMMAND_TREE_GET_INFO, _OnTreeGeneric)  ' Request information from the application.
		ConnectAny(wxEVT_COMMAND_TREE_SET_INFO, _OnTreeGeneric)  ' Information is being supplied.
		ConnectAny(wxEVT_COMMAND_TREE_ITEM_ACTIVATED, _OnTreeGeneric)  ' The item has been activated, i.e. chosen by double clicking it with mouse or from keyboard.
		ConnectAny(wxEVT_COMMAND_TREE_ITEM_COLLAPSED, _OnTreeGeneric)  ' The item has been collapsed.
		ConnectAny(wxEVT_COMMAND_TREE_ITEM_COLLAPSING, _OnVetoingEvent)  ' The item is being collapsed. This can be prevented by calling Veto().
		ConnectAny(wxEVT_COMMAND_TREE_ITEM_EXPANDED, _OnTreeGeneric)  ' The item has been expanded.
		ConnectAny(wxEVT_COMMAND_TREE_ITEM_EXPANDING, _OnVetoingEvent)  ' The item is being expanded. This can be prevented by calling Veto().
		ConnectAny(wxEVT_COMMAND_TREE_ITEM_MIDDLE_CLICK, _OnVetoingEvent)
		ConnectAny(wxEVT_COMMAND_TREE_ITEM_RIGHT_CLICK, _OnVetoingEvent)
		ConnectAny(wxEVT_COMMAND_TREE_SEL_CHANGED, _OnTreeGeneric)  ' Selection has changed.
		ConnectAny(wxEVT_COMMAND_TREE_SEL_CHANGING, _OnVetoingEvent)  ' Selection is changing. This can be prevented by calling Veto().
		ConnectAny(wxEVT_COMMAND_TREE_KEY_DOWN, _OnTreeGeneric)  ' A key has been pressed.
		ConnectAny(wxEVT_COMMAND_TREE_ITEM_GETTOOLTIP, _OnTreeGeneric)  ' NOT IMPLEMENTED
		ConnectAny(wxEVT_COMMAND_TREE_ITEM_MENU, _OnTreeGeneric)
		ConnectAny(wxEVT_COMMAND_TREE_STATE_IMAGE_CLICK, _OnTreeGeneric)  ' NOT IMPLEMENTED
		' mouse
		ConnectAny(wxEVT_MOUSE_EVENTS, _OnMouseGeneric)
		
		sizerTop.Add(logWin, 1,  wxEXPAND | wxGROW, 5)
		wxLogMessage("this is the test sample 'treelisttest' for the wxTreeListCtrl widget - now ready")
	End Method
	
	Method CreateMenu()
		' File menu
		Local menuFile:wxMenu = New wxMenu.Create()
		menuFile.Append(wxID_EXIT, _("&Quit\tCtrl+Q"))
		
		
		' find submenu
		Local menuFind:wxMenu = New wxMenu.Create()
		menuFind.Append(myID_FINDFULL, _("full tree ..."))
		menuFind.Append(myID_FINDEXPANDED, _("expanded ..."))
		menuFind.Append(myID_FINDLEVEL, _("in level ..."))
		menuFind.Append(myID_FINDVISIBLE, _("visible ..."))
		
		' edit menu
		Local menuEdit:wxMenu = New wxMenu.Create()
		menuEdit.Append(myID_DELETE_TREE, _("Delete tree"))
		menuEdit.Append(myID_REBUILD_TREE, _("Rebuild tree"))
		menuEdit.AppendSeparator()
		menuEdit.Append(myID_ADDITEM, _("&Append at parent"))
		menuEdit.Append(myID_INSERTAT, _("&Insert after current"))
		menuEdit.Append(myID_DELETE, _("&Delete this item"))
		menuEdit.AppendSeparator()
		menuEdit.AppendMenu(myID_FIND, _("&Find item"), menuFind)
		menuEdit.Append(myID_GOTO, _("&Goto item ..."))
		
		' Attribute submenu
		Local menuAttr:wxMenu = New wxMenu.Create()
		menuAttr.Append(myID_ATTRTEXTCOLOUR, _("Text colour ..."))
		menuAttr.Append(myID_ATTRBACKCOLOUR, _("Background ..."))
		menuAttr.AppendCheckItem (myID_ATTRBOLDFONT, _("Bold font"))
		menuAttr.Append(myID_ATTRFONTSTYLE, _("Font style ..."))
		menuAttr.Append(myID_ATTRITEMIMAGE, _("Item image ..."))
		
		' Alignment submenu
		Local menuAlign:wxMenu = New wxMenu.Create()
		menuAlign.Append(myID_SETALIGNLEFT, _("&Left"))
		menuAlign.Append(myID_SETALIGNCENTER, _("&Center"))
		menuAlign.Append(myID_SETALIGNRIGHT, _("&Right"))
		
		' view menu
		Local menuView:wxMenu = New wxMenu.Create()
		menuView.AppendCheckItem(myID_BUTTONSNORMAL, _("Toggle &normal buttons"))
		menuView.AppendCheckItem(myID_BUTTONSTWISTER, _("Toggle &twister buttons"))
		menuView.AppendCheckItem(myID_BUTTONSIMAGE, _("Toggle image &buttons"))
		menuView.AppendSeparator()
		menuView.AppendCheckItem(myID_HIDEROOT, _("Toggle &hide root"))
		menuView.AppendCheckItem(myID_LINESATROOT, _("Toggle &lines at root"))
		menuView.AppendCheckItem(myID_LINESCONNECT, _("Toggle &connecting lines"))
		menuView.AppendCheckItem(myID_COLUMNLINES, _("Toggle col&umn lines"))
		menuView.AppendCheckItem(myID_ROWLINES, _("Toggle r&ow lines"))
		menuView.AppendCheckItem(myID_ITEMHIGHLIGHT, _("Toggle &full row highlight"))
		menuView.AppendCheckItem(myID_ITEMVARHEIGHT, _("Toggle &variable row height"))
		menuView.AppendCheckItem(myID_SHOWIMAGES, _("Toggle show ima&ges"))
		menuView.AppendSeparator()
		menuView.AppendCheckItem(myID_ITEMEDIT, _("Toggle &edit mode"))
		menuView.AppendCheckItem(myID_ITEMVIRTUAL, _("Toggle &virtual mode"))
		menuView.AppendCheckItem(myID_SELECTMULTIPLE, _("Toggle select &multiple"))
		menuView.AppendCheckItem(myID_SELECTEXTENDED, _("Toggle select &extended"))
		menuView.AppendSeparator()
		menuView.AppendMenu(myID_SETATTRIBUTE, _("Set &attribute"), menuAttr)
		menuView.AppendMenu(myID_SETALIGNMENT, _("Align &column"), menuAlign)
		
		' extra menu
		Local menuExtra:wxMenu = New wxMenu.Create()
		menuExtra.Append(myID_GETCOUNT, _("Get total count"))
		menuExtra.Append(myID_GETCHILDREN, _("Get children count"))
		menuExtra.AppendSeparator()
		menuExtra.Append(myID_LISTALL, _("List all items"))
		menuExtra.Append(myID_LISTCHILDREN, _("List all children"))
		menuExtra.Append(myID_LISTSELECTED, _("List selected items"))
		menuExtra.AppendSeparator()
		menuExtra.Append(myID_SETINDENT, _("Set &Indent to ..."))
		menuExtra.Append(myID_SETIMAGESIZE, _("Set image si&ze..."))
		menuExtra.AppendSeparator()
		menuExtra.AppendCheckItem (myID_VETOEVENT, _("&Veto event"))
		menuExtra.AppendSeparator()
		menuExtra.Append(myID_GETNEXT, _("Get &Next"))
		menuExtra.Append(myID_GETPREV, _("Get &Prev"))
		
		' Help menu
		Local menuHelp:wxMenu = New wxMenu.Create()
		menuHelp.Append(wxID_ABOUT, _("&About ...\tShift+F1"))
		
		' construct menu
		Local menuBar:wxMenuBar = New wxMenuBar.Create()
		menuBar.Append(menuFile, _("&Tree"))
		menuBar.Append(menuEdit, _("&Edit"))
		menuBar.Append(menuView, _("&View"))
		menuBar.Append(menuExtra, _("&Extra"))
		menuBar.Append(menuHelp, _("&Help"))
		SetMenuBar(menuBar)
	End Method
	
	Method FillTree()
		Local n:Int = 0
		Local m:Int = 0
		' initialize tree
		Local root:wxTreeItemId = treelist.AddRoot("Root")
		treelist.SetItemText(root, "Root, text #0", 1)
		treelist.SetItemText(root, "Root, text #0", 2)
		
		Local parent:wxTreeItemId
		Local item:wxTreeItemId
		n:+ 1
		item = treelist.AppendItem(root, "Item #" + n)
		m:+ 1
		treelist.SetItemText(item, "Item #" + n + ", text #" + m, 1)
		m:+ 1
		treelist.SetItemText(item, "Item #" + n + ", text #" + m, 2)
		
		parent = item
		n:+ 1
		item = treelist.AppendItem(parent, "Item #" + n, 4)
		m:+ 1
		treelist.SetItemText(item, "Item #" + n + ", text #" + m, 1)
		m:+ 1
		treelist.SetItemText(item, "Item #" + n + ", text #" + m, 2)
		n:+ 1
		item = treelist.AppendItem(parent, "Item #" + n, 4)
		m:+ 1
		treelist.SetItemText(item, "Item #" + n + ", text #" + m, 1)
		m:+ 1
		treelist.SetItemText(item, "Item #" + n + ", text #" + m, 2)
		n:+ 1
		item = treelist.AppendItem(parent, "Item #" + n, 4)
		m:+ 1
		treelist.SetItemText(item, "Item #" + n + ", text #" + m, 1)
		m:+ 1
		treelist.SetItemText(item, "Item #" + n + ", text #" + m, 2)
		n:+ 1
		item = treelist.AppendItem(parent, "Item #" + n, 4)
		m:+ 1
		treelist.SetItemText(item, "Item #" + n + ", text #" + m, 1)
		m:+ 1
		treelist.SetItemText(item, "Item #" + n + ", text #" + m, 2)
		n:+ 1
		item = treelist.AppendItem(parent, "Item #" + n, 4)
		m:+ 1
		treelist.SetItemText(item, "Item #" + n + ", text #" + m, 1)
		m:+ 1
		treelist.SetItemText(item, "Item #" + n + ", text #" + m, 2)

		parent = item
		n:+ 1
		item = treelist.AppendItem(parent, "Item #" + n, 4)
		m:+ 1
		treelist.SetItemText(item, "Item #" + n + ", text #" + m, 1)
		m:+ 1
		treelist.SetItemText(item, "Item #" + n + ", text #" + m, 2)
		n:+ 1
		item = treelist.AppendItem(parent, "Item #" + n, 4)
		m:+ 1
		treelist.SetItemText(item, "Item #" + n + ", text #" + m, 1)
		m:+ 1
		treelist.SetItemText(item, "Item #" + n + ", text #" + m, 2)
		n:+ 1
		item = treelist.AppendItem(parent, "Item #" + n, 4)
		m:+ 1
		treelist.SetItemText(item, "Item #" + n + ", text #" + m, 1)
		m:+ 1
		treelist.SetItemText(item, "Item #" + n + ", text #" + m, 2)
		n:+ 1
		item = treelist.AppendItem(parent, "Item #" + n, 4)
		m:+ 1
		treelist.SetItemText(item, "Item #" + n + ", text #" + m, 1)
		m:+ 1
		treelist.SetItemText(item, "Item #" + n + ", text #" + m, 2)
		n:+ 1
		item = treelist.AppendItem(parent, "Item #" + n, 4)
		m:+ 1
		treelist.SetItemText(item, "Item #" + n + ", text #" + m, 1)
		m:+ 1
		treelist.SetItemText(item, "Item #" + n + ", text #" + m, 2)

		parent = item
		n:+ 1
		item = treelist.AppendItem(parent, "Item #" + n, 4)
		m:+ 1
		treelist.SetItemText(item, "Item #" + n + ", text #" + m, 1)
		m:+ 1
		treelist.SetItemText(item, "Item #" + n + ", text #" + m, 2)
		n:+ 1
		item = treelist.AppendItem(parent, "Item #" + n, 4)
		m:+ 1
		treelist.SetItemText(item, "Item #" + n + ", text #" + m, 1)
		m:+ 1
		treelist.SetItemText(item, "Item #" + n + ", text #" + m, 2)
		n:+ 1
		item = treelist.AppendItem(parent, "Item #" + n, 4)
		m:+ 1
		treelist.SetItemText(item, "Item #" + n + ", text #" + m, 1)
		m:+ 1
		treelist.SetItemText(item, "Item #" + n + ", text #" + m, 2)
		n:+ 1
		item = treelist.AppendItem(parent, "Item #" + n, 4)
		m:+ 1
		treelist.SetItemText(item, "Item #" + n + ", text #" + m, 1)
		m:+ 1
		treelist.SetItemText(item, "Item #" + n + ", text #" + m, 2)

		treelist.ExpandAll(root)
	End Method
	
	Method CheckStyle(id:Int, flag:Int)
		Local style:Int = treelist.GetWindowStyle()
		GetMenuBar().Check(id, (style & flag) <> 0)
	End Method
	
	Method ToggleStyle(id:Int, flag:Int)
		Local style:Int = treelist.GetWindowStyle()
		style :~ flag
		treelist.SetWindowStyle(style)
		GetMenuBar().Check(id, (style & flag) <> 0)
	End Method

	Function _OnClose(event:wxEvent)
		AppFrame(event.parent).OnClose(wxCloseEvent(event))
	End Function
	
	Function _OnAbout(event:wxEvent)
		AppFrame(event.parent).OnAbout(wxCommandEvent(event))
	End Function
	
	Function _OnExit(event:wxEvent)
		AppFrame(event.parent).OnExit(wxCommandEvent(event))
	End Function
	
	Function _OnDeleteTree(event:wxEvent)
		AppFrame(event.parent).OnDeleteTree(wxCommandEvent(event))
	End Function
	
	Function _OnRebuildTree(event:wxEvent)
		AppFrame(event.parent).OnRebuildTree(wxCommandEvent(event))
	End Function
	
	Function _OnAddItem(event:wxEvent)
		AppFrame(event.parent).OnAddItem(wxCommandEvent(event))
	End Function
	
	Function _OnInsertItem(event:wxEvent)
		AppFrame(event.parent).OnInsertItem(wxCommandEvent(event))
	End Function
	
	Function _OnDelete(event:wxEvent)
		AppFrame(event.parent).OnDelete(wxCommandEvent(event))
	End Function
	
	Function _OnFindItem(event:wxEvent)
		AppFrame(event.parent).OnFindItem(wxCommandEvent(event))
	End Function
	
	Function _OnGotoItem(event:wxEvent)
		AppFrame(event.parent).OnGotoItem(wxCommandEvent(event))
	End Function
	
	Function _OnAttrTextColour(event:wxEvent)
		AppFrame(event.parent).OnAttrTextColour(wxCommandEvent(event))
	End Function
	
	Function _OnAttrBackColour(event:wxEvent)
		AppFrame(event.parent).OnAttrBackColour(wxCommandEvent(event))
	End Function
	
	Function _OnBoldFont(event:wxEvent)
		AppFrame(event.parent).OnBoldFont(wxCommandEvent(event))
	End Function
	
	Function _OnFontStyle(event:wxEvent)
		AppFrame(event.parent).OnFontStyle(wxCommandEvent(event))
	End Function
	
	Function _OnItemImage(event:wxEvent)
		AppFrame(event.parent).OnItemImage(wxCommandEvent(event))
	End Function
	
	Function _OnAlignment(event:wxEvent)
		AppFrame(event.parent).OnAlignment(wxCommandEvent(event))
	End Function
	
	Function _OnButtonsNormals(event:wxEvent)
		AppFrame(event.parent).OnButtonsNormals(wxCommandEvent(event))
	End Function
	
	Function _OnButtonsTwister(event:wxEvent)
		AppFrame(event.parent).OnButtonsTwister(wxCommandEvent(event))
	End Function
	
	Function _OnButtonsImage(event:wxEvent)
		AppFrame(event.parent).OnButtonsImage(wxCommandEvent(event))
	End Function
	
	Function _OnHideRoot(event:wxEvent)
		AppFrame(event.parent).OnHideRoot(wxCommandEvent(event))
	End Function
	
	Function _OnLinesAtRoot(event:wxEvent)
		AppFrame(event.parent).OnLinesAtRoot(wxCommandEvent(event))
	End Function
	
	Function _OnLinesConnect(event:wxEvent)
		AppFrame(event.parent).OnLinesConnect(wxCommandEvent(event))
	End Function
	
	Function _OnColumnLines(event:wxEvent)
		AppFrame(event.parent).OnColumnLines(wxCommandEvent(event))
	End Function
	
	Function _OnRowLines(event:wxEvent)
		AppFrame(event.parent).OnRowLines(wxCommandEvent(event))
	End Function
	
	Function _OnItemHighlight(event:wxEvent)
		AppFrame(event.parent).OnItemHighlight(wxCommandEvent(event))
	End Function
	
	Function _OnItemVarHeight(event:wxEvent)
		AppFrame(event.parent).OnItemVarHeight(wxCommandEvent(event))
	End Function
	
	Function _OnShowImages(event:wxEvent)
		AppFrame(event.parent).OnShowImages(wxCommandEvent(event))
	End Function
	
	Function _OnItemEditMode(event:wxEvent)
		AppFrame(event.parent).OnItemEditMode(wxCommandEvent(event))
	End Function
	
	Function _OnItemVirtualMode(event:wxEvent)
		AppFrame(event.parent).OnItemVirtualMode(wxCommandEvent(event))
	End Function
	
	Function _OnSelectMultiple(event:wxEvent)
		AppFrame(event.parent).OnSelectMultiple(wxCommandEvent(event))
	End Function
	
	Function _OnSelectExtended(event:wxEvent)
		AppFrame(event.parent).OnSelectExtended(wxCommandEvent(event))
	End Function
	
	Function _OnGetCount(event:wxEvent)
		AppFrame(event.parent).OnGetCount(wxCommandEvent(event))
	End Function
	
	Function _OnGetChildren(event:wxEvent)
		AppFrame(event.parent).OnGetChildren(wxCommandEvent(event))
	End Function
	
	Function _OnListAll(event:wxEvent)
		AppFrame(event.parent).OnListAll(wxCommandEvent(event))
	End Function
	
	Function _OnListChildren(event:wxEvent)
		AppFrame(event.parent).OnListChildren(wxCommandEvent(event))
	End Function
	
	Function _OnListSelected(event:wxEvent)
		AppFrame(event.parent).OnListSelected(wxCommandEvent(event))
	End Function
	
	Function _OnSetIndent(event:wxEvent)
		AppFrame(event.parent).OnSetIndent(wxCommandEvent(event))
	End Function
	
	Function _OnSetImageSize(event:wxEvent)
		AppFrame(event.parent).OnSetImageSize(wxCommandEvent(event))
	End Function
	
	Function _OnVetoEvent(event:wxEvent)
		AppFrame(event.parent).OnVetoEvent(wxCommandEvent(event))
	End Function
	
	Function _OnGetNext(event:wxEvent)
		AppFrame(event.parent).OnGetNext(wxCommandEvent(event))
	End Function
	
	Function _OnGetPrev(event:wxEvent)
		AppFrame(event.parent).OnGetPrev(wxCommandEvent(event))
	End Function
	
	Function _OnVetoingEvent(event:wxEvent)
		AppFrame(event.parent).OnVetoingEvent(wxTreeEvent(event))
	End Function
	
	Function _OnTreeGeneric(event:wxEvent)
		AppFrame(event.parent).OnTreeGeneric(wxTreeEvent(event))
	End Function
	
	Function _OnMouseGeneric(event:wxEvent)
		AppFrame(event.parent).OnMouseGeneric(wxMouseEvent(event))
	End Function

	
	Method OnClose(event:wxCloseEvent)
		Destroy()
	End Method

	Method OnAbout(event:wxCommandEvent)
		wxMessageBox("wxWidgets treelistctrl sample~n(c) 2005-2009 Otto Wyss && others" + ..
			"~nBlitzmax port (c) 2010 Bruce A Henderson", ..
			"About wxWidgets treelistctrl sample", wxICON_INFORMATION)
	End Method

	Method OnExit(event:wxCommandEvent)
		Close(True)
	End Method

	Method OnDeleteTree(event:wxCommandEvent)
		treelist.DeleteRoot()
	End Method

	Method OnRebuildTree(event:wxCommandEvent)
		treelist.DeleteRoot()
		FillTree()
	End Method

	Method OnAddItem(event:wxCommandEvent)
		Local text:String = "Item #" + treelist.GetCount() + 1
		Local c:wxTreeItemId = treelist.GetSelection()
		Local n:wxTreeItemId = treelist.AppendItem(c, text)
		treelist.EnsureVisible(n)
	End Method

	Method OnInsertItem(event:wxCommandEvent)
		Local text:String = "Item #" + treelist.GetCount() + 1
		Local c:wxTreeItemId = treelist.GetSelection()
		Local n:wxTreeItemId = treelist.InsertItem(treelist.GetItemParent(c), c, text)
		treelist.EnsureVisible(n)
	End Method

	Method OnDelete(event:wxCommandEvent)
		treelist.DeleteItem(treelist.GetSelection())
	End Method

	Method OnFindItem(event:wxCommandEvent)
		Local _mode:Int = wxTL_MODE_FIND_PARTIAL | wxTL_MODE_FIND_NOCASE
		Select event.GetId()
			Case myID_FINDFULL
				_mode :| wxTL_MODE_NAV_FULLTREE
			Case myID_FINDEXPANDED
				_mode :| wxTL_MODE_NAV_EXPANDED
			Case myID_FINDLEVEL
				_mode :| wxTL_MODE_NAV_LEVEL
			Case myID_FINDVISIBLE
				_mode :| wxTL_MODE_NAV_VISIBLE
		End Select
		Local text:String = wxGetTextFromUser("Finds the item with the given text", "Find text")
		Local c:wxTreeItemId = treelist.GetSelection()
		treelist.SelectItem(treelist.FindItem(c, text, _mode))
	End Method

	Method OnGotoItem(event:wxCommandEvent)
		Local num:Int = wxGetNumberFromUser ("", "Enter the item number", "Get value");
		If num < 0 Then
			Return
		End If
		
		Local item:wxTreeItemId = treelist.GetRootItem()
		For Local i:Int = 0 Until num
			item = treelist.GetNext(item)
			If Not item Then
				Exit
			End If
		Next

		If item Then
			treelist.SelectItem(item)
		End If
	End Method

	Method OnAttrTextColour(event:wxCommandEvent)
		Local c:wxTreeItemId = treelist.GetSelection()
		Local col:wxColour = wxGetColourFromUser(Self, treelist.GetItemTextColour(c))
		If col.IsOK() Then
			treelist.SetItemTextColour(c, col)
		End If
	End Method

	Method OnAttrBackColour(event:wxCommandEvent)
		Local c:wxTreeItemId = treelist.GetSelection()
		Local col:wxColour = wxGetColourFromUser(Self, treelist.GetItemBackgroundColour(c))
		If col.IsOk() Then
			treelist.SetItemBackgroundColour(c, col)
		End If
	End Method

	Method OnBoldFont(event:wxCommandEvent)
 		Local bold:Int = treelist.IsBold(treelist.GetSelection())
		treelist.SetItemBold(treelist.GetSelection(), Not bold)
	End Method

	Method OnFontStyle(event:wxCommandEvent)
		Local c:wxTreeItemId = treelist.GetSelection()
		Local font:wxFont = wxGetFontFromUser(Self, treelist.GetItemFont(c))
		treelist.SetItemFont(c, font)
	End Method

	Method OnItemImage(event:wxCommandEvent)
		
	End Method

	Method OnAlignment(event:wxCommandEvent)
		Select event.GetId()
			Case myID_SETALIGNLEFT
				alignment = wxALIGN_LEFT
			Case myID_SETALIGNCENTER
				alignment = wxALIGN_CENTER
			Case myID_SETALIGNRIGHT
				alignment = wxALIGN_RIGHT
		End Select
		treelist.SetColumnAlignment(1, alignment)
	End Method

	Method OnButtonsNormals(event:wxCommandEvent)
		ToggleStyle(event.GetId(), wxTR_HAS_BUTTONS)
	End Method

	Method OnButtonsTwister(event:wxCommandEvent)
		ToggleStyle(event.GetId(), wxTR_TWIST_BUTTONS)
	End Method

	Method OnButtonsImage(event:wxCommandEvent)
		
	End Method

	Method OnHideRoot(event:wxCommandEvent)
		ToggleStyle(event.GetId(), wxTR_HIDE_ROOT)
	End Method

	Method OnLinesAtRoot(event:wxCommandEvent)
		ToggleStyle(event.GetId(), wxTR_LINES_AT_ROOT)
	End Method

	Method OnLinesConnect(event:wxCommandEvent)
		ToggleStyle(event.GetId(), wxTR_NO_LINES)
	End Method

	Method OnColumnLines(event:wxCommandEvent)
		ToggleStyle(event.GetId(), wxTR_COLUMN_LINES)
	End Method

	Method OnRowLines(event:wxCommandEvent)
		ToggleStyle(event.GetId(), wxTR_ROW_LINES)
	End Method

	Method OnItemHighlight(event:wxCommandEvent)
		ToggleStyle(event.GetId(), wxTR_FULL_ROW_HIGHLIGHT)
	End Method

	Method OnItemVarHeight(event:wxCommandEvent)
		ToggleStyle(event.GetId(), wxTR_HAS_VARIABLE_ROW_HEIGHT)
	End Method

	Method OnShowImages(event:wxCommandEvent)
		
	End Method

	Method OnItemEditMode(event:wxCommandEvent)
		ToggleStyle(event.GetId(), wxTR_EDIT_LABELS)
	End Method

	Method OnItemVirtualMode(event:wxCommandEvent)
		ToggleStyle(event.GetId(), wxTR_VIRTUAL)
	End Method

	Method OnSelectMultiple(event:wxCommandEvent)
		ToggleStyle(event.GetId(), wxTR_MULTIPLE)
	End Method

	Method OnSelectExtended(event:wxCommandEvent)
		ToggleStyle(event.GetId(), wxTR_EXTENDED)
	End Method

	Method OnGetCount(event:wxCommandEvent)
		Local count:Int = treelist.GetCount()
		wxMessageBox("Total count of items: " + count, "Total count", wxOK | wxICON_INFORMATION)
	End Method

	Method OnGetChildren(event:wxCommandEvent)
		Local count:Int = treelist.GetChildrenCount(treelist.GetSelection())
		wxMessageBox("Total count of items: " + count, "Children count", wxOK | wxICON_INFORMATION)
	End Method

	Method OnListAll(event:wxCommandEvent)
		Local item:wxTreeItemId = treelist.GetSelection()
		If Not item.IsOk() Then
			item = treelist.GetRootItem()
		End If
		Local last:wxTreeItemId = treelist.GetNextSibling(item)
		Local text:String
		While item.IsOk() And item <> last
			text:+ treelist.GetItemText(item) + "~n"
			item = treelist.GetNext(item)
		Wend
		wxMessageBox(text, "All items", wxOK | wxICON_INFORMATION)
	End Method

	Method OnListChildren(event:wxCommandEvent)
		Local item:wxTreeItemId = treelist.GetSelection()
		If Not item.IsOk() Then
			item = treelist.GetRootItem ()
		End If
		Local text:String


		item = treelist.GetFirstChild(item)
		While item.IsOk()
			text:+ treelist.GetItemText(item) + "~n"
			item = treelist.GetNextSibling(item)
		Wend
		wxMessageBox(text, "Children items", wxOK | wxICON_INFORMATION)
	End Method

	Method OnListSelected(event:wxCommandEvent)
		Local items:wxTreeItemId[] = treelist.GetSelections()
		Local count:Int = items.length
		Local text:String
		For Local i:Int = 0 Until count
			text:+ treelist.GetItemText(items[i]) + "~n"
		Next
		wxMessageBox(text, "Selected items", wxOK | wxICON_INFORMATION)
	End Method

	Method OnSetIndent(event:wxCommandEvent)
		Local indent:Int = wxGetNumberFromUser("", "Enter the indent value", "Get value", treelist.GetIndent())
		If indent > 0 Then
			treelist.SetIndent(indent)
		End If
	End Method

	Method OnSetImageSize(event:wxCommandEvent)
		
	End Method

	Method OnVetoEvent(event:wxCommandEvent)
		vetoEvent = Not vetoEvent
		GetMenuBar().Check(event.GetId(), vetoEvent)
	End Method

	Method OnGetNext(event:wxCommandEvent)
		treelist.SelectItem(treelist.GetNext(treelist.GetSelection()))
	End Method

	Method OnGetPrev(event:wxCommandEvent)
		treelist.SelectItem(treelist.GetPrev(treelist.GetSelection()))
	End Method

	' tree events
	Method OnVetoingEvent(event:wxTreeEvent)
		OnTreeGeneric(event)
		If vetoEvent Then
			event.Veto()
		End If
	End Method

	Method OnTreeGeneric(event:wxTreeEvent)
		Local name:String
		
		If  event.GetEventType() = wxEVT_COMMAND_TREE_BEGIN_DRAG Then
			name = "wxEVT_COMMAND_TREE_BEGIN_DRAG"
		Else If event.GetEventType() = wxEVT_COMMAND_TREE_BEGIN_RDRAG Then
			name = "wxEVT_COMMAND_TREE_BEGIN_RDRAG"
		Else If event.GetEventType() = wxEVT_COMMAND_TREE_END_DRAG Then
			name = "wxEVT_COMMAND_TREE_END_DRAG"
		Else If event.GetEventType() = wxEVT_COMMAND_TREE_BEGIN_LABEL_EDIT Then
			name = "wxEVT_COMMAND_TREE_BEGIN_LABEL_EDIT"
		Else If event.GetEventType() = wxEVT_COMMAND_TREE_END_LABEL_EDIT Then
			name = "wxEVT_COMMAND_TREE_END_LABEL_EDIT"
		Else If event.GetEventType() = wxEVT_COMMAND_TREE_DELETE_ITEM Then
			name = "wxEVT_COMMAND_TREE_DELETE_ITEM"
		Else If event.GetEventType() = wxEVT_COMMAND_TREE_GET_INFO Then
			name = "wxEVT_COMMAND_TREE_GET_INFO"
		Else If event.GetEventType() = wxEVT_COMMAND_TREE_SET_INFO Then
			name = "wxEVT_COMMAND_TREE_SET_INFO"
		Else If event.GetEventType() = wxEVT_COMMAND_TREE_ITEM_ACTIVATED Then
			name = "wxEVT_COMMAND_TREE_ITEM_ACTIVATED"
		Else If event.GetEventType() = wxEVT_COMMAND_TREE_ITEM_COLLAPSED Then
			name = "wxEVT_COMMAND_TREE_ITEM_COLLAPSED"
		Else If event.GetEventType() = wxEVT_COMMAND_TREE_ITEM_COLLAPSING Then
			name = "wxEVT_COMMAND_TREE_ITEM_COLLAPSING"
		Else If event.GetEventType() = wxEVT_COMMAND_TREE_ITEM_EXPANDED Then
			name = "wxEVT_COMMAND_TREE_ITEM_EXPANDED"
		Else If event.GetEventType() = wxEVT_COMMAND_TREE_ITEM_EXPANDING Then
			name = "wxEVT_COMMAND_TREE_ITEM_EXPANDING"
		Else If event.GetEventType() = wxEVT_COMMAND_TREE_ITEM_RIGHT_CLICK Then
			name = "wxEVT_COMMAND_TREE_ITEM_RIGHT_CLICK"
		Else If event.GetEventType() = wxEVT_COMMAND_TREE_ITEM_MIDDLE_CLICK Then
			name = "wxEVT_COMMAND_TREE_ITEM_MIDDLE_CLICK"
		Else If event.GetEventType() = wxEVT_COMMAND_TREE_SEL_CHANGED Then
			name = "wxEVT_COMMAND_TREE_SEL_CHANGED"
		Else If event.GetEventType() = wxEVT_COMMAND_TREE_SEL_CHANGING Then
			name = "wxEVT_COMMAND_TREE_SEL_CHANGING"
		Else If event.GetEventType() = wxEVT_COMMAND_TREE_KEY_DOWN Then
			name = "wxEVT_COMMAND_TREE_KEY_DOWN"
		Else If event.GetEventType() = wxEVT_COMMAND_TREE_ITEM_GETTOOLTIP Then
			name = "wxEVT_TREE_ITEM_GETTOOLTIP"
		Else If event.GetEventType() = wxEVT_COMMAND_TREE_ITEM_MENU Then
			name = "wxEVT_COMMAND_TREE_ITEM_MENU"
		Else If event.GetEventType() = wxEVT_COMMAND_TREE_STATE_IMAGE_CLICK Then
			name = "wxEVT_COMMAND_TREE_STATE_IMAGE_CLICK"
		Else
			name = "BUG, unexpected"
		End If
		
		Local message:String = "TREE    type=<" + name + " (" + event.GetEventType() + ")>    "
		message:+ "item=<%X> label=<%s> col=<%d> isOK=%s    keycode=<%d> point=<%d, %d> isEditCancelled=<%s>"
        'name, event.GetEventType(),
        '(unsigned Int)(event.GetItem().m_pItem), event.GetLabel().c_str(), event.GetInt(), event.GetItem().IsOk() ? "True" : "False",
        'event.GetKeyCode(), event.GetPoint().x, event.GetPoint().y, event.IsEditCancelled() ? "True" : "False"
    ');
		wxLogMessage(message)
		
		event.Skip()
	End Method

	' mouse events
	Method OnMouseGeneric(event:wxMouseEvent)
		Local name:String
		
		If event.GetEventType() = wxEVT_LEFT_DOWN Then
			name = "wxEVT_LEFT_DOWN"
		Else If event.GetEventType() = wxEVT_LEFT_UP Then
			name = "wxEVT_LEFT_UP"
		Else If event.GetEventType() = wxEVT_LEFT_DCLICK Then
			name = "wxEVT_LEFT_DCLICK"
		Else If event.GetEventType() = wxEVT_MIDDLE_DOWN Then
			name = "wxEVT_MIDDLE_DOWN"
		Else If event.GetEventType() = wxEVT_MIDDLE_UP Then
			name = "wxEVT_MIDDLE_UP"
		Else If event.GetEventType() = wxEVT_MIDDLE_DCLICK Then
			name = "wxEVT_MIDDLE_DCLICK"
		Else If event.GetEventType() = wxEVT_RIGHT_DOWN Then
			name = "wxEVT_RIGHT_DOWN"
		Else If event.GetEventType() = wxEVT_RIGHT_UP Then
			name = "wxEVT_RIGHT_UP"
		Else If event.GetEventType() = wxEVT_RIGHT_DCLICK Then
			name = "wxEVT_RIGHT_DCLICK"
		Else If event.GetEventType() = wxEVT_MOTION Then
			name = "wxEVT_MOTION"
		Else If event.GetEventType() = wxEVT_ENTER_WINDOW Then
			name = "wxEVT_ENTER_WINDOW"
		Else If event.GetEventType() = wxEVT_LEAVE_WINDOW Then
			name = "wxEVT_LEAVE_WINDOW"
		Else If event.GetEventType() = wxEVT_MOUSEWHEEL Then
			name = "wxEVT_MOUSEWHEEL"
		Else
			name = "BUG,unexpected"
		End If
		
		wxLogMessage("MOUSE    type=<" + name + " (" + event.GetEventType() + ")>    point=(" + event.GetX() + ", " + event.GetY() + ")")
		
		event.Skip()
	End Method


End Type

Type MyTreeListCtrl Extends wxTreeListCtrl

	Method OnInit()
		ConnectAny(wxEVT_MOUSE_EVENTS, _OnMouseGeneric)
	End Method
	
	Function _OnMouseGeneric(event:wxEvent)
		MyTreeListCtrl(event.parent).OnMouseGeneric(wxMouseEvent(event))
	End Function

	Method OnMouseGeneric(event:wxMouseEvent)
		Local name:String
		
		If event.GetEventType() = wxEVT_LEFT_DOWN Then
			name = "wxEVT_LEFT_DOWN"
		Else If event.GetEventType() = wxEVT_LEFT_UP Then
			name = "wxEVT_LEFT_UP"
		Else If event.GetEventType() = wxEVT_LEFT_DCLICK Then
			name = "wxEVT_LEFT_DCLICK"
		Else If event.GetEventType() = wxEVT_MIDDLE_DOWN Then
			name = "wxEVT_MIDDLE_DOWN"
		Else If event.GetEventType() = wxEVT_MIDDLE_UP Then
			name = "wxEVT_MIDDLE_UP"
		Else If event.GetEventType() = wxEVT_MIDDLE_DCLICK Then
			name = "wxEVT_MIDDLE_DCLICK"
		Else If event.GetEventType() = wxEVT_RIGHT_DOWN Then
			name = "wxEVT_RIGHT_DOWN"
		Else If event.GetEventType() = wxEVT_RIGHT_UP Then
			name = "wxEVT_RIGHT_UP"
		Else If event.GetEventType() = wxEVT_RIGHT_DCLICK Then
			name = "wxEVT_RIGHT_DCLICK"
		Else If event.GetEventType() = wxEVT_MOTION Then
			name = "wxEVT_MOTION"
		Else If event.GetEventType() = wxEVT_ENTER_WINDOW Then
			name = "wxEVT_ENTER_WINDOW"
		Else If event.GetEventType() = wxEVT_LEAVE_WINDOW Then
			name = "wxEVT_LEAVE_WINDOW"
		Else If event.GetEventType() = wxEVT_MOUSEWHEEL Then
			name = "wxEVT_MOUSEWHEEL"
		Else
			name = "BUG,unexpected"
		End If
		
		wxLogMessage("CHILDMOUSE    type=<" + name + " (" + event.GetEventType() + ")>    point=(" + event.GetX() + ", " + event.GetY() + ")")
		
		event.Skip()
	End Method

End Type



Const myID_DUMMY:Int = wxID_HIGHEST
Const myID_DELETE_TREE:Int = wxID_HIGHEST + 1
Const myID_REBUILD_TREE:Int = wxID_HIGHEST + 2
Const myID_ADDITEM:Int = wxID_HIGHEST + 3
Const myID_INSERTAT:Int = wxID_HIGHEST + 4
Const myID_DELETE:Int = wxID_HIGHEST + 5
Const myID_FIND:Int = wxID_HIGHEST + 6
Const myID_FINDFULL:Int = wxID_HIGHEST + 7
Const myID_FINDEXPANDED:Int = wxID_HIGHEST + 8
Const myID_FINDLEVEL:Int = wxID_HIGHEST + 9
Const myID_FINDVISIBLE:Int = wxID_HIGHEST + 10
Const myID_GOTO:Int = wxID_HIGHEST + 11
Const myID_ATTRTEXTCOLOUR:Int = wxID_HIGHEST + 12
Const myID_ATTRBACKCOLOUR:Int = wxID_HIGHEST + 13
Const myID_ATTRBOLDFONT:Int = wxID_HIGHEST + 14
Const myID_ATTRFONTSTYLE:Int = wxID_HIGHEST + 15
Const myID_ATTRITEMIMAGE:Int = wxID_HIGHEST + 16
Const myID_SETALIGNMENT:Int = wxID_HIGHEST + 17
Const myID_SETALIGNLEFT:Int = wxID_HIGHEST + 18
Const myID_SETALIGNCENTER:Int = wxID_HIGHEST + 19
Const myID_SETALIGNRIGHT:Int = wxID_HIGHEST + 20
Const myID_BUTTONSNORMAL:Int = wxID_HIGHEST + 21
Const myID_BUTTONSTWISTER:Int = wxID_HIGHEST + 22
Const myID_BUTTONSIMAGE:Int = wxID_HIGHEST + 23
Const myID_HIDEROOT:Int = wxID_HIGHEST + 24
Const myID_LINESATROOT:Int = wxID_HIGHEST + 25
Const myID_LINESCONNECT:Int = wxID_HIGHEST + 26
Const myID_COLUMNLINES:Int = wxID_HIGHEST + 27
Const myID_ROWLINES:Int = wxID_HIGHEST + 28
Const myID_ITEMHIGHLIGHT:Int = wxID_HIGHEST + 29
Const myID_ITEMVARHEIGHT:Int = wxID_HIGHEST + 30
Const myID_SHOWIMAGES:Int = wxID_HIGHEST + 31
Const myID_ITEMEDIT:Int = wxID_HIGHEST + 32
Const myID_ITEMVIRTUAL:Int = wxID_HIGHEST + 33
Const myID_SELECTMULTIPLE:Int = wxID_HIGHEST + 34
Const myID_SELECTEXTENDED:Int = wxID_HIGHEST + 35
Const myID_SETATTRIBUTE:Int = wxID_HIGHEST + 36
Const myID_GETCOUNT:Int = wxID_HIGHEST + 37
Const myID_GETCHILDREN:Int = wxID_HIGHEST + 38
Const myID_LISTALL:Int = wxID_HIGHEST + 39
Const myID_LISTCHILDREN:Int = wxID_HIGHEST + 40
Const myID_LISTSELECTED:Int = wxID_HIGHEST + 41
Const myID_SETINDENT:Int = wxID_HIGHEST + 42
Const myID_SETIMAGESIZE:Int = wxID_HIGHEST + 43
Const myID_VETOEVENT:Int = wxID_HIGHEST + 44
Const myID_GETNEXT:Int = wxID_HIGHEST + 45
Const myID_GETPREV:Int = wxID_HIGHEST + 46


