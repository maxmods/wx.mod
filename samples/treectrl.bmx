Rem

C++ Splitter sample author info from which this .bmx was ported:

/////////////////////////////////////////////////////////////////////////////
// Name:        treectrl.h
// Purpose:     wxTreeCtrl sample
// Author:      Julian Smart
// Modified by:
// Created:     04/01/98
// RCS-ID:      $Id: treetest.h,v 1.50 2006/11/04 11:26:51 VZ Exp $
// Copyright:   (c) Julian Smart
// Licence:     wxWindows license
/////////////////////////////////////////////////////////////////////////////
// BlitzMax port: Bruce A Henderson and a feeble wee bit by David De Candia who got tired and gave up
/////////////////////////////////////////////////////////////////////////////

End Rem

SuperStrict

Framework wx.wxApp
Import wx.wxFrame
Import wx.wxImage
Import wx.wxMouseEvent
Import wx.wxLog
Import wx.wxPanel
Import wx.wxTreeCtrl
Import wx.wxDC

'	Run the sample app
New MyApp.run()

Const 	TREETEST_QUIT:Int 				= WXID_EXIT,..
    		TREETEST_ABOUT :Int			= WXID_ABOUT,..
    		TREETEST_TOGBUTTONS:Int		= WXID_HIGHEST,..
   		TREETEST_TOGTWIST:Int		= WXID_HIGHEST + 1,..
   		TREETEST_TOGLINES:Int			= WXID_HIGHEST + 2,..
   		TREETEST_TOGEDIT:Int			= WXID_HIGHEST + 3,..
    		TREETEST_TOGHIDEROOT:Int	= WXID_HIGHEST + 4,..
    		TREETEST_TOGROOTLINES:Int	= WXID_HIGHEST + 5,..
    		TREETEST_TOGBORDER:Int		= WXID_HIGHEST + 6,..
    		TREETEST_TOGFULLHIGHLIGHT:Int= WXID_HIGHEST +7,..
    		TREETEST_SETFGCOLOUR:Int		= WXID_HIGHEST + 8,..
    		TREETEST_SETBGCOLOUR:Int		= WXID_HIGHEST + 9,..
    		TREETEST_RESETSTYLE:Int		= WXID_HIGHEST + 10,..
    		TREETEST_HIGHLIGHT:Int		= WXID_HIGHEST + 11,..
    		TREETEST_DUMP:Int			= WXID_HIGHEST + 12,..
    		TREETEST_DUMPSELECTED:Int	= WXID_HIGHEST + 13,..
    		TREETEST_COUNT:Int			= WXID_HIGHEST + 14,..
    		TREETEST_COUNTREC:Int		= WXID_HIGHEST + 15,..
   		TREETEST_SORT:Int				= WXID_HIGHEST + 16,..
   		TREETEST_SORTREV:Int			= WXID_HIGHEST + 17,..
    		TREETEST_SETBOLD:Int			= WXID_HIGHEST + 18,..
    		TREETEST_CLEARBOLD:Int		= WXID_HIGHEST + 19,..
   		TREETEST_RENAME:Int			= WXID_HIGHEST + 20,..
    		TREETEST_DELETE:Int			= WXID_HIGHEST + 21,..
    		TREETEST_DELETECHILDREN:Int	= WXID_HIGHEST + 22,..
    		TREETEST_DELETEALL:Int			= WXID_HIGHEST + 23,..
    		TREETEST_RECREATE:Int			= WXID_HIGHEST + 24,..
    		TREETEST_TOGGLEIMAGES:Int	= WXID_HIGHEST + 25,..
    		TREETEST_TOGGLEBUTTONS:Int	= WXID_HIGHEST + 26,..
    		TREETEST_SETIMAGESIZE:Int		= WXID_HIGHEST + 27,..
    		TREETEST_TOGGLESEL:Int		= WXID_HIGHEST + 28,..
   		TREETEST_COLLAPSEANDRESET:Int= WXID_HIGHEST + 29,..
    		TREETEST_ENSUREVISIBLE:Int		= WXID_HIGHEST + 30,..
    		TREETEST_ADDITEM:Int			= WXID_HIGHEST + 31,..
    		TREETEST_INSERTITEM:Int		= WXID_HIGHEST + 32,..
    		TREETEST_INCINDENT:Int		= WXID_HIGHEST + 33,..
    		TREETEST_DECINDENT:Int		= WXID_HIGHEST + 34,..
    		TREETEST_INCSPACING:Int		= WXID_HIGHEST + 35,..
    		TREETEST_DECSPACING:Int		= WXID_HIGHEST + 36,..
    		TREETEST_TOGGLEICON:Int		= WXID_HIGHEST + 37,..
    		TREETEST_SELECT:Int			= WXID_HIGHEST + 38,..
    		TREETEST_UNSELECT:Int			= WXID_HIGHEST + 39,..
    		TREETEST_SELECTROOT:Int		= WXID_HIGHEST + 40,..
    		TREETEST_CTRL:Int 				= 1000

