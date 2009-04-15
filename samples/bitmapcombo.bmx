'
' wxCheckListBox sample
'
' From the C++ sample by Vadim Zeitlin
'
' BlitzMax port by Bruce A Henderson
'
SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxBitmapComboBox
Import wx.wxButton
Import wx.wxPanel
Import wx.wxLog

Type CheckListBoxApp Extends wxApp

	Field frame:MyFrame

	Method OnInit:Int()

		frame = MyFrame(New MyFrame.Create(,, "wxWidgets Checklistbox Sample", 200, 200, 400, 400))
		frame.show()
	
		Return True
	
	End Method

End Type

Type MyFrame Extends wxFrame

	Field panel:wxPanel
	Field listBox:wxBitmapComboBox
	
	' menu IDs
	Const Menu_About:Int = wxID_ABOUT
	Const Menu_Quit:Int = wxID_EXIT
	
	Const Menu_CheckFirst:Int = wxID_HIGHEST
	Const Menu_UncheckFirst:Int = wxID_HIGHEST + 1
	Const Menu_ToggleFirst:Int = wxID_HIGHEST + 2
	Const Menu_Selection:Int = wxID_HIGHEST + 3
	Const Menu_Extended:Int = wxID_HIGHEST + 4
	Const Menu_Sorting:Int = wxID_HIGHEST + 5
	Const Menu_InsertItemsStart:Int = wxID_HIGHEST + 6
	Const Menu_InsertItemsMiddle:Int = wxID_HIGHEST + 7
	Const Menu_InsertItemsEnd:Int = wxID_HIGHEST + 8
	Const Menu_AppendItems:Int = wxID_HIGHEST + 9
	Const Menu_RemoveItems:Int = wxID_HIGHEST + 10
	Const Menu_GetBestSize:Int = wxID_HIGHEST + 11
	Const Menu_MakeItemFirst:Int = wxID_HIGHEST + 12

	Const Control_First:Int = wxID_HIGHEST + 13
	Const Control_Listbox:Int = wxID_HIGHEST + 14
	
	Const Btn_Up:Int = wxID_UP
	Const Btn_Down:Int = wxID_DOWN


