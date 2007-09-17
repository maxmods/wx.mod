SuperStrict

Framework wx.wxApp
Import wx.wxListCtrl
Import wx.wxLog
Import wx.wxPanel
Import wx.wxSystemSettings
Import wx.wxColourDialog

New MyApp.run()


Type MyApp Extends wxApp

	Method OnInit:Int()

		Local frame:MyFrame = MyFrame(New MyFrame.Create(, , "wxListCtrl Test"))

		frame.show()
		
		SetTopWindow(frame)
	
		Return True
	
	End Method

End Type

' number of items in list/report view
Const NUM_ITEMS:Int = 30

' number of items in icon/small icon view
Const NUM_ICONS:Int = 9

Global SMALL_VIRTUAL_VIEW_ITEMS:String[][] = [ ..
    [ "Cat", "meow" ], ..
    [ "Cow", "moo" ], ..
    [ "Crow", "caw"], ..
    [ "Dog", "woof" ], ..
    [ "Duck", "quack" ], ..
    [ "Mouse", "squeak" ], ..
    [ "Owl", "hoo" ], ..
    [ "Pig", "oink" ], ..
    [ "Pigeon", "coo" ], ..
    [ "Sheep", "baaah" ] ]


Type MyFrame Extends wxFrame

	Field imageListNormal:wxImageList
	Field imageListSmall:wxImageList

	Field panel:wxPanel
	Field listCtrl:MyListCtrl
	Field logWindow:wxTextCtrl

	Field logOld:wxLog
	Field smallVirtual:Int

	Method OnInit()
		DoConnections()
	
		If wxSystemSettings.GetScreenType() > wxSYS_SCREEN_SMALL Then
			SetSize(450, 340)
		End If

		' Give it an icon
		'SetIcon( wxIcon(mondrian) );

		' Make an image list containing large icons
		imageListNormal = New wxImageList.Create(32, 32, True)
		imageListSmall = New wxImageList.Create(16, 16, True)
	
		imageListNormal.AddIcon( wxIcon.Load( "media/listctrl/toolbrai.xpm" ) )
		imageListNormal.AddIcon( wxIcon.Load( "media/listctrl/toolchar.xpm" ) )
		imageListNormal.AddIcon( wxIcon.Load( "media/listctrl/tooldata.xpm" ) )
		imageListNormal.AddIcon( wxIcon.Load( "media/listctrl/toolnote.xpm" ) )
		imageListNormal.AddIcon( wxIcon.Load( "media/listctrl/tooltodo.xpm" ) )
		imageListNormal.AddIcon( wxIcon.Load( "media/listctrl/toolchec.xpm" ) )
		imageListNormal.AddIcon( wxIcon.Load( "media/listctrl/toolgame.xpm" ) )
		imageListNormal.AddIcon( wxIcon.Load( "media/listctrl/tooltime.xpm" ) )
		imageListNormal.AddIcon( wxIcon.Load( "media/listctrl/toolword.xpm" ) )
		
		imageListSmall.AddIcon( wxIcon.Load( "media/listctrl/small1.xpm" ) )
		
		' Make a menubar
		Local menuFile:wxMenu = New wxMenu.Create()
		menuFile.Append(LIST_ABOUT, "&About")
		menuFile.AppendSeparator()
		menuFile.Append(LIST_QUIT, "E&xit~tAlt-X")
		
		Local menuView:wxMenu = New wxMenu.Create()
		menuView.Append(LIST_LIST_VIEW, "&List view~tF1")
		menuView.Append(LIST_REPORT_VIEW, "&Report view~tF2")
		menuView.Append(LIST_ICON_VIEW, "&Icon view~tF3")
		menuView.Append(LIST_ICON_TEXT_VIEW, "Icon view with &text~tF4")
		menuView.Append(LIST_SMALL_ICON_VIEW, "&Small icon view~tF5")
		menuView.Append(LIST_SMALL_ICON_TEXT_VIEW, "Small icon &view with text~tF6")
		menuView.Append(LIST_VIRTUAL_VIEW, "&Virtual view~tF7")
		menuView.Append(LIST_SMALL_VIRTUAL_VIEW, "Small virtual vie&w~tF8")