Const 	TreeCtrlIcon_File:Int 			= 0,..
		TreeCtrlIcon_FileSelected:Int 		= 1,..
		TreeCtrlIcon_Folder:Int			= 2,..
		TreeCtrlIcon_FolderSelected:Int	= 3,..
		TreeCtrlIcon_FolderOpened:Int 	=4

' ----------------------------------------------------------------
Rem
	bbdoc:   
	about:    
End Rem	
Type MyApp Extends wxApp

	Field b_ShowImages:Int
	Field b_ShowButtons:Int

	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem	
	Method OnInit:Int()
	
		' 	Create the main frame window
		Local frame:MyFrame = New MyFrame.CreateMyFrame(,,"wxTreeCtrl test", 50,50,450,600)
		
		' 	This cannot be done in the frame's OnInit() - it has to go here				
		frame.Show(True)
		
		SetTopWindow(frame)
				
		Return True
	
	End Method
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem	
	Method SetShowButtons(_b_show:Int)
		b_ShowButtons = _b_show
	End Method
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem	
	Method ShowButtons:Int()
		Return b_ShowButtons 
	End Method
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem	
	Method SetShowImages(_b_show:Int)
		b_ShowImages = _b_show
	End Method
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem	
	Method ShowImages:Int()
		Return b_ShowImages 
	End Method
			
End Type

' ----------------------------------------------------------------
Rem
	bbdoc:   
	about:    