'	Function Create:MyFrame(title:String, x:Int = -1, y:Int = -1, w:Int = -1, h:Int = -1)
'		Local this:MyFrame = New MyFrame
'		
'		this.init(title, x, y, w, h)
'		
'		Return this
'	End Function

	Method OnInit()
	
		' Make a menubar
		
		Local fileMenu:wxMenu = wxMenu.CreateMenu()
		fileMenu.Append(Menu_Quit, "E&xit~tAlt-X")
		
		' listbox submenu
		Local listMenu:wxMenu = wxMenu.CreateMenu()
		listMenu.Append(Menu_CheckFirst, "Check the first item~tCtrl-C")
		listMenu.Append(Menu_UncheckFirst, "Uncheck the first item~tCtrl-U")
		listMenu.Append(Menu_ToggleFirst, "Toggle the first item~tCtrl-T")
		listMenu.AppendSeparator()
		listMenu.Append(Menu_InsertItemsStart, "Insert some item at the beginning")
		listMenu.Append(Menu_InsertItemsMiddle, "Insert some item at the middle")
		listMenu.Append(Menu_InsertItemsEnd, "Insert some item at the end")
		listMenu.Append(Menu_AppendItems, "Append some items~tCtrl-A")
		listMenu.Append(Menu_RemoveItems, "Remove some items")
		listMenu.AppendSeparator()
		listMenu.AppendCheckItem(Menu_Selection, "Multiple selection~tCtrl-M")
		listMenu.AppendCheckItem(Menu_Extended, "Extended selection")
		listMenu.AppendCheckItem(Menu_Sorting, "Sorting")
		listMenu.AppendSeparator()
		listMenu.Append(Menu_GetBestSize, "Get the best size of the checklistbox control")
		listMenu.AppendSeparator()
		listMenu.Append(Menu_MakeItemFirst, "Make selected item the first item")	


		Local helpMenu:wxMenu = wxMenu.CreateMenu()
		helpMenu.Append(Menu_About, "&About...~tF1")
		
		
		' put it all together
		Local menuBar:wxMenuBar = wxMenuBar.CreateMenuBar()
		menuBar.Append(fileMenu, "&File")
		menuBar.Append(listMenu, "&List")
		menuBar.Append(helpMenu, "&Help")

		SetMenuBar(menuBar)
		
		' create a status bar just for fun
		CreateStatusBar(2)
		
		'make a panel with some controls
		panel = wxPanel.CreatePanel(Self)
		
		CreateCheckListbox()
		
		' create buttons for moving the items around
		Local button1:wxButton = wxButton.CreateButton(panel, Btn_Up)
		Local button2:wxButton = wxButton.CreateButton(panel, Btn_Down)
		
		Local mainSizer:wxBoxSizer = wxBoxSizer.CreateBoxSizer(wxVERTICAL)
		mainSizer.Add(listBox, 1, wxGROW | wxALL, 10)
		
		Local bottomSizer:wxBoxSizer = wxBoxSizer.CreateBoxSizer(wxHORIZONTAL)
		bottomSizer.Add(button1, 0, wxALL, 10)
		bottomSizer.Add(button2, 0, wxALL, 10)
		
		mainSizer.AddSizer(bottomsizer, 0, wxCENTER)
		
		
		' tell frame to make use of sizer (or constraints, if any)
		panel.SetAutoLayout(True)
		panel.SetSizer(mainSizer)
		
		' connect the events
		Connect(wxID_EXIT, wxEVT_COMMAND_MENU_SELECTED, OnQuit)
		Connect(wxID_ABOUT, wxEVT_COMMAND_MENU_SELECTED, OnAbout)
		Connect(Menu_CheckFirst, wxEVT_COMMAND_MENU_SELECTED, OnCheckFirstItem)
		Connect(Menu_UncheckFirst, wxEVT_COMMAND_MENU_SELECTED, OnUncheckFirstItem)
		Connect(Menu_ToggleFirst, wxEVT_COMMAND_MENU_SELECTED, OnToggleFirstItem)
		Connect(Menu_Selection, wxEVT_COMMAND_MENU_SELECTED, OnToggleSelection)
		Connect(Menu_Extended, wxEVT_COMMAND_MENU_SELECTED, OnToggleExtended)
		Connect(Menu_Sorting, wxEVT_COMMAND_MENU_SELECTED, OnToggleSorting)
		Connect(Menu_InsertItemsStart, wxEVT_COMMAND_MENU_SELECTED, OnInsertItemsStart)
		Connect(Menu_InsertItemsMiddle, wxEVT_COMMAND_MENU_SELECTED, OnInsertItemsMiddle)
		Connect(Menu_InsertItemsEnd, wxEVT_COMMAND_MENU_SELECTED, OnInsertItemsEnd)
		Connect(Menu_AppendItems, wxEVT_COMMAND_MENU_SELECTED, OnAppendItems)
		Connect(Menu_RemoveItems, wxEVT_COMMAND_MENU_SELECTED, OnRemoveItems)
		Connect(Menu_GetBestSize, wxEVT_COMMAND_MENU_SELECTED, OnGetBestSize)
		Connect(Menu_MakeItemFirst, wxEVT_COMMAND_MENU_SELECTED, OnMakeItemFirst)
		
		Connect(Control_Listbox, wxEVT_COMMAND_LISTBOX_SELECTED, OnListboxSelect)
		Connect(Control_Listbox, wxEVT_COMMAND_CHECKLISTBOX_TOGGLED, OnCheckboxToggle)
		Connect(Control_Listbox, wxEVT_COMMAND_LISTBOX_DOUBLECLICKED, OnListboxDblClick)
		
		Connect(Btn_Up, wxEVT_COMMAND_BUTTON_CLICKED, OnButtonUp)
		Connect(Btn_Down, wxEVT_COMMAND_BUTTON_CLICKED, OnButtonDown)
		
	End Method
	
	Method CreateCheckListbox(flags:Int = 0)
	
		listBox = New wxBitmapComboBox.Create(panel, Control_Listbox, Null, Null, 10, 10, 300, 40, flags)
		listbox.AppendBitmap("one")
		listbox.AppendBitmap("two")
		listbox.AppendBitmap("three")
		listbox.AppendBitmap("four")
		
'DebugStop
		listBox.selectitem(2)
	
	End Method

	Function OnQuit(event:wxEvent)
		wxWindow(event.parent).Close(True)
	End Function
	
	Function OnAbout(event:wxEvent)
		wxMessageBox("Demo of wxCheckListBox control~nOriginal version (c) Vadim Zeitlin 1998-2002" + ..
			"~nBlitzMax version (c) Bruce A Henderson 2007", "About wxCheckListBox", wxICON_INFORMATION, wxWindow(event.parent))
	End Function
	
	Function OnCheckFirstItem(event:wxEvent)
		Local frame:MyFrame = MyFrame(event.parent)