?macos
		menuView.AppendCheckItem(LIST_MAC_USE_GENERIC, "Mac: Use Generic Control")
?
		
		Local menuList:wxMenu = New wxMenu.Create()
		menuList.Append(LIST_FOCUS_LAST, "&Make last item current~tCtrl-L")
		menuList.Append(LIST_TOGGLE_FIRST, "To&ggle first item~tCtrl-G")
		menuList.Append(LIST_DESELECT_ALL, "&Deselect All~tCtrl-D")
		menuList.Append(LIST_SELECT_ALL, "S&elect All~tCtrl-A")
		menuList.AppendSeparator()
		menuList.Append(LIST_SHOW_COL_INFO, "Show &column info~tCtrl-C")
		menuList.Append(LIST_SHOW_SEL_INFO, "Show &selected items~tCtrl-S")
		menuList.AppendSeparator()
		menuList.Append(LIST_SORT, "&Sort~tCtrl-S")
		menuList.AppendSeparator()
		menuList.Append(LIST_ADD, "&Append an item~tCtrl-P")
		menuList.Append(LIST_EDIT, "&Edit the item~tCtrl-E")
		menuList.Append(LIST_DELETE, "&Delete first item~tCtrl-X")
		menuList.Append(LIST_DELETE_ALL, "Delete &all items")
		menuList.AppendSeparator()
		menuList.Append(LIST_FREEZE, "Free&ze~tCtrl-Z")
		menuList.Append(LIST_THAW, "Tha&w~tCtrl-W")
		menuList.AppendSeparator()
		menuList.AppendCheckItem(LIST_TOGGLE_LINES, "Toggle &lines~tCtrl-I")
		menuList.Append(LIST_TOGGLE_MULTI_SEL, "&Multiple selection~tCtrl-M", "Toggle multiple selection", True)
		
		Local menuCol:wxMenu = New wxMenu.Create()
		menuCol.Append(LIST_SET_FG_COL, "&Foreground colour...")
		menuCol.Append(LIST_SET_BG_COL, "&Background colour...")
		
		Local menubar:wxMenuBar = New wxMenuBar.Create()
		menubar.Append(menuFile, "&File")
		menubar.Append(menuView, "&View")
		menubar.Append(menuList, "&List")
		menubar.Append(menuCol, "&Colour")
		SetMenuBar(menubar)

		panel = New wxPanel.Create(Self, wxID_ANY)
		logWindow = New wxTextCtrl.Create(panel, wxID_ANY, "", ,, ,, wxTE_MULTILINE | wxSUNKEN_BORDER)
		
		logOld = wxLog.SetActiveTarget(New wxLogTextCtrl.Create(logWindow))

		RecreateList(wxLC_REPORT | wxLC_SINGLE_SEL)

		CreateStatusBar(3)

	End Method
	
	Method DoConnections()
		ConnectAny(wxEVT_SIZE, OnSize)
		
		Connect(LIST_QUIT, wxEVT_COMMAND_MENU_SELECTED, OnQuit)
		Connect(LIST_ABOUT, wxEVT_COMMAND_MENU_SELECTED, OnAbout)
		Connect(LIST_LIST_VIEW, wxEVT_COMMAND_MENU_SELECTED, OnListView)
		Connect(LIST_REPORT_VIEW, wxEVT_COMMAND_MENU_SELECTED, OnReportView)
		Connect(LIST_ICON_VIEW, wxEVT_COMMAND_MENU_SELECTED, OnIconView)
		Connect(LIST_ICON_TEXT_VIEW, wxEVT_COMMAND_MENU_SELECTED, OnIconTextView)
		Connect(LIST_SMALL_ICON_VIEW, wxEVT_COMMAND_MENU_SELECTED, OnSmallIconView)
		Connect(LIST_SMALL_ICON_TEXT_VIEW, wxEVT_COMMAND_MENU_SELECTED, OnSmallIconTextView)
		Connect(LIST_VIRTUAL_VIEW, wxEVT_COMMAND_MENU_SELECTED, OnVirtualView)
		Connect(LIST_SMALL_VIRTUAL_VIEW, wxEVT_COMMAND_MENU_SELECTED, OnSmallVirtualView)
		
		Connect(LIST_FOCUS_LAST, wxEVT_COMMAND_MENU_SELECTED, OnFocusLast)
		Connect(LIST_TOGGLE_FIRST, wxEVT_COMMAND_MENU_SELECTED, OnToggleFirstSel)
		Connect(LIST_DESELECT_ALL, wxEVT_COMMAND_MENU_SELECTED, OnDeselectAll)
		Connect(LIST_SELECT_ALL, wxEVT_COMMAND_MENU_SELECTED, OnSelectAll)
		Connect(LIST_DELETE, wxEVT_COMMAND_MENU_SELECTED, OnDelete)
		Connect(LIST_ADD, wxEVT_COMMAND_MENU_SELECTED, OnAdd)
		Connect(LIST_EDIT, wxEVT_COMMAND_MENU_SELECTED, OnEdit)
		Connect(LIST_DELETE_ALL, wxEVT_COMMAND_MENU_SELECTED, OnDeleteAll)
		Connect(LIST_SORT, wxEVT_COMMAND_MENU_SELECTED, OnSort)
		Connect(LIST_SET_FG_COL, wxEVT_COMMAND_MENU_SELECTED, OnSetFgColour)
		Connect(LIST_SET_BG_COL, wxEVT_COMMAND_MENU_SELECTED, OnSetBgColour)
		Connect(LIST_TOGGLE_MULTI_SEL, wxEVT_COMMAND_MENU_SELECTED, OnToggleMultiSel)
		Connect(LIST_SHOW_COL_INFO, wxEVT_COMMAND_MENU_SELECTED, OnShowColInfo)
		Connect(LIST_SHOW_SEL_INFO, wxEVT_COMMAND_MENU_SELECTED, OnShowSelInfo)
		Connect(LIST_FREEZE, wxEVT_COMMAND_MENU_SELECTED, OnFreeze)
		Connect(LIST_THAW, wxEVT_COMMAND_MENU_SELECTED, OnThaw)
		Connect(LIST_TOGGLE_LINES, wxEVT_COMMAND_MENU_SELECTED, OnToggleLines)
		Connect(LIST_MAC_USE_GENERIC, wxEVT_COMMAND_MENU_SELECTED, OnToggleMacUseGeneric)
		
		Connect(LIST_SHOW_COL_INFO, wxEVT_UPDATE_UI, OnUpdateShowColInfo)
		Connect(LIST_TOGGLE_MULTI_SEL, wxEVT_UPDATE_UI, OnUpdateToggleMultiSel)

	End Method

	' recreate the list control with the New flags
	Method RecreateList(flags:Int, withText:Int = True)


		If listCtrl Then
			listCtrl.Free()
		End If

		listCtrl = MyListCtrl(New MyListCtrl.Create(panel, LIST_CTRL, ,, ,, flags | wxSUNKEN_BORDER | wxLC_EDIT_LABELS))
		
		Select flags & wxLC_MASK_TYPE
			Case wxLC_LIST
				InitWithListItems()
			
			Case wxLC_ICON
				InitWithIconItems(withText)
			
			Case wxLC_SMALL_ICON
				InitWithIconItems(withText, True)
			
			Case wxLC_REPORT
				If flags & wxLC_VIRTUAL Then
					InitWithVirtualItems()
				Else
					InitWithReportItems()
				End If
			
			Default
				'wxFAIL_MSG( _T("unknown listctrl mode") );
		End Select
		
		
		DoSize()
		
		logWindow.Clear()

	End Method
	
	Method DoSize()
		If Not logWindow Then
			Return
		End If

		Local w:Int, h:Int
		GetClientSize(w, h)
		Local y:Int = (2 * h) / 3
		listCtrl.SetDimensions(0, 0, w, y)
		logWindow.SetDimensions(0, y + 1, w, h - y)
	End Method
	
	' fill the control with items depending on the view
	Method InitWithListItems()
		For Local i:Int = 0 Until NUM_ITEMS
			listCtrl.InsertStringItem(i, "Item " + i)
		Next
	End Method
	
	Method InitWithReportItems()
		listCtrl.SetImageList(imageListSmall, wxIMAGE_LIST_SMALL)

		' note that under MSW For SetColumnWidth() To work we need To create the
		' items with images initially even If we specify dummy image id
		Local itemCol:wxListItem = New wxListItem.Create()
		itemCol.SetText("Column 1")
		itemCol.SetImage(-1)
		listCtrl.InsertColumnItem(0, itemCol)
		
		itemCol.SetText("Column 2")
		itemCol.SetAlign(wxLIST_FORMAT_CENTRE)
		listCtrl.InsertColumnItem(1, itemCol)
		
		itemCol.SetText("Column 3")
		itemCol.SetAlign(wxLIST_FORMAT_RIGHT)
		listCtrl.InsertColumnItem(2, itemCol)
		
		' To speed up inserting we hide the control temporarily
		listCtrl.Hide()
		
		'wxStopWatch sw;
		
		For Local i:Int = 0 Until NUM_ITEMS
			listCtrl.InsertItemInReportView(i)
		Next
		
		'm_logWindow.WriteText(wxString::Format(_T("%d items inserted in %ldms\n"),
		'                                        NUM_ITEMS, sw.Time()));
		listCtrl.Show()
		
		' we leave all mask fields To 0 And only change the colour
		Local item:wxListItem = New wxListItem.Create()
		item.SetId(0)
		item.SetTextColour(wxRED())
		listCtrl.SetItem( item )
		
		item.SetId(2)
		item.SetTextColour(wxGREEN())
		listCtrl.SetItem( item )
		
		item.SetId(4)
		item.SetTextColour(wxLIGHT_GREY())
		item.SetFont(wxITALIC_FONT())
		item.SetBackgroundColour(wxRED())
		listCtrl.SetItem( item );
		
		listCtrl.SetTextColour(wxBLUE())
		
		listCtrl.SetColumnWidth( 0, wxLIST_AUTOSIZE )
		listCtrl.SetColumnWidth( 1, wxLIST_AUTOSIZE )
		listCtrl.SetColumnWidth( 2, wxLIST_AUTOSIZE )
		
		' Set images in columns
		listCtrl.SetItemColumnImage(1, 1, 0)
		
		Local info:wxListItem = New wxListItem.Create()
		info.SetImage(0)
		info.SetId(3)
		info.SetColumn(2)
		listCtrl.SetItem(info)
		
		' test SetItemFont too
		listCtrl.SetItemFont(0, wxITALIC_FONT())
	End Method
	
	Method InitWithIconItems(withText:Int, sameIcon:Int = False)
		listCtrl.SetImageList(imageListNormal, wxIMAGE_LIST_NORMAL)
		listCtrl.SetImageList(imageListSmall, wxIMAGE_LIST_SMALL)
		
		For Local i:Int = 0 Until NUM_ICONS
			Local image:Int = 0
			If Not sameIcon Then
				image = i
			End If
			
			If withText Then
				listCtrl.InsertImageStringItem(i, "Label " + i, image)
			Else
				listCtrl.InsertImageItem(i, image)
			End If
		Next
	End Method
	
	Method InitWithVirtualItems()
		listCtrl.SetImageList(imageListSmall, wxIMAGE_LIST_SMALL)
		
		If smallVirtual Then
			listCtrl.InsertColumn(0, "Animal")
			listCtrl.InsertColumn(1, "Sound")
			listCtrl.SetItemCount(SMALL_VIRTUAL_VIEW_ITEMS.length)
		Else
			listCtrl.InsertColumn(0, "First Column")
			listCtrl.InsertColumn(1, "Second Column")
			listCtrl.SetColumnWidth(0, 150)
			listCtrl.SetColumnWidth(1, 150)
			listCtrl.SetItemCount(1000000)
		End If
	End Method
	
	' Return True If the control is Not in virtual view, give an error message
	' And Return False If it is
	Method CheckNonVirtual:Int()
		If Not listCtrl.HasFlag(wxLC_VIRTUAL) Then
			Return True
		End If
		
		' "this" == whatever
		wxLogWarning("Can't do this in virtual view, sorry.")
		
		Return False
	End Method

	Function OnSize(event:wxEvent)
		MyFrame(event.parent).DoSize()
		
		event.Skip()
	End Function
	
	Function OnQuit(event:wxEvent)
		wxWindow(event.parent).Close(True)
	End Function
	
	Function OnAbout(event:wxEvent)