End Rem	
Type MyFrame Extends wxFrame

	Field m_TreeCtrl:MyTreeCtrl
	Field m_Panel:wxPanel
	Field m_TextCtrl:wxTextCtrl

	' ----------------------------------------------------------------
	Rem
		bbdoc:    
	End Rem	
	Function CheckItem(item:wxTreeItemId)
	
		If item And Not item.IsOk()
		                                 
                     wxMessageBox( "Please select some item first!","Tree sample error",  wxOK| wxICON_EXCLAMATION)    
		
		EndIf
		
	End Function

	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem	
	Method CreateMyFrame:MyFrame( _parent:wxFrame = Null, _id:Int = wxID_ANY, _s_title:String, _x:Int,_y:Int,_w:Int,_h:Int )
	
		Create(_parent,_id,_s_title,_x,_y,_w,_h)
		
		Return Self
		
	End Method	

	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
		about:    
	End Rem	
	Method OnInit()
	
   		' This reduces flicker effects - even better would be To define
    		' OnEraseBackground To do nothing. When the tree control's scrollbars are
    		' show Or hidden, the frame is sent a background erase event.
		SetBackgroundColour(New wxColour.Create(255,255,255)) 
		
		'SetIcon(wxICON(sample))
			
		'	Construct the menu items
		Local file_menu:wxMenu 		=  New wxMenu.Create()
		Local style_menu:wxMenu 	=  New wxMenu.Create()
		Local tree_menu:wxMenu 	=  New wxMenu.Create()
		Local item_menu:wxMenu 	=  New wxMenu.Create()
		
		file_menu.Append(TREETEST_ABOUT,"&About...")
		file_menu.AppendSeparator()
		file_menu.Append(TREETEST_QUIT,"E&xit~tAlt-X")
		
	    	style_menu.AppendCheckItem(TREETEST_TOGBUTTONS, "Toggle &normal buttons")
 	   	style_menu.AppendCheckItem(TREETEST_TOGTWIST, "Toggle &twister buttons")
   	 	style_menu.AppendCheckItem(TREETEST_TOGGLEBUTTONS, "Toggle image &buttons")
   	 	style_menu.AppendSeparator()
   	 	style_menu.AppendCheckItem(TREETEST_TOGLINES, "Toggle &connecting lines")
    		style_menu.AppendCheckItem(TREETEST_TOGROOTLINES, "Toggle &lines at root")
    		style_menu.AppendCheckItem(TREETEST_TOGHIDEROOT, "Toggle &hidden root")
    		style_menu.AppendCheckItem(TREETEST_TOGBORDER, "Toggle &item border")
   	 	style_menu.AppendCheckItem(TREETEST_TOGFULLHIGHLIGHT, "Toggle &full row highlight")
    		style_menu.AppendCheckItem(TREETEST_TOGEDIT, "Toggle &edit mode")
					
    		style_menu.AppendCheckItem(TREETEST_TOGGLESEL, "Toggle &selection mode")

    		style_menu.AppendCheckItem(TREETEST_TOGGLEIMAGES, "Toggle show ima&ges")
    		style_menu.Append(TREETEST_SETIMAGESIZE, "Set image si&ze...")
    		style_menu.AppendSeparator()
    		style_menu.Append(TREETEST_SETFGCOLOUR, "Set &foreground colour...")
    		style_menu.Append(TREETEST_SETBGCOLOUR, "Set &background colour...")
    		style_menu.AppendSeparator()
    		style_menu.Append(TREETEST_RESETSTYLE, "&Reset to default~tF10")

    		tree_menu.Append(TREETEST_RECREATE, "&Recreate the tree")
    		tree_menu.Append(TREETEST_COLLAPSEANDRESET, "C&ollapse and reset")
    		tree_menu.AppendSeparator()
    		tree_menu.Append(TREETEST_ADDITEM, "Append a &new item")
    		tree_menu.Append(TREETEST_INSERTITEM, "&Insert a new item")
    		tree_menu.Append(TREETEST_DELETE, "&Delete this item")
    		tree_menu.Append(TREETEST_DELETECHILDREN, "Delete &children")
    		tree_menu.Append(TREETEST_DELETEALL, "Delete &all items")
    		tree_menu.Append(TREETEST_SELECTROOT, "Select root item")
    		tree_menu.AppendSeparator()
    		tree_menu.Append(TREETEST_COUNT, "Count children of current item")
   		tree_menu.Append(TREETEST_COUNTREC, "Recursively count children of current item")
    		tree_menu.AppendSeparator()
    		tree_menu.Append(TREETEST_SORT, "Sort children of current item")
    		tree_menu.Append(TREETEST_SORTREV, "Sort in reversed order")
    		tree_menu.AppendSeparator()
    		tree_menu.Append(TREETEST_ENSUREVISIBLE, "Make the last item &visible")
    		tree_menu.AppendSeparator()
    		tree_menu.Append(TREETEST_INCINDENT, "Add 5 points to indentation~tAlt-I")
    		tree_menu.Append(TREETEST_DECINDENT, "Reduce indentation by 5 points~tAlt-R")
    		tree_menu.AppendSeparator()
    		tree_menu.Append(TREETEST_INCSPACING, "Add 5 points to spacing~tCtrl-I")
    		tree_menu.Append(TREETEST_DECSPACING, "Reduce spacing by 5 points~tCtrl-R")

    		item_menu.Append(TREETEST_DUMP, "&Dump item children")
    		item_menu.Append(TREETEST_RENAME, "&Rename item...")

    		item_menu.AppendSeparator()
    		item_menu.Append(TREETEST_SETBOLD, "Make item &bold")
    		item_menu.Append(TREETEST_CLEARBOLD, "Make item &not bold")
    		item_menu.AppendSeparator()
    		item_menu.Append(TREETEST_TOGGLEICON, "Toggle the item's &icon")

    		item_menu.AppendSeparator()
    		item_menu.Append(TREETEST_DUMPSELECTED, "Dump selected items~tAlt-D")
    		item_menu.Append(TREETEST_SELECT, "Select current item~tAlt-S")
    		item_menu.Append(TREETEST_UNSELECT, "Unselect everything~tAlt-U")
	
		'	Attach these items to a menu bar
		Local menu_bar:wxMenuBar = New wxMenuBar.Create()
		menu_bar.Append(file_menu,"&File")
		menu_bar.Append(style_menu,"&Style")
		menu_bar.Append(tree_menu,"&Tree")
		menu_bar.Append(item_menu,"&Item")
		
		'	Attach the menu bar to the frame
		SetMenuBar(menu_bar)
		
		m_Panel = New wxPanel.Create(Self);
		
		m_TextCtrl = New wxTextCtrl.Create(m_Panel, wxID_ANY, "",,,,,wxTE_MULTILINE | wxSUNKEN_BORDER) 
		
		CreateTreeWithDefStyle()
	
		menu_bar.Check(TREETEST_TOGGLEIMAGES,True)
		
		CreateStatusBar(2)
		
		Local log_window:wxLogTextCtrl = New wxLogTextCtrl.Create(m_TextCtrl)
		
		wxLog.SetActiveTarget(log_window)
		
		'	Hook up the menus with their functions
	'	Connect(ID_QUIT,wxEVT_COMMAND_MENU_SELECTED, OnQuit)
	'	Connect(ID_ANGLE,wxEVT_COMMAND_MENU_SELECTED, OnAngle)
	'	Connect(ID_CLEAR,wxEVT_COMMAND_MENU_SELECTED, OnClear)

	End Method

	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem	
	Method CreateTreeWithDefStyle()

		Local style:Int = wxTR_DEFAULT_STYLE | wxTR_HAS_VARIABLE_ROW_HEIGHT | wxTR_EDIT_LABELS

		CreateTree( style | wxSUNKEN_BORDER)
		
   		' As we don't know what wxTR_DEFAULT_STYLE could contain, test for everything
    		Local mbar:wxMenuBar  = GetMenuBar()
    		mbar.Check(TREETEST_TOGBUTTONS, (style & wxTR_HAS_BUTTONS) <> 0)
	    	mbar.Check(TREETEST_TOGBUTTONS, (style & wxTR_TWIST_BUTTONS) <> 0)
	   	mbar.Check(TREETEST_TOGLINES, (style & wxTR_NO_LINES) = 0)
	    	mbar.Check(TREETEST_TOGROOTLINES, (style & wxTR_LINES_AT_ROOT) <> 0)
	    	mbar.Check(TREETEST_TOGHIDEROOT, (style & wxTR_HIDE_ROOT) <> 0)
	    	mbar.Check(TREETEST_TOGEDIT, (style & wxTR_EDIT_LABELS) <> 0)
	    	mbar.Check(TREETEST_TOGBORDER, (style & wxTR_ROW_LINES) <> 0)
	    	mbar.Check(TREETEST_TOGFULLHIGHLIGHT, (style & wxTR_FULL_ROW_HIGHLIGHT) <> 0)
	
	End Method
	    
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem	
	Method CreateTree(_style:Int)

    		m_TreeCtrl = New MyTreeCtrl.CreateMyTreeCtrl(m_Panel, TREETEST_CTRL,,,,,_style)
		Resize()
	
	End Method
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem
	Method DoSetBold(_b_bold:Int)
	
		If m_TreeCtrl
			
			Local item:wxTreeItemId = m_TreeCtrl.GetSelection()

  			CheckItem(item)

			m_TreeCtrl.SetItemBold(item,_b_bold)
		
		EndIf

	End Method

	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem
	Method DoSort(_b_reverse:Int)
	
		If m_TreeCtrl
			
			Local item:wxTreeItemId = m_TreeCtrl.GetSelection()

  			CheckItem(item)

			'	Was: m_treeCtrl->DoSortChildren(item, reverse); I may have to override the treectrl compare method...
			m_TreeCtrl.SortChildren(item)
		
		EndIf

	End Method

	' ----------------------------------------------------------------
	Rem 
		bbdoc:   
	End Rem
	Method DoToggleIcon(item:wxTreeItemId)
	
		Local image:Int
		
		If m_TreeCtrl.GetItemImage(item) = TreeCtrlIcon_Folder
			image = TreeCtrlIcon_File
		Else
			image = TreeCtrlIcon_Folder
		EndIf
		
		m_TreeCtrl.SetItemImage(item,image,wxTreeItemIcon_Normal)
		
		If m_TreeCtrl.GetItemImage(item) = TreeCtrlIcon_FolderSelected
			image = TreeCtrlIcon_FileSelected
		Else
			image = TreeCtrlIcon_FolderSelected
		EndIf
		
		m_TreeCtrl.SetItemImage(item,image,wxTreeItemIcon_Selected)
		
	End Method
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   Just a code space saver/helper fn
	End Rem
	Function GetMyTreeCtrl:MyTreeCtrl(_event:wxEvent)
			
		Local my_frame:MyFrame = (MyFrame)(_event.parent)
		
		Local m_tree_ctrl:MyTreeCtrl = Null
		
		If my_frame Then m_tree_ctrl = my_frame.m_TreeCtrl
		
		Return m_tree_ctrl
	
	End Function
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem
	Method LogEvent(_s_name:String, _event:wxTreeEvent)
	
		Local item:wxTreeItemId = _event.GetItem()
		
		Local s_text:String
		
		If item.IsOk()
			s_text = m_TreeCtrl.GetItemText(item)
		Else
			s_text = "invalid item"
		EndIf
		
		wxLogMessage(_s_name +" " +s_text)
	
	End Method
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:    
	End Rem	
	Function OnAbout(_event:wxEvent)
		
		 wxMessageBox("Tree test sample~n original cpp sample is (c) Julian Smart 1997, Vadim Zeitlin 1998","About tree test", wxOK|wxICON_INFORMATION, (MyFrame)(_event.parent))
		
	End Function
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem
	Function OnCount(_event:wxEvent)
	
		Local m_tree_ctrl:MyTreeCtrl = GetMyTreeCtrl(_event)
		
		If m_tree_ctrl
		
			 Local item:wxTreeItemId = m_tree_ctrl.GetSelection()

  			CheckItem(item)

   			Local child_count:Int = m_tree_ctrl.GetChildrenCount( item, False )

    			wxLogMessage("children " +child_count)

		EndIf
	
	End Function
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   I've no idea why they repeated this fn
	End Rem
	Function OnCountRec(_event:wxEvent)
	
		OnCount(_event)
		
	End Function
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem
	Function OnDelete(_event:wxEvent)
	
		Local m_tree_ctrl:MyTreeCtrl = GetMyTreeCtrl(_event)
		
		If m_tree_ctrl
		
			 Local item:wxTreeItemId = m_tree_ctrl.GetSelection()

  			CheckItem(item)

   			m_tree_ctrl.DeleteItem(item)

		EndIf
	
	End Function
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem
	Function OnDeleteAll(_event:wxEvent)
	
		Local m_tree_ctrl:MyTreeCtrl = GetMyTreeCtrl(_event)
		
		If m_tree_ctrl
		
			 Local item:wxTreeItemId = m_tree_ctrl.GetSelection()

  			CheckItem(item)

   			m_tree_ctrl.DeleteAllItems()

		EndIf
	
	End Function

	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem
	Function OnDeleteChildren(_event:wxEvent)
	
		Local m_tree_ctrl:MyTreeCtrl = GetMyTreeCtrl(_event)
		
		If m_tree_ctrl
		
			 Local item:wxTreeItemId = m_tree_ctrl.GetSelection()

  			CheckItem(item)

   			m_tree_ctrl.DeleteChildren(item)

		EndIf
	
	End Function
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem
	Function OnDump(_event:wxEvent)
	
		Local m_tree_ctrl:MyTreeCtrl = GetMyTreeCtrl(_event)
		
		If m_tree_ctrl
		
			Local root:wxTreeItemId = m_tree_ctrl.GetSelection()
			CheckItem(root)
			m_tree_ctrl.GetItemsRecursively(root)
		EndIf
		
	End Function
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem
	Function OnDumpSelected(_event:wxEvent)
	
		Local m_tree_ctrl:MyTreeCtrl = GetMyTreeCtrl(_event)
		
		If m_tree_ctrl

			Local array:wxTreeItemId[] = m_tree_ctrl.GetSelections()
			Local count:Int = array.length
			wxLogMessage(count +" items selected")
			
			For Local item:Int = 0 Until Count
			
				wxLogMessage(m_tree_ctrl.GetItemText(array[item]))
			
			Next
		
		EndIf

	End Function
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem
	Function OnHighlight(_event:wxEvent)
	
		Local m_tree_ctrl:MyTreeCtrl = GetMyTreeCtrl(_event)
		
		If m_tree_ctrl
		
			 Local id:wxTreeItemId = m_tree_ctrl.GetSelection()
			
			CheckItem(id)
	
			Local x:Int,y:Int,w:Int,h:Int
				
			If Not m_tree_ctrl.GetBoundingRect(id,x,y,w,h,True)
			 	wxLogMessage "OnHighlight::Failed To get bounding item rect"
		       		Return
			EndIf
		
			Local dc:wxClientDC = New wxClientDC.Create(m_tree_ctrl)
			  
		    	dc.SetBrush(wxRED_BRUSH())
		    	dc.SetPen(wxTRANSPARENT_PEN())
		   	dc.DrawRectangle(w,x,w,h)
		   	m_tree_ctrl.Update()
			dc.Free()
		

		EndIf
	
	End Function
	
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem
	Function OnIdle(_event:wxEvent)
	
		Local event:wxIdleEvent = (wxIdleEvent)(_event)
		Local my_frame:MyFrame = (MyFrame)(event.parent)
		
		Local m_tree_ctrl:MyTreeCtrl = Null
		
		If my_frame Then m_tree_ctrl = my_frame.m_TreeCtrl
		
		If m_tree_ctrl
		
			Local id_root:wxTreeItemId = m_tree_ctrl.GetRootItem();
   		  	Local s_status:String 

			If id_root.IsOk()
			
				Local id_last:wxTreeItemId  = m_tree_ctrl.GetLastChild(id_root)
						
				s_status = "Root/last item is "
				
				If Not m_tree_ctrl.IsVisible(id_root) Then s_status :+ "not "
				
				s_status :+ "visbile/ "
						
				If id_last.IsOk() And Not m_tree_ctrl.IsVisible(id_last) Then s_status :+ "not "
				
				s_status :+ "visbile"
					
			Else
			
				s_status = "No root item"
			
			EndIf
		
			my_frame.SetStatusText(s_status,1)
		
		EndIf
		       				
		event.Skip()
	
	End Function

	' ----------------------------------------------------------------
	Rem
		bbdoc:    
	End Rem	
	Function OnQuit(_event:wxEvent)
		
		 (MyFrame)(_event.parent).Close(True)
		
	End Function

	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem
	Function OnRecreate(_event:wxEvent)
	
		OnDeleteAll(_event)
	
		Local m_tree_ctrl:MyTreeCtrl = GetMyTreeCtrl(_event)
		
		If m_tree_ctrl
		
			m_tree_ctrl.AddTestItemsToTree(5,2)

		EndIf
	
	End Function


	' ----------------------------------------------------------------
	Rem
		bbdoc:    
	End Rem
	Function OnRename(_event:wxEvent)
	
		Local my_frame:MyFrame = (MyFrame)(_event.parent)
	
		If my_frame
	
			Local item:wxTreeItemId = my_frame.m_TreeCtrl.GetSelection()
			
			CheckItem(item)
	
	 		' TODO demonstrate creating a custom edit control...
	    		my_frame.m_TreeCtrl.EditLabel(item)
	
		EndIf
		

	End Function
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem
	Function OnSelect(_event:wxEvent)
	
		Local m_tree_ctrl:MyTreeCtrl = GetMyTreeCtrl(_event)
		
		If m_tree_ctrl
		
			m_tree_ctrl.SelectItem(m_tree_ctrl.GetSelection())
		
		EndIf

	End Function
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem
	Function OnSelectRoot(_event:wxEvent)
	
		Local m_tree_ctrl:MyTreeCtrl = GetMyTreeCtrl(_event)
		
		If m_tree_ctrl
		
			m_tree_ctrl.SelectItem(m_tree_ctrl.GetRootItem())
		
		EndIf

	End Function
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem		
	Function OnSize(_event:wxEvent)
	
		Local event:wxSizeEvent = (wxSizeEvent)(_event)
		Local my_frame:MyFrame = (MyFrame)(event.parent)
		
		If my_frame And my_frame.m_TreeCtrl And my_frame.m_TextCtrl
		
			my_frame.Resize()
			
		EndIf
		
		event.Skip()
		
	End Function

	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem
	Function OnToggleSel(_event:wxCommandEvent)
	
		Local event:wxCommandEvent = (wxCommandEvent)(_event)
		Local my_frame:MyFrame = (MyFrame)(event.parent)
	
		my_frame.TogStyle(event.GetId(), wxTR_MULTIPLE)
	
	End Function
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem
	Function OnUnselect(_event:wxEvent)
	
		Local m_tree_ctrl:MyTreeCtrl = GetMyTreeCtrl(_event)
		
		If m_tree_ctrl
		
			m_tree_ctrl.UnselectAll()
		
		EndIf

	End Function

	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem		
	Method TogStyle(_id:Int, _flag:Int)

     		Local style:Int = 0

		If m_TreeCtrl
		
			 style = m_TreeCtrl.GetWindowStyle() & ~_flag

			m_TreeCtrl = Null
			
		EndIf
		
		CreateTree(style)
		
    		GetMenuBar().Check(_id, (style & _flag) <> 0)
	
	End Method
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem	
	Method Resize()
	
		Local w:Int, h:Int
		
		GetClientSize(w, h)

		If m_TreeCtrl Then m_TreeCtrl.SetDimensions(0,0,w,h*2/3)
			
		If m_TextCtrl Then m_TextCtrl.SetDimensions(0,2*h/3,w,h/3)
	
	End Method
	
	