'		If Not frame.listBox.IsEmpty() Then
'			frame.listBox.Check(0)
'		End If
	End Function
	
	Function OnUncheckFirstItem(event:wxEvent)
'		Local listbox:wxCheckListBox = MyFrame(event.parent).listBox
'		If Not listBox.IsEmpty() Then
'			listBox.Check(0, False)
'		End If
	End Function
	
	Function OnToggleFirstItem(event:wxEvent)
'		Local listbox:wxCheckListBox = MyFrame(event.parent).listBox
'		If Not listBox.IsEmpty() Then
'			listBox.Check(0, Not listBox.IsChecked(0))
'		End If
	End Function
	
	Function OnToggleSelection(event:wxEvent)
'		Local frame:MyFrame = MyFrame(event.parent)
'
'		Local sizer:wxSizer = frame.panel.GetSizer()
'		
'		sizer.Detach(frame.listBox)
'		frame.listBox.free()
'		
'		If wxCommandEvent(event).IsChecked() Then
'			frame.CreateCheckListbox(wxLB_MULTIPLE)
'		Else
'			frame.CreateCheckListbox()
'		End If
'		
'		sizer.Insert(0, frame.listBox, 1, wxGROW | wxALL, 10)
'		
'		frame.panel.Layout()
	End Function
	
	Function OnToggleSorting(event:wxEvent)
'		Local frame:MyFrame = MyFrame(event.parent)
'
'		Local sizer:wxSizer = frame.panel.GetSizer()
'		
'		sizer.Detach(frame.listBox)
'		frame.listBox.free()
'		
'		If wxCommandEvent(event).IsChecked() Then
'			frame.CreateCheckListbox(wxLB_SORT)
'		Else
'			frame.CreateCheckListbox()
'		End If
'		
'		sizer.Insert(0, frame.listBox, 1, wxGROW | wxALL, 10)
'		
'		frame.panel.Layout()
	End Function
	
	Function OnToggleExtended(event:wxEvent)
'		Local frame:MyFrame = MyFrame(event.parent)
'
'		Local sizer:wxSizer = frame.panel.GetSizer()
'		
'		sizer.Detach(frame.listBox)
'		frame.listBox.free()
'		
'		If wxCommandEvent(event).IsChecked() Then
'			frame.CreateCheckListbox(wxLB_EXTENDED)
'		Else
'			frame.CreateCheckListbox()
'		End If
'		
'		sizer.Insert(0, frame.listBox, 1, wxGROW | wxALL, 10)
'		
'		frame.panel.Layout()
	End Function
	
	Function OnInsertItemsStart(event:wxEvent)
'		Global item:Int
'		
'		Local items:String[] = [ "New item " + (item + 1), ..
'							"New item " + (item + 2), ..
'							"New item " + (item + 3)]
'		item:+3
'		
'		MyFrame(event.parent).listBox.InsertItems(items, 0)
	End Function
	
	Function OnInsertItemsMiddle(event:wxEvent)
'		Global item:Int
'		
'		Local items:String[] = [ "New item " + (item + 1), ..
'							"New item " + (item + 2), ..
'							"New item " + (item + 3)]
'		item:+3
'		
'		If MyFrame(event.parent).listBox.GetCount() Then
'			MyFrame(event.parent).listBox.InsertItems(items, 1)
'		Else
'			MyFrame(event.parent).listBox.InsertItems(items, 0)
'		End If
	End Function
	
	Function OnInsertItemsEnd(event:wxEvent)
'		Global item:Int
'		
'		Local items:String[] = [ "New item " + (item + 1), ..
'							"New item " + (item + 2), ..
'							"New item " + (item + 3)]
'		item:+3
'		
'		MyFrame(event.parent).listBox.InsertItems(items, MyFrame(event.parent).listBox.GetCount())
	End Function
	
	Function OnAppendItems(event:wxEvent)
		Global item:Int