'    wxMessageDialog dialog(this, _T("List test sample\nJulian Smart (c) 1997"),
'            _T("About list test"), wxOK|wxCANCEL);
'
'    dialog.ShowModal();
	End Function
	
	Function OnListView(event:wxEvent)
		MyFrame(event.parent).RecreateList(wxLC_LIST)
	End Function
	
	Function OnReportView(event:wxEvent)
		MyFrame(event.parent).RecreateList(wxLC_REPORT)
	End Function
	
	Function OnIconView(event:wxEvent)
		MyFrame(event.parent).RecreateList(wxLC_ICON, False)
	End Function
	
	Function OnIconTextView(event:wxEvent)
		MyFrame(event.parent).RecreateList(wxLC_ICON)
	End Function
	
	Function OnSmallIconView(event:wxEvent)
		MyFrame(event.parent).RecreateList(wxLC_SMALL_ICON, False)
	End Function
	
	Function OnSmallIconTextView(event:wxEvent)
		MyFrame(event.parent).RecreateList(wxLC_SMALL_ICON)
	End Function
	
	Function OnVirtualView(event:wxEvent)
		MyFrame(event.parent).smallVirtual = False
		MyFrame(event.parent).RecreateList(wxLC_REPORT | wxLC_VIRTUAL)
	End Function
	
	Function OnSmallVirtualView(event:wxEvent)
		MyFrame(event.parent).smallVirtual = True
		MyFrame(event.parent).RecreateList(wxLC_REPORT | wxLC_VIRTUAL)
	End Function
	
	Function OnFocusLast(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		Local index:Int = frame.listCtrl.GetItemCount() - 1
		If index = -1 Then
			Return
		End If
		
		frame.listCtrl.SetItemState(index, wxLIST_STATE_FOCUSED, wxLIST_STATE_FOCUSED)
		frame.listCtrl.EnsureVisible(index)
	End Function
	
	Function OnToggleFirstSel(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		frame.listCtrl.SetItemState(0, (~frame.listCtrl.GetItemState(0, wxLIST_STATE_SELECTED) ) & wxLIST_STATE_SELECTED, wxLIST_STATE_SELECTED)
	End Function
	
	Function OnDeselectAll(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		If Not frame.CheckNonVirtual() Then
			Return
		End If
		
		Local n:Int = frame.listCtrl.GetItemCount()
		For Local i:Int = 0 Until n
			frame.listCtrl.SetItemState(i, 0, wxLIST_STATE_SELECTED)
		Next
	End Function
	
	Function OnSelectAll(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		If Not frame.CheckNonVirtual() Then
			Return
		End If
		
		Local n:Int = frame.listCtrl.GetItemCount()
		For Local i:Int = 0 Until n
			frame.listCtrl.SetItemState(i, wxLIST_STATE_SELECTED, wxLIST_STATE_SELECTED)
		Next
	End Function
	
	Function OnAdd(event:wxEvent)
		MyFrame(event.parent).listCtrl.InsertStringItem(MyFrame(event.parent).listCtrl.GetItemCount(), "Appended item")
	End Function
	
	Function OnEdit(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		Local itemCur:Int = frame.listCtrl.GetNextItem(-1, wxLIST_NEXT_ALL, wxLIST_STATE_FOCUSED)
		
		If itemCur <> -1 Then
			frame.listCtrl.EditLabel(itemCur)
		Else
			frame.logWindow.WriteText("No item to edit")
		End If
	End Function
	
	Function OnDelete(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		If frame.listCtrl.GetItemCount() Then
			frame.listCtrl.DeleteItem(0)
		Else
			frame.logWindow.WriteText("Nothing to delete")
		End If
	End Function
	
	Function OnDeleteAll(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		'wxStopWatch sw;
		
		Local itemCount:Int = frame.listCtrl.GetItemCount()
		
		frame.listCtrl.DeleteAllItems()
		
		' frame.logWindow.WriteText("Deleting " + itemCount + " items took %ld ms\n"),
		'                                        itemCount,
		'                                       sw.Time()));
	End Function
	
	Function OnSort(event:wxEvent)
	End Function
	
	Function OnSetFgColour(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		frame.listCtrl.SetForegroundColour(wxGetColourFromUser(frame))
		frame.listCtrl.Refresh()
	End Function
	
	Function OnSetBgColour(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		frame.listCtrl.SetBackgroundColour(wxGetColourFromUser(frame))
		frame.listCtrl.Refresh()
	End Function
	
	Function OnToggleMultiSel(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		Local flags:Int = frame.listCtrl.GetWindowStyleFlag()
		If flags & wxLC_SINGLE_SEL Then
			flags:& ~wxLC_SINGLE_SEL
		Else
			flags:| wxLC_SINGLE_SEL
		End If
		
		If flags & wxLC_SINGLE_SEL Then
			frame.logWindow.WriteText("Current selection mode: single~n")
		Else
			frame.logWindow.WriteText("Current selection mode: multiple~n")
		End If
		
		frame.RecreateList(flags)
	End Function
	
	Function OnShowColInfo(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		Local count:Int = frame.listCtrl.GetColumnCount()
		wxLogMessage(count + " columns:")
		For Local c:Int = 0 Until count
			wxLogMessage("~tcolumn " + c + " has width " + frame.listCtrl.GetColumnWidth(c))
		Next
	End Function
	
	Function OnShowSelInfo(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
		Local selCount:Int = frame.listCtrl.GetSelectedItemCount()
		wxLogMessage(selCount + " items selected:")
		
		' don't show too many items
		Local shownCount:Int = 0
		
		Local item:Int = frame.listCtrl.GetNextItem(-1, wxLIST_NEXT_ALL, wxLIST_STATE_SELECTED)
		While item <> -1
			wxLogMessage("~t" + item + " (" + frame.listCtrl.GetItemText(item) + ")")
			
			shownCount:+ 1
			If shownCount > 10 Then
				wxLogMessage("~t... more selected items snipped...")
				Exit
			End If
			
			item = frame.listCtrl.GetNextItem(item, wxLIST_NEXT_ALL, wxLIST_STATE_SELECTED)
		Wend
	End Function
	
	Function OnFreeze(event:wxEvent)
		wxLogMessage("Freezing the control")
		
		MyFrame(event.parent).listCtrl.Freeze()
	End Function
	
	Function OnThaw(event:wxEvent)
		wxLogMessage("Thawing the control")
		
		MyFrame(event.parent).listCtrl.Thaw()
	End Function
	
	Function OnToggleLines(event:wxEvent)
		MyFrame(event.parent).listCtrl.SetSingleStyle(wxLC_HRULES | wxLC_VRULES, wxCommandEvent(event).IsChecked())
	End Function
	
	Function OnToggleMacUseGeneric(event:wxEvent)
		'wxSystemOptions.SetOption("mac.listctrl.always_use_generic", event.IsChecked())
	End Function

	Function OnUpdateShowColInfo(event:wxEvent)
		wxUpdateUIEvent(event).Enable( (MyFrame(event.parent).listCtrl.GetWindowStyleFlag() & wxLC_REPORT) <>0 )
	End Function

	Function OnUpdateToggleMultiSel(event:wxEvent)
		wxUpdateUIEvent(event).Check((MyFrame(event.parent).listCtrl.GetWindowStyleFlag() & wxLC_SINGLE_SEL) = 0)
	End Function

End Type



Type MyListCtrl Extends wxListCtrl

    Field logOld:wxLog
    Field attr:wxListItemAttr


'    Method ShowContextMenu(Const wxPoint& pos);
'    Method SetColumnImage(Int col, Int image);
'
'    Method LogEvent(Const wxListEvent& event, Const wxChar *eventName);
'    Method LogColEvent(Const wxListEvent& event, Const wxChar *eventName);
'
'    Method wxString OnGetItemText(Long item, Long column) Const;
'    Method Int OnGetItemColumnImage(Long item, Long column) Const;
'    Method wxListItemAttr *OnGetItemAttr(Long item) Const;



	Method InsertItemInReportView(i:Int)
		Local buf:String = "This is item " + i
		Local tmp:Int = InsertImageStringItem(i, buf, 0)
		'SetItemData(tmp, i)
		
		buf = "Col 1, item " + i
		SetStringItem(tmp, 1, buf)
		
		buf = "Item " + i + " in column 2"
		SetStringItem(tmp, 2, buf)
	End Method
	
	Function OnColClick(event:wxEvent)
	
	End Function
	
	Function OnColRightClick(event:wxEvent)
	
	End Function
	
	Function OnColBeginDrag(event:wxEvent)
	
	End Function
	
	Function OnColDragging(event:wxEvent)
	
	End Function
	
	Function OnColEndDrag(event:wxEvent)
	
	End Function
	
	Function OnBeginDrag(event:wxEvent)
	
	End Function
	
	Function OnBeginRDrag(event:wxEvent)
	
	End Function
	
	Function OnBeginLabelEdit(event:wxEvent)
	
	End Function
	
	Function OnEndLabelEdit(event:wxEvent)
	
	End Function
	
	Function OnDeleteItem(event:wxEvent)
	
	End Function
	
	Function OnDeleteAllItems(event:wxEvent)
	
	End Function
	
	Function OnSelected(event:wxEvent)
	
	End Function
	
	Function OnDeselected(event:wxEvent)
	
	End Function
	
	Function OnListKeyDown(event:wxEvent)
	
	End Function
	
	Function OnActivated(event:wxEvent)
	
	End Function
	
	Function OnFocused(event:wxEvent)
	
	End Function
	
	Function OnCacheHint(event:wxEvent)
	End Function

	Function OnChar(event:wxEvent)
	End Function
	
	Function OnContextMenu(event:wxEvent)
	End Function
	
	Function OnRightClick(event:wxEvent)
	End Function

End Type


' IDs For the menu commands
Const LIST_ABOUT:Int = wxID_ABOUT
Const LIST_QUIT:Int = wxID_EXIT

Const LIST_LIST_VIEW:Int = wxID_HIGHEST
Const LIST_ICON_VIEW:Int = wxID_HIGHEST + 1
Const LIST_ICON_TEXT_VIEW:Int = wxID_HIGHEST + 2
Const LIST_SMALL_ICON_VIEW:Int = wxID_HIGHEST + 3
Const LIST_SMALL_ICON_TEXT_VIEW:Int = wxID_HIGHEST + 4
Const LIST_REPORT_VIEW:Int = wxID_HIGHEST + 5
Const LIST_VIRTUAL_VIEW:Int = wxID_HIGHEST + 6
Const LIST_SMALL_VIRTUAL_VIEW:Int = wxID_HIGHEST + 7

Const LIST_DESELECT_ALL:Int = wxID_HIGHEST + 8
Const LIST_SELECT_ALL:Int = wxID_HIGHEST + 9
Const LIST_DELETE_ALL:Int = wxID_HIGHEST + 10
Const LIST_DELETE:Int = wxID_HIGHEST + 11
Const LIST_ADD:Int = wxID_HIGHEST + 12
Const LIST_EDIT:Int = wxID_HIGHEST + 13
Const LIST_SORT:Int = wxID_HIGHEST + 14
Const LIST_SET_FG_COL:Int = wxID_HIGHEST + 15
Const LIST_SET_BG_COL:Int = wxID_HIGHEST + 16
Const LIST_TOGGLE_MULTI_SEL:Int = wxID_HIGHEST + 17
Const LIST_TOGGLE_FIRST:Int = wxID_HIGHEST + 18
Const LIST_SHOW_COL_INFO:Int = wxID_HIGHEST + 19
Const LIST_SHOW_SEL_INFO:Int = wxID_HIGHEST + 20
Const LIST_FOCUS_LAST:Int = wxID_HIGHEST + 21
Const LIST_FREEZE:Int = wxID_HIGHEST + 22
Const LIST_THAW:Int = wxID_HIGHEST + 23
Const LIST_TOGGLE_LINES:Int = wxID_HIGHEST + 24
Const LIST_MAC_USE_GENERIC:Int = wxID_HIGHEST + 25

Const LIST_CTRL:Int = 1000