End Type
 
' ----------------------------------------------------------------
Rem
	bbdoc:   
End Rem	
Type MyTreeCtrl Extends wxTreeCtrl

	Field m_ReverseSort:Int
	
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem	
	Method AddTestItemsToTree(_num_children:Int, _depth:Int)

		Local image:Int
		
		If MyApp(wxGetApp()).ShowImages()
			image = TreeCtrlIcon_Folder
		Else
			image = -1
		EndIf
		
		Local root_id:wxTreeItemId = AddRoot("Root",image,image, New MyTreeItemData.Create("Root item"))  
	
		If image <> -1 Then SetItemImage(root_id, TreeCtrlIcon_FolderOpened, wxTreeItemIcon_Expanded)
	
		AddItemsRecursively(root_id, _num_children, _depth, True)
	      	SetItemFont(root_id, wxITALIC_FONT())
		
		Local id:wxTreeItemId = GetFirstChild(rootId)
		SetItemTextColour(id, wxBLUE())
			
	    	id = GetNextChild(id)
	    	id = GetNextChild(id)
	
	    	SetItemTextColour(id, wxRED())
    		SetItemBackgroundColour(id, wxLIGHT_GREY())
	
	End Method

	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem	
	Method CreateMyTreeCtrl:MyTreeCtrl( _parent:wxWindow = Null, _id:Int = wxID_ANY, _x:Int=-1,_y:Int=-1,_w:Int=-1,_h:Int=-1 , _style:Int)
	
		Create(_parent,_id,_x,_y,_w,_h, _style)

		m_ReverseSort = False
		
	'	CreateImageList()
		
		AddTestItemsToTree(5,2)
		
		Return Self
		
	End Method	
		
	' ----------------------------------------------------------------
	Rem
		bbdoc:   
	End Rem
	Method GetItemsRecursively( _id_parent:wxTreeItemId Var, _get_first:Int = False)

Rem
in wxWidgets, getFirstChild returns you an id which you need To pass around For its iterator - kind of like a reference To it so it knows how To get the Next child.
so... I hold that in the treelist Type, And pass it around To the calls that need it. with the idea that the user (you), don't need that kind of hassle.
End Rem

    		Local id:wxTreeItemId 

		If _get_first
			id = GetFirstChild(_id_parent)
		Else
			id = GetNextChild(_id_parent)
		EndIf
		
		If Not id.IsOk() Then Return
			
		Local s_text:String = GetItemText(id)
		
		wxLogMessage(s_text)
		
		If ItemHasChildren(id) Then GetItemsRecursively(id)

		GetItemsRecursively(_id_parent)

	End Method

End Type