'		Local listbox:wxListBox = MyFrame(event.parent).listBox
'		
'		listBox.Append("New item " + (item + 1))
'		listBox.Append("New item " + (item + 2))
'		listBox.Append("New item " + (item + 3))
'		
'		item:+ 3
	End Function
	
	Function OnRemoveItems(event:wxEvent)
		For Local i:Int = 0 Until 3
			If MyFrame(event.parent).listBox.GetCount() Then
				MyFrame(event.parent).listBox.DeleteItem(0)
			End If
		Next
	End Function
	
	Function OnGetBestSize(event:wxEvent)
		Local w:Int, h:Int
		MyFrame(event.parent).listBox.GetBestSize(w, h)
		
		wxMessageBox("Best size of the checklistbox is:[" + w + "," + h + "]", , , wxWindow(event.parent))
	End Function
	
	Function OnMakeItemFirst(event:wxEvent)
'		Local listbox:wxListBox = MyFrame(event.parent).listBox
'	
'		If listbox.GetSelection() <> -1 Then
'			listBox.SetFirstItem(listBox.GetSelection())
'		Else
'			wxMessageBox("Nothing selected!", , , wxWindow(event.parent))
'		End If
	End Function
	
	Function OnListboxSelect(event:wxEvent)
	
'		Local selection:Int = wxCommandEvent(event).GetSelection()
'		
'		Local s:String = "Item " + selection + " selected ("
'		
'		If Not MyFrame(event.parent).listBox.IsChecked(selection) Then
'			s:+ "un"
'		End If
'
'		wxLogStatus(s + "checked)", MyFrame(event.parent))

	End Function
	
	Function OnCheckboxToggle(event:wxEvent)

''		Local item:Int = wxCommandEvent(event).GetInt()
'		
'		Local s:String = "item " + item + " was "
'		
'		If Not MyFrame(event.parent).listBox.IsChecked(item) Then
'			s:+ "un"
'		End If
'		
'		wxLogStatus(s + "checked", MyFrame(event.parent))
	End Function
	
	Function OnListboxDblClick(event:wxEvent)
'		Local frame:MyFrame = MyFrame(event.parent)
'		Local selection:Int = -1
'		
'		If frame.listBox.GetWindowStyle() & (wxLB_EXTENDED | wxLB_MULTIPLE) Then
'			Local list:Int[] = frame.listBox.GetSelections()
'			If list.length = 1 Then
'				selection = list[0]
'			End If
'		Else
'			selection = frame.listBox.GetSelection()
'		End If
'		
'		Local strSelection:String
'		If selection <> -1 Then
'			strSelection = "Item " + selection + " double clicked"
'		Else
'			strSelection = "List double clicked in multiple selection mode"
'		End If
'		
'		wxMessageBox(strSelection, "wxCheckListBox message", wxICON_INFORMATION, frame)
	End Function
	
	Function OnButtonUp(event:wxEvent)
		MyFrame(event.parent).OnButtonMove(True)
	End Function
	
	Function OnButtonDown(event:wxEvent)
		MyFrame(event.parent).OnButtonMove(False)
	End Function
	
	Method OnButtonMove(up:Int)
		Local selection:Int = -1
Rem		
		If listBox.GetWindowStyle() & (wxLB_EXTENDED | wxLB_MULTIPLE) Then
		
			Local list:Int[] = listBox.GetSelections()
		
			If list.length = 1 Then
				selection = list[0]
			End If
		Else
			selection = listBox.GetSelection()
		End If
		
		If selection <> wxNOT_FOUND Then

			Local label:String = listBox.GetString(selection)
			Local positionNew:Int
		
			If up Then
				positionNew = selection - 1
			Else
				positionNew = selection + 2
			End If

			If positionNew < 0 Or positionNew > listBox.GetCount() Then
				If up Then
					wxLogStatus("Can't move this item up", Self)
				Else
					wxLogStatus("Can't move this item down", Self)
				End If
			Else

				Local wasChecked:Int = listBox.IsChecked(selection)
				
				Local positionOld:Int
				If up Then
					positionOld = selection + 1
				Else
					positionOld  = selection
				End If

				' insert the item
				listBox.InsertItems([label], positionNew)
				
				' And Delete the old one
				listBox.DeleteItem(positionOld)
				
				Local selectionNew:Int
				If up Then
					selectionNew = positionNew
				Else
					selectionNew = positionNew - 1
				End If

				listBox.Check(selectionNew, wasChecked)
				listBox.SetSelection(selectionNew)
				listBox.SetFocus()
				
				'AdjustColour(selection);
				'AdjustColour(selectionNew);
				
				If up Then
					wxLogStatus("Item moved up", Self)
				Else
					wxLogStatus("Item moved down", Self)
				End If
			End If
		Else
			wxLogStatus("Please select single item", Self)
		End If
End Rem
	End Method
	
End Type

New CheckListBoxApp.run()



